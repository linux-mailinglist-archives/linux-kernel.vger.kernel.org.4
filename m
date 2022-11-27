Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9906639A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiK0MI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK0MIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:08:44 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4560F59F;
        Sun, 27 Nov 2022 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669550923; x=1701086923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2vZn7pfJGB1wey4NKpPHaK01XVk7x6W6OusX0bQ6/Mg=;
  b=XivNyRCpmp+AlxDng6eLkPMv1rYLAZUtvEIllPhcoc5u9Y3+94pi2v0U
   cJgU17ndYXqC7xKEv1uXEcqk+RNoGjtcbuiQQEWik8dOLCd6bo1QWWLXm
   iHVw8YuwCZxA3seHcl/TitJPg/PmbecwYqa61DC/7Sq9QVZSWxTLxpzzH
   dJubWdLZSE32kTHwMyoGZMpyG92ZWv/FBWBWYR/oOTyx+rZROwjmnbd6R
   qzsRIvGsBhpKUsU4b7zj+2qI5HcZ45AA9xfX0HndvZpy5WS5O2Ch3maMC
   6oANT20YdZ2VAAgpr5uupNa0M/5oLi76p1EjTjo280y49doVeofy/6JzT
   w==;
X-IronPort-AV: E=Sophos;i="5.96,198,1665417600"; 
   d="scan'208";a="215510892"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2022 20:08:43 +0800
IronPort-SDR: MO9QTah/Gh5yTcDvhvLwpG9hA0ouboKV413kcNN8asQM0o3Ba9IM2jwCqUNwXo8D23j07IvZJu
 x6DRSJwsBbi/MzdDig1Ixp1TsYPJTi7qeH0vydNRYYsJH5yx0dVkH0Ula/3+S/VjmazXeugEd6
 BChMJwY0igIKB2VkvNH19eeFRjdgc6W0iVzqiG/lMAsD1d6a18VQbqeoAbWc6DSD97zzvGtcAE
 YKBQeOi3XwAz/yM2SiMWUTwd3sQUJ1i7FgPNAZKronfduNku1ybTcflnOVOglBgTJR9Bdr5mx8
 KiY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2022 03:27:26 -0800
IronPort-SDR: hxOimZ7QtkMmnWuPQL/Hu0VxepNeNCtrstXUa+8Dyo1HQpRLp7vJN55PdfSPlXzHCRcXdBGqbP
 tGLMi3cHm3a2pAMC6/ajZSQr6bjy2ZP7F0yNUb2FMclI3noZLnO4pYM2AVA4y3zpsO2V/26muM
 kor0CIr9ikA0Om635sLUSvSK5nnA0qWRqbh26PgzKzCfhBRpr8kB0gRc87bBWjH5KZZRAiNFWi
 q8KJjfxNDtXVSFRsdMqYGgGQ7P0bptoVwkR77NviIMLT+Gf+I+kzwxAuT6Of/Nh2bG+xDbQnVm
 iX8=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2022 04:08:41 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v4 3/4] ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
Date:   Sun, 27 Nov 2022 14:08:29 +0200
Message-Id: <1669550910-9672-4-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

len argument is not used anymore in ufshcd_set_active_icc_lvl function.

Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 70e96b6..617c4e0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7415,12 +7415,11 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
  * In case regulators are not initialized we'll return 0
  * @hba: per-adapter instance
  * @desc_buf: power descriptor buffer to extract ICC levels from.
- * @len: length of desc_buff
  *
  * Returns calculated ICC level
  */
 static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
-						const u8 *desc_buf, int len)
+						const u8 *desc_buf)
 {
 	u32 icc_level = 0;
 
@@ -7478,8 +7477,7 @@ static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 		goto out;
 	}
 
-	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf,
-							 QUERY_DESC_MAX_SIZE);
+	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf);
 	dev_dbg(hba->dev, "%s: setting icc_level 0x%x", __func__, icc_level);
 
 	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.7.4

