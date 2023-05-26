Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28171272E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbjEZNHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjEZNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:07:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F26119;
        Fri, 26 May 2023 06:07:09 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685106427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2J4eEM5RXIP4b+rP/8OD/qqkXSOa3635HqS8iL6gx8=;
        b=WzpM75Segot68BM+UMKk6uK+WErmwQKY5qyywJZSqXmF+qnTvlpGH35vAa9h6Epog44iG/
        8m1dH5Q9VTLZDgmDqYDwqMSyVaz2/u207HwBoHuT73nEXYAJ4D8u8GYiggK/yL2S0zGp4/
        eYTZfGcvi/nIiAZw0Z10Jl7DaDCgVn9OSz8rJo0x2Cy8sxYsd5P1qCBfE71+EpcLqw1yDX
        8Aq8tv2ynvm6CqTfdEso1ZVd8z4Om265ppGvsYMflNGj3LPY+2GfQVp84xmsqqB9sMFJDK
        m30UQ6DP6OGGxrRwcWiy/xP7+Qj3CVvuyNkOm0aisl+ob4Kzmj4ibxfoF0R76w==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E9B2C0006;
        Fri, 26 May 2023 13:07:03 +0000 (UTC)
Date:   Fri, 26 May 2023 15:07:02 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 9/9] ASoC: simple-card: Handle additional devices
Message-ID: <20230526150702.2555143c@bootlin.com>
In-Reply-To: <87v8ghgtyu.wl-kuninori.morimoto.gx@renesas.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-10-herve.codina@bootlin.com>
        <87mt1u7fql.wl-kuninori.morimoto.gx@renesas.com>
        <20230524141411.28765782@bootlin.com>
        <87v8ghgtyu.wl-kuninori.morimoto.gx@renesas.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 00:01:14 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> Hi Herve
> 
> Thank you for your reply.
> 
> > So, IMHO, calling simple_populate_aux() from __simple_for_each_link() is
> > not correct as it has nothing to do with DAI links and must be call once
> > per Card.  
> 
> My biggest concern is that this code is calling same code multiple times.
> It is easy to forget such thing when updating in this kind of code.
> We don't forget / take mistake if these are merged.
> But we have such code everywhere ;) this is just my concern, not a big deal.
> 
> 	static int __simple_for_each_link (...)
> 	{
> 		...
> =>		add_devs = of_get_child_by_name(top, PREFIX "additional-devs");  
> 		...
> 	}
> 
> 	static int simple_populate_aux(...)
> 	{
> 		...
> =>		node = of_get_child_by_name(dev->of_node, PREFIX "additional-devs");  
> 		...
> 	}
> 

Well, of_get_child_by_name() is called twice to retrieve the additional-devs
node but for very different reason.

In __simple_for_each_link() to filter out the node as it has nothing to do with a DAI.
In simple_populate_aux() to take care of the devices declared in the node.

I am not sure that we should avoid that.
It will lead to a more complex code and flags just to avoid this call.

Not sure that it will be better.
__simple_for_each_link() is called multiple times and is supposed to look at links.
To avoid the of_get_child_by_name() filter-out call, __simple_for_each_link()
will look at link *and* populate devices calling simple_populate_aux().
And to do that correctly it will use a flag to be sure that simple_populate_aux()
was called only once.


In order to avoid some kind of duplication (at least the node name):

	static struct device_node *simple_of_get_add_devs(struct device_node *node)
	{
		return of_get_child_by_name(node, PREFIX "additional-devs");
	}

	static int __simple_for_each_link (...)
	{
		...
=>		add_devs = simple_of_get_add_devs(top);  
		...
	}

	static int simple_populate_aux(...)
	{
		...
=>		node = simple_of_get_add_devs(dev->of_node);  
		...
	}


Does it look better ?

Best regards,
Hervé

> Thank you for your help !!
> 
> Best regards
> ---
> Kuninori Morimoto



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
