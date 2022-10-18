Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8826F6034FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJRVag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJRVa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:30:29 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C36B7EC1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:30:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 132AB20183;
        Tue, 18 Oct 2022 23:30:24 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uFR9usVP5MSR; Tue, 18 Oct 2022 23:30:23 +0200 (CEST)
Received: from begin (186.69.205.77.rev.sfr.net [77.205.69.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 8DD862017E;
        Tue, 18 Oct 2022 23:30:23 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1okuAG-007xkb-1Y;
        Tue, 18 Oct 2022 23:30:20 +0200
Date:   Tue, 18 Oct 2022 23:30:20 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Accessiblity: speakup: specifying the default driver
 parameters among the module params
Message-ID: <20221018213020.rjgkfi5j4yk76rqy@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Osama Muhammad <osmtendev@gmail.com>, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
References: <20221018203308.6143-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018203308.6143-1-osmtendev@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Osama Muhammad, le mer. 19 oct. 2022 01:33:08 +0500, a ecrit:
> This is an enhancement which allows to specify the default driver
> parameters among the module parameters.
> 
> Adding default variables to the speakup_acntpc.c and speakup_acntsa.c
> module allows to easily set that at boot, rather than
> setting the sys variables after boot.
> More details can be found here:
> https://github.com/linux-speakup/speakup/issues/7
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  .../accessibility/speakup/speakup_acntpc.c    | 38 +++++++++++++++----
>  .../accessibility/speakup/speakup_acntsa.c    | 37 ++++++++++++++----
>  2 files changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
> index a55b60754eb1..a27e6bbf05da 100644
> --- a/drivers/accessibility/speakup/speakup_acntpc.c
> +++ b/drivers/accessibility/speakup/speakup_acntpc.c
> @@ -34,14 +34,23 @@ static int synth_port_control;
>  static int port_forced;
>  static unsigned int synth_portlist[] = { 0x2a8, 0 };
>  
> -static struct var_t vars[] = {
> -	{ CAPS_START, .u.s = {"\033P8" } },
> -	{ CAPS_STOP, .u.s = {"\033P5" } },
> -	{ RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
> -	{ PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
> -	{ VOL, .u.n = {"\033A%d", 5, 0, 9, 0, 0, NULL } },
> -	{ TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
> -	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
> +enum default_vars_id {
> +	CAPS_START_ID = 0, CAPS_STOP_ID,
> +	RATE_ID, PITCH_ID,
> +	VOL_ID, TONE_ID,
> +	DIRECT_ID, V_LAST_VAR_ID,
> +	NB_ID
> +};
> +
> +
> +static struct var_t vars[NB_ID] = {
> +	[CAPS_START_ID] = { CAPS_START, .u.s = {"\033P8" } },
> +	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\033P5" } },
> +	[RATE_ID] = { RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
> +	[PITCH_ID] = { PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
> +	[VOL_ID] = { VOL, .u.n = {"\033A%d", 5, 0, 9, 0, 0, NULL } },
> +	[TONE_ID] = { TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
> +	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
>  	V_LAST_VAR
>  };
>  
> @@ -305,9 +314,22 @@ static void accent_release(struct spk_synth *synth)
>  
>  module_param_hw_named(port, port_forced, int, ioport, 0444);
>  module_param_named(start, synth_acntpc.startup, short, 0444);
> +module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
> +module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
> +module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
> +module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
> +module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
> +
> +
>  
>  MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");
>  MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
> +MODULE_PARM_DESC(rate, "Set the rate variable on load.");
> +MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
> +MODULE_PARM_DESC(vol, "Set the vol variable on load.");
> +MODULE_PARM_DESC(tone, "Set the tone variable on load.");
> +MODULE_PARM_DESC(direct, "Set the direct variable on load.");
> +
>  
>  module_spk_synth(synth_acntpc);
>  
> diff --git a/drivers/accessibility/speakup/speakup_acntsa.c b/drivers/accessibility/speakup/speakup_acntsa.c
> index 2697c51ed6b5..26bb9f9399d3 100644
> --- a/drivers/accessibility/speakup/speakup_acntsa.c
> +++ b/drivers/accessibility/speakup/speakup_acntsa.c
> @@ -19,14 +19,24 @@
>  
>  static int synth_probe(struct spk_synth *synth);
>  
> -static struct var_t vars[] = {
> -	{ CAPS_START, .u.s = {"\033P8" } },
> -	{ CAPS_STOP, .u.s = {"\033P5" } },
> -	{ RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
> -	{ PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
> -	{ VOL, .u.n = {"\033A%d", 9, 0, 9, 0, 0, NULL } },
> -	{ TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
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
> +
> +static struct var_t vars[NB_ID] = {
> +	[CAPS_START_ID] = { CAPS_START, .u.s = {"\033P8" } },
> +	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\033P5" } },
> +	[RATE_ID] = { RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
> +	[PITCH_ID] = { PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
> +	[VOL_ID] = { VOL, .u.n = {"\033A%d", 9, 0, 9, 0, 0, NULL } },
> +	[TONE_ID] = { TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
> +	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
>  	V_LAST_VAR
>  };
>  
> @@ -129,10 +139,21 @@ static int synth_probe(struct spk_synth *synth)
>  module_param_named(ser, synth_acntsa.ser, int, 0444);
>  module_param_named(dev, synth_acntsa.dev_name, charp, 0444);
>  module_param_named(start, synth_acntsa.startup, short, 0444);
> +module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
> +module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
> +module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
> +module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
> +module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
>  
>  MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
>  MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
>  MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
> +MODULE_PARM_DESC(rate, "Set the rate variable on load.");
> +MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
> +MODULE_PARM_DESC(vol, "Set the vol variable on load.");
> +MODULE_PARM_DESC(tone, "Set the tone variable on load.");
> +MODULE_PARM_DESC(direct, "Set the direct variable on load.");
> +
>  
>  module_spk_synth(synth_acntsa);
>  
> -- 
> 2.25.1
> 
