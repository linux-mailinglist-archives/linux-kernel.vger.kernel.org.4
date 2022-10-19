Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744D8604391
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJSLmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiJSLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:42:17 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7753B739
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DadoXiqteYpnLJ29i7DeTRmR70Jdg+khLdbmGW+Xm0A=; b=eqGdTjr9Okxo1LuL0OBpnuWT3+
        gswk4qO1MpzOsSl6Q5tK5MSZ/Z/EdiBzxQt9FQ/wxMqG9fgH3dZRqaqyaofErZC1occiE6A0eT9bF
        +cgAEOI31xUQIRTSYuoGi20bLNWgXKOYHZS6VB6YkAH5z1K8oS3hWitIGLDuSl/2M3ulT4BUuB423
        9VtMxYnT4ibV5DI47JR82Uk8FWIzCNdhfAtB3dF4sOREpDgFRPfGKZyclSmiQh+tb5Xrp7OzQtj7N
        NxO6opDh/Sse/qWjJq1ExuRKm9NBp/QhuxXZL0S+GDTDtFzw97F6Q00OwoLtb81+8L5Ij3TBBkhfq
        KPbfXByw==;
Received: from [2a01:799:95a:cb00:cca0:57ac:c55d:a485] (port=55269)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1ol6Xm-0007CC-Pr; Wed, 19 Oct 2022 12:43:26 +0200
Message-ID: <694facef-00bc-6b59-7c44-d68c7ca0c40f@tronnes.org>
Date:   Wed, 19 Oct 2022 12:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 12/22] drm/connector: Add a function to lookup a TV
 mode by its name
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Emma Anholt <emma@anholt.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-12-d841cc64fe4b@cerno.tech>
 <7dcf479c-8ac7-ed47-8587-30268684373c@tronnes.org>
 <20221018093353.pt4vset6o2ldxrbs@houat>
 <e3b98674-5a9e-16f3-4741-ffea43e05cc8@tronnes.org>
 <20221019084828.muy46td63bkyewxk@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221019084828.muy46td63bkyewxk@houat>
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



Den 19.10.2022 10.48, skrev Maxime Ripard:
> On Tue, Oct 18, 2022 at 02:29:00PM +0200, Noralf Trønnes wrote:
>>
>>
>> Den 18.10.2022 11.33, skrev Maxime Ripard:
>>> On Mon, Oct 17, 2022 at 12:44:45PM +0200, Noralf Trønnes wrote:
>>>> Den 13.10.2022 15.18, skrev Maxime Ripard:
>>>>> As part of the command line parsing rework coming in the next patches,
>>>>> we'll need to lookup drm_connector_tv_mode values by their name, already
>>>>> defined in drm_tv_mode_enum_list.
>>>>>
>>>>> In order to avoid any code duplication, let's do a function that will
>>>>> perform a lookup of a TV mode name and return its value.
>>>>>
>>>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>>>> ---
>>>>>  drivers/gpu/drm/drm_connector.c | 24 ++++++++++++++++++++++++
>>>>>  include/drm/drm_connector.h     |  2 ++
>>>>>  2 files changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>>>>> index 820f4c730b38..30611c616435 100644
>>>>> --- a/drivers/gpu/drm/drm_connector.c
>>>>> +++ b/drivers/gpu/drm/drm_connector.c
>>>>> @@ -991,6 +991,30 @@ static const struct drm_prop_enum_list drm_tv_mode_enum_list[] = {
>>>>>  };
>>>>>  DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
>>>>>  
>>>>> +/**
>>>>> + * drm_get_tv_mode_from_name - Translates a TV mode name into its enum value
>>>>> + * @name: TV Mode name we want to convert
>>>>> + * @len: Length of @name
>>>>> + *
>>>>> + * Translates @name into an enum drm_connector_tv_mode.
>>>>> + *
>>>>> + * Returns: the enum value on success, a negative errno otherwise.
>>>>> + */
>>>>> +int drm_get_tv_mode_from_name(const char *name, size_t len)
>>>>
>>>> Do we really need to pass in length here? item->name has to always be
>>>> NUL terminated otherwise things would break elsewhere, so it shouldn't
>>>> be necessary AFAICS.
>>>
>>> The only user so far is the command-line parsing code, and we might very
>>> well have an option after the tv_mode, something like
>>> 720x480i,tv_mode=NTSC,rotate=180
>>>
>>> In this case, we won't get a NULL-terminated name.
>>
>> My point is that item->name will always be NUL terminated so strcmp()
>> will never look past that.
> 
> Right, but we don't have the guarantee that strlen(item->name) <
> strlen(name), and we could thus just access after the end of our name
> 

Ok, using the length limiting str funtions is the safe thing to do, so
len needs to stay. But I don't get the 'strlen(item->name) == len'
check. strncmp() will stop when it reaches a NUL in either string so no
need for the length check?

Anyways:

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
