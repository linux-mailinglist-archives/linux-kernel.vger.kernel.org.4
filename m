Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D6600378
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJPVdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJPVdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 17:33:22 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF411829
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 14:33:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 5F3AF2015F;
        Sun, 16 Oct 2022 23:33:19 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lNgpmwb1JskA; Sun, 16 Oct 2022 23:33:19 +0200 (CEST)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id C2BAF20158;
        Sun, 16 Oct 2022 23:33:18 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1okBG2-004C2j-1S;
        Sun, 16 Oct 2022 23:33:18 +0200
Date:   Sun, 16 Oct 2022 23:33:18 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Accessiblity: speakup: specifying the default driver
 parameters among the module params
Message-ID: <20221016213318.zrvywwm5bbfj3r5j@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Osama Muhammad <osmtendev@gmail.com>, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
References: <20221016203936.5264-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221016203936.5264-1-osmtendev@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Osama Muhammad, le lun. 17 oct. 2022 01:39:36 +0500, a ecrit:
> This is an enhancement which allows to specify the default driver
> parameters among the module parameters.
> 
> Adding default variables to the speakup_soft module
> allows to easily set that at boot, rather than
> setting the sys variables after boot.
> More details can be found here:
> https://github.com/linux-speakup/speakup/issues/7
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

(it'd be useful to perform it on other drivers as well)

> 
> ---
> Changes since v2:
> 	- Removed an unnecessary comment.
> 
> Changes since v1:
> 	- Added NB_ID as the last member of enum default_vars_id.
> 	- Added NB_ID as the size of array vars.
> 	- Made sure that that the enteries in vars are in correct order.
> ---
>  drivers/accessibility/speakup/speakup_soft.c | 59 ++++++++++++++------
>  1 file changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
> index 28c8f60370cf..6d446824677b 100644
> --- a/drivers/accessibility/speakup/speakup_soft.c
> +++ b/drivers/accessibility/speakup/speakup_soft.c
> @@ -33,21 +33,30 @@ static struct miscdevice synth_device, synthu_device;
>  static int init_pos;
>  static int misc_registered;
>  
> -static struct var_t vars[] = {
> -	/* DIRECT is put first so that module_param_named can access it easily */
> -	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
> -
> -	{ CAPS_START, .u.s = {"\x01+3p" } },
> -	{ CAPS_STOP, .u.s = {"\x01-3p" } },
> -	{ PAUSE, .u.n = {"\x01P" } },
> -	{ RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
> -	{ PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
> -	{ INFLECTION, .u.n = {"\x01%dr", 5, 0, 9, 0, 0, NULL } },
> -	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
> -	{ TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
> -	{ PUNCT, .u.n = {"\x01%db", 0, 0, 3, 0, 0, NULL } },
> -	{ VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
> -	{ FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
> +
> +enum default_vars_id {
> +	DIRECT_ID = 0, CAPS_START_ID, CAPS_STOP_ID,
> +	PAUSE_ID, RATE_ID, PITCH_ID, INFLECTION_ID,
> +	VOL_ID, TONE_ID, PUNCT_ID, VOICE_ID,
> +	FREQUENCY_ID, V_LAST_VAR_ID,
> +	 NB_ID
> +};
> +
> +
> +static struct var_t vars[NB_ID] = {
> +
> +	[DIRECT_ID]  = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
> +	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x01+3p" } },
> +	[CAPS_STOP_ID]  = { CAPS_STOP, .u.s = {"\x01-3p" } },
> +	[PAUSE_ID]  = { PAUSE, .u.n = {"\x01P" } },
> +	[RATE_ID]  = { RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
> +	[PITCH_ID]  = { PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
> +	[INFLECTION_ID]  = { INFLECTION, .u.n = {"\x01%dr", 5, 0, 9, 0, 0, NULL } },
> +	[VOL_ID]  = { VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
> +	[TONE_ID]  = { TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
> +	[PUNCT_ID]  = { PUNCT, .u.n = {"\x01%db", 0, 0, 3, 0, 0, NULL } },
> +	[VOICE_ID]  = { VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
> +	[FREQUENCY_ID]  = { FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
>  	V_LAST_VAR
>  };
>  
> @@ -451,10 +460,28 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
>  }
>  
>  module_param_named(start, synth_soft.startup, short, 0444);
> -module_param_named(direct, vars[0].u.n.default_val, int, 0444);
> +module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
> +module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
> +module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
> +module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
> +module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
> +module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
> +module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
> +module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
> +module_param_named(frequency, vars[FREQUENCY_ID].u.n.default_val, int, 0444);
> +
> +
>  
>  MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
>  MODULE_PARM_DESC(direct, "Set the direct variable on load.");
> +MODULE_PARM_DESC(rate, "Sets the rate of the synthesizer.");
> +MODULE_PARM_DESC(pitch, "Sets the pitch of the synthesizer.");
> +MODULE_PARM_DESC(inflection, "Sets the inflection of the synthesizer.");
> +MODULE_PARM_DESC(vol, "Sets the volume of the speech synthesizer.");
> +MODULE_PARM_DESC(tone, "Sets the tone of the speech synthesizer.");
> +MODULE_PARM_DESC(punct, "Sets the amount of punctuation spoken by the synthesizer.");
> +MODULE_PARM_DESC(voice, "Sets the voice used by the synthesizer.");
> +MODULE_PARM_DESC(frequency, "Sets the frequency of speech synthesizer.");
>  
>  module_spk_synth(synth_soft);
>  
> -- 
> 2.25.1
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
