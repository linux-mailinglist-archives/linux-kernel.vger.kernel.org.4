Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FD5F22F5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJBLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:34:52 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD9165A2;
        Sun,  2 Oct 2022 04:34:49 -0700 (PDT)
Received: from mail.onse.fi (87-95-225-209.bb.dnainternet.fi [87.95.225.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssi.hannula)
        by meesny.iki.fi (Postfix) with ESMTPSA id F402220048;
        Sun,  2 Oct 2022 14:34:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1664710486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26aK0X8sSRVV4NLxJX755bfG54xzNcdDxpvJf/0n8B0=;
        b=JcKAw3gVOAUp4eqAtZXBTTSWl18rO+tItfM20urAbXaKYiFhA7PYw8pD6L3L5E3bkC0koa
        kuAjLacM+1AWP9SXG9iaeaDVpfSop8Qr125G79+OMR5UHhQ/oFAz/sxCpZur9uVo56hDMD
        O8L7L5zb51Gkejqa9TYc7l2QwMpLAeY=
Received: from mail.onse.fi (delta.onse.fi [127.0.0.1])
        by mail.onse.fi (Postfix) with ESMTP id 24BAD3200A4;
        Sun,  2 Oct 2022 14:34:45 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.onse.fi 24BAD3200A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anssih.iki.fi;
        s=default; t=1664710485;
        bh=26aK0X8sSRVV4NLxJX755bfG54xzNcdDxpvJf/0n8B0=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=cAFLN82F1SwCTAlga4a//llHuCGDv+5MyC2MbUP/NS36lVPYfSkeM+NyWeRMKfXyA
         JOjKnaM3GdHV2m/f4IZfY/Wnkr70GdI7se6oNQmNt33UaQxu6iKZ6pewkscl8Z3Tte
         8zb9m0C2SmaTb9SG0TjpHVOTb+++7LvD3DDbaFkQ=
MIME-Version: 1.0
Date:   Sun, 02 Oct 2022 14:34:45 +0300
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     Paul Dino Jones <paul@spacefreak18.xyz>
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usbhid: Interpret 0 length ff effects as infinite
 (0xffff) length effects
In-Reply-To: <20221001221657.gexisc2egjn3mpog@localhost.localdomain>
References: <20221001221657.gexisc2egjn3mpog@localhost.localdomain>
Message-ID: <93f708f3f9ac8b5c94e6d0b86c1efaa3@iki.fi>
X-Sender: anssi.hannula@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=anssi.hannula smtp.mailfrom=anssi.hannula@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1664710486; a=rsa-sha256; cv=none;
        b=PuawkDF2iCtKTwxVTv4ZsZh/2WDYC8NH09Pv06qhrcWmaJs6YEzpnjslp3WV/NAqjU2X57
        Eb3fNOkckltKJBPvjiqIXZNUibqFshCaRdzzXbYJhDgf4LvBjxTvBzgTwnIl2Gpu7Et3iv
        SCHy/U43bfx3iAWUWWUAqL0+Y2G+iOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1664710486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=26aK0X8sSRVV4NLxJX755bfG54xzNcdDxpvJf/0n8B0=;
        b=Wk+tzMPM/M0uTPWyHcluiohPfcAmqezqs+W65FYWNChCBt4N6pKnu0MeziNdkFXP/fxWIy
        HAIZi2IdlfRGmEUVWbwDDOM5wWQ4NGGHVwZ+NAp1UyKxf2DWIqBpxcEFOMRf/906dY0hFo
        bVcgpE28nQyczgHG/u1SZgfG3cT4WAM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Dino Jones kirjoitti 2022-10-02 01:16:
> Greetings,

Hello, and thanks for looking into this!

> I started using my Accuforce V2 sim wheel on Linux. I was getting no
> response from racing simulators through wine, while native linux test
> tools worked properly. It appears that many real-world applications 
> will
> send 0 as the replay length, which was resulting in the behavior I was
> observing (nothing). The PID document does not explicitly state that 0
> length effects should be interpreted as infinite, but it does mention
> null effects being infinite effects.

Actually, it is Wine that is translating 0xFFFF from the application to 
0x0000 for the Linux FF API:
https://gitlab.winehq.org/wine/wine/-/blob/master/dlls/winebus.sys/bus_udev.c#L1124

Unfortunately "infinite" duration is not actually specified at all in 
our API currently.
input.h just says that the all durations are in msecs and values above 
0x7fff cause unspecified results.

We have three places where the duration is handled:
- ff-memless: Considers 0 as infinite (in ml_get_combo_effect() and 
calculate_next_time()).
- iforce-ff: Just passes the duration to HW as-is - it is unknown what 
counts as infinite, if any.
- pidff: Just passes the duration to HW as-is, so using the 
unspecified-by-API 0xffff results in infinite duration (per USB HID PID 
spec).

So we probably want to specify some value to work as infinite, likely 
either 0 or 0xFFFF, and explicitly document that in input.h.
I suspect that ff-memless devices are currently the most popular, and 
e.g. Wine already assumes 0 is infinite, and I can't think of a reason 
to have an "actual" 0-duration effect, so I guess 0 would be the most 
sensible value.

Since iforce is an "ancestor" of HID PID of sorts, it may also support 
0xffff = infinite.
I'll try to get hold of one to test, though it may take a couple of 
weeks...


> This patch will interpret 0 length force feedback effects as 0xffff
> (infinite) length effects, leaving other values for replay length
> unchanged.
> 
> Signed-off-by: Paul Dino Jones <paul@spacefreak18.xyz>
> ---
>  drivers/hid/usbhid/hid-pidff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/usbhid/hid-pidff.c 
> b/drivers/hid/usbhid/hid-pidff.c
> index 3b4ee21cd811..70653451c860 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -301,7 +301,7 @@ static void pidff_set_effect_report(struct
> pidff_device *pidff,
>  		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
>  	pidff->set_effect_type->value[0] =
>  		pidff->create_new_effect_type->value[0];
> -	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
> +	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length ==
> 0 ? 0xffff : effect->replay.length;
>  	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = 
> effect->trigger.button;
>  	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
>  		effect->trigger.interval;

-- 
Anssi Hannula
