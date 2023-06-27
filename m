Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233F7401E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjF0RHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjF0RHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:07:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D451708;
        Tue, 27 Jun 2023 10:07:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e64e97e2so2707132b3a.1;
        Tue, 27 Jun 2023 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687885631; x=1690477631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCi8Fft3fUuZC6N2KTxcDjbJC9FUbM5bxnxTh2WRBHw=;
        b=WHR2f57IoLDU/fRvv1LemgnrZDMuFxnUu2LVEALSg10BxZ8g9eleTm8wihH9P7SWeR
         fyA53QigAnk5+2eZd1j4HJlZXN7UKg6bkug7t+YLQsjXpXNUVxyXqcDwVPkrcmIluSOK
         bgOpK4pW6RPRjd+TqYZjTCit/lwarkA9S/dUdfnledzPULTdDYDjkVIs1t/QyCXZelYi
         Hg3DgZLLcoxrECPDbMM1XLU3B0eURsIJHty2dwo4UlIiKgdGkzwmpwfCHo4xS1/dyCIr
         V9jVDatEs1R9MUc8j/4KvB37np8DKTMKXwGqbiiRzlnDE41hvvUcopve9vjkp4hczUEF
         anPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885631; x=1690477631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCi8Fft3fUuZC6N2KTxcDjbJC9FUbM5bxnxTh2WRBHw=;
        b=k9buv9+ubCiaAzES0o0owIb/cN+jNCcEBffgUjivfykXgnbxNYni4C1iJT6t1kTU/l
         KKeUWN2tCoqIjZzeqUrlCxz1/mvprjMYdDPY47l5CCexyZLQ7XXw4DTqYhDOHBCUSz98
         PANzwey+GILsEq+eGdSXKVQhp182MyHsu1fdX7+paU/TCj9FDIn/qnNAbAtH1igGiR2Q
         P1le78LhiTwJkcF1EJQrdcfGVBLQvMLLjllh0QGoUloyVamtKoe8UlKbfdYw0J7OymlK
         AqziaADfu2jFzfWERFPydgXSJ3rG//cbD+cLgtx85p+aiasklJxrKbIrBf93teeo+X0M
         NBoA==
X-Gm-Message-State: AC+VfDzR1HuzKQ3oKy9Ri9djkkAFdj+vau9+N5Ibkcy0BgDn9SYPpXf/
        a8xLXLGvCSOSKVQO303E148=
X-Google-Smtp-Source: ACHHUZ4Oo3laIj+hS2va5uKe1T5qB9ZZpvHr4eyfuV/zN4mSV5CufaAlc88Bmvn7F2FA0/nk+qxtkQ==
X-Received: by 2002:a17:90a:188:b0:258:c4b5:c6b4 with SMTP id 8-20020a17090a018800b00258c4b5c6b4mr23840816pjc.12.1687885630872;
        Tue, 27 Jun 2023 10:07:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jx3-20020a17090b46c300b00262f0e4c1a0sm1775179pjb.3.2023.06.27.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:07:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 10:07:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 04/27] locking/atomic: make atomic*_{cmp,}xchg optional
Message-ID: <32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
 <20230605070124.3741859-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605070124.3741859-5-mark.rutland@arm.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 05, 2023 at 08:01:01AM +0100, Mark Rutland wrote:
> Most architectures define the atomic/atomic64 xchg and cmpxchg
> operations in terms of arch_xchg and arch_cmpxchg respectfully.
> 
> Add fallbacks for these cases and remove the trivial cases from arch
> code. On some architectures the existing definitions are kept as these
> are used to build other arch_atomic*() operations.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

This patch results in:

ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!

when trying to build sparc64:allmodconfig.

Guenter

---
bisect log:

# bad: [60e7c4a25da68cd826719b685babbd23e73b85b0] Add linux-next specific files for 20230626
# good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
git bisect start 'HEAD' 'v6.4-rc7'
# good: [1fc7b1b3c9c3211898874f51919fcb1cf6f1cc79] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 1fc7b1b3c9c3211898874f51919fcb1cf6f1cc79
# good: [4fce1fc9cf89412590fb681fa480cde0b23b3381] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
git bisect good 4fce1fc9cf89412590fb681fa480cde0b23b3381
# bad: [cf1a0283badf6d0bfb91876583c24ef535a3c04c] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git bisect bad cf1a0283badf6d0bfb91876583c24ef535a3c04c
# bad: [3c5388e722ea98022b4d557ab33acca2eb16c4f0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 3c5388e722ea98022b4d557ab33acca2eb16c4f0
# good: [997730bdbf14f352ab03e42461f500aafdabc03e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good 997730bdbf14f352ab03e42461f500aafdabc03e
# bad: [6fd8266556af196763b9f876ed682873e605469b] Merge branch into tip/master: 'ras/core'
git bisect bad 6fd8266556af196763b9f876ed682873e605469b
# good: [37380ea71463658934c2d3167d559d4034ea1c5b] Merge branch into tip/master: 'irq/core'
git bisect good 37380ea71463658934c2d3167d559d4034ea1c5b
# bad: [a967852939f864c35f155a2f431292ad6fc3fed9] Merge branch into tip/master: 'locking/core'
git bisect bad a967852939f864c35f155a2f431292ad6fc3fed9
# bad: [e50f06ce2d876c740993b5e3d01e203520391ccd] locking/atomic: m68k: add preprocessor symbols
git bisect bad e50f06ce2d876c740993b5e3d01e203520391ccd
# good: [b1fe7f2cda2a003afe316ce8dfe8d3645694a67e] x86,intel_iommu: Replace cmpxchg_double()
git bisect good b1fe7f2cda2a003afe316ce8dfe8d3645694a67e
# good: [14d72d4b6f0e88b5f683c1a5b7a876a55055852d] locking/atomic: remove fallback comments
git bisect good 14d72d4b6f0e88b5f683c1a5b7a876a55055852d
# bad: [f739287ef57bc01155e556033462e9a6ff020c97] locking/atomic: arc: add preprocessor symbols
git bisect bad f739287ef57bc01155e556033462e9a6ff020c97
# bad: [d12157efc8e083c77d054675fcdd594f54cc7e2b] locking/atomic: make atomic*_{cmp,}xchg optional
git bisect bad d12157efc8e083c77d054675fcdd594f54cc7e2b
# good: [a7bafa7969da1c0e9c342c792d8224078d1c491c] locking/atomic: hexagon: remove redundant arch_atomic_cmpxchg
git bisect good a7bafa7969da1c0e9c342c792d8224078d1c491c
# first bad commit: [d12157efc8e083c77d054675fcdd594f54cc7e2b] locking/atomic: make atomic*_{cmp,}xchg optional

