Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E05F5E28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJFBFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJFBFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:05:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D663F31
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:05:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r18so462330pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zz+HXUH9nJdRQI27LUzdzL5vjVdFK5hIVfPKFeeoWM=;
        b=W9oFKSvSZBKTpp5k39eldV09BnQECEr2wHfFrvrRQgGoVKioiKSxy5PDXDUUj/8Xt3
         9c1MyIGFLZTP7y2nr3TdvhWoyXOADfH9j9xQ1Mffq+LUDliHqXuYfkC9wcaugdvVc3ap
         TVN87T4LRGGzuRU7BxBS9fP9baNIjA2Bs2UoB08USts0LQbGyopR9+iqfXXj9TljNKj0
         tBqaUnJsmrbqMrzcjnnIVu1qJULfNRwpvDGGrse4+ZHPZrx3fTFFvn2uIbon9ESJJRxP
         QBhx7mCPg8xqajVIJ/0qq34dQRZI/iaUK1AnKSI93ch0R45vwIGOK8E+D/WWj6934tmw
         bBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zz+HXUH9nJdRQI27LUzdzL5vjVdFK5hIVfPKFeeoWM=;
        b=0cFcs+Bdt6I5/LD7LDsRDXJM6JRhmX5rP+J8D2/pbnUPaWZXWoaueXodkyxMBY1Hww
         4pKQqhnnWbPk2pMeZAceCh1Ns3ypQF4IM5cQp2sZDxX1FV1p+Mprx2JXnHsh/lMizAM+
         H171E+G0wPgtkHTRRowtaw2QhyFCisAm1sUUFU1EpZvZv5AfSt1fdDMi1vDg5KBRx0Bs
         IEJ4Fv6okMino0FY3SqwsXbTKp2NNS8I6Vjiv+c7UCipIH/yb1OSr0bnsiRhdw+8tw1b
         +ZQjHd33emisHA4wZTQe7DM9PZToo8+j7UuEAuishsz0ePWFHYoVLTJj48A4ETJSMus6
         QGYg==
X-Gm-Message-State: ACrzQf3gjzDzH3sXIsEJPM9rqbhRXhgbMWw5QiwmqsiYWa3/RFSE+l8C
        j0wta0426x38Ado9r0W192e4sQ==
X-Google-Smtp-Source: AMsMyM6867A5+juCRxIx5ivLWt/uRwuXH1Hj6A9x9CUunC87zaZwVIr1m2g/SEds/0zZtclFDhUAAg==
X-Received: by 2002:a05:6a00:a01:b0:561:7e74:11b3 with SMTP id p1-20020a056a000a0100b005617e7411b3mr2084194pfh.35.1665018331640;
        Wed, 05 Oct 2022 18:05:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090301c200b00172ea8ff334sm11129483plh.7.2022.10.05.18.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 18:05:28 -0700 (PDT)
Date:   Wed, 05 Oct 2022 18:05:28 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Oct 2022 18:05:20 PDT (-0700)
Subject:     Re: [PATCH v6 RESEND 0/2] use static key to optimize pgtable_l4_enabled
In-Reply-To: <20220821140918.3613-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        alexandre.ghiti@canonical.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-30c89107-c103-4363-b4af-7778d9512622@palmer-ri-x1c9>
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

On Sun, 21 Aug 2022 07:09:16 PDT (-0700), jszhang@kernel.org wrote:
> The pgtable_l4|[l5]_enabled check sits at hot code path, performance
> is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed after
> boot, so static key can be used to solve the performance issue[1].
>
> An unified way static key was introduced in [2], but it only targets
> riscv isa extension. We dunno whether SV48 and SV57 will be considered
> as isa extension, so the unified solution isn't used for
> pgtable_l4[l5]_enabled now.
>
> patch1 fixes a NULL pointer deference if static key is used a bit earlier.
> patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
> [2] https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.org/T/#t
>
> Since v5:
>  - Use DECLARE_STATIC_KEY_FALSE
>
> Since v4:
>  - rebased on v5.19-rcN
>  - collect Reviewed-by tags
>  - Fix kernel panic issue if SPARSEMEM is enabled by moving the
>    riscv_finalise_pgtable_lx() after sparse_init()
>
> Since v3:
>  - fix W=1 call to undeclared function 'static_branch_likely' error
>
> Since v2:
>  - move the W=1 warning fix to a separate patch
>  - move the unified way to use static key to a new patch series.
>
> Since v1:
>  - Add a W=1 warning fix
>  - Fix W=1 error
>  - Based on v5.18-rcN, since SV57 support is added, so convert
>    pgtable_l5_enabled as well.
>
>
> Jisheng Zhang (2):
>   riscv: move sbi_init() earlier before jump_label_init()
>   riscv: turn pgtable_l4|[l5]_enabled to static key for RV64
>
>  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
>  arch/riscv/include/asm/pgtable-32.h |  3 ++
>  arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
>  arch/riscv/include/asm/pgtable.h    |  5 +--
>  arch/riscv/kernel/cpu.c             |  4 +-
>  arch/riscv/kernel/setup.c           |  2 +-
>  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
>  arch/riscv/mm/kasan_init.c          | 16 ++++----
>  8 files changed, 104 insertions(+), 66 deletions(-)

Sorry for being slow here, but it looks like this still causes some 
early boot hangs.  Specifically kasan+sparsemem is failing.  As you can 
probably see from the latency I'm still a bit buried right now so I'm 
not sure when I'll have a chance to take more of a look.
