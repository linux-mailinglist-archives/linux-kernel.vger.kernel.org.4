Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B16CD773
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjC2KNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjC2KNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:13:44 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEBA423E;
        Wed, 29 Mar 2023 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680084822; x=1711620822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MPMXoxzu2xE5sIKaeII+XvZroi/oANKy6EjQqW8Vufo=;
  b=ObpChqArv+IstEjF7x8MPw3qdY2+olj9AcAJILQgPhmR27hRIkZggb7p
   q1xSVxWrnfQZhhMdHlyzzaC01DcJ7j3LkkC7PeBz2sckLndiV8RNqQFCf
   aN7mIp2Z4s0tH/7j+qC5PuA5Myo6o15TKS3vYA5KOkDnDUKSLXHgcIzNb
   Ux5IBCXTJei9aKWiCSmkbYF3vGuLa53hMC5n8FyeSYjOni0XKtpIkAswG
   1IBx1QWMm4YXP7SHikJCscQSohSBcrHnUaaLMipbl0Pj1Xh7Wg/h8rw6h
   sjMNH7OozhL6W7mUDnDpua+14/zmhi3tzKE6QKT4nWAR57G346/8chmgc
   w==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="226595784"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 18:13:42 +0800
IronPort-SDR: 28wNf8Ygi3leoSoYkyHJyNERZnX+/iSSPKoqeZ9FkNFPCCqZ3tCaqcJvJ9s1jgFJGGMxlPK8NP
 B7yPjDWwJZ1NdcJi4QPAi572iT0WDCEZy1gdJlBMqPBlf4ZEZtP2h/2UDCzlbg82n7BhxspNi2
 9Lxm5/KSnigPxG71YNl1sZhKUifRgjTnmklAAjFtYzSn/pORD5kFRPQpV4NrH3yfK/Iz52IEcB
 V6mrx97PsgAUOk+JE6/0kM4gxWbI57/mZR+MSNLzz1A9LTbDWCFCeaT96f5zXixoHyA8mPbuhf
 HyM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 02:29:52 -0700
IronPort-SDR: ktiaKIgyfHdgGWoL/Lk76w+HuD0q7JFMOe0UO9PK9oLpqgSE0AZQSnr1G2NhKtAOABC372EWTH
 GgSQaoX7WrTSys3K8zdkoJGeiJrognQAlJHdHCcFMoQ2/9NE4Jw0w3dxg7a4qK7vUVvDJ2nNhH
 PcbuuwfdDU9/GxCqBo6a81fNieoEnfIuV9uyL6zLUNsMKzVj8kFQT+mz8vrQToye1yCJ/U3XhQ
 +euLLxAUwnvWAq/9W+/YwCi5mGnBHohn5X5ZdL6lOtlS2S4w/nHp46UPtvBs6GJj4Ppu8bpsCG
 j8s=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.30.255])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2023 03:13:41 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/2] scsi: ufs: mcq: Use pointer arithmetic in send_command
Date:   Wed, 29 Mar 2023 13:13:03 +0300
Message-Id: <20230329101303.18377-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230329101303.18377-1-avri.altman@wdc.com>
References: <20230329101303.18377-1-avri.altman@wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sqe_base_addr a UTRD pointer it is, instead of an opaque void *.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 5 +++--
 include/ufs/ufshcd.h      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 35a3bd95c5e4..aa7bb05e99eb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2242,10 +2242,11 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 
 	if (is_mcq_enabled(hba)) {
 		int utrd_size = sizeof(struct utp_transfer_req_desc);
+		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
+		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
 
 		spin_lock(&hwq->sq_lock);
-		memcpy(hwq->sqe_base_addr + (hwq->sq_tail_slot * utrd_size),
-		       lrbp->utr_descriptor_ptr, utrd_size);
+		memcpy(dest, src, utrd_size);
 		ufshcd_inc_sq_tail(hwq);
 		spin_unlock(&hwq->sq_lock);
 	} else {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 25aab8ec4f86..bd42477706b6 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1100,7 +1100,7 @@ struct ufs_hw_queue {
 	void __iomem *mcq_cq_head;
 	void __iomem *mcq_cq_tail;
 
-	void *sqe_base_addr;
+	struct utp_transfer_req_desc *sqe_base_addr;
 	dma_addr_t sqe_dma_addr;
 	struct cq_entry *cqe_base_addr;
 	dma_addr_t cqe_dma_addr;
-- 
2.17.1

