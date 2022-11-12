Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B09626A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiKLQ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:29:46 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64948DF16
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ItdrEzd/ypbcqe2BCw66feMX7m17nPXFSJOaI27/nkQ=; b=rFsBBXpR5kW0ZTIRro+NqvImhk
        EhsHq7xGOjgbT5Q0JMV7Rup1oo8niXkDANAAgbHovP46Tc9i2Z0T0+LN9Z0LT7Wf4O0AyERaC7N4I
        sCC0JKdGDK/DiO/FJfBpqhXQkn3Cg72/KQIBKNoHojAbWzpjvqUNB1Z2Ks94AACK4uc2EI2mDnrLv
        UAKzvHVCTJwswnGU08vwygQY6vCNXKkQDiHrzyAOVaK52Myy4vxamy7VUC0onDOJmUgsGo/nAgNeV
        yBGpPCv6RuENflkIaDgPHpx4IAYutqo4ui1Fv38RPkkHgqG/nO2Q3qtS5LJe646/zMqtjDhA2brFp
        2x15nfjg==;
Received: from [2a01:799:95a:cb00:9d29:d4c4:45a0:777e] (port=49700)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1ottO1-0006e5-Er; Sat, 12 Nov 2022 17:29:41 +0100
Message-ID: <02747a6a-567a-5a70-4ab5-735eda8ac179@tronnes.org>
Date:   Sat, 12 Nov 2022 17:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 14/24] drm/modes: Properly generate a drm_display_mode
 from a named mode
To:     Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v8-0-09ce1466967c@cerno.tech>
 <20220728-rpi-analog-tv-properties-v8-14-09ce1466967c@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v8-14-09ce1466967c@cerno.tech>
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



Den 10.11.2022 12.07, skrev Maxime Ripard:
> The framework will get the drm_display_mode from the drm_cmdline_mode it
> got by parsing the video command line argument by calling
> drm_connector_pick_cmdline_mode().
> 
> The heavy lifting will then be done by the drm_mode_create_from_cmdline_mode()
> function.
> 
> In the case of the named modes though, there's no real code to make that
> translation and we rely on the drivers to guess which actual display mode
> we meant.
> 
> Let's modify drm_mode_create_from_cmdline_mode() to properly generate the
> drm_display_mode we mean when passing a named mode.
> 
> Tested-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
