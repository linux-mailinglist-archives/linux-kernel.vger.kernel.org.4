Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAE6B7F00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCMRMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjCMRMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:12:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE2C4E5D6;
        Mon, 13 Mar 2023 10:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 374ECB811A9;
        Mon, 13 Mar 2023 17:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0089CC433D2;
        Mon, 13 Mar 2023 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727167;
        bh=EV3CRIXlQTm/Q61HwT5ekp+KlCI04uPQhJRqRcCEn4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+7bPAcbsUxfx0YYD3S/+4/0dpZzavp9DZjd6tOq2JBeRTRkzYFBAS6LXBhDTQbDT
         kOlH0mBDH5tspnNX/d90ht9/nlL+sEU+q8i5i9nAXVI58JAnbzlOD2PatVQ1tskkcE
         pztFHZTb42W7lSrypCv+KDNLOpVVlMbZA/Hz6lx/pEmWWRn1pb63VO4diDQmkUVSe6
         sFcYOw0Qr3p5ZkxN8Ti+MgLk2LndYaPg+MXJp6PT4GdRC0d+V9YhZLhNlg4zHEASNm
         PvB74+kT+Hia5vkj5X5Ijkg9mpxajXPfHr0CuXCRdRp4q0QLE6NENqCjSRlQ28C5Et
         3RWtvE+n8RMsQ==
Date:   Mon, 13 Mar 2023 17:06:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: apple_bl: Use acpi_video_get_backlight_type()
Message-ID: <20230313170601.GW9667@google.com>
References: <20230307120540.389920-1-hdegoede@redhat.com>
 <20230309170911.GC96419@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309170911.GC96419@aspen.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023, Daniel Thompson wrote:

> On Tue, Mar 07, 2023 at 01:05:40PM +0100, Hans de Goede wrote:
> > On some MacBooks both the apple_bl and the apple-gmux backlight drivers
> > may be able to export a /sys/class/backlight device.
> >
> > To avoid having 2 backlight devices for one LCD panel until now
> > the apple-gmux driver has been calling apple_bl_unregister() to move
> > the apple_bl backlight device out of the way when it loads.
> >
> > Similar problems exist on other x86 laptops and all backlight drivers
> > which may be used on x86 laptops have moved to using
> > acpi_video_get_backlight_type() to determine whether they should load
> > or not.
> >
> > Switch apple_bl to this model too, so that it is consistent with all
> > the other x86 backlight drivers.
> > [snip]
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> but...
>
> > ---
> > A note to the backlight class / subsystem maintainers, this change
> > applies on top of a similar patch for drivers/platform/x86/apple-gmux.c
> > which makes that driver use acpi_video_get_backlight_type(). See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> >
> > I believe it is easiest to also merge this patch through
> > the platform-drivers-x86 tree, may I please have your Ack for this ?
> > ---
>
> ... please don't treat above as an ack. Lee Jones will hopefully be
> along shortly to discuss that!

That's fine.  I will need a succinct, immutable pull-request though.

Acked-by: Lee Jones <lee@kernel.org>

--
Lee Jones [李琼斯]
