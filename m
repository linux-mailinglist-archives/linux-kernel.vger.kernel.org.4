Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85E0716717
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjE3Paz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjE3Pax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:30:53 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93794C7;
        Tue, 30 May 2023 08:30:51 -0700 (PDT)
Received: from [192.168.178.25] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 877E82FC0073;
        Tue, 30 May 2023 17:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1685460649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAekkNJ91ucrLIslysTWlQCuNuST6srDBKEWW2bK6Mo=;
        b=qEZDK44NVdqpg1+rzrDXlcwupOzeJedAwpZi32dVcZJ5L59k3L3Y6S/zSjvarosO+wFE6X
        vETY2DoX/0G447KKZvmfO//RCgDCceb6LPWHp+p3KX18hgTsGUr5DENv8/Bh+h0Yk2Y/Gy
        mYNDl5uPl5OALX7rYL4hxcfgU35xotw=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <fe88e20b-d192-4c35-5e54-53027b36797e@tuxedocomputers.com>
Date:   Tue, 30 May 2023 17:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] input: Add new keyboard backlight control keys to match
 modern notebooks
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530110550.18289-1-wse@tuxedocomputers.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20230530110550.18289-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SCC_BODY_URI_ONLY,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.05.23 um 13:05 schrieb Werner Sembach:
> The old three KEY_KBDILLUM* keycodes don't reflect the current situation
> modern notebooks anymore. Especially the ones with RGB keyboards.
>
> e.g.
> - Clevo NL50NU has a toggle, an up, a down and a color-cycle key
> - TongFang PH4ARX1 doesn't have a toggle key, but one that cycles through
>    off, half-brightness, and full-brightness.
>
> Also, on some devices these keys are already implemented in firmware. It
> would still be nice if there is a way to let userspace know when one of
> these keys is pressed to display the OSD, but don't advice it to actually
> do anything. This is the intended purpose of the KEY_KBDILLUMCHANGE define.
Nevermind the KEY_KBDILLUMCHANGE. I just found out there is already a way to 
communicate this from kernel to userspace via sysfs 
https://docs.kernel.org/leds/leds-class.html#led-registration-api -> 
brightness_hw_changed
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   include/uapi/linux/input-event-codes.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 022a520e31fc2..05287bf9a77f7 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -803,6 +803,10 @@
>   #define BTN_TRIGGER_HAPPY39		0x2e6
>   #define BTN_TRIGGER_HAPPY40		0x2e7
>   
> +#define KEY_KBDILLUMCYCLE		0x2e8
> +#define KEY_KBDILLUMCOLORCYCLE		0x2e9
> +#define KEY_KBDILLUMCHANGE		0x2ea
> +
>   /* We avoid low common keys in module aliases so they don't get huge. */
>   #define KEY_MIN_INTERESTING	KEY_MUTE
>   #define KEY_MAX			0x2ff
