Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C56E962E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDTNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDTNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D81892;
        Thu, 20 Apr 2023 06:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6E78649A4;
        Thu, 20 Apr 2023 13:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074D9C433D2;
        Thu, 20 Apr 2023 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681998429;
        bh=1QyZRHlOCNh9KYcYd1u1wFLy/1mxyOjwo5PSkFTP51Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7KbwL3B37Ss08VH2w5iWaWpX9Jl6YME4jhFY3c8tFLqpQ16ldi0kp6YLjZ4L5QKH
         EUKyNwzn2BqYWOpofJeddadPrTiicNAOoOnsiW76Plp8dZeB87tTpub5KknGRaeGTB
         PpAKO0551ifA+rY5VD4PCGpp8twUlDNplmKCBsKh1WeWjHwIMFvwo6jds6K6I+bl49
         uY/LpWRzxcPDknDfGFvSyIlP0VSxxhcX78w2I+rEs8NkuzepB6EWjCcu9oKldt0w4I
         Ao5xZvvalV+RC9NJXFPB17qfXkZFueFyGRUx5eHCrDaG/zYCLeaqizq+a7w9EOIAQU
         w1b4GUDOuYqYA==
Date:   Thu, 20 Apr 2023 14:47:03 +0100
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
Message-ID: <20230420134703.GC996918@google.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
 <20230417171601.74656-4-herve.codina@bootlin.com>
 <20230420123946.GB996918@google.com>
 <20230420151551.78c1288b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230420151551.78c1288b@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023, Herve Codina wrote:

> On Thu, 20 Apr 2023 13:39:46 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Mon, 17 Apr 2023, Herve Codina wrote:
> > 
> > > The Lantiq PEF2256 is a framer and line interface component designed to
> > > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > > digital PCM system highway/H.100 bus.
> > > 
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > >  drivers/mfd/Kconfig         |  16 +
> > >  drivers/mfd/Makefile        |   1 +
> > >  drivers/mfd/pef2256-regs.h  | 250 ++++++++++
> > >  drivers/mfd/pef2256.c       | 950 ++++++++++++++++++++++++++++++++++++  
> > 
> > 95% of this driver needs to be moved somewhere else.
> > 
> > What is a Framer?  Perhaps sound/ is a good candidate?
> 
> The pef2256 framer is a device that transfers data to/from a TDM (time-slots
> data) from/to quite old telecommunication lines (E1 in my case).
> Several subsystem can set/get data to/from the TDM. Each device using their
> own time-slots set.
> 
> On my use-case, I have some audio consumer and a not yet upstreamed HDLC
> consumer. Both of them uses the framer to know the E1 link state.
> The framer needs to be initialized 'globally' and not by a specific consumer
> as several consumers can use the framer.

I can't think of a good place for this.

If all else fails, it's drivers/misc

> > >  include/linux/mfd/pef2256.h |  52 ++
> > >  5 files changed, 1269 insertions(+)
> > >  create mode 100644 drivers/mfd/pef2256-regs.h
> > >  create mode 100644 drivers/mfd/pef2256.c
> > >  create mode 100644 include/linux/mfd/pef2256.h  
> > 
> > [...]
> > 
> > > +static int pef2256_add_audio_devices(struct pef2256 *pef2256)
> > > +{
> > > +	const char *compatible = "lantiq,pef2256-codec";
> > > +	struct mfd_cell *audio_devs;
> > > +	struct device_node *np;
> > > +	unsigned int count = 0;
> > > +	unsigned int i;
> > > +	int ret;
> > > +
> > > +	for_each_available_child_of_node(pef2256->dev->of_node, np) {
> > > +		if (of_device_is_compatible(np, compatible))
> > > +			count++;
> > > +	}  
> > 
> > Converting Device Tree nodes into MFD cells to register with the
> > Platform Device API is not a reasonable use-case of MFD.
> > 
> > Have the CODEC driver match on "lantiq,pef2256-codec" and let it
> > instantiate itself.
> 
> As the framer is going to used by several subsystem, I cannot instantiate
> it in the specific ASoC subsystem.
> 
> > 
> > Your first version using of_platform_populate() was closer to the mark.
> 
> The issue was that I need MFD cells for the pinctrl part.

Why can't it be represented in DT?

> > > +	if (!count)
> > > +		return 0;
> > > +
> > > +	audio_devs = kcalloc(count, sizeof(*audio_devs), GFP_KERNEL);
> > > +	if (!audio_devs)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < count; i++) {
> > > +		(audio_devs + i)->name = "lantiq-pef2256-codec";
> > > +		(audio_devs + i)->of_compatible = compatible;
> > > +		(audio_devs + i)->id = i;
> > > +	}
> > > +
> > > +	ret = mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);
> > > +	kfree(audio_devs);
> > > +	return ret;
> > > +}  

-- 
Lee Jones [李琼斯]
