Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4C62CE03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiKPWsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiKPWs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:48:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA6265C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:48:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v28so18845646pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tY+wNQyQr9wPRbBlHemy/Ow0QrjPYX29aHEdCbmWCjA=;
        b=Irm4bCz514lGdnwcQqmqoHmbAqBeJHqAPIPoDytG1aUqgawgE8nQ+59KXiVT5jefrI
         K/lZtd3M5uX8rYpg8fYT+IDvQRhSloDjUcDbVbF8z8NTnFyf6BUlqMD9Uf9KYcPXSi63
         3wW33c5sXYetGuj71Tev+WnM/0CYskBdzPLpVS0SVa7YUVUJJ0P5EeMhD4Rd+H0/zQgp
         /QGbRxalUE2NdDaRDtfMB/q2s7irdW0c813OTDxr+PNoW/6M0WzAgUEHvpmwKSRiUn++
         YJUyGwXBWX3SABW4nZIEIY7Z+UrTH9QKU96Gjj4i03BhWkOkPWz3+gZoIRnkeEoPQwaC
         1hPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tY+wNQyQr9wPRbBlHemy/Ow0QrjPYX29aHEdCbmWCjA=;
        b=C525kwcALAQxiJ//Iq4OCezXtE7NTeWWgS0w+rHtz06Ohe5XB9RS5jhtxLWOF1cYhv
         oR7I+zxDJ2whUloy7aXBe4qcLt9lfAhgUih5qNdiWo1D72EEDKdhGY0Cv6lFFHUNmopP
         Eq1R1xXgzG/fObCsIAAHNuWW6Amm8r6C/UMNUzXh9vbiFUdgHHrN/46jcJPDOyA4zogM
         OCWm0KJYm3865LE7mSSEJfC1HVFcJ525+y+Srxp17Aw3uDbtcxb3FnX1Qq79Gegc0Gy/
         E5670ABZS8Z/kHIGyJ9PSaZWNqYZtu6AbA7OkIrqdpmTdyjjiBOZt9/GEz9Y/HlyKoIK
         rwuA==
X-Gm-Message-State: ANoB5pn8ulPtmYhB/+qV5wXzmPCTGHddxIEWCvH02/h5WjC8iPIdSjWu
        poAwWdU8FCAvpJyJd3ZdEIWoVyP3/oMFpGJxzOR+pw==
X-Google-Smtp-Source: AA0mqf5kQvJwFf82KIl71ybL3dQWhzxKDwLOGBO/ssSS/OJvUmC9FERxr8oIgbocduj8UNJG4kRxc625LjsFEIBBsyc=
X-Received: by 2002:a62:1a05:0:b0:56c:1277:d056 with SMTP id
 a5-20020a621a05000000b0056c1277d056mr214615pfa.23.1668638906885; Wed, 16 Nov
 2022 14:48:26 -0800 (PST)
MIME-Version: 1.0
References: <fe18ed06-12f1-1dcb-71ee-aec5a5d656ea@gmail.com>
In-Reply-To: <fe18ed06-12f1-1dcb-71ee-aec5a5d656ea@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Nov 2022 14:48:15 -0800
Message-ID: <CAKwvOdnx_hyf=3DZtU_P8icWa07jf1+baNgM9MBh_ojE-EK5=A@mail.gmail.com>
Subject: Re: kbuild: check the minimum compiler version in Kconfig
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nathan Chancellor <natechancellor@gmail.com>, ojeda@kernel.org,
        sedat.dilek@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 1:48 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi Masahiro, Nick,
>
> The compiler version check performed with
> aec6c60a01d3a3170242d6a99372a388e1136dc6 ("kbuild: check the minimum
> compiler version in Kconfig") can be defeated and prevent running the
> *config targets if specifying LLVM=1 on the command line, in that way:
>
> BR_BINARIES_DIR=/local/users/fainelli/buildroot-llvm/output/arm64/images
> LLVM=1 LLVM_IAS=1 PKG_CONFIG_PATH="" /usr/bin/make -j49 -C
> /local/users/fainelli/buildroot-llvm/output/arm64/build/linux-custom
> HOSTCC="/usr/bin/gcc"
> HOSTCC="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/ccache
> /usr/bin/gcc -O2
> -I/local/users/fainelli/buildroot-llvm/output/arm64/host/include
> -DNDEBUG -L/local/users/fainelli/buildroot-llvm/output/arm64/host/lib
> -Wl,-rpath,/local/users/fainelli/buildroot-llvm/output/arm64/host/lib"
> ARCH=arm64
> INSTALL_MOD_PATH=/local/users/fainelli/buildroot-llvm/output/arm64/target
> CROSS_COMPILE="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-"
> WERROR=0
> DEPMOD=/local/users/fainelli/buildroot-llvm/output/arm64/host/sbin/depmod
> INSTALL_MOD_STRIP=1 HOSTCC="/usr/bin/gcc" menuconfig
>    UPD     scripts/kconfig/mconf-cfg
>    HOSTCC  scripts/kconfig/mconf.o
>    HOSTCC  scripts/kconfig/lxdialog/checklist.o
>    HOSTCC  scripts/kconfig/lxdialog/inputbox.o
>    HOSTCC  scripts/kconfig/lxdialog/menubox.o
>    HOSTCC  scripts/kconfig/lxdialog/textbox.o
>    HOSTCC  scripts/kconfig/lxdialog/util.o
>    HOSTCC  scripts/kconfig/lxdialog/yesno.o
>    HOSTLD  scripts/kconfig/mconf
> ***
> *** Compiler is too old.
> ***   Your Clang version:    10.0.0
> ***   Minimum Clang version: 10.0.1
> ***
> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
>
> Here, the compiler check is actually checking the host compiler clang
> version installed on my Ubuntu 20.04 system, as opposed to the cross
> compiler clang version that is being used.

LLVM=1 will use `clang` as found by your $PATH.  Where did you express
to make what the "cross compiler clang version" is? (And why do you
set HOSTCC three times)

>
> It is not clear to me how to best address that, short of not specifying
> LLVM=1 on the kernel *config targets, but IMHO there is still an actual
> issue where we do not check the compiler that we would want to check.
>
> Thanks!
> --
> Florian



-- 
Thanks,
~Nick Desaulniers
