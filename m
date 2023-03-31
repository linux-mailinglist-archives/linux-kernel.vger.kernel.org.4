Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212816D18D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCaHmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjCaHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:42:19 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3981B34F;
        Fri, 31 Mar 2023 00:42:12 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 10DDB240006;
        Fri, 31 Mar 2023 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680248531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYpXCgEwZhV7ddL7BC9dvRkRU/+f02CS6YXe85krNsA=;
        b=pMs1cInVUT9wPGuOnfg0VyW+3qPwdHF6UY8MhR4wtFulN2et/85ZfTpJFH9pXdCIovPyYs
        Yo5SMgCYPt7HSvp46i3qsZQxMwky3+ofDUJHyBaycm5S6z4LwWzdXZ+mbv6ZAJNR3Afh6/
        HWXszxi6YG7EhJ/7ScppdXQjK3AiSiMuWJAqJFozvfhbMDKsd4rrT/mi0dW/xjHOp1TItQ
        Lf8tq/qYI6KCbboO1kslK4IWy5RbrZukpxWxn1xBr6VfYYrt0LIzo9dwQl9pcXa4BxQtZ/
        HcEa6LlKvle9aw15vM48B0NI9HUy+9pHnUukJfrUTvP2bya9QODa00V48aE31g==
Date:   Fri, 31 Mar 2023 09:42:08 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 2/5] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230331094208.41ab4420@bootlin.com>
In-Reply-To: <20230330160510.GB489249@google.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
        <20230328092645.634375-3-herve.codina@bootlin.com>
        <20230330160510.GB489249@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Thu, 30 Mar 2023 17:05:10 +0100
Lee Jones <lee@kernel.org> wrote:

> On Tue, 28 Mar 2023, Herve Codina wrote:
> 
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.  
> 
> My goodness!
> 
> It's been a long time since I've seen anything quite like this.

Yes, old things but working on recent kernel.

> 
> My suggestion to you:
> 
> * Split this up into components that fit functional subsystems

It is done. The audio part is present in ASoC subsystem (path 5 in this
series). pinctrl function is implemented in this driver and, as I don't
want to share registers, I would prefer to keep this function inside this
driver.

Also, I sent a RFC related to HDLC and PHY. In this RFC, the pef2256 is
considered as a PHY and handled in the PHY subsystem.
  https://lore.kernel.org/linux-kernel/20230323103154.264546-1-herve.codina@bootlin.com/

> * Run checkpatch.pl

I did.

> * Remove all of the debug prints

I can do that in the next iteration if really needed.

> * Move all of the defines out to a header file

These defines are related to registers. As I don't want to share these
registers, is it really necessary to use a header file for them ?

> * Be more verbose in your documentation / comments

I can improve the API documentation present in include/mfd/pef2256.h.
Do you thing that is necessary ? Only a few devices will use this API.

> * Consider using simple-mfd to probe child devices.

I did.
The driver has (and needs to have) a compatible string.
Having this compatible string, sub-nodes are not automatically populated
in the device tree. In order to have them populated and probed, the pef2256
probe function ends calling devm_of_platform_populate().

Best regards,
Hervé

> 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/mfd/Kconfig         |   17 +
> >  drivers/mfd/Makefile        |    1 +
> >  drivers/mfd/pef2256.c       | 1355 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/pef2256.h |   28 +
> >  4 files changed, 1401 insertions(+)
> >  create mode 100644 drivers/mfd/pef2256.c
> >  create mode 100644 include/linux/mfd/pef2256.h  
> 
> --
> Lee Jones [李琼斯]
