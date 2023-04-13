Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38C76E03BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDMBeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMBef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:34:35 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD440C4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:34:34 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PxhvY3fGJz2vls;
        Wed, 12 Apr 2023 21:34:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681349673; bh=ttP36cvM3SeBuIZNI6FDWxhhzpIFeQ19ryLaTKM7zPw=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=LrVUQ9SDKQ29apum0gcw9biln6brtDc8tUdwOzymNTTvvMrIeFC5FKQnc1ZNG4FKY
         rhjiF0kLrZnz3HhN5Z6gv3iCjT3V4A3kwoVcN1PSQIahxAM5MkjKoF0pX0DB6KCstE
         yKL/oIEX9IQ+N5JJxqT9dF67OyuTQzviZ6n9h8TA=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Wed, 12 Apr 2023 21:34:33 -0400
Message-ID: <f3004fccf706fb3cbb7ef6877dcd9168.squirrel@mail.panix.com>
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
Date:   Wed, 12 Apr 2023 21:34:33 -0400
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
From:   "Pierre Asselin" <pa@panix.com>
To:     "Pierre Asselin" <pa@panix.com>
Cc:     pa@panix.com, javierm@redhat.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, jfalempe@redhat.com,
        hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, ardb@kernel.org
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

> (not tested)

Tested.  It fixes the regression on my laptop.

> diff --git a/drivers/firmware/sysfb_simplefb.c
> b/drivers/firmware/sysfb_simplefb.c
> index 82c64cb9f531..9f5299d54732 100644
> --- a/drivers/firmware/sysfb_simplefb.c
> +++ b/drivers/firmware/sysfb_simplefb.c
> @@ -56,10 +56,11 @@ __init bool sysfb_parse_mode(const struct screen_info
> *si,
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
>  	} else {
>  		bits_per_pixel = si->lfb_depth;
>  	}


