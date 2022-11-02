Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25F61652E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiKBOak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiKBO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:29:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E332B25E;
        Wed,  2 Nov 2022 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667399394; x=1698935394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tcPZBpWAoPb3fJeuZ0FofoSwD+Q2agXunSV1QbOjiq0=;
  b=Fz3D/rvEUtrD4zkALuBuh9L1BgHhZT7w7JycKhHbJxGjMNbcptIhWpSl
   lvLkyEnNEP0xHkSFmL1wT+kGSutmBL3If9Bxv4DwI8eL/qvhOiDL0Sxni
   u5dKMwxVIzo1fe8TgaYr28p6LUFpLlYagpZxIL06Jb38QylQuZqiU4fbA
   lI9T87c+uFUgqZd0h0V2WwHHunguK2pTBn13HC4QZipPQOh8N7fT5B8AB
   +zJkUXJhaBcwPMDw7SsrXulrTSAXdNMrMZcYcDaahPjrZz3HR9BxmcMCj
   47+E956d33k9TsM4MzCQioLMRXBQRCLRZXjFOltAFNq8HAq54X6rORHqa
   A==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661788800"; 
   d="scan'208";a="215319624"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 22:29:53 +0800
IronPort-SDR: 2+7O5UByoXFstokGK6KcAGxlxxv0DbAK93NuHLbEoKA0ucL9SDcdKbNq8TujzrrvfQsxx/rXmq
 M3caF7i/vPtdlQLs/TBRMv8VzwwAovH8rgGxcNdPzaKO3RswmcWUZuB8wUEeCG0UaQ7Qn6JbE8
 hSJDwbHNGJWK5iMbGfQ+nRmt3mYgKX6nZAb/sKcv1hTBL4CQHIDdkLcZvCxVtIBpiRhKNzP5NO
 t3FnrvDRnGvdjSfCdLiatVvT4XDmLBnA2plD5gvGf4GYuLfsiX6VJmRk/JU3PUeOhJUzZ4edqU
 KOQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 06:43:22 -0700
IronPort-SDR: iqX87oE/bpon0BBxzhrydNldnGCHDFpiqvkC+OmZ3yPKLz5yCxyxf/y9QlYJDvKsGccDXVoRIS
 1zDDyriyyrfuDiieLQvmwfB1p8k9QCQgo140U5SY9pIf96A4R0Y/PeZjy0soBNmonaGGXmoQk0
 c6t0I0fjOkIRPynWOYAr3S8pwPTCKtFGv9lFegPJP3DFjwMX/xLMWd9KWIz+j17wGYVo3/gXSh
 a/r4qubTacHgvfWnuOPm5pc1fswghHl93UnL4ACiChZhu4rknoi/97YF9xD5Sv7QVHOR5kGgo9
 9tg=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Nov 2022 07:29:52 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v2 3/4] ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
Date:   Wed,  2 Nov 2022 16:29:12 +0200
Message-Id: <1667399353-10228-4-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

len argument is not used anymore in ufshcd_set_active_icc_lvl function.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index aa46292..9cc3abd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7386,7 +7386,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
  * Returns calculated ICC level
  */
 static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
-						const u8 *desc_buf, int len)
+						const u8 *desc_buf)
 {
 	u32 icc_level = 0;
 
@@ -7444,8 +7444,7 @@ static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 		goto out;
 	}
 
-	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf,
-							 QUERY_DESC_MAX_SIZE);
+	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf);
 	dev_dbg(hba->dev, "%s: setting icc_level 0x%x", __func__, icc_level);
 
 	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.7.4

