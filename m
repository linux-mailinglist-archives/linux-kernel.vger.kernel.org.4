Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017B0660D9E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjAGKEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjAGKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:03:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44BB40C3D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:59:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so5431786edc.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/G9FcPlsL/ZYj6GpUzWdxZcsGx3VidjRMEnUyipGwTQ=;
        b=ycWZqSuFZ74To3dd3tRCQ6yRVxeq0UgluFKJfCwP7NMrAi4WhtdoXJFHq0fmn1PcGZ
         BidASz6yKHGfquMRO74r2wrv8n+3X0DaZHkvkUeed47LjYLFsCzlUSCcaNFJrkFwxmoe
         XAHqOJ+UooXB9uvMJr8qlJIPmNmP37tWffvmpi4nX/A3FuNHaVXj1ce3Qn+8CeG8GX3Y
         MbyMb8D/6efptMLg4LLEfs6zzrHmW6u41Vva+hK3pWH/RbLaTmU0G1JtluVSjaq/fitt
         rTRyEpJadF8DorfLe9vcUfJby2JEfhmaVxAxCymp+VXVioibcnYNPo8pOZlOma6G5xX6
         DZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/G9FcPlsL/ZYj6GpUzWdxZcsGx3VidjRMEnUyipGwTQ=;
        b=rrEvQiw62KaN8ImIxNEwZI93Vp+HOb7oavbOVpgXTyUv/Ps4AuEHdchd7/7r8Cb65G
         L2zHJ9beTVjIqahza/v1vSGvFQW5vcjGXnGGKf0vJzwkA75rjyqPT3Bvj5EVcaYL5fZG
         eLK/kEWiICBpSI5QTEnuXmLUppmZMa8l3wi46h+aQHMTVgMB9v6ZV4AW7xLaR8/fp6Ng
         mumQDiRTwvnUeXQPAGNXlJ+PIBWtgHlaOHmvPyhDdkQnVUXLnDZNbYwJTIEXW2m/hBUd
         PHxFLjlrZ0tNz9iEM0KwtaFqVvr7LlvEOBdewbVG+zj+A55VgIvF35fYZdYP8Qs5R16a
         i1Xw==
X-Gm-Message-State: AFqh2krVHAEyrWMx4GGVyXPzXuPgRUUqvKLpbNFHPQ4a2jrZX7DW355n
        1+N/NEfHcPQZVSEWHt53Hn/ce0ggvCNqtxo6domXXg==
X-Google-Smtp-Source: AMrXdXtLzFeJ9Ad5w+6FMr/1aURZJ28sV0J+AoE7j06eU9sJC8r/2qmYF8xl4P6NBEVpO98LES7s9yYkIY+u5wURJzM=
X-Received: by 2002:a05:6402:43cf:b0:48d:5b18:b009 with SMTP id
 p15-20020a05640243cf00b0048d5b18b009mr2154665edc.49.1673085498197; Sat, 07
 Jan 2023 01:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1> <20230105003813.1770367-5-paulmck@kernel.org>
In-Reply-To: <20230105003813.1770367-5-paulmck@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 7 Jan 2023 15:28:06 +0530
Message-ID: <CAAhSdy1VsT48WPQHZ5Pj5WNZRPUQvciFPF2LySawVv27tehD+g@mail.gmail.com>
Subject: Re: [PATCH rcu 05/27] arch/riscv/kvm: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 6:08 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: <kvm@vger.kernel.org>
> Cc: <kvm-riscv@lists.infradead.org>
> Cc: <linux-riscv@lists.infradead.org>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index f36a737d5f96d..6bc9b290c1283 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -27,7 +27,6 @@ config KVM
>         select KVM_XFER_TO_GUEST_WORK
>         select HAVE_KVM_VCPU_ASYNC_IOCTL
>         select HAVE_KVM_EVENTFD
> -       select SRCU
>         help
>           Support hosting virtualized guest machines.
>
> --
> 2.31.1.189.g2e36527f23
>
