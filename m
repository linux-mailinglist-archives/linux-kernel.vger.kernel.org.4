Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BE61F1D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiKGL3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:29:37 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C97648
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B8Qv3G6jlxbDnN0yOE9Mm49TEBfZzJWK2QWKJn/4g/E=; b=OKmL8xe/O0wgRO8t9gtcWKIjpC
        GoG99sdMaZA0k6TOA6REEMTwdPKVlWt1B62cudm31jh9VIFRkc6bFKr8RL/6LadKyAyo9epZIbSVJ
        X74Icm4ko/UdbJO6J0VCPf2CGRauort43+cnQpWKVPoy/FfLyxRxNcfmDyaK+mBICHhTgFieMVxGH
        FUB6ae6NWocOierzkzediJ5Mu0m17KyWqWmlErqxUk2XL7thDcFc/YN8BWiIuJRr9TUaKUg/V8mQ9
        wVtwKy2Axt5WAy6G+AiYRlrITea0Iou3CK83pwIBvZZErMEy2mNA4TgL5jIvIU5rvjExMOyO18bjK
        o5Eq8GAg==;
Received: from [2a01:799:95a:cb00:fd97:29ff:d72a:349e] (port=49995)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1os0Jp-0006SH-3V; Mon, 07 Nov 2022 12:29:33 +0100
Message-ID: <813ebf68-a7f4-441f-d0d6-f63fd923a479@tronnes.org>
Date:   Mon, 7 Nov 2022 12:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 16/23] drm/probe-helper: Provide a TV get_modes helper
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Karol Herbst <kherbst@redhat.com>, Emma Anholt <emma@anholt.net>,
        Ben Skeggs <bskeggs@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, linux-sunxi@lists.linux.dev,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-16-e7792734108f@cerno.tech>
 <842076aa-8d7c-96d6-ba46-d0e66dacd2df@tronnes.org>
 <20221107102126.klxrvfe34e6uriyx@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221107102126.klxrvfe34e6uriyx@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 07.11.2022 11.21, skrev Maxime Ripard:
> Hi Noralf,
> 
> I'll leave aside your comments on the code, since we'll use your implementation.
> 
> On Sun, Nov 06, 2022 at 05:33:48PM +0100, Noralf Trønnes wrote:
>> Den 26.10.2022 17.33, skrev maxime@cerno.tech:
>>> +
>>> +	if (cmdline->tv_mode_specified)
>>> +		default_mode = cmdline->tv_mode;
>>
>> I realised that we don't verify tv_mode coming from the command line,
>> not here and not in the reset helper. Should we do that? A driver should
>> be programmed defensively to handle an illegal/unsupported value, but it
>> doesn't feel right to allow an illegal enum value coming through the
>> core/helpers.
> 
> I don't think we can end up with an invalid value here if it's been
> specified.
> 
> We parse the command line through drm_mode_parse_tv_mode() (introduced
> in patch 13 "drm/modes: Introduce the tv_mode property as a command-line
> option") that will pick the tv mode part of the command line, and call
> drm_get_tv_mode_from_name() using it.
> 
> drm_get_tv_mode_from_name() will return a EINVAL if it's not a value we
> expect, and mode->tv_mode is only set on success. And AFAIK, there's no
> other path that will set tv_mode.
> 

I see now that illegal was the wrong word, but if the driver only
supports ntsc, the user can still set tv_mode=PAL right? And that's an
unsupported value that the driver can't fulfill, so it errors out. But
then again maybe that's just how it is, we can also set a display mode
that the driver can't handle, so this is no different in that respect.
Yeah, my argument lost some of its strength here :)

Noralf.
