Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0866EC979
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDXJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjDXJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D326BD;
        Mon, 24 Apr 2023 02:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 969AC61F83;
        Mon, 24 Apr 2023 09:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B832C433EF;
        Mon, 24 Apr 2023 09:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682329963;
        bh=8nXbvKN3NVOq1MNMv2BKZhKpGyGFEU9KPwYeI4htA1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYctiapfbLl+v3aiA7xN8Q4wOwyqvb4gdGU+zMHB9DiPq5oiH9iFm4VyDM/x8l0IK
         EWBqN4LKCvBxZwuR2nMMHJ8ILfNzMfHJDuCAeGEzHD/G5LYObnKm1Am3lKpnxGomp2
         b5P9cf7qS26wDU1OxGkEMc9OYD72iutYMkf88wEVbhxyJbkGwrbsO4O/hGrfdYNoud
         TrQmiiT3OvxjYCh9WWYnt6+gpqN2Wmb+QzMatz1LWVu3vnrPKEE8Jr4GWHhXf7J80/
         mRuKFKHa5U5Oj6sZGPwVQgJ6jOYJX+qkq6Le/M3nkmp1Bx5FufXOGoZbW/ZcRVvOr1
         O+kgUXnCW8oJQ==
Date:   Mon, 24 Apr 2023 10:52:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/7] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230424095200.GC8035@google.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
 <20230417171601.74656-4-herve.codina@bootlin.com>
 <20230420123946.GB996918@google.com>
 <20230420151551.78c1288b@bootlin.com>
 <20230420134703.GC996918@google.com>
 <20230421092645.56127f11@bootlin.com>
 <20230421074558.GQ996918@google.com>
 <054a384b-b0ef-2697-4a70-09868694ec6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <054a384b-b0ef-2697-4a70-09868694ec6d@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023, Krzysztof Kozlowski wrote:

