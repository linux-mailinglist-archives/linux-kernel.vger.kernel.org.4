Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF2E64C655
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiLNJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiLNJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:50:50 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A412188C;
        Wed, 14 Dec 2022 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671011439; x=1702547439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=V0ClKsMY3FdP1g701gqMkgtISnKb8gAvvri+sfKXjbg=;
  b=Gcte6Pj7/9I7Twy6Wtd05WaejbPG3bjOVSR5ZzijuCcYmfnIChM2IjjQ
   4miOwbqljihM8+rS1pjfsW+9XkXV6n1V9RTNlh5WEy+rNJmfOpIogWVd+
   8BK5sCxo3PSJvIBnecLOGEhrD5m0m/l4ninbtbDu8Laff8omZXRt94eAa
   kjymPAutjnaPAIssMMjh9ltHpf1624arCcLZXrJW5rUGZ11/oZJPkMztu
   eIUeaG8AhgA+P6ZdZv8HNut0GI6YEow60toBVEdDWZMeccPc04qWV+5oY
   S1cqOXnVhswO3tbny93qD4ahCgN6iFMAUBomTvCPxEK8oY6VXvgP98UDy
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,244,1665417600"; 
   d="scan'208";a="218870764"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2022 17:50:39 +0800
IronPort-SDR: tqNKfsd9S2jXepeipJyVIRcuSqHJQ9jb/QoV6eEEJLCUZclyDexGLQPVVGQXF/Wok5hXQXHS0b
 5q3lRf8nsvTZs6pzNjQtdDlu/i6Udmhd03K/nTNSqhkcVU3ZDtn8X95Dhzjxzqxa44Wd+0and1
 wSQ0rCeHdG6PwOIO12eYRBtieEAGNgrljlVS1NHuHs5ZSoFS6WPPGQLcgB2ZzymzhOf74xwk3r
 5U8yKsRT1h+Vl8mjxXSprszg4Cp3xba5ccsciUriUxKqmWIPc961kwOzOFJSWiga+dsy4vazTu
 mNo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Dec 2022 01:09:02 -0800
IronPort-SDR: tmo2Tf1EeZsSIi9zbqeeDcrt5Mhqjdv3Q3e5KCAdft+PjjJadkzDJoOpUR6319n4VWWqbGmsEW
 O3mmTdXzP5NI4afSeZjTfP+/tDaE9TlZKEsWMkWFnMVn8+feodH3Rj33+NJK+b73pGwng3Wm7q
 4S7f6wYW7ZrRVOwaWuMjJ/AnEjF2VDJoy8tNZtoFpDf30P32HxA8zptwnxPTIhSPn4hDzPLBDa
 x2ST+ZXweBMN21LMP6aBH7jdZfxMMsb88EK6EFQ3Qb/gWJqGrZqbyTMoK02v6ovW8ok02E6M0u
 SUY=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2022 01:50:38 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v6 3/4] ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
Date:   Wed, 14 Dec 2022 11:50:26 +0200
Message-Id: <1671011427-26184-4-git-send-email-Arthur.Simchaev@wdc.com>
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

len argument is not used anymore in ufshcd_set_active_icc_lvl function.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 97eb5a6..99806c7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7402,12 +7402,11 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
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
 
@@ -7465,8 +7464,7 @@ static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 		goto out;
 	}
 
-	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf,
-							 QUERY_DESC_MAX_SIZE);
+	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf);
 	dev_dbg(hba->dev, "%s: setting icc_level 0x%x", __func__, icc_level);
 
 	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.7.4

