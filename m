Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEF974F3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjGKPii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjGKPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:37:36 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D3210E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:37:10 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R0lNj1tB4zMqFmf;
        Tue, 11 Jul 2023 15:37:09 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R0lNg6NPpzMpssN;
        Tue, 11 Jul 2023 17:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689089829;
        bh=ZcM6YJj7mVrbgyAnj9A/OJa5Lxwp6VLbC4EnK2HOg18=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RsnhhrCAk1UuGfk+Y1ETtaKlbv8nVLt9SzgKZIlSAdbgjSxup7gJiJYJRX/6MO342
         D18+cffABrUL0DI14sKadyq7sW0JJbV2y4LdwfkGBvZ5F8OBNs0fehA/+qkhW5GZYI
         zaem+SSpGOOijbc4UbHYAh+ybsuQBYx8Mu6Nrbj8=
Message-ID: <938bd332-75bc-ce0c-b8d2-d989351b56a9@digikod.net>
Date:   Tue, 11 Jul 2023 17:37:07 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v12 06/11] LSM: wireup Linux Security Module syscalls
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-7-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230629195535.2590-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2023 21:55, Casey Schaufler wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
> system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-api@vger.kernel.org

The master branch got a new cachestat syscall, so all these syscall 
numbers would need to be incremented, but it looks good otherwise.


