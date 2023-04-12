Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F966E0137
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDLVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:53:27 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64AE48
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:53:26 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4Pxc0P3wRHz2kKb;
        Wed, 12 Apr 2023 17:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681336405; bh=bEXG3RlzB+cCgvd7LZLlacWwHWawjB5ycq4sdxN137E=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=AmffuYjMweW4Hwcow0b5ZMkmQ0sdtAInS8YwixD+eXqQ+9FM710qxP0kBwC3Y3M20
         nth+QPbjZcgtgXx7/bLJ+maIGp1A3BnZi0ZvElt0TChsgo/FoeDyrJQsDJoe3VDklH
         owGVM+rfTTbEESeQHDHcCjHgytsiJ9n0hiZlWkww=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Wed, 12 Apr 2023 17:53:25 -0400
Message-ID: <40edb0fdb0eaff434f4872dd677923a6.squirrel@mail.panix.com>
In-Reply-To: <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
References: <20230412150225.3757223-1-javierm@redhat.com>
    <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
    <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
    <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
    <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
    <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
    <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
    <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
Date:   Wed, 12 Apr 2023 17:53:25 -0400
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
From:   "Pierre Asselin" <pa@panix.com>
To:     "Javier Martinez Canillas" <javierm@redhat.com>
Cc:     "Pierre Asselin" <pa@panix.com>,
        "Jocelyn Falempe" <jfalempe@redhat.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Ard Biesheuvel" <ardb@kernel.org>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Javier Martinez Canillas <javierm@redhat.com> writes:
>
> I still don't understand why this particular configuration didn't work...
>
> The framebuffer starts at 0xd8000000 and has a size of 0x240000 bytes, so

Says who ?  It's the same grub, same video mode as before the regression,
so the size is probably 0x300000 like it always was.

> a r8g8b8 pixel format with resolution 1024x768 should be correct. Since is
> 1024 * 768 * (24 / 8) = 2359296 = 0x240000.

That is internally consistent, but at variance with the video mode
set up by grub.

It is better to sqeeze bits by 4:3 on each line (regression) than to
scatter 4 logical lines across 3 physical lines (regression, patched) !

> Could you please apply the following diff that will print all the relevant
> fields from the screen_info that are used to calculate the bpp and stride.

YES !  I can't peer into that struct screen_info and I don't know to
write the printk's.  (Hm, doesn't look too hard, but trust me, I would
fumble it.)

I'll back out the original patch first.
Stand by.

--PA

