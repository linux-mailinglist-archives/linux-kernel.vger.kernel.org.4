Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768CD6E0385
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDMBNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMBNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:13:07 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03BE2D73
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:13:06 -0700 (PDT)
Received: from panix1.panix.com (panix1.panix.com [166.84.1.1])
        by mailbackend.panix.com (Postfix) with ESMTP id 4PxhQn3rp8z2v3l;
        Wed, 12 Apr 2023 21:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681348385; bh=3PDeKttSJ7pA4nWTc74l+a2Ub5ZqA+OBy7VNvMYiIY8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From;
        b=Op77uQix3100OFjDvoMlpPYbSteO8ND9VvXA1Pg7DNdYTxisW9eMVQyg2wqrzTbcL
         i8ZzO6YTDMouMD0Dx3+Bn/ShG3ASZaDgZOpVLsuMkkcSK+KkRxbinLyC0/RSWV3O3u
         iYaTL5FVZa/jUXsQuv4SqwAbPhUjyZUbc6Deqp4o=
Received: by panix1.panix.com (Postfix, from userid 19171)
        id 4PxhQn3zK1zcbc; Wed, 12 Apr 2023 21:13:05 -0400 (EDT)
Date:   Thu, 13 Apr 2023 01:13:05 +0000
To:     pa@panix.com, javierm@redhat.com
Cc:     tzimmermann@suse.de, pa@panix.com, linux-kernel@vger.kernel.org,
        jfalempe@redhat.com, hdegoede@redhat.com,
        dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        ardb@kernel.org
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
 <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
 <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
 <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
 <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
 <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
 <40edb0fdb0eaff434f4872dd677923a6.squirrel@mail.panix.com>
 <87a5zcsqg8.fsf@minerva.mail-host-address-is-not-set>
 <9e6fff69b09b36cbdd96499cd0015154.squirrel@mail.panix.com>
In-Reply-To: <9e6fff69b09b36cbdd96499cd0015154.squirrel@mail.panix.com>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <4PxhQn3zK1zcbc@panix1.panix.com>
From:   pa@panix.com (Pierre Asselin)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After careful reading of the comments in f35cd3fa7729, would this
be an appropriate fix ?  Does it still address all the issues raised
by Thomas ?

(not tested)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 82c64cb9f531..9f5299d54732 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -56,10 +56,11 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	 * don't specify alpha channels.
 	 */
 	if (si->lfb_depth > 8) {
-		bits_per_pixel = max(max3(si->red_size + si->red_pos,
+		bits_per_pixel = max3(max3(si->red_size + si->red_pos,
 					  si->green_size + si->green_pos,
 					  si->blue_size + si->blue_pos),
-				     si->rsvd_size + si->rsvd_pos);
+				     si->rsvd_size + si->rsvd_pos,
+				     si->lfb_depth);
 	} else {
 		bits_per_pixel = si->lfb_depth;
 	}