> On 21/04/2023 09:45, Lee Jones wrote:
> > On Fri, 21 Apr 2023, Herve Codina wrote:
> > 
> >> Hi Lee, Krzysztof,
> >>
> >> On Thu, 20 Apr 2023 14:47:03 +0100
> >> Lee Jones <lee@kernel.org> wrote:
> >>
> >>> On Thu, 20 Apr 2023, Herve Codina wrote:
> >>>
> >>>> On Thu, 20 Apr 2023 13:39:46 +0100
> >>>> Lee Jones <lee@kernel.org> wrote:
> >>>>   
> >>>>> On Mon, 17 Apr 2023, Herve Codina wrote:
> >>>>>   
> >>>>>> The Lantiq PEF2256 is a framer and line interface component designed to
> >>>>>> fulfill all required interfacing between an analog E1/T1/J1 line and the
> >>>>>> digital PCM system highway/H.100 bus.
> >>>>>>
> >>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>>>>> ---
> >>>>>>  drivers/mfd/Kconfig         |  16 +
> >>>>>>  drivers/mfd/Makefile        |   1 +
> >>>>>>  drivers/mfd/pef2256-regs.h  | 250 ++++++++++
> >>>>>>  drivers/mfd/pef2256.c       | 950 ++++++++++++++++++++++++++++++++++++    
> >>>>>
> >>>>> 95% of this driver needs to be moved somewhere else.
> >>>>>
> >>>>> What is a Framer?  Perhaps sound/ is a good candidate?  
> >>>>
> >>>> The pef2256 framer is a device that transfers data to/from a TDM (time-slots
> >>>> data) from/to quite old telecommunication lines (E1 in my case).
> >>>> Several subsystem can set/get data to/from the TDM. Each device using their
> >>>> own time-slots set.
> >>>>
> >>>> On my use-case, I have some audio consumer and a not yet upstreamed HDLC
> >>>> consumer. Both of them uses the framer to know the E1 link state.
> >>>> The framer needs to be initialized 'globally' and not by a specific consumer
> >>>> as several consumers can use the framer.  
> >>>
> >>> I can't think of a good place for this.
> >>>
> >>> If all else fails, it's drivers/misc
> >>>
> >>>>>>  include/linux/mfd/pef2256.h |  52 ++
> >>>>>>  5 files changed, 1269 insertions(+)
> >>>>>>  create mode 100644 drivers/mfd/pef2256-regs.h
> >>>>>>  create mode 100644 drivers/mfd/pef2256.c
> >>>>>>  create mode 100644 include/linux/mfd/pef2256.h    
> >>>>>
> >>>>> [...]
> >>>>>   
> >>>>>> +static int pef2256_add_audio_devices(struct pef2256 *pef2256)
> >>>>>> +{
> >>>>>> +	const char *compatible = "lantiq,pef2256-codec";
> >>>>>> +	struct mfd_cell *audio_devs;
> >>>>>> +	struct device_node *np;
> >>>>>> +	unsigned int count = 0;
> >>>>>> +	unsigned int i;
> >>>>>> +	int ret;
> >>>>>> +
> >>>>>> +	for_each_available_child_of_node(pef2256->dev->of_node, np) {
> >>>>>> +		if (of_device_is_compatible(np, compatible))
> >>>>>> +			count++;
> >>>>>> +	}    
> >>>>>
> >>>>> Converting Device Tree nodes into MFD cells to register with the
> >>>>> Platform Device API is not a reasonable use-case of MFD.
> >>>>>
> >>>>> Have the CODEC driver match on "lantiq,pef2256-codec" and let it
> >>>>> instantiate itself.  
> >>>>
> >>>> As the framer is going to used by several subsystem, I cannot instantiate
> >>>> it in the specific ASoC subsystem.
> >>>>   
> >>>>>
> >>>>> Your first version using of_platform_populate() was closer to the mark.  
> >>>>
> >>>> The issue was that I need MFD cells for the pinctrl part.  
> >>>
> >>> Why can't it be represented in DT?
> >>
> >> The pinctrl part has no specific compatible string.
> >> Not sure that a compatible string for pinctrl can be accepted
> >> as there is only one pinctrl subnode and no specific reg for this
> >> subnode.
> >>
> >> The DT looks like this:
> >>     framer@2000000 {
> >>       compatible = "lantiq,pef2256";
> >>       reg = <0x2000000 0x100>;
> >>       ...
> >>       pinctrl {
> >>         pef2256_rpa_sypr: rpa-pins {
> >>           pins = "RPA";
> >>           function = "SYPR";
> >>         };
> >>       };
> >>
> >>       pef2256_codec0: codec-0 {
> >>         compatible = "lantiq,pef2256-codec";
> >>         #sound-dai-cells = <0>;
> >>         sound-name-prefix = "PEF2256_0";
> >>       };
> >>     };
> >>
> >> Krzysztof, is it acceptable to have a compatible string in the pinctrl node ?
> > 
> > Why wouldn't it be?
> > 
> > $ git grep ".compatible" -- drivers/pinctrl/
> > 
> >> In this case, it will looks like this:
> >>     framer@2000000 {
> >>       compatible = "lantiq,pef2256";
> >>       reg = <0x2000000 0x100>;
> >>       ...
> >>       pinctrl {
> >>         compatible = "lantiq,pef2256-pinctrl";
> 
> If you do not have any resources, there is no point in having separate
> compatible for separate device node.

That's a new rule.  Is that documented somewhere?  I'm sure we already
have device nodes for devices whom only operate on shared resources. 

> Anyway this discussions should not be about DT. How Linux drivers are
> implementing DT is not really a guide how to write DT. Since these
> series were brought there were some DT decisions made based how you want
> to write the driver. No, please don't. I also do not see any problems in
> handling more-or-less complex driver structures without poking the DT.
> We have already many such device families.

-- 
Lee Jones [李琼斯]
