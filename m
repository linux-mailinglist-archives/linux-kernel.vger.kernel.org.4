Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE7614C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKANuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiKANtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:49:55 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFE41C121
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310573; bh=YqDTb9YthK+f5gOGsv+KgABsraC6uIX0b8maMGYNFJM=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=KaFOj9jQ8iO9FyTZo+JvYbqOsfuKwJhsUd8pflLTJ+7lm/zZJ9LW0/ohu4NAUzFD4
         zA1uUt+ssNH5ppvove9WZ2fvE8YhgaGUES7//DNpZhuWBsl3ixMrQbXP+LKvusGan3
         Xc/532AKC16p5M2RjtftgXSRv3JVLUgllE1C5ABM=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:49:33 +0100 (CET)
X-EA-Auth: XE2K7QgmM9ENyzefGEIHGiLeNNWaodO0XceUBUiw1lnmYFPJbnJ3xq6xR5z83375JTmC4NM2pLOGPu2b1kV5xflX/vLhdMXr
Date:   Tue, 1 Nov 2022 19:19:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] staging: wlan-ng: Remove unused struct
 wlan_ie_ibss_parms references
Message-ID: <e53084cdd3ca3ffea6a32393f6f28c7b7650d1a4.1667308828.git.drv@mailo.com>
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

Pointer reference to struct wlan_ie_ibss_parms is added as a member
variable to 2 structures; However, these references are never used.
Remove such unused struct references. The cleanup also renders the
struct useless; so remove it as well.
Issue identified as part of coccicheck based code analysis.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   1. Include additional code clean-up opportunities and combine changes in a
      patch set based on impact areas.
   2. The patch changes are compile tested only on X86 arch.

 drivers/staging/wlan-ng/p80211mgmt.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index d95ffe0097e9..816b25641f5a 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -253,13 +253,6 @@ struct wlan_ie_cf_parms {
 	u16 cfp_durremaining;
 } __packed;

-/*-- IBSS Parameter Set ---------------------------*/
-struct wlan_ie_ibss_parms {
-	u8 eid;
-	u8 len;
-	u16 atim_win;
-} __packed;
-
 /*-- Challenge Text  ------------------------------*/
 struct wlan_ie_challenge {
 	u8 eid;
@@ -298,7 +291,6 @@ struct wlan_fr_beacon {
 	struct wlan_ie_fh_parms *fh_parms;
 	struct wlan_ie_ds_parms *ds_parms;
 	struct wlan_ie_cf_parms *cf_parms;
-	struct wlan_ie_ibss_parms *ibss_parms;
 };

 /*-- IBSS ATIM ------------------------------------*/
@@ -424,7 +416,6 @@ struct wlan_fr_proberesp {
 	struct wlan_ie_fh_parms *fh_parms;
 	struct wlan_ie_ds_parms *ds_parms;
 	struct wlan_ie_cf_parms *cf_parms;
-	struct wlan_ie_ibss_parms *ibss_parms;
 };

 /*-- Authentication -------------------------------*/
--
2.34.1



