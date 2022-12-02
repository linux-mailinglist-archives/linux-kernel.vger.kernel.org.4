Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF76405D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiLBLbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiLBLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:31:11 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CABD3DF9;
        Fri,  2 Dec 2022 03:31:10 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E9A9E5FD0C;
        Fri,  2 Dec 2022 14:31:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669980669;
        bh=gUwn4rgw/3aJmLAswDc3LzNzhfrHmZOgM875DBVbpAc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=XGyZdqRXwz2PxRkJNwfZSoNCSfGDhus0I1vEL7cbMnV8+FsGo+A3SvzQe9cnc7SzW
         1hLaBgaL2BcBlepqocMiYJw584LlYyPuEl4yolnIldOEFA1uQPYbrIgrZvs4nQM9FA
         yKjGAWOA47MRsNulb+a/MpT/dVHB+nSHfVl+Z/MEYLZWvsjpr2TIwypLyPH1hrReF8
         +Y9qolJbnWOaWg34cLllhhcYMObceltpeueE0JmI8YAqm8z3oP4e6zNidNgw7zFJny
         UetZFTW+5iAVlDR0+udXcKFN0OVMPmd3XnazM9U9yCJ1uNPXOKx6mvSmESSt7in96I
         KGEUel/ByZAfw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 14:31:08 +0300 (MSK)
Date:   Fri, 2 Dec 2022 14:31:08 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 02/11] clk: meson: a1: add support for Amlogic A1 PLL
 clock driver
Message-ID: <20221202113108.netb53ajd4ayqnfy@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-3-ddrokosov@sberdevices.ru>
 <1j7cza8368.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1j7cza8368.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/02 07:44:00 #20636821
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:16:12PM +0100, Jerome Brunet wrote:
> >  drivers/clk/meson/Kconfig  |   9 +
> >  drivers/clk/meson/Makefile |   1 +
> >  drivers/clk/meson/a1-pll.c | 360 +++++++++++++++++++++++++++++++++++++
> >  drivers/clk/meson/a1-pll.h |  56 ++++++
> >  4 files changed, 426 insertions(+)
> >  create mode 100644 drivers/clk/meson/a1-pll.c
> >  create mode 100644 drivers/clk/meson/a1-pll.h
> >
> > diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> > index fc002c155bc3..ab34662b24f0 100644
> > --- a/drivers/clk/meson/Kconfig
> > +++ b/drivers/clk/meson/Kconfig
> > @@ -99,6 +99,15 @@ config COMMON_CLK_AXG_AUDIO
> >  	  Support for the audio clock controller on AmLogic A113D devices,
> >  	  aka axg, Say Y if you want audio subsystem to work.
> >  
> > +config COMMON_CLK_A1_PLL
> > +	bool
> 
> Could you add a tristate with some text please ?
> 

Yep... I did it in my fixup patches :-) Looks like it's better to review
the next version with already squashed patches.

-- 
Thank you,
Dmitry
