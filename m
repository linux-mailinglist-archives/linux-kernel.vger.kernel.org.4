Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594460DCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiJZIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiJZIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:07:57 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543BFA98E7;
        Wed, 26 Oct 2022 01:07:57 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id i12so10866419qvs.2;
        Wed, 26 Oct 2022 01:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQEEiiTh8IYFR3lRTgfMpxwgMeIOqIFndmpnifBl0C8=;
        b=yS/VJPfdjJGCuBLo2Ul9Krr2Dh8Lp3KXMKhD0cO+2/sb9u8DesxcpQqrESwpHiVReK
         oKidbNJufoNnNR53ltH7x06RK/t6op9D6whe0lzOD+fzzvrm2l1gFe+4h+8vtr0qnhYq
         VLXMhZ4qg71/8JaSrpGaIPfWj16IT9i/46BWUEdfk7IZsXM8G/th4RH3glWxKVw27uNs
         toKycU5XCO3s7Ei0Eo4g5UvRqoF7DwVR0/c3gGZQF8oT9oe3Cx+44dMLvbVeAw4sNOcZ
         pQ+NtCzyvih3zT3+shLjr0+4AszQc4K3JAvQisNhY0yPIihqFzEFx1WAvxK5V4V3Whm5
         SfwQ==
X-Gm-Message-State: ACrzQf0Z3/2aHf+OfTxbSuQy/IjBaGkNp3CaTf+J6oVeYlQ9a0ZwlLem
        JDRb/ViQx9MyTdysJIH2HDv4Mrb6PxWi9g==
X-Google-Smtp-Source: AMsMyM5wUfCqBMO9b3tRLPZm9mHX6nxG3qIn9Ljq0Hecieql8IIhOnV6w7zsL+Js8rDq+iQnkbG2HQ==
X-Received: by 2002:a05:6214:21a6:b0:4bb:85b4:fd96 with SMTP id t6-20020a05621421a600b004bb85b4fd96mr8295689qvc.28.1666771676366;
        Wed, 26 Oct 2022 01:07:56 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a430500b006bb78d095c5sm3567121qko.79.2022.10.26.01.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 01:07:56 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y72so17819499yby.13;
        Wed, 26 Oct 2022 01:07:55 -0700 (PDT)
X-Received: by 2002:a25:687:0:b0:6c2:2b0c:26e with SMTP id 129-20020a250687000000b006c22b0c026emr38190526ybg.202.1666771675521;
 Wed, 26 Oct 2022 01:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com> <20221025184519.13231-9-casey@schaufler-ca.com>
In-Reply-To: <20221025184519.13231-9-casey@schaufler-ca.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 10:07:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCjhLeHbDp1R3QPaY-TgTx31TBUdXq8PQeUE8OKeDP5g@mail.gmail.com>
Message-ID: <CAMuHMdVCjhLeHbDp1R3QPaY-TgTx31TBUdXq8PQeUE8OKeDP5g@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] lsm: wireup syscalls lsm_self_attr and lsm_module_list
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

CC linux-perf

On Tue, Oct 25, 2022 at 8:52 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Wireup two syscalls for Linux Security Modules.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks for your patch!

>  arch/m68k/kernel/syscalls/syscall.tbl               | 2 ++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -907,6 +907,8 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
>  __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
> +#define __NR_lsm_attr_set 451
> +__SYSCALL(__NR_lsm_attr_set, sys_lsm_attr_set)

Missing lsm_module_list.

>
>  /*
>   * Please add new compat syscalls above this comment and update

> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>
> +#define __NR_lsm_self_attr 451
> +__SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)

Missing lsm_module_list.

> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452

Hence one off.

> --- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> +++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> @@ -365,3 +365,5 @@
>  448    n64     process_mrelease                sys_process_mrelease
>  449    n64     futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    n64     lsm_self_attr                   sys_lsm_self_attr
> +452    n64     lsm_module_list                 sys_lsm_module_list
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> index 2bca64f96164..7b779080acbe 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -530,3 +530,5 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    nospu   set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  lsm_self_attr                   sys_lsm_self_attr
> +452    common  lsm_module_list                 sys_lsm_module_list
> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> index 799147658dee..eaba1ed5654e 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -453,3 +453,5 @@
>  448  common    process_mrelease        sys_process_mrelease            sys_process_mrelease
>  449  common    futex_waitv             sys_futex_waitv                 sys_futex_waitv
>  450  common    set_mempolicy_home_node sys_set_mempolicy_home_node     sys_set_mempolicy_home_node
> +451  common    lsm_self_attr           sys_lsm_self_attr       sys_lsm_self_attr
> +452  common    lsm_module_list         sys_lsm_module_list     sys_lsm_module_list
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..40b35e7069a7 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,8 @@
>  448    common  process_mrelease        sys_process_mrelease
>  449    common  futex_waitv             sys_futex_waitv
>  450    common  set_mempolicy_home_node sys_set_mempolicy_home_node
> +451    common  lsm_self_attr           sys_lsm_self_attr
> +452    common  lsm_module_list         sys_lsm_module_list

BTW, why are the syscall tables not shared between arch/ and tools/perf/?
They seem to be identical (except for ppc due to 32/64 vs. common)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
