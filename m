Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5A5FFB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJOPzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJOPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:55:05 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609A303E3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:55:04 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1324e7a1284so9142479fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x12m8DrljSUsR12aaA1YeihZxPj67JHyfjJnVCYRx+w=;
        b=h/bw8ClQDtmyXl/4OvlJSBaREVvX+KQL5LWgL3f6AfHU5fpK0gDbXd6CuZGsReu1Pb
         6fpr6wimP/NIMSN0Ee9OESX3/T/5WGg4/lloPVPLPv7sciLfrRsc/l/rypcCcNxuJ4/+
         snqxj+XFUCBg5JfvAYe4WQfBPnMuo44uC0ER4WBwjBlIkkCtKh8mlhDNX5A5ZjBx4oKR
         VChU5/Xeqzji9ddJl+VQdzVO9hf+iEueLsC+fxAvyNMRZ/Jazb2PJrif3i5mok1XX1AB
         HuUv0rBtB4nOeHuS9LdX0Rl/CAeekWOwEr1ZEZVZoc3KJo8eG+i7SALhsr9m3Ek1ZFfZ
         CAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x12m8DrljSUsR12aaA1YeihZxPj67JHyfjJnVCYRx+w=;
        b=HErjfKraifj/lr3kWZ/bS0FDBZFLuK43GVP2HOe/x5Vs2XcHfv2h8tCaeB8q2Sf6b7
         txYDo8wnbWAC0jmnzVW2HYdYCxrBPYeRKSaNHCHeEdy4AEz6Co1Z3xmiv8fsO4QGOh21
         EWAxCz1PPtNmHiY2VklBcaadhr91zUM3qT7WhJoMDAhMlcAfwP9MbosP8GFDHucc28Kw
         pftszTRzBnU/ETDDPxYKzLSBho0N8wn3C5AlogclNsPG6DV0+u5P9D0grfa/dmjjuRhz
         Gy5kwm3pB+tC5NCYYegJmWMkbqElfRYIS+chvr8rjQ2pPb3V6Hdf1stkEDfn7LyTatxh
         gKqA==
X-Gm-Message-State: ACrzQf1cMcgYBGUOc8kl1j6d+CctFUKK99LHtReJa7z4yMNvQjW0+EQd
        Hp+UQVAVURuYWCUgE14RMte3CFKX52I=
X-Google-Smtp-Source: AMsMyM7BA81YPiez1/DevuOp3tSBWWDYr9IiJGHfyk1SxtsClBl4MirdOnGkBBowfk4xa+f99E44UA==
X-Received: by 2002:a05:6870:e2cf:b0:132:9fa0:fc28 with SMTP id w15-20020a056870e2cf00b001329fa0fc28mr10932879oad.170.1665849303917;
        Sat, 15 Oct 2022 08:55:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r22-20020a056870581600b001324315bb6asm2894960oap.29.2022.10.15.08.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 08:55:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Oct 2022 08:55:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cpumask: fix checking valid cpu range
Message-ID: <20221015155501.GA967719@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:05:53PM -0700, Yury Norov wrote:
> The range of valid CPUs is [0, nr_cpu_ids). Some cpumask functions are
> passed with a shifted CPU index, and for them, the valid range is
> [-1, nr_cpu_ids-1). Currently for those functions, we check the index
> against [-1, nr_cpu_ids), which is wrong.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

