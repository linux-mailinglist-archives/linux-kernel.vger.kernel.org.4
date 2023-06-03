Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04EC72118E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFCS1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFCS1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:27:48 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DFAC2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 11:27:47 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 555a7ff2-023c-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 21:27:45 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 21:27:44 +0300
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
Subject: Re: [PATCH v2 9/9] ASoC: simple-card: Handle additional devices
Message-ID: <ZHuGIGDsyGWPTvKi@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-10-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523151223.109551-10-herve.codina@bootlin.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 23, 2023 at 05:12:23PM +0200, Herve Codina kirjoitti:
> An additional-devs subnode can be present in the simple-card top node.
> This subnode is used to declared some "virtual" additional devices.
> 
> Create related devices from this subnode and avoid this subnode presence
> to interfere with the already supported subnodes analysis.

...

> +static int simple_populate_aux(struct asoc_simple_priv *priv)
> +{
> +	struct device *dev = simple_priv_to_dev(priv);
> +	struct device_node *node;
> +	struct device **ptr;
> +	int ret;
> +
> +	node = of_get_child_by_name(dev->of_node, PREFIX "additional-devs");
> +	if (!node)
> +		return 0;
> +
> +	ptr = devres_alloc(simple_populate_aux_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = of_platform_populate(node, NULL, NULL, dev);
> +	if (ret) {
> +		devres_free(ptr);
> +	} else {
> +		*ptr = dev;
> +		devres_add(dev, ptr);
> +	}
> +	return ret;

This can be well simplified by using devm_add_action_or_reset().

> +}

-- 
With Best Regards,
Andy Shevchenko


