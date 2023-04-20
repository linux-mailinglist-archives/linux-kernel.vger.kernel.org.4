Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62566E8FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjDTKOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjDTKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:13:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5132730EE;
        Thu, 20 Apr 2023 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1681985506; x=1713521506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IqX1KGc2zqXc+B1++YmyPlNP2lpj621/TtGNfPcNhxc=;
  b=JPhVkVGuwPX+vXRa39++itG3XazcHzzTsEjUiM2eNxmwXZJRDWcvZpna
   7e78BZU6faZ5uYTSgS9Z9NMmFJJ1oZcIB+Y81g2BKd7utaM33z6qOnEv2
   c+f+xGVl51XvWTukHibZ/SDt7ymWA0yBRALYiyRmwwsAfqVDrXD6vhexB
   zysv75miOd+uDbe5Dki0o99KoOjPap4ZwVeR/SgsttUK3DhfKajhfOdxn
   b36gN1KTP97ROvOi2Dg8SBXx4Nzh3cFpYSCrU0DRkGlSNkiTpeeo8U9Mx
   q5ckui+wnB8eU2r/Hh3QCUvHj69qC+uAF5hQ19SnNJWkT1qYgPa/VI1qd
   g==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677513600"; 
   d="scan'208";a="227179734"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2023 18:11:45 +0800
IronPort-SDR: rdE0lWEq9+TofNrozWjk06ulUBQ8VgH6Jg0K2Ekbeom1b9UFskhNm1kpxbmVLLOKdw8aCXqNoD
 fFh3Znqn0Xi5x45TYRRj5fkQi7sq6i51K9mSoyJOQJUAl05ULWLw32j2ouqPHvhQHGLUcx/M5V
 3tjCo1WICe8dP0YSZjJwFC0VHXn+FJjNvzImO9jpfKBGcWQtsnLM37D+MZc+G8qKoEm0aMFXL/
 NX5MoHHq0bkWsjC30u5rrAviiOiSkm9fBJehvu/4VfqvvGDbJ15Rwwy2OAI7sIzZ83VjjdQaU6
 9K8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2023 02:21:47 -0700
IronPort-SDR: ORsds7CtjxmB5wYxkvbO2BbKRBatGs09seFBUNJYG1SyomkUvbUDcKdrEjOtxAATob/67q+1Ww
 5kB1UgCufxRzQa8oDELgTy7DFmlpP+LWlQSRB6XzPFj5bm43lMxtFchbeZ7xDsT06ifPwT9xaK
 EffgDeF727Wi38xD++31niqoaO/IupmJe7nqsyEAT88DTmqJu7hiH6OAr2P/sa6ljxbzhWukBr
 UR6i9MtV8T+MsTbFdk8Enelh/yFFuCt8ZKYGkVZpENznXa/C/HH9Cs53QILh2sl/cQGeJkJamE
 XDM=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Apr 2023 03:11:43 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.g.garry@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] scsi: ufs: mcq: Limit the amount of inflight requests
Date:   Thu, 20 Apr 2023 13:11:16 +0300
Message-Id: <20230420101116.173-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in UFS, each request is designated via the triplet <iid, lun, task tag>.

In UFS4.0 the Initiator ID field is 8 bits wide, comprised of the
EXT_IID and IID fields. Together with the task tag (single byte), they
limit the driver's hw queues capacity.

The purpose of this patch is to document the ufs spec restrictions.
practically, it impose no functional change because a) the current hw
supports much less (merely 64 requests), and b) since shost->host_tagset
is set - then the number of inflight IOs is limited by just the HW queue
depth.

---
v2 -> v3:
fix smatch warnings (Dan Carpenter)
elaborate commit log (John Garry)

v1 -> v2:
Attend Johannes's and Bart's comments

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 03c47f9a2750..9cebec6be35c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8468,6 +8468,12 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 	if (ret)
 		goto err;
 
+	if (hba->nutrs * hba->nr_hw_queues > SZ_64K - 1) {
+		dev_info(hba->dev, "there can be at most 64K inflight requests\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
 	/*
 	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
 	 * Number of supported tags in MCQ mode may be larger than SDB mode.
-- 
2.17.1

