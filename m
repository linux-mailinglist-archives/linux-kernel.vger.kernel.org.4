Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C056147F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKAKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:53:22 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348833B;
        Tue,  1 Nov 2022 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667300000; x=1698836000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iR5nbEeb8llq1Y8iZDzFZH97eYqMxkF8ru+fo1WsjQk=;
  b=kY6mgNDZ4o7GysJNxiBJWCSdhJeLMSCsXgzjuu2UlKJ8aZ0N1/qrXORF
   weqbaQym9ts9Y916NSYx0nrCRKKjpvY8QjQtwVkiuQerQl2C09mlb61Hb
   Ud3i8obBmYXADHKW8KGF3Lw8dvgkFEv4Q6XACBGmKpwN3YKBK/nH2tZua
   3DyqIHor3iCTbhfl8Nh1ymkqAjQPyz4ZMXxK5e4NPkA2aYZHf7H+nCRsW
   FpFDLqTx0OgdarmtkmjOuuDgrrNDZpfaXjaL81sVQpavSKpO/fldzWRwO
   nuV8n2ssjn/rYk6Qhp0s8GS8/Qa4WHanhDBxtWMDGgwoznGtbLHC8O9c1
   A==;
X-IronPort-AV: E=Sophos;i="5.95,230,1661810400"; 
   d="scan'208";a="27084645"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Nov 2022 11:53:18 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 01 Nov 2022 11:53:18 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 01 Nov 2022 11:53:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667299998; x=1698835998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iR5nbEeb8llq1Y8iZDzFZH97eYqMxkF8ru+fo1WsjQk=;
  b=DsAO7v5asU45fn25A/NOWFVRclqqAMh4qvgqKmiQCaYnV6OULs8ciJwD
   cGOIIEjJUuMbLAK2gzmzJGTtVQlc4OrBPXaGDmHqYLJZJ74z9YdjHAsjA
   JLe9ePi41EKKs/Ah3MZjSyrMWx7DV6WuEoRJ2G1Y91+LkoOjQYTeK8wEC
   gQf6T/9Fa4PVLiGMPc1/2XDSjVmIPhzCRa6wwWBXkv31rgXnu0PZY15q2
   TnH1NF56LOOLaHQwhEYqbssSC60SaS4deg51Dy7/66UruiaLgz9Wd2BIJ
   6ffaJ5/g1nttCZsZzpbBWPBwoba82E5E4dr9ZmDVXpYxpocntePeK3wwe
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,230,1661810400"; 
   d="scan'208";a="27084644"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Nov 2022 11:53:18 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 17CD0280056;
        Tue,  1 Nov 2022 11:53:18 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] mmc: sdhci_am654: Use dev_err_probe() for mmc_of_parse() return code
Date:   Tue,  1 Nov 2022 11:52:42 +0100
Message-Id: <20221101105242.2019036-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking phandle references like mmc-pwrseq can result in -EPROBE_DEFER.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mmc/host/sdhci_am654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8f1023480e12..4e17efa8ab97 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -835,7 +835,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
-		dev_err(dev, "parsing dt failed (%d)\n", ret);
+		dev_err_probe(dev, ret, "parsing dt failed\n");
 		goto pm_runtime_put;
 	}
 
-- 
2.25.1

