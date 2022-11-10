Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC062428D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiKJMqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKJMqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:46:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147632BA9;
        Thu, 10 Nov 2022 04:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E363615D8;
        Thu, 10 Nov 2022 12:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FD9C433C1;
        Thu, 10 Nov 2022 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668084405;
        bh=AmZ6tHCpImbg6Vy4ACo1PQbNrrDox82e5K50AxZpNuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7OBeTafIOzUbaAunGJQ2rqU8WowtnlOM/DY+i4E5OLfKChnbeCjhWTk7l/c/jL2m
         hx3me101CRRa9eV6v2w+zvD8sNjJ16SsluvSaqshFm7NmKnV/LUTTLxFdOpNGLEzOx
         G1Z4LunD8NRESHE8y0d9cxvUQjSbmK1YNLHk6SN6zNEY1PiyEKJqufxDm98ZWFwVdJ
         QOXzj3llitkkAkL+XZJMB5x5F6RF8vC0yyI5LpimAyACsYh44YpcuOJuaQXENv/gIt
         lzWTeXTsy2YOEA65HoNerkujMZDyOYu6WGyjHxMuKAwvdeoiUeRuNnkTJxADaHgLjR
         rO2iA6c9RADCw==
Date:   Thu, 10 Nov 2022 05:46:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: x86: clang: acpi-cpufreq.c:970:24: error: variable 'ret' is
 uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <Y2zysjBdAERPdUOQ@dev-arch.thelio-3990X>
References: <CA+G9fYtaNmXOKnwH_ih9vZyFeaD+Lvzxf3WTbAV50rBtwkPxpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtaNmXOKnwH_ih9vZyFeaD+Lvzxf3WTbAV50rBtwkPxpQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Thu, Nov 10, 2022 at 04:44:09PM +0530, Naresh Kamboju wrote:
> [Please ignore email this if it is already reported]
> 
> Kernel build warning noticed on x86_64 with clang toolchain [1].
> Build failures noticed from next-20221108 .. next-20221110.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- HOSTCC=clang
> CC=clang
> drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is
> uninitialized when used here [-Werror,-Wuninitialized]
>         acpi_cpufreq_online = ret;
>                               ^~~
> drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable
> 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> 1 error generated.

Thanks for the report. I noticed this when it came down in next-20221108
and sent a patch for it:

https://lore.kernel.org/20221108170103.3375832-1-nathan@kernel.org/
https://github.com/ClangBuiltLinux/linux/issues/1757

It just needs to be reviewed and picked up.

Cheers,
Nathan
