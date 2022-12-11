Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6C649458
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiLKNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiLKNFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:05:32 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C806643C;
        Sun, 11 Dec 2022 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670763932; x=1702299932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lOhqg0Kj2b3Ceb+h0MzSJtC+pjsOicvAGo60FmKdVGU=;
  b=ddkI1w9QzAT6UmE8h8rjzN/Hvb9VsatILGAK2zLfIBskloBonsCq2dEY
   6qh0qr4ilLLM0694+rsUvU/X6aetKV418WO1ajir+tduWNFjHJIZyRUII
   1Eyt2cACjzz7Wt18A9JrLPLywOU0bB9OmQbkYQ+Z46/TLaO8/zK0YOaVK
   fhp4qS7542XVLEpobMaQANwDCWRuCr+ouQ6/0ITsb+2B4uXYSNxXorMd3
   KuCcGaQXS8AMK+Nu5HY76zv3k+SsFC7L/claoDCGgrQo/q1TfQxtgfykq
   hbTDGnPM8Sl7qUCDKeSBIohPYFAindetpFvSxU+x4YJIkz9m/ybs5KSbS
   w==;
X-IronPort-AV: E=Sophos;i="5.96,236,1665417600"; 
   d="scan'208";a="218373517"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2022 21:05:32 +0800
IronPort-SDR: o0zBj+HN8/uru9NTHeYI2i80dM+swNp042xFEYiwIIkD9hFXlOzHy6rszglZY2FxrLfwZYxWgw
 9nF2qTejwDD7n+eMY1nAbhLZexdSpSixmiHqA6WApSs5croSbLiBbB3Xch+2rEI9/Ho2/72le5
 nx3d7B/WB6igQuQFAOuU2U+ddenHb4m4J955o/u5FE3Al7UVBWr/QOm2XEhUFuq78tOixN9yyN
 zvL2JmM1907TFovVZPoy7+P3YzDrilhertkQcNVGz9s3dNHyEXUto1srcyWD7KVsle8wnFM755
 d8g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2022 04:23:58 -0800
IronPort-SDR: r1LvllYZ4Wr/PWHUu/G+btmcckGzyClIzCTdRFhE3MUfvX7o1z5sKiISf7P4Um/tH2VSsfXpA0
 rqbIvRNhbZBY97KNKExm7e+vbgJ29G54r+wI+NzDHralKOTasXnO7CYt9T+g0vaaCZVIIyC549
 j/Kw8OGvTdv1LNQotE55twO9cwG8DWjeSs6wp2XLqAXzzGhh6lZcFxkaNDjgzC2HJTJa8DszG8
 PHK5Sv6cap1C1e2Wys+YjsRUNLoNm19DEbJ7eH/lIl+isjVFyTk12tV7IvThdvx1vDtwsyDRih
 MFU=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2022 05:05:30 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v5 3/4] ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
Date:   Sun, 11 Dec 2022 15:05:10 +0200
Message-Id: <1670763911-8695-4-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

len argument is not used anymore in ufshcd_set_active_icc_lvl function.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bb032bc..b6ef92d3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7394,12 +7394,11 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
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
 
@@ -7457,8 +7456,7 @@ static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 		goto out;
 	}
 
-	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf,
-							 QUERY_DESC_MAX_SIZE);
+	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf);
 	dev_dbg(hba->dev, "%s: setting icc_level 0x%x", __func__, icc_level);
 
 	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.7.4

