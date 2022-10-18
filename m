Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83FF602BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJRM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJRM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:29:10 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75259B7F59
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/VMmtMu4pQhq3eb3CmoCzX4wgnyZcOj95TFTQ8SYeac=; b=MhYLd2PQ4CLURN4fZx7LJYFGlc
        f18Cit2mCb9dZGn9UkBRC9+Bpla51HhjDEFdmmsNcWBdcx4T35meDGoP7CUSvF6Sm7KtX83nXemCn
        YwYtxOULoeeyEizMFkBf/5rhLSKDbUDMK7IA7wvIVA0aG7n22ta2bUN0KBfJTBV0TgglUrVfBitA2
        Gf2sK5RaxJeCX3jdyh4SJVCK4Dpb+O+TBijpKiF/prYMnUgGAAfsKfgwniZdEzwxQKmyzq0LlVTK7
        U55+ylYLtbACenlyou3/I9wCoNsJN0EelI5asWYVDExI7TrrWU2+5ay53rXTuwdsbiimGX9p48MZ/
        3aomOqhw==;
Received: from [2a01:799:95a:cb00:cc2f:df30:b81e:38c0] (port=62480)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1okliU-00015y-Is; Tue, 18 Oct 2022 14:29:06 +0200
Message-ID: <e3b98674-5a9e-16f3-4741-ffea43e05cc8@tronnes.org>
Date:   Tue, 18 Oct 2022 14:29:00 +0200
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
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221018093353.pt4vset6o2ldxrbs@houat>
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



Den 18.10.2022 11.33, skrev Maxime Ripard:
> On Mon, Oct 17, 2022 at 12:44:45PM +0200, Noralf Trønnes wrote:
>> Den 13.10.2022 15.18, skrev Maxime Ripard:
>>> As part of the command line parsing rework coming in the next patches,
>>> we'll need to lookup drm_connector_tv_mode values by their name, already
>>> defined in drm_tv_mode_enum_list.
>>>
>>> In order to avoid any code duplication, let's do a function that will
>>> perform a lookup of a TV mode name and return its value.
>>>
>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>> ---
>>>  drivers/gpu/drm/drm_connector.c | 24 ++++++++++++++++++++++++
>>>  include/drm/drm_connector.h     |  2 ++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>>> index 820f4c730b38..30611c616435 100644
>>> --- a/drivers/gpu/drm/drm_connector.c
>>> +++ b/drivers/gpu/drm/drm_connector.c
>>> @@ -991,6 +991,30 @@ static const struct drm_prop_enum_list drm_tv_mode_enum_list[] = {
>>>  };
>>>  DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
>>>  
>>> +/**
>>> + * drm_get_tv_mode_from_name - Translates a TV mode name into its enum value
>>> + * @name: TV Mode name we want to convert
>>> + * @len: Length of @name
>>> + *
>>> + * Translates @name into an enum drm_connector_tv_mode.
>>> + *
>>> + * Returns: the enum value on success, a negative errno otherwise.
>>> + */
>>> +int drm_get_tv_mode_from_name(const char *name, size_t len)
>>
>> Do we really need to pass in length here? item->name has to always be
>> NUL terminated otherwise things would break elsewhere, so it shouldn't
>> be necessary AFAICS.
> 
> The only user so far is the command-line parsing code, and we might very
> well have an option after the tv_mode, something like
> 720x480i,tv_mode=NTSC,rotate=180
> 
> In this case, we won't get a NULL-terminated name.
> 

My point is that item->name will always be NUL terminated so strcmp()
will never look past that.

Noralf.
