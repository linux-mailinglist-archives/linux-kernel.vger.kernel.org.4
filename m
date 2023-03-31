Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0170B6D18FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjCaHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCaHuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:50:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7997110AA8;
        Fri, 31 Mar 2023 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680248961; x=1711784961;
  h=from:to:cc:subject:date:message-id;
  bh=wvFXHtpZ7xPN75TSbGJGueSihEi7iWOy4Ow7TTI4BhQ=;
  b=CrV2T2fDOBoAZrLP16Hn/uI0uu1L1tfci67n3YaameI9mUeglvsEG/ay
   uPai+m7VPp5Iy5JnufED7FWb7NcZkkvn06RCYkOeBk3OEjl29VlsVknyl
   aqoytvEsqT2de1uyhZOosLVhJNL+4ViphnaYWN24mx/efxquPUNPvRdNE
   doSPkJT/xCT3DUOGv0R8j4WNV3DhKuBjdDfQcDvFTy5SJ3yTWUazipEIM
   LN5hdv38P5zHGxBQU+uob+h0b2B23ZN6zdYpfOdxuQ7fk3UP0KmX7M9SV
   syX85wMlePQaw3Co1eI++9pibYxjKf5ewT6eJwYET3o8ZyQs6SIJ/pOOh
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673884800"; 
   d="scan'208";a="331406323"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 15:47:04 +0800
IronPort-SDR: UiICxUixaSpM0FBiqKJyNulx0j6qIkigx4HrZOjt/8xxmUZDTbFgovVZ4VWSD3y6x8z1gci8Cq
 kuqwMGNr0jUvQ34iK9Ko3/xRiC0AKNeuJXS2n6law6/96u2IOI3ciU+Fd7Vldi69s71lB2/hdr
 38HkbPvut1uLpJBuldyvSDBK/xCHnra9qTAWnRT3G4JtRz2PmBO1Wd19/91BHCX+EF77o/h/1F
 RDJFrvFU9rwvUxJ2Kl9CRTdmyyErj9Rg3kgvJKG3x2ucSibzBtz2TXPqnohVmDJulqzTYsd8/I
 LLA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2023 00:03:12 -0700
IronPort-SDR: b31kBmBQnRDARAFbLux9YmCnsRW8UbbrsifQPGXsyNtpbsPFvacY+QDWVnEFCJijV5x6zXQEOU
 8Btw01YRScDFzc03kMKbEW8MnT+H3sOKdn6EjTxHOg/p1xRrwIq7nkg3cAeiGGZob275R+JPIT
 Wbb1P2Exu75Nllr713JLJ0eOFmFgAntqvJ7d62S5V283nHMQOD61g6EdJ5QRpAji0Mz+HUFSek
 KODGfEmGHBOzxE+CyetJELXDwDETVo9ETQgjRMfOtRQrdNSQJHHIFPoSdp8KYLcQh5nrysDDeR
 H84=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.225.33.176])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Mar 2023 00:46:59 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Date:   Fri, 31 Mar 2023 10:46:50 +0300
Message-Id: <20230331074650.75-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in UFS, each request is designated via the triplet <iid, lun, task tag>.

In UFS4.0 the Initiator ID field is 8 bits wide, comprised of the
EXT_IID and IID fields. Together with the task tag (single byte), they
limit the driver's hw queues capacity.

---
v1 -> v2:
Attend Johannes's and Bart's comments

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 35a3bd95c5e4..cac7c9918c5b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8468,6 +8468,11 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 	if (ret)
 		goto err;
 
+	if (hba->nutrs * hba->nr_hw_queues > SZ_64K - 1) {
+		dev_info(hba->dev, "there can be at most 64K inflight requests\n");
+		goto err;
+	}
+
 	/*
 	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
 	 * Number of supported tags in MCQ mode may be larger than SDB mode.
-- 
2.17.1

