Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D00734361
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjFQTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346317AbjFQTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:48:53 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C221BF3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=JpMOu/1hNxHuaKwCQGdnk2FzL/My6PZIjCLG8MrTMrk=;
        b=olI+Ud46siOzcq3kqIqwPJ5i5dACaKmPy5sljdckqrt15mByDfSsLsOKxpsY+d1Q8ZOsNY/yq1oIA
         ulh1AWDpe3MgKw7Vbgs4w4Xrr5NCiCobIuFefe/lku4nOnv+V4NsdLgh6lumQLt5MnnIM8uTOiNSnZ
         jLWdvw2UMxvk8TRbEF9Boh55EPdfXsgLDa8U8b+C1ZE6N3knAZCGZ5Sa6HhG2lBbZIiCX6eAGTK4aZ
         C+6xiQBoM/ZO7Ai0Smy6WueXyTSwoyC19PN0XRCNsnh0apc+F7EOI0ZL8wup/9FTtFKce8FGW5g7xk
         PiLYlUpa+M2Mul8/UfI/PjqhILtGycQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=JpMOu/1hNxHuaKwCQGdnk2FzL/My6PZIjCLG8MrTMrk=;
        b=iU5ZO50tbDLra8ur+ON9C1XNg0BNwnaNbHntd4Pjwx1O7eY+11EAX0xPMRW6vni1YchwjRSloKQcu
         qSNMxVZDw==
X-HalOne-ID: f63d52c5-0d47-11ee-ada2-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id f63d52c5-0d47-11ee-ada2-99461c6a3fe8;
        Sat, 17 Jun 2023 19:48:45 +0000 (UTC)
Date:   Sat, 17 Jun 2023 21:48:43 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/ingenic: Kconfig: select REGMAP and REGMAP_MMIO
Message-ID: <20230617194843.GA1854380@ravnborg.org>
References: <20230607110650.569522-1-suijingfeng@loongson.cn>
 <c70cb3cb326439a5868beb54d720538923f653d1.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c70cb3cb326439a5868beb54d720538923f653d1.camel@crapouillou.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
On Sat, Jun 17, 2023 at 09:13:37PM +0200, Paul Cercueil wrote:
> Hi,
> 
> Le mercredi 07 juin 2023 à 19:06 +0800, Sui Jingfeng a écrit :
> > Otherwise its failed to pass basic compile test on platform without
> > REGMAP_MMIO selected by defconfig
> > 
> > make -j$(nproc) ARCH=mips CROSS_COMPILE=mips64el-linux-gnuabi64-
> > 
> >   SYNC    include/config/auto.conf.cmd
> >   Checking missing-syscalls for N32
> >   CALL    scripts/checksyscalls.sh
> >   Checking missing-syscalls for O32
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/checksyscalls.sh
> >   MODPOST Module.symvers
> > ERROR: modpost: "__devm_regmap_init_mmio_clk"
> > [drivers/gpu/drm/ingenic/ingenic-drm.ko] undefined!
> > make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> > make: *** [Makefile:1978: modpost] Error 2
> > 
> > V2: Order alphabetically
> > 
> > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> The patch looks good to me. But I need an ACK from someone else to
> apply to drm-misc-next.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
