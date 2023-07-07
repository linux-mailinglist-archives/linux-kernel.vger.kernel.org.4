Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044E74ABFE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGGHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGGHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F401FCE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3916617BB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3787EC433CA;
        Fri,  7 Jul 2023 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688715319;
        bh=ngiEgkYK7ySolai9wW68canKG3JxLVmENycSOl9PzLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxeXnpDhClySaU6OWlU7dZSI5c6p79N+YHy2XZfHg/VpD5U+Pobs5W0IuRX0k8T5+
         pyptW7rPvsuoFeW37J0fSXj6SI4Hc6f4Z0cPAsmyVaiwPgOHZguLFjvt7dbEaBNVKx
         h0nGy+NdQ1HYAZCcCUg7vT3PNbOqNb2dqbN7Qj4mGyoNe/uj9Mx5K2WqWeHgaNRfSk
         IepdqSYaVm0+1BVdpNt79mJkoMDmbjZyfhU4/8meJ2bzCTNy9axKdKgtzkq+5Y/7Wn
         Unhi+g4vqzVlhbaKS33h/CBfkh7vyxtnrvNQmxhuRL+Hx11jkl8xdNh/MXvsdtD6uc
         ix61AaZSTc05A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHg0G-0004Mn-1k;
        Fri, 07 Jul 2023 09:35:44 +0200
Date:   Fri, 7 Jul 2023 09:35:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:57:23PM +0100, Srinivas Kandagatla wrote:
> dB range for HPHL and HPHR gains are from +6dB to -30dB in steps of
> 1.5dB with register values range from 0 to 24.
> 
> Current code maps these dB ranges incorrectly, fix them to allow proper
> volume setting.
> 
> Fixes: e8ba1e05bdc0("ASoC: codecs: wcd938x: add basic controls")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/wcd938x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index faa15a5ed2c8..3a3360711f8f 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -210,7 +210,7 @@ struct wcd938x_priv {
>  };
>  
>  static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
> -static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
> +static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);

This looks wrong, and indeed that forth argument appears to be a mute
flag. I guess that one should have been 0 (false) here?

Headphone output also appears to be way too loud by default with this
patch (alone) applied. Perhaps it's just the default mixer settings need
to be updated to match?

It looks like you're inverting the scale above. Perhaps that's intended,
but some more details in the commit message as to what was wrong and
what you intended to do would have been good.

Johan
