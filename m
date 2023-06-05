Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AF72272B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjFENP6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjFENPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:15:51 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C0E8;
        Mon,  5 Jun 2023 06:15:49 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-62606e67c0dso42669076d6.2;
        Mon, 05 Jun 2023 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685970948; x=1688562948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evDCePhMrS7Ny+TFmHSDloaESI5T/zQOM1dd67+oY2c=;
        b=Z2f94QkcOhLJQUKjSw31y6xZbxRMpPBvGikkcKSBHkoYbXya7/B3JbcgU+x4JovXJp
         G7wsNKiY53TcmCwYW0fTphzVm8hulAkoy7vPyo3PCcU57J2hj4BxIpJsdkE5nd+vIMcZ
         L8+Hq0Ia9K+MQ41HrAnBvRfYi9jgeupekVWvL2XPyu0ozafvd3eW8pc0SnF+6/supsjI
         AhoXFvo+a22Rie3EYZ88Qqql2sYHEG2eYDBdcdAwDgQLR057xFAB1KKPLaR9w2Aa4wbV
         P9Njd+AHQVAlDPw5a4Zi0b2uGrVKRC+m3YgJPt4Jet+Gecyo+DfJSx9WKwEJgJjH6sK4
         ibrw==
X-Gm-Message-State: AC+VfDyJPuciJ7aSdaBvarlEz74U+3vPJ5nyfb7OcUVMzxgXe/CX56HJ
        IaP6RJw1CSFIFPzf7GJKM9XPf1J1CMVPXg==
X-Google-Smtp-Source: ACHHUZ43dmtEypQe0I2S0CTImw5harU0FrUV+yzWbIYKN00lpjQhg4QYsXfaxuYjydlMC0SgYMAAvA==
X-Received: by 2002:a05:6214:130c:b0:626:2461:9f09 with SMTP id pn12-20020a056214130c00b0062624619f09mr8274707qvb.40.1685970948287;
        Mon, 05 Jun 2023 06:15:48 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id mn14-20020a0562145ece00b006235e8fe94esm4629206qvb.58.2023.06.05.06.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:15:47 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-62614a2ce61so42649146d6.3;
        Mon, 05 Jun 2023 06:15:47 -0700 (PDT)
X-Received: by 2002:a25:76cf:0:b0:ba9:89d4:b2f5 with SMTP id
 r198-20020a2576cf000000b00ba989d4b2f5mr14228253ybc.53.1685970927309; Mon, 05
 Jun 2023 06:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685692810.git.geert+renesas@glider.be> <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
In-Reply-To: <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Jun 2023 15:15:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9n3ypBG1HffvHxYke5Ym068ZK1s2QryE-rbVgFS9dzw@mail.gmail.com>
Message-ID: <CAMuHMdV9n3ypBG1HffvHxYke5Ym068ZK1s2QryE-rbVgFS9dzw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] soc: renesas: rmobile-sysc: Convert to readl_poll_timeout_atomic()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Fri, Jun 2, 2023 at 10:51 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Use readl_poll_timeout_atomic() instead of open-coding the same
> operation.
>
>   1. rmobile_pd_power_down(): as typically less than 20 retries are
>      needed, PSTR_RETRIES (100) µs is a suitable timeout value.
>
>   2. __rmobile_pd_power_up(): the old method of first polling some
>      cycles with a 1 µs delay, followed by more polling cycles without
>      any delay didn't make much sense, as the latter was insignificant
>      compared to the former.  Furthermore, typically no retries are
>      needed.  Hence just retain the polling with delay.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
> index 728ebac98e14a5cc..5d621c35fba1116a 100644

> @@ -74,25 +71,17 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
>
>  static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
>  {
> -       unsigned int mask = BIT(rmobile_pd->bit_shift);
> -       unsigned int retry_count;
> -       int ret = 0;
> +       unsigned int val, mask = BIT(rmobile_pd->bit_shift);
> +       int ret;

Oops, "ret" should still be initialized to zero.

>
>         if (readl(rmobile_pd->base + PSTR) & mask)
>                 return ret;
>
>         writel(mask, rmobile_pd->base + SWUCR);
>
> -       for (retry_count = 2 * PSTR_RETRIES; retry_count; retry_count--) {
> -               if (!(readl(rmobile_pd->base + SWUCR) & mask))
> -                       break;
> -               if (retry_count > PSTR_RETRIES)
> -                       udelay(PSTR_DELAY_US);
> -               else
> -                       cpu_relax();
> -       }
> -       if (!retry_count)
> -               ret = -EIO;
> +       ret = readl_poll_timeout_atomic(rmobile_pd->base + SWUCR, val,
> +                                       (val & mask), PSTR_DELAY_US,
> +                                       PSTR_RETRIES * PSTR_DELAY_US);
>
>         pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
>                  rmobile_pd->genpd.name, mask,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
