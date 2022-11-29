Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296363BCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiK2JVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiK2JVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:21:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AC63E085
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:21:40 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ozwo3-0001ed-Mr; Tue, 29 Nov 2022 10:21:35 +0100
Message-ID: <ce69ab2c95e500ab94ab9ebc186c351a605ada89.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/5] drm/etnaviv: add HWDB entry for
 VIPNano-QI.7120.0055
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>
Date:   Tue, 29 Nov 2022 10:21:33 +0100
In-Reply-To: <20221129085047.49813-6-tomeu.vizoso@collabora.com>
References: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
         <20221129085047.49813-6-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomeu,

Am Dienstag, dem 29.11.2022 um 09:50 +0100 schrieb Tomeu Vizoso:
> This is a compute-only module marketed towards AI and vision
> acceleration. This particular version can be found on the Amlogic A311D
> SoC.
> 
> The feature bits are taken from the Khadas downstream kernel driver
> 6.4.4.3.310723AAA.
> 
Since the downstream driver uses NNCoreCount or the TP_Engine feature
bit to tell if a core is a NPU, I think we should add the NNCoreCount
field to the HWDB to be able to do the same.

Also I would like to see a notice printed into the kernel log that we
instantiated the driver on a NPU core and show it as experimental, as
I'm not sure if our UAPI covers all things that are needed for NPU
operation. I wouldn't want to break our basic assumption that the
kernel driver is in charge of cleaning write caches when switching
contexts and event management, which might require some UAPI additions
to work with the NPU accelerator programming model.

Regards,
Lucas

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> index f2fc645c7956..3f6fd9a3c088 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -130,6 +130,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>  		.minor_features10 = 0x90044250,
>  		.minor_features11 = 0x00000024,
>  	},
> +	{
> +		.model = 0x8000,
> +		.revision = 0x7120,
> +		.product_id = 0x45080009,
> +		.customer_id = 0x88,
> +		.eco_id = 0,
> +		.stream_count = 8,
> +		.register_max = 64,
> +		.thread_count = 256,
> +		.shader_core_count = 1,
> +		.vertex_cache_size = 16,
> +		.vertex_output_buffer_size = 1024,
> +		.pixel_pipes = 1,
> +		.instruction_count = 512,
> +		.num_constants = 320,
> +		.buffer_size = 0,
> +		.varyings_count = 16,
> +		.features = 0xe0287cac,
> +		.minor_features0 = 0xc1799eff,
> +		.minor_features1 = 0xfefbfadb,
> +		.minor_features2 = 0xeb9d6fbf,
> +		.minor_features3 = 0xedfffced,
> +		.minor_features4 = 0xd30dafc7,
> +		.minor_features5 = 0x7b5ac333,
> +		.minor_features6 = 0xfc8ee200,
> +		.minor_features7 = 0x03fffa6f,
> +		.minor_features8 = 0x00fe0ef0,
> +		.minor_features9 = 0x0088003c,
> +		.minor_features10 = 0x108048c0,
> +		.minor_features11 = 0x00000010,
> +	},
>  };
>  
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)


