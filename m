Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893415FCCB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJLVCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJLVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:02:14 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD91038
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:01:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id E38FF20148;
        Wed, 12 Oct 2022 23:01:49 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CBk8J5dCBBeV; Wed, 12 Oct 2022 23:01:49 +0200 (CEST)
Received: from begin.home (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id EF1652012C;
        Wed, 12 Oct 2022 23:01:47 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oiirM-00CNqf-20;
        Wed, 12 Oct 2022 23:01:48 +0200
Date:   Wed, 12 Oct 2022 23:01:48 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Accessiblity: speakup: specifying the default driver
 parameters among the module params
Message-ID: <20221012210148.di6qxcdproztponz@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Osama Muhammad <osmtendev@gmail.com>, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
References: <20221012204723.110285-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012204723.110285-1-osmtendev@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Osama Muhammad, le jeu. 13 oct. 2022 01:47:23 +0500, a ecrit:
> +enum default_vars_id {
> +	DIRECT_ID = 0, CAPS_START_ID, CAPS_STOP_ID,
> +	PAUSE_ID, RATE_ID, PITCH_ID, INFLECTION_ID,
> +	VOL_ID, TONE_ID, PUNCT_ID, VOICE_ID,
> +	FREQUENCY_ID,
> +};
> +
> +
>  static struct var_t vars[] = {
>  	/* DIRECT is put first so that module_param_named can access it easily */
>  	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
> @@ -451,10 +460,33 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)

We need to make sure that the entries in vars are in the same order, so
use 

  	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },

etc. to make sure that the indexes are correct. Also add NB_ID as last
member of the enum, and use it for the "vars" array length, so we're
sure we're not missing anything.

>  module_param_named(start, synth_soft.startup, short, 0444);
> -module_param_named(direct, vars[0].u.n.default_val, int, 0444);
> +module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
> +module_param_named(caps_start, vars[CAPS_START_ID].u.s.default_val, charp, 0444);
> +module_param_named(caps_stop, vars[CAPS_STOP_ID].u.s.default_val, charp, 0444);
> +module_param_named(pause, vars[PAUSE_ID].u.n.default_val, int, 0444);
> +module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
> +module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
> +module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
> +module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
> +module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
> +module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
> +module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
> +module_param_named(frequency, vars[FREQUENCY_ID].u.n.default_val, int, 0444);

Not all vars make sense as parameters: caps_start, caps_stop and pause
are not actually tunable, so don't add a parameter for them.

Samuel
