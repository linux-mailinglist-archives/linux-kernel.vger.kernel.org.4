Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2DC681D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjA3WDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA3WDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:03:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3C41B75
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:03:26 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k13so13190742plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BQY9unmzOV7TCZ96aU2p1l97OntyBK2gZGuBkFiwM9A=;
        b=kQ5/LBE4EPmy0MTjOLRhc7F+4NC2emrrWOeOsFIdDMoM6TY4QMWar6RfJKJvMjsYxf
         5aGron06eS18nyIgvaYuvNjXzAW9psgcktCwJlm6XwmaTc2k/ECsXNAjasvPiENdvkMM
         8sWFPzniRelG8krBvqHTNtdpxdqNSjGrONOHCYImQ/iZHfiMly0NDoypeYmfSQqYs+Kd
         XE+DisN7vEDdePh/OQQ0v/6WCUY9QKF0yPRien8ylSn4Qu5UUYxciPC/mPumeOjcqHDc
         Zr3x8WTqi23teJmdjv3iwTSuCfbzkUgswKW1D/epr7IQYPSoPbVVYVXwRVkMzFUzNtp/
         nqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQY9unmzOV7TCZ96aU2p1l97OntyBK2gZGuBkFiwM9A=;
        b=K2J8H1/cDNNhinhjIsGEBX6d42+LBa+1akqKu/nOgjyHfNI6+VdQ/cHvnYm+LXprsP
         05FCVeU1VlhquBvmuOf6j1nPAqhOXxKUj2YmAxxxTx5XoKx3LpDIt7w91V4AXC+euYaD
         4aFkzzzyGhe4ANS0pn9zgdl8wtXh9vFpB4S3H7epkU3xR2VC6ZF/QgvS+7+uxxpjG6JL
         5Gfrj5Chu2CtVhjAFCM2hav9g5hi9SS8WWFGhUdRVFDX2mhyAIxO/XJpK1eGbfx0F5MM
         u79NkgFmG4KutbEeSI8u5fBqxHBxxOtBG5YZPn7ibNBFq986lM9iF4GgzmNoRyQJNqcu
         mnDA==
X-Gm-Message-State: AO0yUKVyh8A9sRNO4DWyhXGWBvMysr3m4XRKeiNF+3bm8s4fSnpNNmMo
        ygAHovZJ25KPJO9dgW8oNliWckB4RE0qsUZ/E8+BLQ==
X-Google-Smtp-Source: AK7set/bVllA+pXLc5bfi4Hr1MjNdTVvmsxv0RI7/gPQMOGYUc7EXoUGxxPyg9Z429Lxw5P7MYpHCt7QsgZFWpVdr5U=
X-Received: by 2002:a17:90a:9c1:b0:22c:816f:3203 with SMTP id
 59-20020a17090a09c100b0022c816f3203mr1221685pjo.28.1675116206022; Mon, 30 Jan
 2023 14:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20230118-v4-v4t-lld-16-v1-1-e3d9a00ae47c@kernel.org>
 <202301310149.euWWUSrD-lkp@intel.com> <a40df1e3-ed92-4662-bb9e-106becce63d7@app.fastmail.com>
In-Reply-To: <a40df1e3-ed92-4662-bb9e-106becce63d7@app.fastmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Jan 2023 14:03:14 -0800
Message-ID: <CAKwvOd=GbixTFko8aGzPQiq8QBtDY0ZZncHKag-gjsgqUM_diA@mail.gmail.com>
Subject: Re: [PATCH] ARM: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Russell King <linux@armlinux.org.uk>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 30, 2023, at 19:10, kernel test robot wrote:
> > Hi Nathan,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on 5dc4c995db9eb45f6373a956eb1f69460e69e6d4]
> >
> > url:
> > https://github.com/intel-lab-lkp/linux/commits/Nathan-Chancellor/ARM-Allow-pre-ARMv5-builds-with-ld-lld-16-0-0-and-newer/20230119-032402
> > base:   5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> >>> arch/arm/mach-sa1100/pm.c:122:12: warning: no previous prototype for function 'sa11x0_pm_init' [-Wmissing-prototypes]
> >    int __init sa11x0_pm_init(void)
> >               ^
> >    arch/arm/mach-sa1100/pm.c:122:1: note: declare 'static' if the
> > function is not intended to be used outside of this translation unit
> >    int __init sa11x0_pm_init(void)
> >    ^
> >    static
> >    1 warning generated.
> > --
>
>
> For refernece, these are all known problems, the patch just allowed
> the code to be built by clang/lld when that was previously not
> possible.
>
> After the 6.3 merge window, we can probably go through the much
> smaller set of board files are address most of the W=1 warnings that
> were previously overwhelming.

Yeah! I've filed
https://github.com/ClangBuiltLinux/continuous-integration2/issues/509
too so that we can wire up an ARMv4 test in our CI as well.

>
>       Arnd



-- 
Thanks,
~Nick Desaulniers
