Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC661061B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiJ0XH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiJ0XHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:07:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9EC8F97E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f193so3208307pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gyfpmFe14VJ3jdYNVJ0rx3Ah2uaRzNTmMnT4495S4I=;
        b=ZNNSYZLMCiTx3pCpdTSLaMqTAwcT0XD23hboDkck2m1sj0K18I/wiwFIJBnxkxlMh1
         TMOX+6v0XNUWVLrMkaS7nFMD6HK3C70ZLK5411vF56AMxZrrEveIWdn7U/wWYAX6hu8f
         z7X+MhLcDZ2abQ+JkeJnFiHqWkFba2HtnVwkX4LhmKXO9kCXDrbkBH+MQc0VlITciM7I
         DQ4GGK7LnrmeObtOo33dthlXeC/HBl0rQRBuyHKeRHXZmYYPUrcsYqTcTlXIWwUSoL9i
         Op+9awjoXqXajuMDeHaLc5MvW/7/blHnT1v9JwgcyUng9A7q3UoZ9aZNVukbXbfjaCwz
         UOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gyfpmFe14VJ3jdYNVJ0rx3Ah2uaRzNTmMnT4495S4I=;
        b=aNuJZaEFuemXFQ3A9P5PBNrQWZYJ/+lnaUCqzBxlmv8G93zN4zuY7nyLFGbHSmrBhM
         FCa3B1k8DKq4mD32QPyACzh5Y4xTSgws9hkFMI3TmnTdB/V/7QUnkQnq1PS5GWuQt2yD
         MzVCzpD1E7/Davk2ZT2eX9uPTIgAOl5rY1r7izwe3OFNyPmuEnrdDpbdzCuogFB5LmIw
         IjmfQNOVtTOmfIH9sRwafu7yu/vjrpWqVkn/Ltahd5dxfZ46y5nVvtJr+vuqx6XLe1Fp
         8sjymKxW6qPm/pk+ZzySy/8N0/27SgV6sLY3kUseYtSaIaTyMi3oN3JdFlzI8BKkZPPQ
         adNg==
X-Gm-Message-State: ACrzQf3jWTpEpCFR4MuqI89KM5PeRgRDqMeKX3Wv1Xi7jRtWN4h4DPXz
        qz+jqQmSNQeyDv62qVpEIVrqcQ==
X-Google-Smtp-Source: AMsMyM48cCCOaGHpcUrqKPuvLPqi8N0s0YHUDIkD3gXkNLjihHit7dpsoFkfZbjAvACH4Z61kt9rCg==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr44319504pgs.211.1666912040505;
        Thu, 27 Oct 2022 16:07:20 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b00186e8526790sm1675818plb.127.2022.10.27.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:07:18 -0700 (PDT)
Date:   Thu, 27 Oct 2022 16:07:18 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Oct 2022 15:22:27 PDT (-0700)
Subject:     Re: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
CC:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, yury.norov@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        openrisc@lists.librecores.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ajones@ventanamicro.com
Message-ID: <mhng-b3bcbdea-1572-44ba-9d9a-e35e55b8880f@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 08:58:43 PDT (-0700), ajones@ventanamicro.com wrote:
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> start and next seq operations implement a pattern like
>
>   n = cpumask_next(n - 1, mask);
>   show(n);
>   while (1) {
>       ++n;
>       n = cpumask_next(n - 1, mask);
>       if (n >= nr_cpu_ids)
>           break;
>       show(n);
>   }
>
> which will issue the warning when reading /proc/cpuinfo.
>
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
>
> This series address the issue for x86 and riscv, but from a quick
> grep of cpuinfo seq operations, I think at least openrisc, powerpc,
> and s390 also need an equivalent patch. While the test is simple (see
> next paragraph) I'm not equipped to test on each architecture.
>
> To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
> a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.
>
> While the patches are being posted together in a series since they're
> for two different architectures they don't necessarily need to go
> through the same tree.
>
> v3:
>   - Change condition from >= to == in order to still get a warning
>     for > as that's unexpected. [Yury]
>   - Picked up tags on the riscv patch
>
> v2:
>   - Added all the information I should have in the first place
>     to the commit message [Boris]
>   - Changed style of fix [Boris]
>
> Andrew Jones (2):
>   RISC-V: Fix /proc/cpuinfo cpumask warning

I just took the RISC-V fix, might be worth re-sending the x86 one alone 
as nobody's replied over there so it may be lost.

Thanks!

>   x86: Fix /proc/cpuinfo cpumask warning
>
>  arch/riscv/kernel/cpu.c    | 3 +++
>  arch/x86/kernel/cpu/proc.c | 3 +++
>  2 files changed, 6 insertions(+)
