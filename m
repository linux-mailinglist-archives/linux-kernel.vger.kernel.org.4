Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE663AAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiK1OUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiK1OU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:20:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E5183A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:20:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vp12so24903777ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EjFqsuE9cNphk4gOSD8zOQ2dx5nFpRj2oii2XFa96hw=;
        b=jrQw5V1v04IGHZdR5h2OUfd/Y7Kff/cLc2xJjUCWykMmOzhVTRxm4cQwZgdMagWBJz
         RnDz+IJnJrUzvtGRd1ryVeNKWl/nvaBy1+H0oKWTLgyKBPbsCOz+kFjhYgeh8Ijz47fY
         Mcft500rMg9OWjcSNds8wXEslPK1sSZhpQKfM7CLwCOpDJA36TZcIXQLknD4WnRMZEAo
         1sLuML/qCc/iJ5HPz75sqLdB5JVvdVNVWwa2Iuo05Q/D0q/LldgNyDWdHwo5iRUML16o
         j81UeFMZnBMji5gxbQgrXX6RxgL2VNmE4J/DKqz06QSoaMl3PRS7gtfGB2l5hz5Zay+J
         O6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjFqsuE9cNphk4gOSD8zOQ2dx5nFpRj2oii2XFa96hw=;
        b=lrNEErRPiN0c9iF1L23zcDRBdzj/lFcGiNymrBHvXyrxD+1r0pwDLuQMOjm263f7lo
         tt+z5K02Q21Ctl2EqlJFwdouK18XL25hZgPFx1uTnLYK1Gi0tTkOM9wcjMBFf/LS8Bie
         Ex0fLuiURaW607XVdDhhV+Pp00n+CHr0H9VH5S80xEbN8+rSkjxZtJfJ8NdEMsBHUL7V
         AWrh0iT3IJQhR/Lw3Th/GAOxJ1+l1NkluAJTTJTY+KVSojnWqWEiV8do35TWi6wOvkET
         YDPPtEDwlM7hX4osynSzpmSj6nxQ7Obc/HCCnS/rI+Gd6+rJTuwYEztktf6KVkHC0egb
         infw==
X-Gm-Message-State: ANoB5pmkKSH+QnoY40LMyVBhAGPwxAwJ4n7qdwrr7APaG3QR0hJBeAbE
        y3sNVuuoSCAb5S4G0fb1V0HjoDN9sGneH6VVMlV6lw==
X-Google-Smtp-Source: AA0mqf46LtoiAqSDAiLpjSZZawqrzC9mDj3lYWvf1KHmpmQZwPs6WTm5ODMbHD2Q4yVhIGc27RNK5u/sdLLhhhPXoRU=
X-Received: by 2002:a17:906:bcda:b0:7c0:80b0:7f67 with SMTP id
 lw26-20020a170906bcda00b007c080b07f67mr473326ejb.462.1669645224199; Mon, 28
 Nov 2022 06:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20221128104403.2660703-1-anders.roxell@linaro.org> <5FC4A1FD-9631-43B2-AE93-EFC059F892D3@kernel.org>
In-Reply-To: <5FC4A1FD-9631-43B2-AE93-EFC059F892D3@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 28 Nov 2022 15:20:13 +0100
Message-ID: <CADYN=9LT7xWScSiprwgB2DhTN-Mws7rxG33BRZwLktK7P_jzkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib: fortify_kunit: build without structleak plugin
To:     Kees Cook <kees@kernel.org>
Cc:     akpm@linux-foundation.org, elver@google.com,
        kasan-dev@googlegroups.com, keescook@chromium.org,
        davidgow@google.com, Jason@zx2c4.com,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 at 15:09, Kees Cook <kees@kernel.org> wrote:
>
> On November 28, 2022 2:44:03 AM PST, Anders Roxell <anders.roxell@linaro.org> wrote:
> >Building fortify_kunit with strucleak plugin enabled makes the stack
> >frame size to grow.
> >
> >lib/fortify_kunit.c:140:1: error: the frame size of 2368 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>
> Under what config

I saw this with a arm64 allmodconfig build [1],

> and compiler version do you see these warnings?

Toolchain
aarch64-linux-gnu-gcc (Debian 11.3.0-6) 11.3.0


Cheers,
Anders
[1] http://ix.io/4h6w

>
> -Kees
>
> >
> >Turn off the structleak plugin checks for fortify_kunit.
> >
> >Suggested-by: Arnd Bergmann <arnd@arndb.de>
> >Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >---
> > lib/Makefile | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/lib/Makefile b/lib/Makefile
> >index bdb1552cbe9c..aab32082564a 100644
> >--- a/lib/Makefile
> >+++ b/lib/Makefile
> >@@ -382,6 +382,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
> > CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
> > obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
> > CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
> >+CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> > obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
> > obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
> > obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
>
>
> --
> Kees Cook
