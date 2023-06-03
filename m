Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE772105A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjFCOHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFCOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:07:47 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6328B4
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 07:07:46 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 026c733a-0218-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 17:07:44 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 17:07:43 +0300
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 6/9] ASoC: soc-dapm.h: Add a helper to build a DAPM
 widget dynamically
Message-ID: <ZHtJLxNReoc4Yjqj@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-7-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523151223.109551-7-herve.codina@bootlin.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 23, 2023 at 05:12:20PM +0200, Herve Codina kirjoitti:
> The SND_SOC_DAPM_* helpers family are used to build widgets array in a
> static way.
> 
> Introduce SND_SOC_DAPM_WIDGET() in order to use the SND_SOC_DAPM_*
> helpers family in a dynamic way. The different SND_SOC_DAPM_* parameters
> can be computed by the code and the widget can be built based on this
> parameter computation.
> For instance:
>   static int create_widget(char *input_name)
>   {
> 	struct snd_soc_dapm_widget widget;
> 	char name*;
> 	...
> 	name = input_name;
> 	if (!name)
> 		name = "default";
> 
> 	widget = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_INPUT(name));
> 	...
>   }

Maybe instead of adding a helper, simply convert those macros to provide
a compaund literal? (See, for example,
https://elixir.bootlin.com/linux/v6.4-rc4/source/include/linux/pinctrl/pinctrl.h#L42)

-- 
With Best Regards,
Andy Shevchenko


