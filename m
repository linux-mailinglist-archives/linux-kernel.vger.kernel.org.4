Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A656A53BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjB1HeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1HeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:34:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F810AB1;
        Mon, 27 Feb 2023 23:34:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184EE60FF3;
        Tue, 28 Feb 2023 07:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89DFC433D2;
        Tue, 28 Feb 2023 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677569660;
        bh=3BCQtTaoAWxY6XcyC7IK2Ni1ftd1LIYwHPXYAOHigno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMXs3aMDccSqN83TVIdJPnk7imTUeC/8STtUztsKGxdg1jQ532YK4qH46ZMTZn77S
         TOdGQ9WQY1anhHpw/dBZLGprghzwMTvSoZUYn0SwBtShoIsh/rRZeTJR3vdjk/nVFI
         78gZctIC8RCRVLE/IYsFQyYXg9z1ga+B8HIL6bFs=
Date:   Tue, 28 Feb 2023 08:34:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     dmitry.torokhov@gmail.com, swboyd@chromium.org,
        hdegoede@redhat.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, wsa+renesas@sang-engineering.com,
        tiwai@suse.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: atkbd - Make it possible to apply
 atkbd.reset via kernel quirk
Message-ID: <Y/2ueXSFK0iOR5M5@kroah.com>
References: <20230227185907.569154-1-wse@tuxedocomputers.com>
 <20230227185907.569154-2-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227185907.569154-2-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 07:59:06PM +0100, Werner Sembach wrote:
> atkbd.reset was only a command line parameter. Some devices might have a
> known bug that can be worked around by just permanently applying this
> quirk.
> 
> This patch adds the ability to do this on the kernel level for known buggy
> devices.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/keyboard/atkbd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 246958795f60..ef65c46c4efe 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1731,6 +1731,12 @@ static int __init atkbd_deactivate_fixup(const struct dmi_system_id *id)
>  	return 1;
>  }
>  
> +static int __init atkbd_reset_fixup(const struct dmi_system_id *id)
> +{
> +	atkbd_reset = true;
> +	return 1;

Why is this returning 1?  Who calls this?

And this should be a per-device attribute, not a global one, right?

thanks,

greg k-h
