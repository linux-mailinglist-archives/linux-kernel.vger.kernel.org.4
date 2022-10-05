Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2105F5ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJEUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJEUEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:04:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874C2CDDE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:04:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a2so7248ejx.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=APdvrkSkgG5mJL1Ma1CRX3gFSv5UdVBjrmh3RMJ2q4U=;
        b=vBTC7uICf+fkeIsyfa7UB80Zr1/JGJqx3rccgomA5bPJUzZMu1oW4F3dzTmVepeU/g
         71j1KkR5ndQIzZUDI6hdtUMx9qOLsUTR1MhMQA8leOLUQLqa1KLpdnEHH5IwAbUEYxCP
         X3iwP27rE3G7AqhJMfUsXGL7kVdJwtD0OC4HAlLpQd5NAmNv6PWohR+aGeY3OS6NEehG
         1+MJhViiNwAO+nn+7WjgkKagAXfLx8nI7vDyIw0lBi8eTxrvyoaNptPBSTteZ2a9bc+V
         xERaO3jityWqsDWxsDecej9CRMaYYCHIdRnLioZ/tklvFkLmtUysgoC6jprfGK7Hg5zW
         PkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=APdvrkSkgG5mJL1Ma1CRX3gFSv5UdVBjrmh3RMJ2q4U=;
        b=lfzaa/xIbyjp7HA555idzt+VtjtoocUHwOGkQTjPrbfSODggEK4S4MuogWXWkHTbPq
         GF4XbnBY7nMz1Vei6DWm25yl7ruRiy8V0FJQF/orWoqBiZvxvRkOWDkCikSaoz7sIWb7
         xMpAHzySp7CrNKBzAIvfNm/bi9sgbq/JG/HEbXeiISDOKZF2uKUHgMKkwh2xKAD6qD+J
         pxChyK29tWGduOVb6r2OPjL6q/cFiFp4Qylltk3Zj+gCDU6vQS1FP6MWkf5GryTMq9vs
         lKVsm/1jdYwOJ1H0YteJHeiHkfaVMHjlBXTTtFoA6kLTHiuUCaEo8f68XF9XhJCR8z7Z
         F5aA==
X-Gm-Message-State: ACrzQf3axfCjgVhJi1oYPDV+D3LJZQlcBHLtQfBsfqvidBurrmO0g288
        i9gtbxj4/fwqlhmuZLkmtQFE+ztvJd7Gqbifuo0TGA==
X-Google-Smtp-Source: AMsMyM6TewkbfaWSZnsLE/N292EoeVua0JXFWqw/5fwF6+/hmP/aqa+EpEnY4ShgFge+vVLsgQ6cqltlr0Gwmb+93ck=
X-Received: by 2002:a17:907:a064:b0:78c:1511:a3cd with SMTP id
 ia4-20020a170907a06400b0078c1511a3cdmr1028359ejc.203.1665000267968; Wed, 05
 Oct 2022 13:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <Yz0koHybNXGTFfDr@debian> <Yz1ew+EdD94TjQYK@sirena.org.uk>
In-Reply-To: <Yz1ew+EdD94TjQYK@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Oct 2022 22:04:15 +0200
Message-ID: <CACRpkda-dquOCUChDMwFgGy7kUNFE05H+Bebb2bB5=UQGgwyCA@mail.gmail.com>
Subject: Re: mainline build failure due to 81c0386c1376 ("regmap: mmio:
 Support accelerared noinc operations")
To:     Mark Brown <broonie@kernel.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 12:39 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 05, 2022 at 07:30:56AM +0100, Sudip Mukherjee (Codethink) wrote:
> > Hi All,
> >
> > The latest mainline kernel branch fails to build alpha allmodconfig
> > with the error:
> >
> > drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_noinc_write':
> > drivers/base/regmap/regmap-mmio.c:222:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
> >   222 |                 writesb(ctx->regs + reg, (const u8 *)val, val_count);
> >       |                 ^~~~~~~
> >       |                 writeb
>
> I'd forgotten about this one, sorry, and alpha isn't covered by things
> like KernelCI so I didn't see the failure when I checked before sending
> my pull request.  It's fixed in -next by 7e772dad9913992 ("alpha: Use
> generic <asm-generic/io.h>") from Linus Walleij which is in the
> asm-generic tree.

There were some further issues with the fix (alpha is really hairy)
but Arnd stepped in and fixed those too, it should all be fixed up when
the arch tree gets pulled.

This was the first time I had to do generic arch maintenance duty so
it was a bit bumpy.

Yours,
Linus Walleij
