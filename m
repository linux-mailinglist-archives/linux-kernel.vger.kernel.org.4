Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3D69DC25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjBUIgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjBUIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:36:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95CD241F6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:36:17 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676968488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEFsVpdz84nk4ndDccDsxytDmpNm8adKyT8SapFlJ/s=;
        b=P+C2m2YLOpyBsBwrg/OTuVt7SYeoVL2/4koUUiPOqH7rpMW9nZblNIBHkLSOKAvvAIB+rX
        ujwkCVBh+35fnoeV8H+sssYormN7ldXANUeJSPNeGftpWATPBdOrghGTUgTUpnwk/GtSkY
        Qh3Vb3z+x0YzNMAowKENJHx/Zt6EWU6daf3T3tAc0hIgRaF/1bICvuBUZu4hZAohc2bXq7
        bfHKmBbJIoTroLk57rlHYVilNr3mAKO6mrmgfzw7eU9CJ6sPZsNNChaN6Aff/yfH8eUSi6
        kIDF+1130RdhYecm7Kenueh7FILbesMIA468lLp6RJshGUMfq6xBXevFGrEp6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676968488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEFsVpdz84nk4ndDccDsxytDmpNm8adKyT8SapFlJ/s=;
        b=XsIAt7ga9PWt0LIiAqkcoqGek4vwcqq4R/ANCVlyL84isfkZskIrO6dCSA/pI8HZRvaeKN
        GFLkT2tXJYrCd/CA==
To:     Marc =?utf-8?Q?Aur=C3=A8le?= La France <tsi@tuyoix.net>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT
In-Reply-To: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net>
References: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net>
Date:   Tue, 21 Feb 2023 09:39:30 +0106
Message-ID: <87r0ujs9id.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Added the rest of the printk team CC.)

On 2023-02-20, Marc Aur=C3=A8le La France <tsi@tuyoix.net> wrote:
> After 93d102f094be9beab28e5afb656c188b16a3793b "printk: remove safe buffe=
rs",
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT is no longer useful.  Remove it.
>
> This change is not eligible for stable@.
>
> Please Reply-To-All.
>
> Marc.
>
> Signed-off-by: Marc Aur=C3=A8le La France <tsi@tuyoix.net>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/powerpc/configs/micr=
owatt_defconfig devel-6.2.0/arch/powerpc/configs/microwatt_defconfig
> --- linux-6.2.0/arch/powerpc/configs/microwatt_defconfig	2023-02-19 15:24=
:22.000000000 -0700
> +++ devel-6.2.0/arch/powerpc/configs/microwatt_defconfig	2023-02-20 21:39=
:39.057268798 -0700
> @@ -4,7 +4,6 @@ CONFIG_HIGH_RES_TIMERS=3Dy
>  CONFIG_PREEMPT_VOLUNTARY=3Dy
>  CONFIG_TICK_CPU_ACCOUNTING=3Dy
>  CONFIG_LOG_BUF_SHIFT=3D16
> -CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D12
>  CONFIG_CGROUPS=3Dy
>  CONFIG_BLK_DEV_INITRD=3Dy
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/riscv/configs/nommu_=
k210_defconfig devel-6.2.0/arch/riscv/configs/nommu_k210_defconfig
> --- linux-6.2.0/arch/riscv/configs/nommu_k210_defconfig	2023-02-19 15:24:=
22.000000000 -0700
> +++ devel-6.2.0/arch/riscv/configs/nommu_k210_defconfig	2023-02-20 21:40:=
01.349181760 -0700
> @@ -1,6 +1,5 @@
>  # CONFIG_CPU_ISOLATION is not set
>  CONFIG_LOG_BUF_SHIFT=3D13
> -CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D12
>  CONFIG_BLK_DEV_INITRD=3Dy
>  # CONFIG_RD_GZIP is not set
>  # CONFIG_RD_BZIP2 is not set
> diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/riscv/configs/nommu_=
k210_sdcard_defconfig devel-6.2.0/arch/riscv/configs/nommu_k210_sdcard_defc=
onfig
> --- linux-6.2.0/arch/riscv/configs/nommu_k210_sdcard_defconfig	2023-02-19=
 15:24:22.000000000 -0700
> +++ devel-6.2.0/arch/riscv/configs/nommu_k210_sdcard_defconfig	2023-02-20=
 21:39:46.721238871 -0700
> @@ -1,6 +1,5 @@
>  # CONFIG_CPU_ISOLATION is not set
>  CONFIG_LOG_BUF_SHIFT=3D13
> -CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D12
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
>  # CONFIG_SYSFS_SYSCALL is not set
>  # CONFIG_FHANDLE is not set
> diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/riscv/configs/nommu_=
virt_defconfig devel-6.2.0/arch/riscv/configs/nommu_virt_defconfig
> --- linux-6.2.0/arch/riscv/configs/nommu_virt_defconfig	2023-02-19 15:24:=
22.000000000 -0700
> +++ devel-6.2.0/arch/riscv/configs/nommu_virt_defconfig	2023-02-20 21:39:=
55.329205262 -0700
> @@ -1,6 +1,5 @@
>  # CONFIG_CPU_ISOLATION is not set
>  CONFIG_LOG_BUF_SHIFT=3D16
> -CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D12
>  CONFIG_BLK_DEV_INITRD=3Dy
>  # CONFIG_RD_BZIP2 is not set
>  # CONFIG_RD_LZMA is not set
> diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/init/Kconfig devel-6.2.0/=
init/Kconfig
> --- linux-6.2.0/init/Kconfig	2023-02-19 15:24:22.000000000 -0700
> +++ devel-6.2.0/init/Kconfig	2023-02-20 21:40:23.329095967 -0700
> @@ -769,30 +769,6 @@ config LOG_CPU_MAX_BUF_SHIFT
>  		     13 =3D>   8 KB for each CPU
>  		     12 =3D>   4 KB for each CPU
>
> -config PRINTK_SAFE_LOG_BUF_SHIFT
> -	int "Temporary per-CPU printk log buffer size (12 =3D> 4KB, 13 =3D> 8KB=
)"
> -	range 10 21
> -	default 13
> -	depends on PRINTK
> -	help
> -	  Select the size of an alternate printk per-CPU buffer where messages
> -	  printed from unsafe contexts are temporary stored. One example would
> -	  be NMI messages, another one - printk recursion. The messages are
> -	  copied to the main log buffer in a safe context to avoid a deadlock.
> -	  The value defines the size as a power of 2.
> -
> -	  Those messages are rare and limited. The largest one is when
> -	  a backtrace is printed. It usually fits into 4KB. Select
> -	  8KB if you want to be on the safe side.
> -
> -	  Examples:
> -		     17 =3D> 128 KB for each CPU
> -		     16 =3D>  64 KB for each CPU
> -		     15 =3D>  32 KB for each CPU
> -		     14 =3D>  16 KB for each CPU
> -		     13 =3D>   8 KB for each CPU
> -		     12 =3D>   4 KB for each CPU
> -
>  config PRINTK_INDEX
>  	bool "Printk indexing debugfs interface"
>  	depends on PRINTK && DEBUG_FS

Thanks!

John Ogness
