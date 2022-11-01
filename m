Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA9614C0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKANte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiKANtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:49:23 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8726540
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310549; bh=vFzpmBoau7NBl7FFTlmZYFwyYNbzqXjwJoyGzhQ4sDE=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=DPOe8NTGgDw6DENTKI2h+HFxSxlw2SNLglRET2d/j2LL38nDz9MOmBZYOCTJseT7Z
         DGvZsdmgbj7RgxGC87zlbSRSrYy3vLAYawlpka1LCMkAJM9oquaf2cMmGkCUlmE8IZ
         wsuDSA/zkzkWqLCLxa6ZIICZyfrWr2T/1Q5j2atk=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:49:09 +0100 (CET)
X-EA-Auth: m4kbEFhoIEjDxdTr7Dx+G1fH9jl1AA03O/KmMzF+amilm1q+pNst2gH1Zw2gw19RPWicZz0R3CJzQnchs6LjAeOi4oRIlVHt
Date:   Tue, 1 Nov 2022 19:19:05 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] staging: wlan-ng: Remove unused struct wlan_ie_tim
 references
Message-ID: <36834007587a2e0ef7a782f5919f3a4c756b7840.1667308828.git.drv@mailo.com>
References: <cover.1667308828.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667308828.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer reference to struct wlan_ie_tim is added as a member
variable of a structure; However, this references is never
used. Remove such unused struct reference. The cleanup also
renders the struct useless; so remove it as well.
Issue identified as part of coccicheck based code analysis.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   1. Include additional code clean-up opportunities and combine changes in a
      patch set based on impact areas.
   2. The patch changes are compile tested only on X86 arch.

 drivers/staging/wlan-ng/p80211mgmt.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index 536794bdd1f0..d95ffe0097e9 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -253,16 +253,6 @@ struct wlan_ie_cf_parms {
 	u16 cfp_durremaining;
 } __packed;

-/*-- TIM ------------------------------------------*/
-struct wlan_ie_tim {
-	u8 eid;
-	u8 len;
-	u8 dtim_cnt;
-	u8 dtim_period;
-	u8 bitmap_ctl;
-	u8 virt_bm[1];
-} __packed;
-
 /*-- IBSS Parameter Set ---------------------------*/
 struct wlan_ie_ibss_parms {
 	u8 eid;
@@ -309,8 +299,6 @@ struct wlan_fr_beacon {
 	struct wlan_ie_ds_parms *ds_parms;
 	struct wlan_ie_cf_parms *cf_parms;
 	struct wlan_ie_ibss_parms *ibss_parms;
-	struct wlan_ie_tim *tim;
-
 };

 /*-- IBSS ATIM ------------------------------------*/
--
2.34.1



