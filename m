Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82D6674C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjALOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjALOKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:10:44 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DD59319;
        Thu, 12 Jan 2023 06:05:36 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id B42B51B001DE;
        Thu, 12 Jan 2023 16:05:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1673532333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a42ddED8o+V9ePA7ykJUXoFIdNLHF7yzyFQBjqmdKao=;
        b=vIQ2YXfr3xNvbTOdl83e19bPe2xDIasfxZoBuZhkEVGPFSiOzJ+V+p9lGqs1t+tnYnQC9I
        g0sjgAGGOWS466QiM5sJITzzpIo20DcR0tv3je/mm+gWMEhqoqGgm4yigBpIqsF0N+53g5
        Rd1oGaPoOZ4Qfcgo2DMnVExb2b9CEcEFtXo4xdEddZ23kGIEJtT6T7pLvQ2TLKbnY4tzBN
        fe2oMEBSRJ+my7bR0Mus3ELFfjvfTfjh359DEXsulC5+rzqjXJ4aKedwG5k/FqG/yb317P
        I7qACWS+XJKBjFIQlYxWZELN/KnS8ncVsoXbWC65FYzySrVmAYT+7dC4us0OEA==
Received: from darkstar.musicnaut.iki.fi (85-76-134-241-nat.elisa-mobile.fi [85.76.134.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id B240B20035;
        Thu, 12 Jan 2023 16:05:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1673532327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a42ddED8o+V9ePA7ykJUXoFIdNLHF7yzyFQBjqmdKao=;
        b=OTVmEy7cAIC2YV0GRP5Z3UN/hqAAHBlBXTIklXfbIH1sGgjB7Mj7y8KXvhCWuetxxixmgo
        63Pu9yO2S3/gGck7DgkYTKCfF4KMG1mN4zW4wpDkJ8jn5nl3e8hVta8QrCzDE5Rkq3LUlk
        yq4oJRSEew/o9UYuutj3V2Q+vKtTDbs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1673532327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a42ddED8o+V9ePA7ykJUXoFIdNLHF7yzyFQBjqmdKao=;
        b=Yf6JJnmg9Rvc7t5bCOrwCKFEbA6lIuM3GH35pHypszsVX+SW0NbSA1WElYoxKSEwQ0efZ6
        16Lra2Ssjhqg0EQ1Y8kx9DAJE3YU1DYq8wF7HvkjcFxm+Rl8AOJUnZT39Z+PqwforTEloh
        8ejnkD8Gz1RaKBwqNT7LCzLyVyY2mD8=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1673532327; a=rsa-sha256; cv=none;
        b=BlSSRJwBB6M1x9Im046gh9g8xl8qv7hOi7A9fvWSGH4nbeAlKYllI6fXycSgDmOpT4dFiY
        fksFAIIhPyio/cLPRaSJeFBPhSdMY3m5LvbmYWOajvzJ2HE16Cyj3dz8hP0S9mPQXGzr0x
        Dw5xu8Lo+q390+6BwGu9TTZyZJwZUk8=
Date:   Thu, 12 Jan 2023 16:05:24 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI
 support for OMAP1/2 chips
Message-ID: <20230112140524.GK730856@darkstar.musicnaut.iki.fi>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com>
 <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
 <Y7/YiMPIDN0Cf5Ky@atomide.com>
 <c9821df0-cd3e-43a0-b903-430d1251d51c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9821df0-cd3e-43a0-b903-430d1251d51c@app.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 12, 2023 at 11:19:53AM +0100, Arnd Bergmann wrote:
> On Thu, Jan 12, 2023, at 10:53, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [230112 09:03]:
> >> On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
> >> > Commit 0fee2eac5c2b ("usb: phy: remove phy-isp1301-omap driver") removes
> >> > the Philips ISP1301 with OMAP OTG driver and its corresponding config
> >> > ISP1301_OMAP. The drivers, OMAP USB Device Controller and OHCI support for
> >> > OMAP1/2 chips, with corresponding configs, USB_OMAP and USB_OHCI_HCD_OMAP1,
> >> > need this removed driver (see "depends on ISP1301_OMAP") to build.
> >> >
> >> > Remove those two drivers.
> >> >
> >> > With the config USB_OMAP removed in this commit, remove some further code
> >> > in the omap-dma header and mach-omap1 architecture code.
> >> >
> >> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >> 
> >> This would be a great cleanup because of the simplications of the
> >> omap-dma code. I had previously looked at it and concluded that
> >> the driver is still in use though, and I think my mistake was
> >> just in the Kconfig part of this patch:
> >
> > It sure would be nice to drop the old custom dma api in omap-dma.c
> > while keeping the dma.c in arch/arm/mach-omap1.
> 
> I see that four out of the five remaining board files still use
> omap_udc, which is the only remaining user of the custom
> DMA interface. What I had not noticed earlier is that DMA support
> in that driver is actually optional, though it's hardwired
> to be enabled.
> 
> So if we want to kill off the old DMA stuff there is actually
> a choice between either making omap_udc PIO-only or converting
> it to use the standard dmaengine interface.

I use this driver on Palm TE and 770, and without it those boards would
be useless for my use cases. Also DMA doubles the throughput, probably
also power usage is smaller.

A.
