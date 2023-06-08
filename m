Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754EF72762A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjFHEh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjFHEhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:37:52 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E262705
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:37:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565ba6aee5fso1495767b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 21:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686199069; x=1688791069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVIyYHGZb4joQEF0M5IDzKbE+TgXfm5LbjSjHU53b9E=;
        b=fHvwsR8OiUDqZjtR0MeqJr1qjSKqHstZPtjRaa997MGADaxzW0HQiU0wz7Nr+cfFwf
         0U5QoQK/MKHEWidKrLsCo58tYfg9YRHAnAmyyPRy4KtekL6Vh3NLP7i1pbKp+xPTpxql
         sUQoD2mPkkURyxi+bPFGub8QiEA9q35K+SzVq7gqZhK5Q7EPFvzzy2eOw7gCnl/0rWOB
         III1Pk2qS923pX6YI/H/CPyqXLyo+DA9rVuV2ZxkAUcPg/dHVCsoVLd/OWJwlVEwI+vt
         ePDtct2hEy0KAgCOcVN23//oq+dzsiRej7w8YhyAF5UIXMD8Mp70efjkILIF4VOeqHL5
         B/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686199069; x=1688791069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVIyYHGZb4joQEF0M5IDzKbE+TgXfm5LbjSjHU53b9E=;
        b=PR6wH4G4erEsiIjan45MEfaLS385XwR9NTok1bgNx2WTgM6puvrsqqMo81dHlE57/9
         dmfU2aAlZI6dMxIgKK4c8MltDqyhpQYrPIyvthfgjSJILZDY74Eayhwai6TSvfdLOEFT
         rXmK2DosqX696iFDOfMkBVvle3dhAFKkP/C3uOUeXcYx0KbpBFxz2H/7a/B1uCZYu2x0
         PEH1HIzMz2mSJP5GhU9m3ltE9AOEINiGojaBYF/aFXXYEQeNzPONvkYau2A3rHoeC8Pq
         3SKYZrzz6D+Qo+Sc3ZE2UpoJD5vfz/k1GB43FoaMFJyxAj8E1iXpJiBqnC0zG99npNkQ
         8cIw==
X-Gm-Message-State: AC+VfDxudhZBkyipU02nHAJb29q1MInbPSMzSZtvv8o4bbGF6OnZHFr+
        ybW2lC4JCwS0wUlK+Jo1AENviywwsWsPLHa4jw==
X-Google-Smtp-Source: ACHHUZ6hC75E2lFShf0PFKGF9NYCLbSIj9DRDLQjCgWoKJQLZkQ5WxLpqP3HhvdgMLpFp1iVAsGauVBzBywbsIiVPXI=
X-Received: by 2002:a81:8413:0:b0:564:e8e3:e0ba with SMTP id
 u19-20020a818413000000b00564e8e3e0bamr7304904ywf.51.1686199069104; Wed, 07
 Jun 2023 21:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072936.3766231-1-nik.borisov@suse.com> <20230607072936.3766231-4-nik.borisov@suse.com>
In-Reply-To: <20230607072936.3766231-4-nik.borisov@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 8 Jun 2023 00:37:37 -0400
Message-ID: <CAMzpN2gvCE6UqC7kk61UCM9y7AGBHoczSL6YTcmLsdJGWnwhPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        jslaby@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 3:41=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.co=
m> wrote:
>
> In addition to disabling 32bit syscall interface let's also disable the
> ability to run 32bit processes altogether. This is achieved by setting
> the GDT_ENTRY_DEFAULT_USER32_CS descriptor to not present which would
> cause 32 bit processes to trap with a #NP exception. Furthermore,
> forbid loading compat processes as well.
>
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/include/asm/elf.h   | 5 +++--
>  arch/x86/kernel/cpu/common.c | 8 ++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 18fd06f7936a..406245bc0fb0 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -148,9 +148,10 @@ do {                                               \
>  #define elf_check_arch(x)                      \
>         ((x)->e_machine =3D=3D EM_X86_64)
>
> +extern bool ia32_disabled;
>  #define compat_elf_check_arch(x)                                       \
> -       (elf_check_arch_ia32(x) ||                                      \
> -        (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine =3D=3D EM_X86_=
64))
> +       (!ia32_disabled && (elf_check_arch_ia32(x) ||                   \
> +        (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine =3D=3D EM_X86_=
64)))
>
>  static inline void elf_common_init(struct thread_struct *t,
>                                    struct pt_regs *regs, const u16 ds)
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 71f8b55f70c9..ddc301c09419 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2359,6 +2359,11 @@ void microcode_check(struct cpuinfo_x86 *prev_info=
)
>  }
>  #endif
>
> +static void remove_user32cs_from_gdt(void * __unused)
> +{
> +       get_current_gdt_rw()[GDT_ENTRY_DEFAULT_USER32_CS].p =3D 0;
> +}
> +
>  /*
>   * Invoked from core CPU hotplug code after hotplug operations
>   */
> @@ -2368,4 +2373,7 @@ void arch_smt_update(void)
>         cpu_bugs_smt_update();
>         /* Check whether IPI broadcasting can be enabled */
>         apic_smt_update();
> +       if (ia32_disabled)
> +               on_each_cpu(remove_user32cs_from_gdt, NULL, 1);
> +
>  }

Disabling USER32_CS isn't really necessary, as simply running 32-bit
user code (in a normally 64-bit process) doesn't pose much of a threat
to the kernel with 32-bit syscalls disabled.

Wine, for example, is moving to a model where the main code runs in
64-bit mode, uses only 64-bit unix libraries, and the 32->64 bit
transitions are done entirely in userspace.  It will still need the
ability to use 32-bit code segments, but won't need 32-bit unix
libraries or syscalls to run 32-bit Windows code.

Brian Gerst
