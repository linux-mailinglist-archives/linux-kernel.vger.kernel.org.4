Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14BD722A80
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjFEPJt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjFEPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:48 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC7E8;
        Mon,  5 Jun 2023 08:08:47 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-652d76be8c2so4031464b3a.3;
        Mon, 05 Jun 2023 08:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685977727; x=1688569727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aiwp/bDLmwSr5erFDhpBQgGpKXSsi00J2xGn70rauW0=;
        b=i/t6YyMlsjxqkrnXcHZz40E0tIOs/MX1dkTUnkQFq3Whz5BuqPrf8MmlMlfTUTIeq5
         GzgzH6ufZFkL8dUCo86PsKTMhdtrki3W8CWh6JmdrFxKh+Tmve4A9RrKYgXkelwFFRPV
         05JQHomJITaILvFidLUhVK7fLCbtTe0jCbQn2D18vcqrn9LtD3qnMFy7xQnj/SGQESIT
         G8ckZm8GVVpLogGt1Nf65lCfZQiUVroc/Muf6Stka0dTMEltCgABJ2/1eVehkOT406W0
         t0sg41pWIQcd3sQMALvLyygMJUHjP2jtild2HauQlIty+Af4Q5VWE1v92N/a+TYQj82E
         O9UQ==
X-Gm-Message-State: AC+VfDz7JqZcupCyyg8bHRmkBkhgsw/iX7sW9c87/IEUK9eqWbOm2jvp
        OCani0oj7Wb0BoANli1zgm5Jlxu5fkuFlQ==
X-Google-Smtp-Source: ACHHUZ4MY6YnuUEHDcUmTbFEAZ6SSspWqZ1lBBkbZm3P116kLzJ54SkD8Rf/7C8YgiKfKUsZ330efg==
X-Received: by 2002:a05:6a20:7490:b0:109:c161:a679 with SMTP id p16-20020a056a20749000b00109c161a679mr9141445pzd.19.1685977726567;
        Mon, 05 Jun 2023 08:08:46 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id q16-20020a62e110000000b0063d29df1589sm5302851pfh.136.2023.06.05.08.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:08:46 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6532671ccc7so3740863b3a.2;
        Mon, 05 Jun 2023 08:08:46 -0700 (PDT)
X-Received: by 2002:a05:6870:3e4:b0:19e:86e4:55b0 with SMTP id
 h36-20020a05687003e400b0019e86e455b0mr54853oaf.1.1685977705560; Mon, 05 Jun
 2023 08:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685692810.git.geert+renesas@glider.be>
In-Reply-To: <cover.1685692810.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Jun 2023 17:08:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrgyWT=RtS6cuUP6sT-Ta9Oa4cU2kHP10ah-U50DOSsg@mail.gmail.com>
Message-ID: <CAMuHMdXrgyWT=RtS6cuUP6sT-Ta9Oa4cU2kHP10ah-U50DOSsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] iopoll: Busy loop and timeout improvements + conversions
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 10:51 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> When implementing a polling loop, a common review comment is to use one
> of the read*_poll_timeout*() helpers.  Unfortunately this is not always
> possible, or might introduce subtle bugs.  This patch series aims to
> improve these helpers, so they can gain wider use.
>
>   1. The first patch improves busy-looping behavior of both the atomic
>      and non-atomic read*_poll_timeout*() helpers.
>      The issue addressed by this patch was discussed before[1-2], but I
>      am not aware of any patches moving forward.
>
>   2. The second patch fixes timeout handling of the atomic variants.
>      Some of the issues addressed by this patch were mitigated in
>      various places[3-5], and some of these findings may be of interest
>      to the authors of [6-8].
>
> The first two patches were sent before, and already received some acks
> and reviews.  I plan to queue these in an immutable and tagged branch
> after the weekend, for consumption by myself, and by other interested
> parties.

FTR...
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
tags/iopoll-busy-loop-timeout-tag

for you to fetch changes up to 7349a69cf3125e92d48e442d9f400ba446fa314f:

  iopoll: Do not use timekeeping in read_poll_timeout_atomic()
(2023-06-05 15:35:27 +0200)

----------------------------------------------------------------
iopoll: Busy loop and timeout improvements

----------------------------------------------------------------
Geert Uytterhoeven (2):
      iopoll: Call cpu_relax() in busy loops
      iopoll: Do not use timekeeping in read_poll_timeout_atomic()

 include/linux/iopoll.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
