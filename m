Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BEC6170C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiKBWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiKBWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:37:14 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9506BE25
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667428623; bh=Jh9hVKlG9E8M6+Hg4/uFDmdMr+5rCinh9+KF12rxCMs=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=eLa3HMC9o56WEYZq2SgqNyfJWWMf14vSK+J+8Kjo/Wz4Z9/jOClxEgzxzq4VSyik9
         yQAZGFrNuIQTvtblfxcgbc1kj8dt97CffGv8a3yBmVKLuT0w7bkCxxwzmmq8g5oatW
         xhEm4Xgo1HYeDvNL3ZxA2G1vE2+ROoZueYOczGe0=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Wed,  2 Nov 2022 23:37:03 +0100 (CET)
X-EA-Auth: w+3zi4nkHeGs1aO9AAZFE88t8u3GtxhuNPQ5I+2Kebsq2h73girS4qV9PZWmt8dwhm8SNoKbKQoIgCfn4kr4gD0xympHdQW7
Date:   Thu, 3 Nov 2022 04:06:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Use min_t/max_t macros for variable
 comparison
Message-ID: <Y2LxC2kziM1TznhO@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using min_t and max_t helper macros in place of lengthy
if/else block oriented logical evaluation and value assignment. This
issue is identified by coccicheck using the minmax.cocci file.

Use the *_t variants of min/max macros to avoid compiler warnings about
data typecast.
Also, use u32 as type for min_t macro to avoid any truncation of data
associated with enum constant HT_AGG_SIZE_32K.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 62aa8e893c34..ccb86660ab48 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -587,17 +587,12 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
 		} else {
-			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
-				pHTInfo->CurrentAMPDUFactor =
-						 pPeerHTCap->MaxRxAMPDUFactor;
-			else
-				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
+			pHTInfo->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
+							    HT_AGG_SIZE_32K);
 		}
 	}
-	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
-		pHTInfo->current_mpdu_density = pHTInfo->MPDU_Density;
-	else
-		pHTInfo->current_mpdu_density = pPeerHTCap->MPDUDensity;
+	pHTInfo->current_mpdu_density = max_t(u8, pHTInfo->MPDU_Density,
+					      pPeerHTCap->MPDUDensity);
 	if (pHTInfo->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		pHTInfo->bCurrentAMPDUEnable = false;
 		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
--
2.34.1



