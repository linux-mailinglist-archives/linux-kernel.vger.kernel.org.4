Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F5614C07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKANtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiKANsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:48:54 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5844A64DC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310519; bh=vD5xPP6rhDMyEPUB2EJfYmq4IJWWiXIGuVb0HXRZWT4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=fVcb+/nupJ7AhmJnZetNK34/9sZngg5xfUJsvcaYThBAwhncmsYLqdFmE5XItZ1yp
         h+O9SuSPXpN+fOD4lSZF0bo30/fA36OtRLLHISFPXtk/uBqN423wJLLC4QCfPRD5R2
         WeoXRd9xg13Tt/G2PPHucnD4a4EaTNf9355JLqpw=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:48:39 +0100 (CET)
X-EA-Auth: X4pN+7UwV7tuIgo8s4NSyRI91QHFNeZwe3Lbq6lEeocWM1koDQGJMOfbBYzQ20847gAz1Jl7Tuk5oWFzZrXgTyHCm0VQ1Fqw
Date:   Tue, 1 Nov 2022 19:18:35 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] staging: wlan-ng: Remove unused struct
 wlan_ie_supp_rates references
Message-ID: <370feb1f300896af66fa1c443d3ad19dc8934be3.1667308828.git.drv@mailo.com>
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

Pointer reference to struct wlan_ie_supp_rates is added as a member
variable to 7 different structures. However, these references are
never used. Remove such unused struct references. The cleanup also
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

 drivers/staging/wlan-ng/p80211mgmt.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index dcff56d18498..536794bdd1f0 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -225,13 +225,6 @@ struct wlan_ie {
 	u8 len;
 } __packed;

-/*-- Supported Rates  -----------------------------*/
-struct wlan_ie_supp_rates {
-	u8 eid;
-	u8 len;
-	u8 rates[1];		/* had better be at LEAST one! */
-} __packed;
-
 /*-- FH Parameter Set  ----------------------------*/
 struct wlan_ie_fh_parms {
 	u8 eid;
@@ -312,7 +305,6 @@ struct wlan_fr_beacon {
 	u16 *bcn_int;
 	u16 *cap_info;
 	/*-- info elements ----------*/
-	struct wlan_ie_supp_rates *supp_rates;
 	struct wlan_ie_fh_parms *fh_parms;
 	struct wlan_ie_ds_parms *ds_parms;
 	struct wlan_ie_cf_parms *cf_parms;
@@ -364,7 +356,6 @@ struct wlan_fr_assocreq {
 	u16 *cap_info;
 	u16 *listen_int;
 	/*-- info elements ----------*/
-	struct wlan_ie_supp_rates *supp_rates;

 };

@@ -381,7 +372,6 @@ struct wlan_fr_assocresp {
 	u16 *status;
 	u16 *aid;
 	/*-- info elements ----------*/
-	struct wlan_ie_supp_rates *supp_rates;

 };

@@ -398,7 +388,6 @@ struct wlan_fr_reassocreq {
 	u16 *listen_int;
 	u8 *curr_ap;
 	/*-- info elements ----------*/
-	struct wlan_ie_supp_rates *supp_rates;

 };

@@ -415,7 +404,6 @@ struct wlan_fr_reassocresp {
 	u16 *status;
 	u16 *aid;
 	/*-- info elements ----------*/
-	struct wlan_ie_supp_rates *supp_rates;

 };

@@ -429,7 +417,6 @@ struct wlan_fr_probereq {
 	void *priv;
 	/*-- fixed fields -----------*/
 	/*-- info elements ----------*/
-	struct wlan_ie_supp_rates *supp_rates;

 };

@@ -446,7 +433,6 @@ struct wlan_fr_proberesp {
 	u16 *bcn_int;
 	u16 *cap_info;
 	/*-- info elements ----------*/
-	struct wlan_ie_supp_rates *supp_rates;
 	struct wlan_ie_fh_parms *fh_parms;
 	struct wlan_ie_ds_parms *ds_parms;
 	struct wlan_ie_cf_parms *cf_parms;
--
2.34.1



