Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550AA74360B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjF3Ho7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjF3Hou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:44:50 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E872110A;
        Fri, 30 Jun 2023 00:44:48 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b6993ef4f2so4590011fa.0;
        Fri, 30 Jun 2023 00:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688111087; x=1690703087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VbIl1y0i7rIoWjjfxcRpXsTkBfT6VxJ9ft8slDj2fo=;
        b=jpmMzf0SgFqI0uMmspxrHq3MMKKLOthKaQCu/xrGbK4GjNMaywmL3EieAmL1HZgbqa
         nW2MzlqHk4rMHAek+e0d2NagGXb+t8EOklWeeFXaVM6cd85V2Gd5SF6KWPsha/0xD+hh
         d0gzrELZg8rMgoplx/n7l2LGtxVsmS3OVz4oipwNpbrGeQxESImfkJHaKkHiMfa/1hSQ
         e5C+KkIxC8WSxdUlsFbwhwAgRoClvX9t0IIFnXRx1Hx+b3Fe56uSe2/uSvfMVj6vQTnt
         UFEW/9/c+buCsKPU3DzaaeCjyBRe7DJ+VmAuk/BfAOZ9KH/M3B67xp0ZZrcO+H4pT2sh
         n9Mg==
X-Gm-Message-State: ABy/qLakMyW5K2gVki2A0D+/2cdP8PuSBSRXMKvpd7MokmfxtLXsiDRq
        JAAcZ8qJWg0NRzDNldslDB01GmOBJ4SJbXSUCmOKUkWg
X-Google-Smtp-Source: APBJJlGTZXFmdKOEuvUQ5cmo4UuavmnKLYH86d1HCPMwj/rfQvGZzzzKQ24mrZne/h6mX7gMjAMKwC6An8fGPiUJdK4=
X-Received: by 2002:a2e:7c1a:0:b0:2b6:a096:4cf8 with SMTP id
 x26-20020a2e7c1a000000b002b6a0964cf8mr995525ljc.1.1688111086596; Fri, 30 Jun
 2023 00:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <4639e8e00a321e2bbbe4dcbb93e57ca6c10bab51.1688105074.git.viresh.kumar@linaro.org>
In-Reply-To: <4639e8e00a321e2bbbe4dcbb93e57ca6c10bab51.1688105074.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 09:44:34 +0200
Message-ID: <CAJZ5v0i5zXJK8p7Sr5c8gpnFMY0jGTBfYS_R7QXEi7hEaVbXEg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Make CONFIG_CPUFREQ_DT_PLATDEV depend on OF
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Zhipeng Wang <zhipeng.wang_1@nxp.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 8:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq-dt-platform.c driver requires CONFIG_OF to be selected. Mark
> it as a dependency.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306250025.savpMM8L-lkp@intel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Rafael,
>
> Please apply this directly for v6.5. Thanks.

Done, thanks!

>  drivers/cpufreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index dda3a78bfd5c..6693d52ac3fa 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -219,6 +219,7 @@ config CPUFREQ_DT
>
>  config CPUFREQ_DT_PLATDEV
>         tristate "Generic DT based cpufreq platdev driver"
> +       depends on OF
>         help
>           This adds a generic DT based cpufreq platdev driver for frequency
>           management.  This creates a 'cpufreq-dt' platform device, on the
> --
> 2.31.1.272.g89b43f80a514
>
