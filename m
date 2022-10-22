Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B91608DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJVObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJVObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:31:18 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D12751A5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:31:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 31E0B2011C;
        Sat, 22 Oct 2022 16:31:15 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NYAcY9Gk2vYK; Sat, 22 Oct 2022 16:31:15 +0200 (CEST)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 0DA552011A;
        Sat, 22 Oct 2022 16:31:15 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1omFWs-0001v7-2G;
        Sat, 22 Oct 2022 16:31:14 +0200
Date:   Sat, 22 Oct 2022 16:31:14 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Accessiblity: speakup_bns: specifying the default driver
 parameters among the module params
Message-ID: <20221022143114.4zozcvq55dhavss4@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Osama Muhammad <osmtendev@gmail.com>, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
References: <20221021135342.254016-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021135342.254016-1-osmtendev@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Osama Muhammad, le ven. 21 oct. 2022 18:53:42 +0500, a ecrit:
> This is an enhancement which allows to specify the default driver
> parameters among the module parameters.
> 
> Adding a default variables to the speakup_bns module
> allows to easily set that at boot, rather than
> setting the sys variables after boot.
> More details can be found here:
> https://github.com/linux-speakup/speakup/issues/7
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
>  drivers/accessibility/speakup/speakup_bns.c | 36 ++++++++++++++++-----
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/speakup_bns.c b/drivers/accessibility/speakup/speakup_bns.c
> index b8103eb117b8..60507756499c 100644
> --- a/drivers/accessibility/speakup/speakup_bns.c
> +++ b/drivers/accessibility/speakup/speakup_bns.c
> @@ -16,14 +16,23 @@
>  #define SYNTH_CLEAR 0x18
>  #define PROCSPEECH '\r'
>  
> -static struct var_t vars[] = {
> -	{ CAPS_START, .u.s = {"\x05\x31\x32P" } },
> -	{ CAPS_STOP, .u.s = {"\x05\x38P" } },
> -	{ RATE, .u.n = {"\x05%dE", 8, 1, 16, 0, 0, NULL } },
> -	{ PITCH, .u.n = {"\x05%dP", 8, 0, 16, 0, 0, NULL } },
> -	{ VOL, .u.n = {"\x05%dV", 8, 0, 16, 0, 0, NULL } },
> -	{ TONE, .u.n = {"\x05%dT", 8, 0, 16, 0, 0, NULL } },
> -	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
> +
> +enum default_vars_id {
> +	CAPS_START_ID = 0, CAPS_STOP_ID,
> +	RATE_ID, PITCH_ID,
> +	VOL_ID, TONE_ID,
> +	DIRECT_ID, V_LAST_VAR_ID,
> +	NB_ID
> +};
> +
> +static struct var_t vars[NB_ID] = {
> +	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05\x31\x32P" } },
> +	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05\x38P" } },
> +	[RATE_ID] = { RATE, .u.n = {"\x05%dE", 8, 1, 16, 0, 0, NULL } },
> +	[PITCH_ID] = { PITCH, .u.n = {"\x05%dP", 8, 0, 16, 0, 0, NULL } },
> +	[VOL_ID] = { VOL, .u.n = {"\x05%dV", 8, 0, 16, 0, 0, NULL } },
> +	[TONE_ID] = { TONE, .u.n = {"\x05%dT", 8, 0, 16, 0, 0, NULL } },
> +	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
>  	V_LAST_VAR
>  };
>  
> @@ -113,10 +122,21 @@ static struct spk_synth synth_bns = {
>  module_param_named(ser, synth_bns.ser, int, 0444);
>  module_param_named(dev, synth_bns.dev_name, charp, 0444);
>  module_param_named(start, synth_bns.startup, short, 0444);
> +module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
> +module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
> +module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
> +module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
> +module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
> +
>  
>  MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
>  MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
>  MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
> +MODULE_PARM_DESC(rate, "Set the rate variable on load.");
> +MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
> +MODULE_PARM_DESC(vol, "Set the vol variable on load.");
> +MODULE_PARM_DESC(tone, "Set the tone variable on load.");
> +MODULE_PARM_DESC(direct, "Set the direct variable on load.");
>  
>  module_spk_synth(synth_bns);
>  
> -- 
> 2.25.1
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
