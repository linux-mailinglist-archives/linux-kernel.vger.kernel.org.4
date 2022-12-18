Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF565047F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 20:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLRTZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 14:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:25:31 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987ECB870;
        Sun, 18 Dec 2022 11:25:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so10900457lfv.2;
        Sun, 18 Dec 2022 11:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZCLe2m2NSD05JaVIkjBaPWHL388f0XCT+zD7gnXxJg=;
        b=G312hAt4HxrtBRbux5zdMisgUtEQYRrbQ35b0S9QLptUREc/qCFw4lNReSwD7fb84p
         JCmsZeCW+BujvZVvkbN33v45J200CxzR2wMa912pDgTGQ6tL1LsCoyqye8An7p831laI
         QdhvdDN2Xa8KLzcueDZtMT4FTdYogY0hMXZzmpc1JY2Zmdmj2XKopk1/FcgumSQH/MEZ
         tipl30yhqmJqtfelm6GlvrANJfemuGNl5TBMbZPsL1Lz/AZTyJ5397gGpz251poCrrIU
         W7HbsAadvuOyFrfP3ZE3Hmzaycc7QJW4Tx3+sppsr12L16WlJTjlYl+hvAhdyeR20P6s
         FdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZCLe2m2NSD05JaVIkjBaPWHL388f0XCT+zD7gnXxJg=;
        b=6IHbCk0JzKj1o70g5SBH2Px3IVkj7Y0ohDjIEY1+Tqx9sXqQkwcU1d8z392RSYkI5D
         6Kq/hlEJo8yu6nhYfz37HDMxqKEvJF6TISHeqbPqE8V4TFGz/Yr5AYamOM5Un9sg6Cac
         n1S/KlLjwy7CImQCNGsyCmpGeGB3TbL9Kohupdjlg8nG2CRCik0ZIErlo++B9Er+1e4w
         Hrl2nuzBwrDeusB3ZA9olOrwNdTqHqSPx/4Ub0h8WYe7kMmTGI2eoT98JIaP/bk0hnNQ
         JVmzOQKMr7G7RwLuN9IobpUryx8rZvqeWiw/QzUzQQfQ/rQgEyI0d2dZ7els+f1NGFBw
         lAZw==
X-Gm-Message-State: ANoB5pmZ/ePuaaQbmGLbC05gBh0Qy/LlsD5QoxzWfEcp0+Tbydn3rop8
        sYlG8Ts4U1FUV+JVQmJHPWJDLmoRnpg=
X-Google-Smtp-Source: AA0mqf4+cOft/eyKec3yMJWbNGjr1IHI4qho/dSvocsBiGPavqTUZ3kgqwbT0GleCtc2zCAOv5y+lg==
X-Received: by 2002:a05:6512:3d8f:b0:4b6:ee14:3e98 with SMTP id k15-20020a0565123d8f00b004b6ee143e98mr16918128lfv.23.1671391525808;
        Sun, 18 Dec 2022 11:25:25 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id o19-20020a05651205d300b00498f77cfa63sm889219lfo.280.2022.12.18.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 11:25:25 -0800 (PST)
Date:   Sun, 18 Dec 2022 22:25:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw_bt1: fix MUX_MMIO dependencies
Message-ID: <20221218192523.c6vnfo26ua6xqf26@mobilestation>
References: <20221215165247.1723462-1-arnd@kernel.org>
 <20221218142231.qhczawk2zhpgh6dl@mobilestation>
 <60290159-8d63-4358-9ff1-a65cc335e0c6@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60290159-8d63-4358-9ff1-a65cc335e0c6@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 06:56:24PM +0100, Arnd Bergmann wrote:
> On Sun, Dec 18, 2022, at 15:22, Serge Semin wrote:
> > Hi Arnd
> >
> > On Thu, Dec 15, 2022 at 05:52:34PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> Selecting a symbol with additional dependencies requires
> >> adding the same dependency here:
> >> 
> >> WARNING: unmet direct dependencies detected for MUX_MMIO
> >>   Depends on [n]: MULTIPLEXER [=y] && OF [=n]
> >>   Selected by [y]:
> >>   - SPI_DW_BT1 [=y] && SPI [=y] && SPI_MASTER [=y] && SPI_DESIGNWARE [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
> >> 
> >> Alternatively, we could drop this 'select' and require users to manually
> >> put it into their .config as we do for other drivers.
> >
> > Thanks for the patch. Seeing the driver is only implicitly dependent
> > from the mux-mmio driver (via the device described in the device tree
> > blob) I'd suggest to either drop the MUX_MMIO config reverse
> > dependency or convert it to the weak one - 'imply' (if it will solve
> > the problem).
> 

> Ok, I'll send a new patch. I don't want to use 'imply' though, that
> tends to cause other problems because almost nobody understands what
> it actually does.

Ok. Dropping it will be also suitable solution. I'll make sure our
defconfigs will be updated afterwards.

-Serge(y)

> 
>       Arnd
