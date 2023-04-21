Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2286EA4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDUH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDUH0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:26:52 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA82680;
        Fri, 21 Apr 2023 00:26:49 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A6C22000F;
        Fri, 21 Apr 2023 07:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682062007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rg7mAqWYm80zziSBLUX+QJbAH6dTgm61KDeO9JG0CbU=;
        b=WIxsnrcBlhc9LsM3u1yFOmR9oM19m7i3CMb6shmBvGggsaVHgJnCVF8YbOfNLJs4Drj7dI
        Gnk4+aexGNF6tVsushn80roLXBUgjed/c4CQRPqkNYNY1tz7emmr9KyuJGq1XaIg34OMoG
        CigzyYfobZpKMu//UHsn/R7MgA6hlwrtdLY6Ns2VfxK+kP8pN5N0a7knbl3aCDkMEy+afA
        BbmDPWjJ6u88w+4xtx+ztmKh/sx88ytClv9s4IiBhB6Y0NmiscKObKuQ8oyEfpr8nl0rUJ
        o7Wle9mu+0sEEs2FmyRmRPbD1rN14crmFQbc9rgRxn5dDIAhkzjkBk9o5SqfXQ==
Date:   Fri, 21 Apr 2023 09:26:45 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/7] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230421092645.56127f11@bootlin.com>
In-Reply-To: <20230420134703.GC996918@google.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
        <20230417171601.74656-4-herve.codina@bootlin.com>
        <20230420123946.GB996918@google.com>
        <20230420151551.78c1288b@bootlin.com>
        <20230420134703.GC996918@google.com>
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

Hi Lee, Krzysztof,

On Thu, 20 Apr 2023 14:47:03 +0100
Lee Jones <lee@kernel.org> wrote:

> On Thu, 20 Apr 2023, Herve Codina wrote:
> 
> > On Thu, 20 Apr 2023 13:39:46 +0100
> > Lee Jones <lee@kernel.org> wrote:
> >   
> > > On Mon, 17 Apr 2023, Herve Codina wrote:
> > >   
> > > > The Lantiq PEF2256 is a framer and line interface component designed to
> > > > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > > > digital PCM system highway/H.100 bus.
> > > > 
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > >  drivers/mfd/Kconfig         |  16 +
> > > >  drivers/mfd/Makefile        |   1 +
> > > >  drivers/mfd/pef2256-regs.h  | 250 ++++++++++
> > > >  drivers/mfd/pef2256.c       | 950 ++++++++++++++++++++++++++++++++++++    
> > > 
> > > 95% of this driver needs to be moved somewhere else.
> > > 
> > > What is a Framer?  Perhaps sound/ is a good candidate?  
> > 
> > The pef2256 framer is a device that transfers data to/from a TDM (time-slots
> > data) from/to quite old telecommunication lines (E1 in my case).
> > Several subsystem can set/get data to/from the TDM. Each device using their
> > own time-slots set.
> > 
> > On my use-case, I have some audio consumer and a not yet upstreamed HDLC
> > consumer. Both of them uses the framer to know the E1 link state.
> > The framer needs to be initialized 'globally' and not by a specific consumer
> > as several consumers can use the framer.  
> 
> I can't think of a good place for this.
> 
> If all else fails, it's drivers/misc
> 
> > > >  include/linux/mfd/pef2256.h |  52 ++
> > > >  5 files changed, 1269 insertions(+)
> > > >  create mode 100644 drivers/mfd/pef2256-regs.h
> > > >  create mode 100644 drivers/mfd/pef2256.c
> > > >  create mode 100644 include/linux/mfd/pef2256.h    
> > > 
> > > [...]
> > >   
> > > > +static int pef2256_add_audio_devices(struct pef2256 *pef2256)
> > > > +{
> > > > +	const char *compatible = "lantiq,pef2256-codec";
> > > > +	struct mfd_cell *audio_devs;
> > > > +	struct device_node *np;
> > > > +	unsigned int count = 0;
> > > > +	unsigned int i;
> > > > +	int ret;
> > > > +
> > > > +	for_each_available_child_of_node(pef2256->dev->of_node, np) {
> > > > +		if (of_device_is_compatible(np, compatible))
> > > > +			count++;
> > > > +	}    
> > > 
> > > Converting Device Tree nodes into MFD cells to register with the
> > > Platform Device API is not a reasonable use-case of MFD.
> > > 
> > > Have the CODEC driver match on "lantiq,pef2256-codec" and let it
> > > instantiate itself.  
> > 
> > As the framer is going to used by several subsystem, I cannot instantiate
> > it in the specific ASoC subsystem.
> >   
> > > 
> > > Your first version using of_platform_populate() was closer to the mark.  
> > 
> > The issue was that I need MFD cells for the pinctrl part.  
> 
> Why can't it be represented in DT?

The pinctrl part has no specific compatible string.
Not sure that a compatible string for pinctrl can be accepted
as there is only one pinctrl subnode and no specific reg for this
subnode.

The DT looks like this:
    framer@2000000 {
      compatible = "lantiq,pef2256";
      reg = <0x2000000 0x100>;
      ...
      pinctrl {
        pef2256_rpa_sypr: rpa-pins {
          pins = "RPA";
          function = "SYPR";
        };
      };

      pef2256_codec0: codec-0 {
        compatible = "lantiq,pef2256-codec";
        #sound-dai-cells = <0>;
        sound-name-prefix = "PEF2256_0";
      };
    };

Krzysztof, is it acceptable to have a compatible string in the pinctrl node ?
In this case, it will looks like this:
    framer@2000000 {
      compatible = "lantiq,pef2256";
      reg = <0x2000000 0x100>;
      ...
      pinctrl {
        compatible = "lantiq,pef2256-pinctrl";
        pef2256_rpa_sypr: rpa-pins {
          pins = "RPA";
          function = "SYPR";
        };
      };

      pef2256_codec0: codec-0 {
        compatible = "lantiq,pef2256-codec";
        #sound-dai-cells = <0>;
        sound-name-prefix = "PEF2256_0";
      };
    };

Best regards,
Hervé
