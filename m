Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF205B4848
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIJToN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIJTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:43:44 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD4494AD50;
        Sat, 10 Sep 2022 12:43:27 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 43FD7DC0;
        Sat, 10 Sep 2022 22:46:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 43FD7DC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839199;
        bh=Q03SFI4ONE2ihopSD+9YeOW44HMs95xhDvnyiU0Z6Qc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=daM5bKUpgjH71aAcgCwZY5t//eLXBrLa0Psbu5RrI+2YdWHmvfeyGGX5rbDo6UQcj
         OxpOyRMJRNZi/Uhni1oRc22q+F21pxycALBe0JW+hxT2V+5ClhE80Zeyjx7v2gX6iw
         MR1bHJ0HiBN4oC/WWca313esUCKLPVM9Ev1YiP3w=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:42:48 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/19] EDAC/mc: Init DIMM labels in MC registration method
Date:   Sat, 10 Sep 2022 22:42:30 +0300
Message-ID: <20220910194237.10142-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation before adding the unique MC index allocation procedure we
need to move the DIMM labels initialization to the memory controller
registration method. It's required because the labels contain the MC index
as the "mc%u" part of the string, which in case of the auto-generated
index isn't available at the moment of the MCI/csrow/dimms descriptor
allocation.

So nothing complex is done here. Just move the labels initialization from
edac_mc_alloc_dimms() to the dedicated method edac_mc_init_labels() and
call it from edac_mc_add_mc_with_groups().

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/edac_mc.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..24814839d885 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -256,7 +256,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	unsigned int pos[EDAC_MAX_LAYERS];
 	unsigned int row, chn, idx;
 	int layer;
-	void *p;
 
 	/*
 	 * Allocate and fill the dimm structs
@@ -271,7 +270,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	for (idx = 0; idx < mci->tot_dimms; idx++) {
 		struct dimm_info *dimm;
 		struct rank_info *chan;
-		int n, len;
 
 		chan = mci->csrows[row]->channels[chn];
 
@@ -282,22 +280,9 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 		dimm->mci = mci;
 		dimm->idx = idx;
 
-		/*
-		 * Copy DIMM location and initialize it.
-		 */
-		len = sizeof(dimm->label);
-		p = dimm->label;
-		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
-		p += n;
-		len -= n;
-		for (layer = 0; layer < mci->n_layers; layer++) {
-			n = scnprintf(p, len, "%s#%u",
-				      edac_layer_name[mci->layers[layer].type],
-				      pos[layer]);
-			p += n;
-			len -= n;
+		/* Copy DIMM location */
+		for (layer = 0; layer < mci->n_layers; layer++)
 			dimm->location[layer] = pos[layer];
-		}
 
 		/* Link it to the csrows old API data */
 		chan->dimm = dimm;
@@ -510,6 +495,33 @@ void edac_mc_reset_delay_period(unsigned long value)
 
 
 
+/**
+ * edac_mc_init_labels() - Initialize DIMM labels
+ *
+ * @mci: pointer to the mci structure which DIMM labels need to be initialized
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_init_labels(struct mem_ctl_info *mci)
+{
+	int n, len, layer;
+	unsigned int idx;
+	char *p;
+
+	for (idx = 0; idx < mci->tot_dimms; idx++) {
+		len = sizeof(mci->dimms[idx]->label);
+		p = mci->dimms[idx]->label;
+
+		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
+		for (layer = 0; layer < mci->n_layers; layer++) {
+			n += scnprintf(p + n, len - n, "%s#%u",
+				      edac_layer_name[mci->layers[layer].type],
+				      mci->dimms[idx]->location[layer]);
+		}
+	}
+}
+
 /* Return 0 on success, 1 on failure.
  * Before calling this function, caller must
  * assign a unique value to mci->mc_idx.
@@ -637,6 +649,8 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	edac_mc_init_labels(mci);
+
 	if (add_mc_to_global_list(mci))
 		goto fail0;
 
-- 
2.37.2

