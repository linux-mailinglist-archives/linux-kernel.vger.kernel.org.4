Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E96645054
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLGA3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGA3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:29:06 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FF13E2B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:29:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f3so14865311pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voAudIRJP5sQutQIavFNeSzpqijZekkEGtvdiO471Ek=;
        b=xkMxskjBKkw+g8PokDgbx1oNKostwgPAnQwTwV2pjUGkDq2LkqDLpnzlaE2FoTiys7
         BKlw2jyoB78h43kOm/P9FZIT2dVAnA9MShxCrADe/XyTdsTiAnfKJwEgAXOXyhXAlMxl
         BQaPS3einHxIEipylA5+oCrB5VUktxJxP5ua+LopBsXnqEqrcz1u2hQVATNO6Zo1dDLJ
         HZlE1aDSqSLVf2hF1dmJwDZnlXMljg2z8yQ3+NCXhYcnirNe8kx3QY1A3IB+3gpfTYZa
         kkQtPAASxz92LViCELkMcXdLbzgTmMSsrxHKdEj9PzKLDLu1Wk28Mq6xC3mZb5zU3Cpd
         GA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voAudIRJP5sQutQIavFNeSzpqijZekkEGtvdiO471Ek=;
        b=URBXWF0FegTMZb283ug3ytOLIBTyFEI5KJgTAecCViNSE4zxzYJrEb9dMZ3TCH5zrX
         cNR6stqlfwUYCxlGOSYr5F8Y+DAPVzSwqA8MEGNDF4mTE/HaHHVzRIPOR8JCcXDqkXym
         zctsg1xH3Rd1sCZtDFHSuyv5Smkj1si9rnzTqujpxsR3cGVJMpEMrKAD8oVmPLXtcypz
         zjXXZPIyG9BV6PdFhR3JbUo6c3d/ulAeNY3TJGRWyK1W6qkzFLDlLw72aglX6w9Bbun8
         /BJFhdY/4HkUO0Wt4t17aF9W0u+XsYtbgJoCWGrW+uHIb+I7Onlp00JIVsuTrI+CAIWo
         hIMQ==
X-Gm-Message-State: ANoB5pm4x9Vg5X9R+beLaXBg40rt7UEdWmSufr+FHIdLbSBNf0OhKjUN
        Ntw4uU9f1G14rzQTiIdAY3ziS1UoV2Ei6MqPB1kXOw==
X-Google-Smtp-Source: AA0mqf4iIZSOr/CI+28XR5Z+hgAzSujqCHuUDsd+/iuwkREx6kWTgeXRw2tKCu9Wm60bX2znH34RbTXWYg6moxNcCDQ=
X-Received: by 2002:a65:45c5:0:b0:46e:c7be:16fc with SMTP id
 m5-20020a6545c5000000b0046ec7be16fcmr60608158pgr.462.1670372944823; Tue, 06
 Dec 2022 16:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20220416001103.1524653-1-keescook@chromium.org>
In-Reply-To: <20220416001103.1524653-1-keescook@chromium.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 6 Dec 2022 18:28:53 -0600
Message-ID: <CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com>
Subject: Re: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Li <ashimida@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, 16 Apr 2022 at 00:30, Kees Cook <keescook@chromium.org> wrote:
> In order to test various backward-edge control flow integrity methods,
> add a test that manipulates the return address on the stack. Currently
> only arm64 Pointer Authentication and Shadow Call Stack is supported.
>
>  $ echo CFI_BACKWARD | cat >/sys/kernel/debug/provoke-crash/DIRECT
>
> Under SCS, successful test of the mitigation is reported as:
>
>  lkdtm: Performing direct entry CFI_BACKWARD
>  lkdtm: Attempting unchecked stack return address redirection ...
>  lkdtm: ok: redirected stack return address.
>  lkdtm: Attempting checked stack return address redirection ...
>  lkdtm: ok: control flow unchanged.
>
> Under PAC, successful test of the mitigation is reported by the PAC
> exception handler:
>
>  lkdtm: Performing direct entry CFI_BACKWARD
>  lkdtm: Attempting unchecked stack return address redirection ...
>  lkdtm: ok: redirected stack return address.
>  lkdtm: Attempting checked stack return address redirection ...
>  Unable to handle kernel paging request at virtual address bfffffc0088d05=
14
>  Mem abort info:
>    ESR =3D 0x86000004
>    EC =3D 0x21: IABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x04: level 0 translation fault
>  [bfffffc0088d0514] address between user and kernel address ranges
>  ...
>
> If the CONFIGs are missing (or the mitigation isn't working), failure
> is reported as:
>
>  lkdtm: Performing direct entry CFI_BACKWARD
>  lkdtm: Attempting unchecked stack return address redirection ...
>  lkdtm: ok: redirected stack return address.
>  lkdtm: Attempting checked stack return address redirection ...
>  lkdtm: FAIL: stack return address was redirected!
>  lkdtm: This is probably expected, since this kernel was built *without* =
CONFIG_ARM64_PTR_AUTH_KERNEL=3Dy nor CONFIG_SHADOW_CALL_STACK=3Dy
>
> Co-developed-by: Dan Li <ashimida@linux.alibaba.com>
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220413213917.711770-1-keescook@chromiu=
m.org
> v2:
>  - add PAGE_OFFSET setting for PAC bits (Dan Li)
> ---
>  drivers/misc/lkdtm/cfi.c                | 134 ++++++++++++++++++++++++
>  tools/testing/selftests/lkdtm/tests.txt |   1 +
>  2 files changed, 135 insertions(+)
>
> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> index e88f778be0d5..804965a480b7 100644
> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -3,6 +3,7 @@
>   * This is for all the tests relating directly to Control Flow Integrity=
.
>   */
>  #include "lkdtm.h"
> +#include <asm/page.h>
>
>  static int called_count;
>
> @@ -42,8 +43,141 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>         pr_expected_config(CONFIG_CFI_CLANG);
>  }
>
> +/*
> + * This can stay local to LKDTM, as there should not be a production rea=
son
> + * to disable PAC && SCS.
> + */
> +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
> +# ifdef CONFIG_ARM64_BTI_KERNEL
> +#  define __no_pac             "branch-protection=3Dbti"
> +# else
> +#  define __no_pac             "branch-protection=3Dnone"
> +# endif
> +# define __no_ret_protection   __noscs __attribute__((__target__(__no_pa=
c)))
> +#else
> +# define __no_ret_protection   __noscs
> +#endif

We're seeing this problem with allmodconfig on arm64 and GCC 8 (this
one observed on 6.0.12-rc3):

-----8<----------8<----------8<-----
make --silent --keep-going --jobs=3D8
O=3D/home/tuxbuild/.cache/tuxmake/builds/2/build
CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf- ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- 'CC=3Dsccache aarch64-linux-gnu-gcc'
'HOSTCC=3Dsccache gcc'
/builds/linux/drivers/misc/lkdtm/cfi.c:67:1: error: pragma or
attribute 'target("branch-protection=3Dnone")' is not valid
 {
 ^
make[4]: *** [/builds/linux/scripts/Makefile.build:249:
drivers/misc/lkdtm/cfi.o] Error 1
make[4]: Target '__build' not remade because of errors.
make[3]: *** [/builds/linux/scripts/Makefile.build:465:
drivers/misc/lkdtm] Error 2
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:465: drivers/misc] Error=
 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1852: drivers] Error 2
----->8---------->8---------->8-----

Reproducer: `tuxmake --runtime podman --target-arch arm64 --toolchain
gcc-8 --kconfig allmodconfig
CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf-`

Is this a legit problem?

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
