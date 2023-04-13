Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E516E075C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDMHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDMHJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C747DA5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681369710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JboGrBX3f0DwI3qI1gXPHFBUEEqE8FooJIY+dnV8VBU=;
        b=C1DD8qh3exSh5dMWXLo6DLjxSU1jXLyi0812BGQDb66DiLvZbY9uEejoCbIw7HK8ciySBW
        jAru4sVurq7UT2Hc8+2qmnXAxvfhFyDsX2wwfT6RK3hV0WZy1octCFFhwpNC0rZKJUJzhD
        dJyG0EGxwAhUX+nVaVf6mfkU14ACGi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-66m_H_yrMmO9cLpPu3Ac3g-1; Thu, 13 Apr 2023 03:08:28 -0400
X-MC-Unique: 66m_H_yrMmO9cLpPu3Ac3g-1
Received: by mail-wm1-f71.google.com with SMTP id bh18-20020a05600c3d1200b003f05a99b571so9951294wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681369707; x=1683961707;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JboGrBX3f0DwI3qI1gXPHFBUEEqE8FooJIY+dnV8VBU=;
        b=iNDiYX3aPKjHuVgZeOvLzrXpXUqsxFo74wgJIfMAl9uLQlzoVaaYRADG0SBGLKcsuV
         i+t1zQBdFRm/wMqbqJrIYZze0NiVRcW6/N3OSrkE5GJDd24R0/Tr3snBvURQH/a5KK6G
         OAavXOylVqtGp8467vsA7zTS/NB5414jHgtgdZztrjiE3PWoVEafVQgUB8GxUykl9Hva
         NPVwxMw8GJjUFT060KmJqHURURoxEAtQNQip3ShInQVxqjl7sypu2s+j+e642lE4xMJD
         TFIt0DbqOtsQrlnxTzEFDgP4QPBc8yMURRzIy3b1O1phREKSlp8Mia6JQwivkLgtT5Tz
         HfIg==
X-Gm-Message-State: AAQBX9dyqIZrIUI5oUZW+9oZPmVAXBeQlR70W8ccGO8JEHktFdQ2kTqd
        8DH/wTW1w5c0Gmd1XJ86nyxpVswF+QYn3JgRiTkPEMIqZoob4JIUxLUTqDv4Q0eIvhAhYm1aFM7
        Lptoa27jPVCdotQrOrfRmQjmPxZGJ3uWm
X-Received: by 2002:a05:600c:22c7:b0:3f0:3ab2:a7e5 with SMTP id 7-20020a05600c22c700b003f03ab2a7e5mr578684wmg.34.1681369707408;
        Thu, 13 Apr 2023 00:08:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350b24F3nDTc3CpXlWOjLktSqOUfgzmTlSCyQm9BbUFxjNlRlmGoV/Mzmvs8W2U5fj6y8Fpvrnw==
X-Received: by 2002:a05:600c:22c7:b0:3f0:3ab2:a7e5 with SMTP id 7-20020a05600c22c700b003f03ab2a7e5mr578661wmg.34.1681369707094;
        Thu, 13 Apr 2023 00:08:27 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d44cd000000b002e61e002943sm581838wrr.116.2023.04.13.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 00:08:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>, pa@panix.com
Cc:     tzimmermann@suse.de, pa@panix.com, linux-kernel@vger.kernel.org,
        jfalempe@redhat.com, hdegoede@redhat.com,
        dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        ardb@kernel.org
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <4PxhQn3zK1zcbc@panix1.panix.com>
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
 <4PxhQn3zK1zcbc@panix1.panix.com>
Date:   Thu, 13 Apr 2023 09:08:26 +0200
Message-ID: <87o7nsuumt.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pa@panix.com (Pierre Asselin) writes:

> After careful reading of the comments in f35cd3fa7729, would this
> be an appropriate fix ?  Does it still address all the issues raised
> by Thomas ?
>
> (not tested)
>
> diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
> index 82c64cb9f531..9f5299d54732 100644
> --- a/drivers/firmware/sysfb_simplefb.c
> +++ b/drivers/firmware/sysfb_simplefb.c
> @@ -56,10 +56,11 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
>  	 * don't specify alpha channels.
>  	 */
>  	if (si->lfb_depth > 8) {
> -		bits_per_pixel = max(max3(si->red_size + si->red_pos,
> +		bits_per_pixel = max3(max3(si->red_size + si->red_pos,
>  					  si->green_size + si->green_pos,
>  					  si->blue_size + si->blue_pos),
> -				     si->rsvd_size + si->rsvd_pos);
> +				     si->rsvd_size + si->rsvd_pos,
> +				     si->lfb_depth);

I would defer to Thomas but personally I don't like it. Seems to me that
this is getting too complicated just to workaround buggy BIOS that are not
reporting consistent information about their firmware-provided framebuffer.

I would either trust the pixel channel information (what Thomas patch did)
+ my patch to calculate the stride (since we can't trust the line lenght
which is based on the reported depth) + a DMI table for broken machines.

But that will only work if your systems are the exception and not a common
issue, otherwise then Thomas' approach won't work if there are too many
buggy BIOS out there.

Another option is to do the opposite, not calculate a BPP using the pixel
and then use that value to calculate a new stride, but instead assume that
the lfb_linelength is correct and use that to calculate the BPP.

Something like the following patch, which should also fix your regression
and may be enough to address Thomas' concerns of inconsistent depths too?


From e70d4df257f8a84deea82f75270b14e069729679 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 13 Apr 2023 09:00:09 +0200
Subject: [PATCH v2] firmware/sysfb: Use reported line length to calculate the
 bits-per-pixel

The commit f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
fixed format selection, by calculating the bits-per-pixel instead of just
using the reported color depth.

But unfortunately it broke some systems due the calculated bits-per-pixel
not taking into account the filler bits, for pixel formats that contained
padding bits.

For example some firmware-provided framebuffers with pixel format xRGB24
where wrongly reported as RGB24, causing the VT output to have glitches.

This seems to be caused by the rsvd_size and rsvd_pos fields not being
set correctly in some cases. So a different calculation has to be made.

Since the lfb_depth field can't be trusted, use the lfb_linelength field
to calculate the bits-per-pixel. This is already set to the stride so it
is already deemed to be correctly set by the firmware.

Fixes: f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
Reported-by: Pierre Asselin <pa@panix.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Instead of calculating the stride from the bits-per-pixel, assume that
  it is correct and use it to calculate the bits-per-pixel.

 drivers/firmware/sysfb_simplefb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 82c64cb9f531..0ab8c542b1f5 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -55,14 +55,10 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	 * ignore simplefb formats with alpha bits, as EFI and VESA
 	 * don't specify alpha channels.
 	 */
-	if (si->lfb_depth > 8) {
-		bits_per_pixel = max(max3(si->red_size + si->red_pos,
-					  si->green_size + si->green_pos,
-					  si->blue_size + si->blue_pos),
-				     si->rsvd_size + si->rsvd_pos);
-	} else {
+	if (si->lfb_depth > 8)
+		bits_per_pixel = si->lfb_linelength * 8 / si->lfb_width;
+	else
 		bits_per_pixel = si->lfb_depth;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
 		const struct simplefb_format *f = &formats[i];

base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d
-- 
2.40.0

