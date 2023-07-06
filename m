Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2A749E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjGFOBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjGFOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:01:42 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814211BE3;
        Thu,  6 Jul 2023 07:01:40 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-579ed2829a8so9610627b3.1;
        Thu, 06 Jul 2023 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688652099; x=1691244099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YxdEnLVX4p6L9VdcJgJfX3ANf/EuhvUyyqiujSowdUU=;
        b=HKpfmMe18SWS0jZc6cwOKYjUoYLtdEHeghVnrtbUmfZeb2diQdGD+59iiEdI4aTDGd
         DEUnxf8VuB10a+kXqzzV33AUIQMXQlB2u/Tu44daKx0Wy+rCNiVQyHGsUBDTl9p7GQM2
         Hc0bxF93QVIfl9cYhnJKZS1bQTjlLYZTlUWM1CRAHpxa2QMPikqzHGu/QgUG0JEyabtG
         VU+z6OV3hNR8BoOq+WMBPhh6NgW1fNmZEN7fke04zPiDxjfoWZtqiOrZ652r9pmVx6Hc
         OWyFULfiFjmHbz/+i7f2yckCdxlBBfdbZY2d6UMoclt5xtQK11587UhsfSgBKBG2uzJ2
         Zb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688652099; x=1691244099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxdEnLVX4p6L9VdcJgJfX3ANf/EuhvUyyqiujSowdUU=;
        b=dKCoyH+Fvcu7V+MmsRcI0pCzJpazc9fQ0MlHGL1Nw4fPvYlr1Tyu6hmi0mg927UW+x
         aB0qh/1iAJa1TfoN+rCuIdhWYW0j73K7NYDnfEp7XFyFh+hmyb95+MeDgL7Ad37pYtlI
         Hyp6d9yX+BBQhweT6N65HTS1BRydHG9u2FSq9nYh9soY2UDsdOPGT8KpiQljVy5nJa0a
         qvpqphNCPayLHZ4i2/xoTLWc0COw4ZAybXkSf15FtQBWM/8R9sMH/kGyaXUF3c/cLmlS
         PbSyyPvm7ay3c7YszpKS5FwWFPJMWNgvHCT13eXdi+eVNDv4kFBrEzA1JumIX3vIBeix
         JueQ==
X-Gm-Message-State: ABy/qLafuEIz6CzVIeTmNLTy1e8ZBuGMAt8yD+ysvHBSKe003yRZ6Tw7
        XdQMMsEVySRwkZjkKkeMVOg=
X-Google-Smtp-Source: APBJJlEqFwwIx73WB+xYRURaWQNcgGKLa/1/4BrO6ictQPrh+N3rm3yhO5vYDV7I2Z2AyPVgYXNvMA==
X-Received: by 2002:a81:7bd5:0:b0:573:6cf0:4008 with SMTP id w204-20020a817bd5000000b005736cf04008mr2234907ywc.26.1688652099166;
        Thu, 06 Jul 2023 07:01:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k128-20020a0dc886000000b00569ff2d94f6sm367660ywd.19.2023.07.06.07.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:01:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9bc72d0c-fe33-5759-799c-f54e325ba38d@roeck-us.net>
Date:   Thu, 6 Jul 2023 07:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [GIT PULL] sh updates for v6.5
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 14:43, John Paul Adrian Glaubitz wrote:
> Hi Linus!
> 
> I am being a little late this merge window since it took me a little longer
> to thoroughly review the changes which address important issues in the DMA
> and IRQ code in arch/sh.
> 
> The pull request includes a patch by me to fix a compiler warning in the J2
> probing code and a fix by Sergey Shtylyov to avoid using IRQ0 on SH3 and SH4
> targets. Masahiro Yamada made some clean-up in the build system to address
> reports by the 0day bot.
> 
> The most notable changes come from Artur Rojek who addressed a number of issues
> in the DMA code, in particular a fix for the DMA channel offset calculation that
> was introduced in in 7f47c7189b3e ("sh: dma: More legacy cpu dma chainsawing.")
> in 2012! Together with another change to correct the number of DMA channels for
> each SuperH SoC according to specification, Artur's series unbreaks the kernel
> on the SH7709 SoC allowing Linux to boot on the HP Jornada 680 handheld again.
> 
> Last but not least, Guenter Roeck sent in a patch to fix a build regression that
> was recently introduced in 99b619b37ae1 ("mips: provide unxlate_dev_mem_ptr() in
> asm/io.h").
> 
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>    Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.5-tag1
> 
> for you to fetch changes up to 7497840d462c8f54c4888c22ab3726a8cde4b9a2:
> 
>    sh: Provide unxlate_dev_mem_ptr() in asm/io.h (2023-07-05 19:04:51 +0200)
> 
> Thanks for pulling!
> 
> Adrian
> 
> ----------------------------------------------------------------
> sh updates for v6.5
> 
> - sh: Provide unxlate_dev_mem_ptr() in asm/io.h
> - sh: dma: Correct the number of DMA channels for SH7709
> - sh: dma: Drop incorrect SH_DMAC_BASE1 definition for SH4
> - sh: dma: Fix DMA channel offset calculation
> - sh: Remove compiler flag duplication
> - sh: Refactor header include path addition
> - sh: Move build rule for cchips/hd6446x/ to arch/sh/Kbuild
> - sh: Fix -Wmissing-include-dirs warnings for various platforms
> - sh: Avoid using IRQ0 on SH3 and SH4
> - sh: j2: Use ioremap() to translate device tree address into kernel memory
> 
> ----------------------------------------------------------------
> Artur Rojek (3):
>        sh: dma: Fix DMA channel offset calculation
>        sh: dma: Drop incorrect SH_DMAC_BASE1 definition for SH4
>        sh: dma: Correct the number of DMA channels for SH7709
> 
> Guenter Roeck (1):
>        sh: Provide unxlate_dev_mem_ptr() in asm/io.h
> 

Perfect example why it is a bad idea to let build failures linger around.
The build failure fixed by this patch ...

> John Paul Adrian Glaubitz (1):
>        sh: j2: Use ioremap() to translate device tree address into kernel memory
> 
> Masahiro Yamada (4):
>        sh: Fix -Wmissing-include-dirs warnings for various platforms
>        sh: Move build rule for cchips/hd6446x/ to arch/sh/Kbuild
>        sh: Refactor header include path addition
>        sh: Remove compiler flag duplication
> 
> Sergey Shtylyov (1):
>        sh: Avoid using IRQ0 on SH3 and SH4
> 
... was hiding boot failures with all my qemu emulations caused by
this patch.

Guenter