This patch results in warnings when booting riscv images.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 smp_call_function_many_cond+0x462/0x46a
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-12198-gde62603c1e8c #1
Hardware name: riscv-virtio,qemu (DT)
epc : smp_call_function_many_cond+0x462/0x46a
ra : smp_call_function_many_cond+0x108/0x46a
epc : c00b7c36 ra : c00b78dc sp : c2515c00
gp : c1d8e778 tp : c2578040 t0 : 00001fff
t1 : 00000001 t2 : 00001fff s0 : c2515c60
s1 : c1d8e378 a0 : 00000000 a1 : c1d911e0
a2 : 00000001 a3 : 00000001 a4 : 00000000
a5 : 00000000 a6 : c1d911dc a7 : c1d8f304
s2 : c0239310 s3 : 00000000 s4 : c2843ac0
s5 : 00000000 s6 : 00000000 s7 : 00000001
s8 : c31c3468 s9 : 00000001 s10: 00000001
s11: 00000000 t3 : 5b9996c6 t4 : 5b152795
t5 : 00000005 t6 : 00000064
status: 00000120 badaddr: 00000000 cause: 00000003
[<c00b7ca8>] on_each_cpu_cond_mask+0x1e/0x30
[<c0239472>] invalidate_bh_lrus+0x2c/0x34
[<c051666c>] blkdev_flush_mapping+0x52/0x102
[<c0516bac>] blkdev_put+0x1a6/0x1c8
[<c05339fa>] disk_scan_partitions+0x4a/0x64
[<c0533cb8>] device_add_disk+0x2a4/0x2c4
[<c06a8070>] virtblk_probe+0xa8e/0xb2a
[<c063ce72>] virtio_dev_probe+0x1d6/0x354
[<c0683d46>] really_probe+0x82/0x214
[<c0683f30>] __driver_probe_device+0x58/0xa2
[<c0683faa>] driver_probe_device+0x30/0xaa
[<c068456e>] __driver_attach+0x56/0x11c
[<c0681efe>] bus_for_each_dev+0x52/0x90
[<c0683798>] driver_attach+0x1a/0x22
[<c06832f2>] bus_add_driver+0x148/0x1b6
[<c0684d48>] driver_register+0x52/0xea
[<c063c8fc>] register_virtio_driver+0x1a/0x28
[<c0c22862>] virtio_blk_init+0x68/0x9c
[<c0002824>] do_one_initcall+0x5e/0x2e2
[<c0c01130>] kernel_init_freeable+0x298/0x306
[<c0aa0a7a>] kernel_init+0x1e/0x10e
[<c0003ad0>] ret_from_exception+0x0/0x10
irq event stamp: 103724
hardirqs last  enabled at (103723): [<c0007518>] __trace_hardirqs_on+0xc/0x14
hardirqs last disabled at (103724): [<c000752c>] __trace_hardirqs_off+0xc/0x14
softirqs last  enabled at (103620): [<c0195420>] bdi_register_va.part.0+0x168/0x27a
softirqs last disabled at (103618): [<c0195396>] bdi_register_va.part.0+0xde/0x27a
---[ end trace 0000000000000000 ]---

Guenter

> ---
>  include/linux/cpumask.h | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 13b32dd9803b..286804bfe3b7 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -174,9 +174,8 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
>  static inline
>  unsigned int cpumask_next(int n, const struct cpumask *srcp)
>  {
> -	/* -1 is a legal arg here. */
> -	if (n != -1)
> -		cpumask_check(n);
> +	/* n is a prior cpu */
> +	cpumask_check(n + 1);
>  	return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
>  }
>  
> @@ -189,9 +188,8 @@ unsigned int cpumask_next(int n, const struct cpumask *srcp)
>   */
>  static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  {
> -	/* -1 is a legal arg here. */
> -	if (n != -1)
> -		cpumask_check(n);
> +	/* n is a prior cpu */
> +	cpumask_check(n + 1);
>  	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
>  }
>  
> @@ -231,9 +229,8 @@ static inline
>  unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>  		     const struct cpumask *src2p)
>  {
> -	/* -1 is a legal arg here. */
> -	if (n != -1)
> -		cpumask_check(n);
> +	/* n is a prior cpu */
> +	cpumask_check(n + 1);
>  	return find_next_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
>  		nr_cpumask_bits, n + 1);
>  }
> @@ -263,8 +260,8 @@ static inline
>  unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
>  {
>  	cpumask_check(start);
> -	if (n != -1)
> -		cpumask_check(n);
> +	/* n is a prior cpu */
> +	cpumask_check(n + 1);
>  
>  	/*
>  	 * Return the first available CPU when wrapping, or when starting before cpu0,
> -- 
> 2.36.2
