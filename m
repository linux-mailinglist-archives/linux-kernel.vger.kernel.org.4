Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3064C64F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbiLNJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiLNJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:50:35 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCBF1147F;
        Wed, 14 Dec 2022 01:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671011434; x=1702547434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RBpmj1MhSQxHo6w1QqeXk+NMU5iMKvHbRg1xIDkWq6k=;
  b=g8mU9xI63uthJCgIN2zQkDY390H5OmTpyTPsoDc8XmMS6ODJYslbzAaD
   PNGkRk5E1OHsJzUlLcaxxUzEbrjlbyeSMmf05FqfZJaS2ir37x3v4uB4+
   4+ZPUOaJmAnypt943EKuI6NGUK6KnSipwUCAszUtnp0pkr97VFDiy+NbZ
   V7YIn9PhfNtlAajVHhN1WNTU5W8F6MK6SDQhc0GwzAzqaFaPOexeONp6j
   KoFkAC++mqD1sNNie4h/y6jBJLFAJbGSU4HaOCtkp3YLFP4vRQ0AW16QP
   ecY8fYqww3M9QK4Yv5o3KXDA9TXAx5/E3qL6ENXKn4jMvQawzuQVuZz5I
   g==;
X-IronPort-AV: E=Sophos;i="5.96,244,1665417600"; 
   d="scan'208";a="218870760"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2022 17:50:34 +0800
IronPort-SDR: L4M2FQe/TtGdKPIoC6W+qegQv0BLXemwVwuJnkFBVIHKs7HWtpPhHVwsYt1zwSJPGmp+87+CG6
 2kFfomFQSeD7tDCdcH9Ahks4gIpdVGda+P4eJKgZ/hZgThkbyo9joEFgTlLJUScJNOjBmIIX4s
 TZR0Uvez3/vEd7o222yP2iW4M65X4UdXE9P6Vo5Mcl2da3nVIwIPf0sIdaJnbH/7defVgvVU3j
 FVImpCRp2ttp5UlnDYLOAi994meCFAAJ8HjljTSF56pvPRVrh8P0i2JEtiE60ZgILOqpVfyuTT
 a5s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Dec 2022 01:08:57 -0800
IronPort-SDR: eyZtjl+ghJwRAOL0EVhvFS7HnUTXI9QD2YdusFGCwGAEHDn3S0a2lAv6kHjFKXr/Nxim2zq0nG
 Sam3DOL3fS597AP/F6EiDd28JutHWwkvREacU4sSPytnwR9Ru/DHZfDbbAAse8nZ9J+mZ5IC8n
 jf2rc7S1ZN/Q7wXwLxkZx4ueFBpN6gl00auxLX1kEhPZLPDXpRMv4mqu+jVFIgYo0Tb0km7kzC
 Dq58qgQXSPE3KFoXKzc6NWr74XKtkwcneaLuybPGD5EAP/mT7f15F7BvUz0HHJD3zufCi/McKX
 btQ=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2022 01:50:33 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v6 1/4] ufs: core: Remove redundant wb check
Date:   Wed, 14 Dec 2022 11:50:24 +0200
Message-Id: <1671011427-26184-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671011427-26184-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1671011427-26184-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to use the extended-feature field in the device descriptor,
as an indication that the device supports ufs2.2 or later.
Remove that as this check is specifically done few lines above.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c63cd8b..c43dc2e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7616,10 +7616,6 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
 		goto wb_disabled;
 
-	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
-	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
-		goto wb_disabled;
-
 	ext_ufs_feature = get_unaligned_be32(desc_buf +
 					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
 
-- 
2.7.4

