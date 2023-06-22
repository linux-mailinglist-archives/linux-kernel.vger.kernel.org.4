Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70373942D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjFVA50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFVA5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:57:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7706A197;
        Wed, 21 Jun 2023 17:57:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668711086f4so84378b3a.1;
        Wed, 21 Jun 2023 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687395443; x=1689987443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRHIPcIYRAsemBQXSugqu1HmfZ2F6V2nohZmaYh7iX8=;
        b=bNJZdch2OwwbnqDEK2vJWSbZAhzVy+lJNFjojoaYtGBHQ42zzJE9uP0xQXAKcHVwJy
         zWrH1177G7B/nu196zLwqmr4/gOwUm9R/vLT/prTcANUa4BN1xisyNtrMMQo5YUqEy+W
         8/a8c0RrrmFyTfSfkmX4Dw9tbioOB2nPfhnowk/g6KcKhHm6R47BweJBTxVB3nQHsPt4
         v7hd/i1tZiCVgQNRvqw859uOQbiIk02jSIJ97h+vCQokQaLhMriKc7QXpfEyh5iuK8oF
         vSX6ofjVC1G2M9D1q1HzM0YtKHOTH3Hf4d3AbSzuFFNYZBeIGYt4HlASt9FzXuXJwO23
         S9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687395443; x=1689987443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRHIPcIYRAsemBQXSugqu1HmfZ2F6V2nohZmaYh7iX8=;
        b=WtttNffqYv6uZRI1yf4J6idXBPda+INQwg/qlBTNP7d8iZU8noIfw62Jrc0WEnLpbT
         4jUBlUyLlB6YIjOuNZoY9qlD89XVwpuYEINXPVPmYOprm8+lH+PYyCXZiTV1BC2XYwdl
         xIuwRWZrMapEjDFu+7xP5GuLEv2CQll2EG2mMKCoMz6jEHmEFlUWbeDRSd2WIJXlQvTW
         cpy0tmJMpz+Tp9psfz6KdQvKa2wxr9CVmL6ceZt9UjS3vRG8OV7TADPDGkWjGmA0yDH7
         w9TDSRUfQnzMMUTeH7q/bAP33w4iPAcbfgnUy1mIjabuhWixvm0iK1H99s4ljCJly9h4
         Rhng==
X-Gm-Message-State: AC+VfDxZvamWxsZe5N2p8/cWf68RH/fqK0P3ewL6jm1QRWx6bbJEg+M1
        tnP23LsuDt1HEbBhhlqF194=
X-Google-Smtp-Source: ACHHUZ6iMp+OYqownUXjVdBdLJssPnWKXdDhAMDRONi/XOCG8SypV1kVE1GgB0nIJZDzI0bj35KRhw==
X-Received: by 2002:a05:6a00:13a0:b0:668:9f95:b518 with SMTP id t32-20020a056a0013a000b006689f95b518mr9140094pfg.9.1687395442837;
        Wed, 21 Jun 2023 17:57:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12-20020a62ea0c000000b00657fbf81ffbsm1420690pfh.80.2023.06.21.17.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:57:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 17:57:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 04/10] arm64: introduce STM32 family on Armv8
 architecture
Message-ID: <24e9c526-4128-4e63-8d28-c4ef1647f886@roeck-us.net>
References: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
 <20230602132859.16442-5-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602132859.16442-5-alexandre.torgue@foss.st.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 02, 2023 at 03:28:53PM +0200, Alexandre Torgue wrote:
> Add a dedicated ARCH_STM32 for STM32 SoCs config. First STM32 Armv8 SoC
> family is the STM32MP25 which is composed of STM32MP251, STM32MP253,
> STM32MP255, STM32MP257 SoCs.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

This patch (or patch series) results in the following build error when
trying to build arm64:allmodconfig.

Building arm64:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/printk.h:564,
                 from include/asm-generic/bug.h:22,
                 from arch/arm64/include/asm/bug.h:26,
                 from include/linux/bug.h:5,
                 from include/linux/fortify-string.h:5,
                 from include/linux/string.h:254,
                 from include/linux/dma-mapping.h:7,
                 from drivers/remoteproc/stm32_rproc.c:9:
drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_mem_alloc':
drivers/remoteproc/stm32_rproc.c:122:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t'

Bisect log attached.

Guenter

---
# bad: [15e71592dbae49a674429c618a10401d7f992ac3] Add linux-next specific files for 20230621
# good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
git bisect start 'HEAD' 'v6.4-rc7'
# bad: [e867e67cd55ae460c860ffd896c7fc96add2821c] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad e867e67cd55ae460c860ffd896c7fc96add2821c
# bad: [57b289d5b1005a9c39d6d6567e0ef6115bd59cea] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
git bisect bad 57b289d5b1005a9c39d6d6567e0ef6115bd59cea
# good: [dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f] Merge branch 'for-next/perf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
git bisect good dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f
# good: [5bfea833dd8f972ce3435359f12f61bdbf01b147] Merge tag 'v6.4-next-dts64' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into soc/dt
git bisect good 5bfea833dd8f972ce3435359f12f61bdbf01b147
# bad: [6f8f9120fd588b28edb0a9c6b9ae9ca6c261d9f6] Merge branch 'for-linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
git bisect bad 6f8f9120fd588b28edb0a9c6b9ae9ca6c261d9f6
# bad: [fe16e4b5e7fa1badc2fa69d85f7b13926cce8fe2] Merge branch 'at91-next' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
git bisect bad fe16e4b5e7fa1badc2fa69d85f7b13926cce8fe2
# good: [0e4ad579ef10d4e9eca86eb33fb4cd87de7c05c4] soc: document merges
git bisect good 0e4ad579ef10d4e9eca86eb33fb4cd87de7c05c4
# good: [d704f1fe9f4a4ae9c9f1f9fac1e4194c34dd035b] Merge tag 'arm-soc/for-6.5/devicetree-arm64' of https://github.com/Broadcom/stblinux into soc/dt
git bisect good d704f1fe9f4a4ae9c9f1f9fac1e4194c34dd035b
# bad: [26588df4e5a385e5b7751997d48bdeef042cf736] Merge branch 'soc/newsoc' into for-next
git bisect bad 26588df4e5a385e5b7751997d48bdeef042cf736
# good: [6bce45197c25c99612a3c5e0cf041d18aa28fbf3] Merge branch 'soc/dt' into for-next
git bisect good 6bce45197c25c99612a3c5e0cf041d18aa28fbf3
# bad: [3b170e1653c05b067ea6ef616ece961b07714f48] arm64: dts: st: introduce stm32mp25 pinctrl files
git bisect bad 3b170e1653c05b067ea6ef616ece961b07714f48
# good: [c3053382574a5a829c93fb5ab0bb52d20456e745] dt-bindings: stm32: add st,stm32mp25-syscfg compatible for syscon
git bisect good c3053382574a5a829c93fb5ab0bb52d20456e745
# bad: [5d30d03aaf78586c37100006ba271d045f730bb5] arm64: dts: st: introduce stm32mp25 SoCs family
git bisect bad 5d30d03aaf78586c37100006ba271d045f730bb5
# bad: [9e4e24414cc6b45bd887d746a59691e295431ddf] arm64: introduce STM32 family on Armv8 architecture
git bisect bad 9e4e24414cc6b45bd887d746a59691e295431ddf
# first bad commit: [9e4e24414cc6b45bd887d746a59691e295431ddf] arm64: introduce STM32 family on Armv8 architecture
