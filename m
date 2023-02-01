Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E8686570
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjBALcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBALcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:32:04 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D3ECDC6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:32:03 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 143so12256890pgg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BBlFMphcYAKGu8ilzPr5Z81/fHgzzMqhp9aruKhD+k=;
        b=au5gJa1iq220Ld8ZF6MxmOrYAyHIOGCXtNmqgX/IMCnFlogzvvEwcW12Gdoi/Zax4k
         EZK1jbpR1vUuym1nFbHScy157/n2kdUnRl423j+ble5oXFtDeRU3QkG1MwWo9CmnEG1E
         e09TS3oWTWI+4YBxwdLunnsLQF0ecBi7y0LDKvlMpb+lQNgeDvrxPKJHDa7q93HkvERT
         QkcCo0so/Z8j7pBg0qAGliK7lAcyuTom7o5J/wre9d3SjwKYoKSDUIrtas5+bNKvETqz
         2sv86qfkJ0bmdj+bs7SO9TjUz739qXefSwj1W0jzG2Bo8I8xmjJzmk/9A54n4QzNpZya
         oTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BBlFMphcYAKGu8ilzPr5Z81/fHgzzMqhp9aruKhD+k=;
        b=i//sUWL12TL4BRMYOK2T9xoqdzNsgb5RdUQNGH7VgHgB+nZo7fsWNALY313OlfwtdI
         CeThce7oGX95JHpneTmSlvTw6cd+m80Vsds7WcegLLQgV7dLGo0tOxDTkZD2cSyvdGsv
         I/evDpYWoDYKgYdvTvqH74q53s8p3uGjChe918Jt+PnClBd0CBUOf9m34xjZvRI62yA8
         akIfjWgCMxYVJ8fvec6AoC4PE5MMGiNsABK11maf0TzyYD+SRWxFdYSieC3FenQ0NwRk
         vNejws6orH/lMhfkQa0PV8mXol9f1Ov/PM8oasWuAZTCAFWf0UCe2fxw5e3cMnGN5w2l
         bvXQ==
X-Gm-Message-State: AO0yUKUGLLbgFRFfJ0c7p6gLNh7tSsQWlsWU/q0/BBZV017hOAH/sjIQ
        OYBW7HkGKpTIdTrGHF4PdImXeA==
X-Google-Smtp-Source: AK7set+C0uPsa2mdXLmzGnjX/RqEqmB7QuIr0iNYXeo+TID3anmh3rbkC6bKeQcgcvGxz8S+AWYnxg==
X-Received: by 2002:aa7:8dd2:0:b0:593:3ab1:a144 with SMTP id j18-20020aa78dd2000000b005933ab1a144mr2006259pfr.12.1675251122558;
        Wed, 01 Feb 2023 03:32:02 -0800 (PST)
Received: from localhost.localdomain ([124.123.179.186])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a001c8f00b0059260f01115sm10024336pfw.76.2023.02.01.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 03:32:02 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, npiggin@gmail.com, pali@kernel.org,
        arnd@arndb.de, anders.roxell@linaro.org, llvm@lists.linux.dev,
        nathan@kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 1/2] powerpc/64: Set default CPU in Kconfig
Date:   Wed,  1 Feb 2023 17:01:55 +0530
Message-Id: <20230201113155.18113-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <76c11197b058193dcb8e8b26adffba09cfbdab11.1674632329.git.christophe.leroy@csgroup.eu>
References: <76c11197b058193dcb8e8b26adffba09cfbdab11.1674632329.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regression started from next-20230131.

Regressions found on powerpc:

  build/clang-nightly-tqm8xx_defconfig
  build/clang-nightly-ppc64e_defconfig


make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- HOSTCC=clang CC=clang LLVM=1 LLVM_IAS=0 tqm8xx_defconfig
make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- HOSTCC=clang CC=clang LLVM=1 LLVM_IAS=0

error: unknown target CPU '860'
note: valid target CPU values are: generic, 440, 450, 601, 602, 603, 603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548, 970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5, pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7, power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32, powerpc64, ppc64, powerpc64le, ppc64le, future
make[2]: *** [/builds/linux/scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 1
error: unknown target CPU '860'
note: valid target CPU values are: generic, 440, 450, 601, 602, 603, 603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548, 970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5, pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7, power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32, powerpc64, ppc64, powerpc64le, ppc64le, future
make[2]: *** [/builds/linux/scripts/Makefile.build:252: scripts/mod/empty.o] Error 1

    
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230201/testrun/14479384/suite/build/test/clang-nightly-tqm8xx_defconfig/history/

The bisection pointed to this commit,
  45f7091aac35 ("powerpc/64: Set default CPU in Kconfig")

--
Linaro LKFT
https://lkft.linaro.org
