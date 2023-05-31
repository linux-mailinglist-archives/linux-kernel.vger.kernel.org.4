Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61567718748
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjEaQXq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 12:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEaQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:23:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D9199
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:23:28 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1q4ObW-0006OY-35; Wed, 31 May 2023 18:23:18 +0200
Message-ID: <5e0b34054ca6fa540e481d93f3c1d9fbdd2defcd.camel@pengutronix.de>
Subject: Re: [PATCH v6 5/6] drm/etnaviv: add driver support for the PCI
 devices
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn, Li Yi <liyi@loongson.cn>
Date:   Wed, 31 May 2023 18:23:12 +0200
In-Reply-To: <950fdaaa-b62c-7f36-a499-9eca71c8bc47@loongson.cn>
References: <ZHZIXZPuCkFSMF4H@bhelgaas>
         <950fdaaa-b62c-7f36-a499-9eca71c8bc47@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui Jingfeng,

Am Donnerstag, dem 01.06.2023 um 00:08 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/5/31 03:02, Bjorn Helgaas wrote:
> > On Wed, May 31, 2023 at 12:06:42AM +0800, Sui Jingfeng wrote:
> > > This patch adds PCI driver support on top of what already have. Take the
> > > GC1000 in LS7A1000/LS2K1000 as the first instance of the PCI device driver.
> > > There is only one GPU core for the GC1000 in the LS7A1000 and LS2K1000.
> > > Therefore, component frameworks can be avoided. Because we want to bind the
> > > DRM driver service to the PCI driver manually.
> > > +	 * Loongson Mips and LoongArch CPU(ls3a5000, ls3a4000, ls2k1000la)
> > > +	 * maintain cache coherency by hardware
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_CPU_LOONGSON64) || IS_ENABLED(CONFIG_LOONGARCH))
> > > +		priv->has_cached_coherent = true;
> > This looks like something that should be a runtime check, not a
> > compile-time check.
> > 
> > If it's possible to build a single kernel image that runs on Loongson
> > MIPS or LoongArch CPU and, in addition, runs on other platforms, you
> > cannot assume that all the others maintain this cache coherency.
> 
> Nice catch! I don't even realize this!
> 
> 
> LS3A4000 is mips64r2 with MSA SIMD, while LS3A5000 is LoongArch,
> 
> instruction set, compiler, and binary interface are totally changed.
> 
> Therefore, it's impossible to build a single kernel image that runs on 
> all Loongson CPUs.
> 
> Currently, I can guarantee that this works on the Loongson platform.
> 
> My initial intent here is to let priv->has_cached_coherent be *true* on 
> the Loongson platform (both mips and loongarch).
> 
> I do know there are some other vendors who bought GPU IP from Vivante.
> 
> say GC7000, and integrate it into their discrete GPU product.
> 
> But it is also a PCI device, but this is another story; it deserves 
> another patch.
> 
> I don't know if Etnaviv folk find some similar hardware on Arm Arch,
> 
> Some Arm CPUs do not maintain cached coherency on hardware.
> 
> The has_cached_coherent member can be set to false on such hardware.
> 
> For us, it seems that there is no need to do runtime checking,
> 
> because they are all cached coherent by default.
> 
> 
> Can I improve this in the future, currently I don't have a good idea.

I think I mentioned before that this needs to be a runtime check. What
does dev_is_dma_coherent() return for the Vivante GPU device on your
platform?

Regards,
Lucas
