Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC45F1E76
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJARoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJARoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:44:08 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F5F2180F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9ZvRHOU18e7h4A4d6PSko7Bg/uoJADNtuvXxaSjBcE4=; b=kukm3IuTORUMlf/QbJJMHUAuvQ
        V1G70+Abwv3zlu6kGWVMJ57PKpgHIsQWsnEIODq4QjM10fSQZ8+rR831octdmaAcgajX3CJpgeumx
        V0MRBeYUKLuv4P6RBu3GdW491xkZxdYfSbXumQwHF+/hqLfqJDY5wQGF33lRb3IZCugDEDRKV/qsw
        bmYTknaQduH2/X81nkpC4xlzmT3ykrIm8l0MxiUqwBD68HtVcrHt1nVp3WX3qBt0TxMlmolAS6sfY
        Qdg/Fcg7u+8xbM0/dWcauL+Mryw4w5YKuvsevTIoo0X2EYdaWuF76tNywAeohTGwPjKsvbrqVEKy8
        FQWJBrIQ==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oegVf-002bNr-M6; Sat, 01 Oct 2022 19:42:43 +0200
Message-ID: <4d9d7795-7e98-5bca-14fd-8e8f86da31b3@igalia.com>
Date:   Sat, 1 Oct 2022 14:42:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 14/30] drm/client: Add some tests for
 drm_connector_pick_cmdline_mode()
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20220728-rpi-analog-tv-properties-v4-0-60d38873f782@cerno.tech>
 <20220728-rpi-analog-tv-properties-v4-14-60d38873f782@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20220728-rpi-analog-tv-properties-v4-14-60d38873f782@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 13:31, Maxime Ripard wrote:
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
> Changes in v4:
> - Removed MODULE macros
> ---
>  drivers/gpu/drm/drm_client_modeset.c            |   4 +
>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 105 ++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
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
> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> new file mode 100644
> index 000000000000..09dc5acbbc42
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Maxime Ripard <mripard@kernel.org>
> + */
> +
> +#include <kunit/test.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include "drm_kunit_helpers.h"
> +
> +struct drm_client_modeset_test_priv {
> +	struct drm_device *drm;
> +	struct drm_connector connector;
> +};
> +
> +static int drm_client_modeset_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct drm_display_mode *mode;

Small nit: I guess this should be added on patch 21/30, as it is not
being currently used.

> +	int count;
> +
> +	count = drm_add_modes_noedid(connector, 1920, 1200);
> +
> +	return count;
> +}
> +
> +static const struct drm_connector_helper_funcs drm_client_modeset_connector_helper_funcs = {
> +	.get_modes = drm_client_modeset_connector_get_modes,
> +};
> +
> +static const struct drm_connector_funcs drm_client_modeset_connector_funcs = {
> +};
> +
> +static int drm_client_modeset_test_init(struct kunit *test)
> +{
> +	struct drm_client_modeset_test_priv *priv;
> +	int ret;
> +
> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;

I believe it would be nicer to use KUNIT_ASSERT_NOT_NULL here, instead
of returning a error.

> +	test->priv = priv;
> +
> +	priv->drm = drm_kunit_device_init(test, "drm-client-modeset-test");
> +	if (IS_ERR(priv->drm))
> +		return PTR_ERR(priv->drm);

Here you could use KUNIT_ASSERT_NOT_ERR_OR_NULL.

> +
> +	ret = drmm_connector_init(priv->drm, &priv->connector,
> +				  &drm_client_modeset_connector_funcs,
> +				  DRM_MODE_CONNECTOR_Unknown,
> +				  NULL);
> +	if (ret)
> +		return ret;

Same idea here. This would make it more compliant to the KUnit API.

> +	drm_connector_helper_add(&priv->connector, &drm_client_modeset_connector_helper_funcs);
> +
> +	return 0;
> +
> +}
> +
> +static void drm_pick_cmdline_res_1920_1080_60(struct kunit *test)
> +{
> +	struct drm_client_modeset_test_priv *priv = test->priv;
> +	struct drm_device *drm = priv->drm;
> +	struct drm_connector *connector = &priv->connector;
> +	struct drm_cmdline_mode *cmdline_mode = &connector->cmdline_mode;
> +	struct drm_display_mode *expected_mode, *mode;
> +	const char *cmdline = "1920x1080@60";
> +	int ret;
> +
> +	expected_mode = drm_mode_find_dmt(priv->drm, 1920, 1080, 60, false);
> +	KUNIT_ASSERT_PTR_NE(test, expected_mode, NULL);

You could use KUNIT_ASSERT_NOT_NULL here.

> +
> +	KUNIT_ASSERT_TRUE(test,
> +			  drm_mode_parse_command_line_for_connector(cmdline,
> +								    connector,
> +								    cmdline_mode));
> +
> +	mutex_lock(&drm->mode_config.mutex);
> +	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
> +	mutex_unlock(&drm->mode_config.mutex);
> +	KUNIT_ASSERT_GT(test, ret, 0);
> +
> +	mode = drm_connector_pick_cmdline_mode(connector);
> +	KUNIT_ASSERT_PTR_NE(test, mode, NULL);

You could also use KUNIT_ASSERT_NOT_NULL here.

This idea could also apply to the patches 21/30 and 22/30, which have a
similar structure and are also using KUNIT_ASSERT_PTR_NE.

Best Regards,
- Maíra Canal

> +
> +	KUNIT_EXPECT_TRUE(test, drm_mode_equal(expected_mode, mode));
> +}
> +
> +static struct kunit_case drm_pick_cmdline_tests[] = {
> +	KUNIT_CASE(drm_pick_cmdline_res_1920_1080_60),
> +	{}
> +};
> +
> +static struct kunit_suite drm_pick_cmdline_test_suite = {
> +	.name = "drm_pick_cmdline",
> +	.init = drm_client_modeset_test_init,
> +	.test_cases = drm_pick_cmdline_tests
> +};
> +
> +kunit_test_suite(drm_pick_cmdline_test_suite);
> 
