Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DAC5FFB52
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJOQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJOQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:58:38 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808B4D24A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gRy1MHYPV0WjU4nMQ/DZ5j9qWrakSMjHmkC1JCQLKKk=; b=G9nlUqcHHVoUyqjchI57Tgoe/d
        m0lGjU3ZwAjc3YFmnUb6DEBU1fUKAWLFOBaxCcQJhLYc02d8hfd7deQYYai/8RdQK8jEt9nxd6oSI
        d57mdNzMsoRDprp6M2gwI4UKaHZXKKU2b4ZGt2Q5p4kdC6V9xEiC0TKUy0MuPdTGI3nMaMR1fkDRj
        0YPw6ta/NXrolu/c5x9cb4ETDRdQY67UfzMdwdetJCo8ou3OqZX6EpjIHn1UioQaztW25/wG92ADt
        jP05MU+8u9yN1bmPdqx1lgpm0jS8dOMGJanP0dXqafqWGPQGWtQ0ABLTwpdQcaMusFHsoEqyf5A/B
        qJcVU25A==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:62527 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1ojkUb-0004Ts-Bm; Sat, 15 Oct 2022 18:58:33 +0200
Message-ID: <61813964-8f3e-87b0-4124-4566a7f9c86e@tronnes.org>
Date:   Sat, 15 Oct 2022 18:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 07/22] drm/client: Add some tests for
 drm_connector_pick_cmdline_mode()
To:     Maxime Ripard <maxime@cerno.tech>,
        Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
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
 <20220728-rpi-analog-tv-properties-v5-7-d841cc64fe4b@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v5-7-d841cc64fe4b@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 13.10.2022 15.18, skrev Maxime Ripard:
> drm_connector_pick_cmdline_mode() is in charge of finding a proper
> drm_display_mode from the definition we got in the video= command line
> argument.
> 
> Let's add some unit tests to make sure we're not getting any regressions
> there.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---
> Changes in v5:
> - Removed useless (for now) count and modes intermediate variables in
>   get_modes
> - Switched to kunit assertions in test init, and to KUNIT_ASSERT_NOT_NULL
>   instead of KUNIT_ASSERT_PTR_NE(..., NULL)
> 
> Changes in v4:
> - Removed MODULE macros
> ---
>  drivers/gpu/drm/drm_client_modeset.c            |  4 +
>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 99 +++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index bbc535cc50dd..d553e793e673 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -1237,3 +1237,7 @@ int drm_client_modeset_dpms(struct drm_client_dev *client, int mode)
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_client_modeset_dpms);
> +
> +#ifdef CONFIG_DRM_KUNIT_TEST
> +#include "tests/drm_client_modeset_test.c"
> +#endif

I can't say I like including the file like this, but exporting the
static function for testing isn't attractive either and doing it like
this is shown in the kunit docs, so:

Acked-by: Noralf Trønnes <noralf@tronnes.org>