> ---
>   arch/alpha/kernel/syscalls/syscall.tbl              |  3 +++
>   arch/arm/tools/syscall.tbl                          |  3 +++
>   arch/arm64/include/asm/unistd.h                     |  2 +-
>   arch/arm64/include/asm/unistd32.h                   |  6 ++++++
>   arch/ia64/kernel/syscalls/syscall.tbl               |  3 +++
>   arch/m68k/kernel/syscalls/syscall.tbl               |  3 +++
>   arch/microblaze/kernel/syscalls/syscall.tbl         |  3 +++
>   arch/mips/kernel/syscalls/syscall_n32.tbl           |  3 +++
>   arch/mips/kernel/syscalls/syscall_n64.tbl           |  3 +++
>   arch/mips/kernel/syscalls/syscall_o32.tbl           |  3 +++
>   arch/parisc/kernel/syscalls/syscall.tbl             |  3 +++
>   arch/powerpc/kernel/syscalls/syscall.tbl            |  3 +++
>   arch/s390/kernel/syscalls/syscall.tbl               |  3 +++
>   arch/sh/kernel/syscalls/syscall.tbl                 |  3 +++
>   arch/sparc/kernel/syscalls/syscall.tbl              |  3 +++
>   arch/x86/entry/syscalls/syscall_32.tbl              |  3 +++
>   arch/x86/entry/syscalls/syscall_64.tbl              |  3 +++
>   arch/xtensa/kernel/syscalls/syscall.tbl             |  3 +++
>   include/uapi/asm-generic/unistd.h                   | 11 ++++++++++-
>   tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl |  3 +++
>   tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  |  3 +++
>   tools/perf/arch/s390/entry/syscalls/syscall.tbl     |  3 +++
>   tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   |  3 +++
>   23 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 8ebacf37a8cf..178e2792c251 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -490,3 +490,6 @@
>   558	common	process_mrelease		sys_process_mrelease
>   559	common  futex_waitv                     sys_futex_waitv
>   560	common	set_mempolicy_home_node		sys_ni_syscall
> +561	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +562	common	lsm_list_modules		sys_lsm_list_modules
> +563	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index ac964612d8b0..9cda144f9631 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -464,3 +464,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 037feba03a51..6a28fb91b85d 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -39,7 +39,7 @@
>   #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>   #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>   
> -#define __NR_compat_syscalls		451
> +#define __NR_compat_syscalls		454
>   #endif
>   
>   #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 604a2053d006..72022ffd5faa 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -907,6 +907,12 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
>   __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>   #define __NR_set_mempolicy_home_node 450
>   __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
> +#define __NR_lsm_get_self_attr 451
> +__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
> +#define __NR_lsm_list_modules 452
> +__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
> +#define __NR_lsm_set_self_attr 453
> +__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
>   
>   /*
>    * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 72c929d9902b..c52e9d87f47d 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -371,3 +371,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index b1f3940bc298..31eac3c99d84 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -450,3 +450,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 820145e47350..5037fa1f74b8 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -456,3 +456,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 253ff994ed2e..29545b3ec587 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -389,3 +389,6 @@
>   448	n32	process_mrelease		sys_process_mrelease
>   449	n32	futex_waitv			sys_futex_waitv
>   450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	n32	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	n32	lsm_list_modules		sys_lsm_list_modules
> +453	n32	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 3f1886ad9d80..8492aa4a771f 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -365,3 +365,6 @@
>   448	n64	process_mrelease		sys_process_mrelease
>   449	n64	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	n64	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	n64	lsm_list_modules		sys_lsm_list_modules
> +453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 8f243e35a7b2..d74fd86de2a2 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -438,3 +438,6 @@
>   448	o32	process_mrelease		sys_process_mrelease
>   449	o32	futex_waitv			sys_futex_waitv
>   450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	o32	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	o32	lsm_list_modules		sys_lsm_list_modules
> +453	032	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 0e42fceb2d5e..d1a5f3120d6c 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -448,3 +448,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index a0be127475b1..a414fe8c069b 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -537,3 +537,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index b68f47541169..7511e05b785d 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -453,3 +453,6 @@
>   448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
>   449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
>   450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
> +452  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
> +453  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 2de85c977f54..1a75a599bb55 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -453,3 +453,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 4398cc6fb68d..80b165091f6f 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -496,3 +496,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 320480a8db4f..130f9feb9eb9 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -455,3 +455,6 @@
>   448	i386	process_mrelease	sys_process_mrelease
>   449	i386	futex_waitv		sys_futex_waitv
>   450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	i386	lsm_get_self_attr	sys_lsm_get_self_attr
> +452	i386	lsm_list_modules	sys_lsm_list_modules
> +453	i386	lsm_set_self_attr	sys_lsm_set_self_attr
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..96dd45bc5988 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,9 @@
>   448	common	process_mrelease	sys_process_mrelease
>   449	common	futex_waitv		sys_futex_waitv
>   450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr	sys_lsm_get_self_attr
> +452	common	lsm_list_modules	sys_lsm_list_modules
> +453	common	lsm_set_self_attr	sys_lsm_set_self_attr
>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 52c94ab5c205..2610aba19802 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -421,3 +421,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 45fa180cc56a..93f89fb06ef5 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -886,8 +886,17 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>   #define __NR_set_mempolicy_home_node 450
>   __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>   
> +#define __NR_lsm_get_self_attr 451
> +__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
> +
> +#define __NR_lsm_list_modules 452
> +__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
> +
> +#define __NR_lsm_set_self_attr 453
> +__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
> +
>   #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 454
>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> index 3f1886ad9d80..8492aa4a771f 100644
> --- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> +++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> @@ -365,3 +365,6 @@
>   448	n64	process_mrelease		sys_process_mrelease
>   449	n64	futex_waitv			sys_futex_waitv
>   450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	n64	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	n64	lsm_list_modules		sys_lsm_list_modules
> +453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> index a0be127475b1..a414fe8c069b 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -537,3 +537,6 @@
>   448	common	process_mrelease		sys_process_mrelease
>   449	common  futex_waitv                     sys_futex_waitv
>   450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr		sys_lsm_get_self_attr
> +452	common	lsm_list_modules		sys_lsm_list_modules
> +453	common	lsm_set_self_attr		sys_lsm_set_self_attr
> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> index b68f47541169..36a52d54d987 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -453,3 +453,6 @@
>   448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
>   449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
>   450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
> +452  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules
> +453  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..96dd45bc5988 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,9 @@
>   448	common	process_mrelease	sys_process_mrelease
>   449	common	futex_waitv		sys_futex_waitv
>   450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	common	lsm_get_self_attr	sys_lsm_get_self_attr
> +452	common	lsm_list_modules	sys_lsm_list_modules
> +453	common	lsm_set_self_attr	sys_lsm_set_self_attr
>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently
