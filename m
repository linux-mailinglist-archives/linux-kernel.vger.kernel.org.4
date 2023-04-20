Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D456A6E94BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjDTMkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjDTMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031487AAA;
        Thu, 20 Apr 2023 05:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C2C064933;
        Thu, 20 Apr 2023 12:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767F8C4339B;
        Thu, 20 Apr 2023 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681994391;
        bh=bEkdbyIx72etuIAUa7h/JO4/RfZQctLNpOFTkKfZP2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsnu7aGbIiJe8e/Wq0dB/VoyqAPHGW9sbLxsVwAV0vba0aMxuEg5i0nI8yNQFp5Cd
         pRBJGMmFjAYJo9ABzZtKsxSKn4KPevNYs5wq0pTkvpLmQOWgyTMVKm+Eg9xSjCOzyx
         JHEQJTqTybxSlHTKFKmdO6z/JtJR2hGH07hY7G24w1ruAU7R/qNCY1Lmc2NceXiSRs
         aBvEtPuc4x1dncYhmnan1NU/Vyy8cX50hJyFQA0QirH8kGS1Lga8X5UGBstXBb4tzm
         fjnZpX/h27Z1TpqI2OVkeGyWSAmJTe7K8GGFDyXjZ2XC+DSr2L9k4VQgFEfwZk4sP1
         zu8LLycUVhOCQ==
Date:   Thu, 20 Apr 2023 13:39:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/7] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230420123946.GB996918@google.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
 <20230417171601.74656-4-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417171601.74656-4-herve.codina@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Herve Codina wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/mfd/Kconfig         |  16 +
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/pef2256-regs.h  | 250 ++++++++++
>  drivers/mfd/pef2256.c       | 950 ++++++++++++++++++++++++++++++++++++

95% of this driver needs to be moved somewhere else.

What is a Framer?  Perhaps sound/ is a good candidate?

>  include/linux/mfd/pef2256.h |  52 ++
>  5 files changed, 1269 insertions(+)
>  create mode 100644 drivers/mfd/pef2256-regs.h
>  create mode 100644 drivers/mfd/pef2256.c
>  create mode 100644 include/linux/mfd/pef2256.h

[...]

> +static int pef2256_add_audio_devices(struct pef2256 *pef2256)
> +{
> +	const char *compatible = "lantiq,pef2256-codec";
> +	struct mfd_cell *audio_devs;
> +	struct device_node *np;
> +	unsigned int count = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	for_each_available_child_of_node(pef2256->dev->of_node, np) {
> +		if (of_device_is_compatible(np, compatible))
> +			count++;
> +	}

Converting Device Tree nodes into MFD cells to register with the
Platform Device API is not a reasonable use-case of MFD.

Have the CODEC driver match on "lantiq,pef2256-codec" and let it
instantiate itself.

Your first version using of_platform_populate() was closer to the mark.

> +	if (!count)
> +		return 0;
> +
> +	audio_devs = kcalloc(count, sizeof(*audio_devs), GFP_KERNEL);
> +	if (!audio_devs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < count; i++) {
> +		(audio_devs + i)->name = "lantiq-pef2256-codec";
> +		(audio_devs + i)->of_compatible = compatible;
> +		(audio_devs + i)->id = i;
> +	}
> +
> +	ret = mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);
> +	kfree(audio_devs);
> +	return ret;
> +}

-- 
Lee Jones [李琼斯]
