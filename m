Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20472654690
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiLVT1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiLVT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:26:47 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CD316591
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:26:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u9so7313670ejo.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkdYIiBNbyRc3wXAS6hL3mE7JDUZXVb9wv49/R8RZ1o=;
        b=QjvDiBT3HDQwH55j4taVz50qSDVwDb0rXUszHBIV2H0TPA0Vzy83NZty7fbrE/OvX1
         ybNEcUMQUG66j+YAu0Fh1wyKZw6GDIMvwa5da3ajXpLHw8qLXvUALin6k9nQTxVMJ/+E
         O+7KB1YLYM84TsSHAXT5g7tDcQXZJceeQKyqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkdYIiBNbyRc3wXAS6hL3mE7JDUZXVb9wv49/R8RZ1o=;
        b=U6qFLpUrR7SmxgKJ1yfN49SEZlOsfB6xuWUT7qrC1kc1bOJBNiVzc+DkTHeQkT5kYN
         nMKafnAsLhgu9Cftl7vNbqx6od30P7aAIfKTr4+Zc1HS51ueWJGrzurWAjZVleI2cQ6D
         GPKUE486CMJTp1ssHezOfVU2VbyRQnAg4ZNvB72qzhzu0UOxVqDZBRfFLWREBpD60rGA
         6ggU0t3vSWuuTrC2/ACXyHMC60/7HVlLibZR3C+OjSGss0C68eT9tWSWIzpE7IZiV4xh
         msGDzJlt78t0Kk5HsBq2jmt0tmUSec1xmL1amzAkkQNo3Nw+hnPplkGXmg0yIOkxD3Hm
         i2TA==
X-Gm-Message-State: AFqh2kpLAMWCFZbjl2w7Tt9HNzOEn69mpvlx4V8Sj96874j8A5i477ej
        mMuQDt0Xf4CWioMfGxTDQE+1w5qkvo6AC4yI2PE=
X-Google-Smtp-Source: AMrXdXujVBZE8x4G2a6wJh1v5VXSDRAg+sRf98LDj/C7swfGybgc1uKChznlRpr2xC2yBTg1JykU0Q==
X-Received: by 2002:a17:907:80cb:b0:7c0:deb1:bb8a with SMTP id io11-20020a17090780cb00b007c0deb1bb8amr7111948ejc.28.1671737200587;
        Thu, 22 Dec 2022 11:26:40 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b007c0fd177c0bsm558855ejo.46.2022.12.22.11.26.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 11:26:39 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id n3so1895800wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:26:39 -0800 (PST)
X-Received: by 2002:a05:6000:1f9c:b0:26f:7de2:a55e with SMTP id
 bw28-20020a0560001f9c00b0026f7de2a55emr192058wrb.617.1671737199562; Thu, 22
 Dec 2022 11:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20221222022605.v2.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
In-Reply-To: <20221222022605.v2.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Dec 2022 11:26:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XNxZ3iDYAAqKWqDVLihJ63Du4L7kDdKO55avR9nghc5A@mail.gmail.com>
Message-ID: <CAD=FV=XNxZ3iDYAAqKWqDVLihJ63Du4L7kDdKO55avR9nghc5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: misc: onboard_usb_hub: Don't create platform
 devices for DT nodes without 'vdd-supply'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>, stable@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Icenowy Zheng <uwu@icenowy.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 21, 2022 at 6:26 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The primary task of the onboard_usb_hub driver is to control the
> power of an onboard USB hub. The driver gets the regulator from the
> device tree property "vdd-supply" of the hub's DT node. Some boards
> have device tree nodes for USB hubs supported by this driver, but
> don't specify a "vdd-supply". This is not an error per se, it just
> means that the onboard hub driver can't be used for these hubs, so
> don't create platform devices for such nodes.
>
> This change doesn't completely fix the reported regression. It
> should fix it for the RPi 3 B Plus and boards with similar hub
> configurations (compatible DT nodes without "vdd-supply"), boards
> that actually use the onboard hub driver could still be impacted
> by the race conditions discussed in that thread. Not creating the
> platform devices for nodes without "vdd-supply" is the right
> thing to do, independently from the race condition, which will
> be fixed in future patch.
>
> Fixes: 8bc063641ceb ("usb: misc: Add onboard_usb_hub driver")
> Link: https://lore.kernel.org/r/d04bcc45-3471-4417-b30b-5cf9880d785d@i2se.com/
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - don't create platform devices when "vdd-supply" is missing,
>   rather than returning an error from _find_onboard_hub()
> - check for "vdd-supply" not "vdd" (Johan)
> - updated subject and commit message
> - added 'Link' tag (regzbot)
>
>  drivers/usb/misc/onboard_usb_hub_pdevs.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

I'm a tad bit skeptical.

It somehow feels a bit too much like "inside knowledge" to add this
here. I guess the "onboard_usb_hub_pdevs.c" is already pretty
entangled with "onboard_usb_hub.c", but I'd rather the "pdevs" file
keep the absolute minimum amount of stuff in it and all of the details
be in the other file.

If this was the only issue though, I'd be tempted to let it slide. As
it is, I'm kinda worried that your patch will break Alexander Stein,
who should have been CCed (I've CCed him now) or Icenowy Zheng (also
CCed now). I believe those folks are using the USB hub driver
primarily to drive a reset GPIO. Looking at the example in the
bindings for one of them (genesys,gl850g.yaml), I even see that the
reset-gpio is specified but not a vdd-supply. I think you'll break
that?

In general, it feels like it should actually be fine to create the USB
hub driver even if vdd isn't supplied. Sure, it won't do a lot, but it
shouldn't actively hurt anything. You'll just be turning off and on
bogus regulators and burning a few CPU cycles. I guess the problem is
some race condition that you talk about in the commit message. I'd
rather see that fixed... That being said, if we want to be more
efficient and not burn CPU cycles and memory in Stefan Wahren's case,
maybe the USB hub driver itself could return a canonical error value
from its probe when it detects that it has no useful job and then
"onboard_usb_hub_pdevs" could just silently bail out?
