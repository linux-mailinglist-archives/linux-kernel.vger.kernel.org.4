Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635CA60EF48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiJ0FDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiJ0FDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:03:01 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A48157452
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:03:00 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g129so203493pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFiEViH1pmz7CSziqwdr/K8qMtJRaQVlUIY1JyGa0HI=;
        b=GaeWuyn0Y1l2/rp+z3jcUlS98ZQnSqI3XVznWzalbixnQFJnFyqd2wpy2PLIaJK+ct
         q2yn0oEtQg3SCXvbCCpOE/r7fq9T9vPCbtBmVTz82KO6WEUdmNRPYk+QUEH0PDlgSbkt
         o9fP8jyFOrXaqQf6XPSqcbatE1OCnCTTe50I8BTGSo1TIqFfl5ICTeUSPS56JTwkfs2M
         Jg4e1qPN+JvxmXyUh44bAkeCoJ1B797BUiFLkyREcM2dXsQrN2tuwHqC4x1Lkcvu4NDd
         5zyK1mFmAqLojKKnC4EJhqhl13DEccGeC/1EeMb/C3DEzjtZYmk3B5ofk7Ar6vFi38gi
         xN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFiEViH1pmz7CSziqwdr/K8qMtJRaQVlUIY1JyGa0HI=;
        b=JmEkDasOcaejS5ld5JysWJBij7FdkZG0yXufoEwdJPL1Ra7lbNeGZpHdSUmMlC7lKm
         lJxRDkMQ4mQmdfUCPQJwMpHWydgE7spLN2TBNOmvtR78+q4htuX3obOjczEJ3q1d937R
         sJO7CloF6mPpWdf0u9eAzCQxXagXodureQAWB+mIcfI8b1gonO2OYUR3nnkFOFz1kocm
         w+wbSEw7f1WxainpAE+/rQM5HmuMV9RO8tLLMw0vuVoNYymG/aS9H9mSfvP4C3QAMXiB
         k+wS3BmYRw9MzmpiXNwOrnkyFdiQhAV0moXfnUxh4/jyq6/8qScMlhySJ2TfRodhIIpt
         Dlvw==
X-Gm-Message-State: ACrzQf3CXvJoyIqxLirr3aOqOcGeWjyKduSqn7ACDmIhyhqToSSocPP7
        0RZ9hs9pSDjitIjg5/Y6vLxTBw==
X-Google-Smtp-Source: AMsMyM5dkgtlTYHOqsvTwbjfn4tuJhkiZCsTozcFbzD9oiklIBw3USJnQzUOe+bEWvy//QAuJJce5Q==
X-Received: by 2002:a63:4753:0:b0:462:b3f0:a984 with SMTP id w19-20020a634753000000b00462b3f0a984mr39380873pgk.501.1666846980192;
        Wed, 26 Oct 2022 22:03:00 -0700 (PDT)
Received: from localhost ([135.180.227.132])
        by smtp.gmail.com with ESMTPSA id u144-20020a627996000000b0056bdc3f5b29sm256869pfc.186.2022.10.26.22.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:02:59 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:02:59 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Oct 2022 20:26:02 PDT (-0700)
Subject:     Re: [PATCH v6 0/2] riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
In-Reply-To: <20221011231841.2951264-1-heiko@sntech.de>
CC:     atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        samuel@sholland.org, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-0bf8c154-76ce-4cd3-bfdb-ffd8a4670600@palmer-ri-x1c9>
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

On Tue, 11 Oct 2022 16:18:39 PDT (-0700), heiko@sntech.de wrote:
> The PMU on T-Head C9xx cores is quite similar to the SSCOFPMF extension
> but not completely identical, so this series

The rest of that sentance got dropped, so I put in

    The PMU on T-Head C9xx cores is quite similar to the SSCOFPMF extension
    but not completely identical, so this series adds a T-Head PMU errata
    that handlen the differences.

but LMK if you had a better version, it's still early so I don't mind 
swapping it around.

b4 also got kind of confused here so I had to merge suff manually.

> changes in v6:
> - follow Anup's suggestion and hook into the (pending) cpuinfo patch [2]
>   instead of modifying the core sbi_get_* functions
>
> changes in v5:
> - add received Reviews
> - fix sbi caching wrt. negative values (Drew)
> - add comment about specific c9xx arch- and imp-ids (Conor)
>
> changes in v4:
> - add new patch to cache sbi mvendor, march and mimp-ids (Atish)
> - errata dependencies in one line (Conor)
> - make driver detection conditional on CONFIG_ERRATA_THEAD_PMU too (Atish)
>
> changes in v3:
> - improve commit message (Atish, Conor)
> - IS_ENABLED and BIT() in errata probe (Conor)
>
> The change depends on my cpufeature/t-head errata probe cleanup series [1].
>
>
> changes in v2:
> - use alternatives for the CSR access
> - make the irq num selection a bit nicer
>
> There is of course a matching opensbi-part whose most recent implementation
> can be found on [0].
>
>
> [0] https://patchwork.ozlabs.org/project/opensbi/cover/20221004164227.1381825-1-heiko@sntech.de
> [1] https://lore.kernel.org/all/20220905111027.2463297-1-heiko@sntech.de/
> [2] https://lore.kernel.org/r/20220727043829.151794-1-apatel@ventanamicro.com
>
> Heiko Stuebner (2):
>   RISC-V: Cache SBI vendor values
>   drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head
>     C9xx cores
>
>  arch/riscv/Kconfig.erratas           | 13 +++++++++++
>  arch/riscv/errata/thead/errata.c     | 19 ++++++++++++++++
>  arch/riscv/include/asm/errata_list.h | 16 ++++++++++++-
>  arch/riscv/include/asm/sbi.h         |  5 ++++
>  arch/riscv/kernel/cpu.c              | 30 +++++++++++++++++++++---
>  drivers/perf/riscv_pmu_sbi.c         | 34 ++++++++++++++++++++--------
>  6 files changed, 103 insertions(+), 14 deletions(-)
