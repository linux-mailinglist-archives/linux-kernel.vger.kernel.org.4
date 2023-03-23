Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43E6C61B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjCWIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjCWIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:32:00 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184E25BA6;
        Thu, 23 Mar 2023 01:31:59 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E7332100005;
        Thu, 23 Mar 2023 08:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679560317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDd1tQ/W5Z8aDygD3qGQ9dvWDUINrjV0N0N66+d7lpc=;
        b=PzcT9o7ji9u/dXSGXb6PtP6CQzgcHhTT8zhGYCvtujxPxxKXBTaggDueOSiguXoX2aVL5l
        31PPwc3OLu2pSDIlUnig5zhy7LCBDOpynVLazso+9YfV1tWvnmQmDWU45ebTgzX6JeZBMA
        5JF/KUs5PvgRUZ8JQRkCx00/HczUmyvT5rUg1QmIg2TjSh2mxufeBLBGiPYIttQ0nQbCRg
        evjwELvxhhf5oOOKkGbMRzqU+5KtKaaqIwfYnwq/U29or35s0wnWPrXjgSoDcjCYvSqyYA
        QV07XU3erWsCTRpwPFliOzu8NDId3K4aJ+qu3R/ZVka3eUpzuOlPm/PdpaOkog==
Date:   Thu, 23 Mar 2023 09:31:54 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/6] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230323093154.5852f81b@bootlin.com>
In-Reply-To: <551fe9b4-4c99-74b8-af44-9f431c488af8@linaro.org>
References: <20230322134654.219957-1-herve.codina@bootlin.com>
        <20230322134654.219957-3-herve.codina@bootlin.com>
        <551fe9b4-4c99-74b8-af44-9f431c488af8@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 08:30:39 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 22/03/2023 14:46, Herve Codina wrote:
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> 
> > +static const struct of_device_id pef2256_id_table[] = {
> > +	{ .compatible = "lantiq,pef2256" },
> > +	{} /* sentinel */
> > +};
> > +MODULE_DEVICE_TABLE(of, pef2256_id_table);
> > +
> > +static struct platform_driver pef2256_driver = {
> > +	.driver = {
> > +		.name = "lantiq-pef2256",
> > +		.of_match_table = of_match_ptr(pef2256_id_table),  
> 
> Drop of_match_ptr. This will case warnings with W=1 and !OF.
> 
> Best regards,
> Krzysztof
> 

Acked. Will be dropped in v4.

Thanks.
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
