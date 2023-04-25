Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B449C6EE135
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjDYLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjDYLpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:45:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFBBBA2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:45:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f09b4a156eso37561545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682423126; x=1685015126;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imO3AIEoJomqZzm4NUm2eTOkQ1OOyIgveuGZCNLCvOI=;
        b=l5TAU8xIX+bj+RwpddJG7ytkp1VjQ5YXN945VPvzYXmoqfxbb58TDUPr17DbQw6sWF
         zd0SqWxUdtGiGWg75gAKvNLGxhb2k+RAkJQVE8qKMt8RzPFj8cxry1nyI3kbtbg86kuk
         aEcrCIcCpF7gQmwVO0uHffstZX3URnjgdpjr4Zk8VrKU45BfqZn+g4QHecwKTj/+C9ar
         jL7X4eOqAF+JjhOwfSdMZISueGqwhDxfWIxQmH9re58g3WfLaQLV+oEw4fNhTZ9cqY5I
         5jFi5UL4S4yaGr0il9WvUNvcUaJ0TQeFtMJ0Fe/qGX2l5VmYC2miWPKegGFYTKnEPUzI
         BDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682423126; x=1685015126;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=imO3AIEoJomqZzm4NUm2eTOkQ1OOyIgveuGZCNLCvOI=;
        b=PZVw0xACmF+FarPXuTE2m7aPPBo5GrLA/MwtPMUebJqOXUwvbD71OWrm2xVPH0w24C
         MwHtwZOU4vw9kZ6NCwNfhhkG0EJYDYo4hAQmVaMj/nOqMwyRgKcgYSGeQ09lRV+Ae5YM
         0rxkgLeslafnG5T80LnyERkhhGBBFiLuLPEY4pEOxA0mkCASjKeeWAXG2Qt0WM0Eed+I
         n1v6G0mZikeQAyqtW7Xrud6XzCji456FE61AuIbuD2IiHyWxYl2glaXtK1gG+esu3+UZ
         IE3kU7hiCfNu2x5wLwtTTZpMEKut6MhkqLaTF4bDbAqvUlxNiaMkVBZ6+QCxQC1g8Ll+
         wGiQ==
X-Gm-Message-State: AAQBX9e2Fckg1vzyRlUTxsUt1AyirI8VRG6kzl8ayrwa62+nGUzqvDaN
        WIsyjhPEVlkojFxsiTA8VMjBlg==
X-Google-Smtp-Source: AKy350aDmQuVT7dvYGoVbx0Gl5aM/pIkyIhUH019RsHK8WF6YrdYN02UNxdxZs2bl3hOfdzCUhxXuA==
X-Received: by 2002:a1c:7211:0:b0:3f1:82d8:8fde with SMTP id n17-20020a1c7211000000b003f182d88fdemr9609077wmc.24.1682423126169;
        Tue, 25 Apr 2023 04:45:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:60a2:ee0e:c790:8f0e? ([2a05:6e02:1041:c10:60a2:ee0e:c790:8f0e])
        by smtp.googlemail.com with ESMTPSA id p10-20020a1c544a000000b003f03d483966sm18102139wmi.44.2023.04.25.04.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 04:45:25 -0700 (PDT)
Message-ID: <d30fd923-e6e5-a1a6-ca76-1b39f8fad6c9@linaro.org>
Date:   Tue, 25 Apr 2023 13:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Qinrun Dai <flno@hust.edu.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timers material for v6.4-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider pulling these changes for v6.4-rc1

Sorry for the delay, last weeks have been extremely overloaded

Thanks

   -- Daniel


The following changes since commit f7abf14f0001a5a47539d9f60bbdca649e43536b:

   posix-cpu-timers: Implement the missing timer_wait_running callback 
(2023-04-21 15:34:33 +0200)

are available in the Git repository at:

   ssh://git@git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.4-rc1

for you to fetch changes up to e2a1406c84c43bd104e2f85c4d8ab0b0b1609ab0:

   dt-bindings: timer: rockchip: Add rk3588 compatible (2023-04-24 
16:56:14 +0200)

----------------------------------------------------------------
- Fix error returned for shared timers on Exynos MCT timers (Krzysztof 
Kozlowski)

- Code reorg by splitting the CPUXGPT timer code (AngeloGioacchino Del 
Regno)

- Remove the unused mxc_timer_init() function on i.MX (Fabio Estevam)

- Replace of_get_address() and of_translate_address() calls with
   single call to of_address_to_resource() on TI timer (Rob Herring)

- Mark driver as non-removable and remove useless remove() callback on
   SH MTU2 and STM32 LP timers. Improve the error message in the remove
   callback of the TI DM timer (Uwe Kleine-König)

- Convert to platform remove callback returning void on Tegra186, TI
   DM timers (Uwe Kleine-König)

- Drop pointless of_match_ptr for ID table in the STM32 LP timer
   (Krzysztof Kozlowski)

- Fix memory leak in davinci_timer_register when init fails on DaVinci
   (Qinrun Dai)

- Fix finding alwon timer regression on Timer TI DM (Tony Lindgren)

- Use of_property_read_bool() for boolean properties on TI timer (Rob
   Herring)

- Drop superfluous rk3288 compatible and add rk3588 compatible DT
   bindings (Cristian Ciocaltea)

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
       clocksource/drivers/timer-mediatek: Split out CPUXGPT timers

Cristian Ciocaltea (2):
       dt-bindings: timer: rockchip: Drop superfluous rk3288 compatible
       dt-bindings: timer: rockchip: Add rk3588 compatible

Fabio Estevam (1):
       clocksource/drivers/timer-imx-gpt: Remove non-DT function

Krzysztof Kozlowski (2):
       clocksource/drivers/exynos_mct: Explicitly return 0 for shared timer
       clocksource/drivers/stm32-lp: Drop of_match_ptr for ID table

Qinrun Dai (1):
       clocksource/drivers/davinci: Fix memory leak in 
davinci_timer_register when init fails

Rob Herring (2):
       clocksource/drivers/timer-ti-dm: Use of_address_to_resource()
       clocksource/drivers/ti: Use of_property_read_bool() for boolean 
properties

Tony Lindgren (1):
       clocksource/drivers/timer-ti-dm: Fix finding alwon timer

Uwe Kleine-König (5):
       clocksource/drivers/sh_mtu2: Mark driver as non-removable
       clocksource/drivers/timer-stm32-lp: Mark driver as non-removable
       clocksource/drivers/timer-ti-dm: Improve error message in .remove
       clocksource/drivers/timer-tegra186: Convert to platform remove 
callback returning void
       clocksource/drivers/timer-ti-dm: Convert to platform remove 
callback returning void

  .../bindings/timer/rockchip,rk-timer.yaml          |   2 +-
  drivers/clocksource/Kconfig                        |   9 ++
  drivers/clocksource/Makefile                       |   1 +
  drivers/clocksource/exynos_mct.c                   |   2 +-
  drivers/clocksource/sh_mtu2.c                      |   7 +-
  drivers/clocksource/timer-davinci.c                |  30 ++++-
  drivers/clocksource/timer-imx-gpt.c                |  19 ---
  drivers/clocksource/timer-mediatek-cpux.c          | 140 
+++++++++++++++++++++
  drivers/clocksource/timer-mediatek.c               | 114 -----------------
  drivers/clocksource/timer-stm32-lp.c               |  11 +-
  drivers/clocksource/timer-tegra186.c               |   6 +-
  drivers/clocksource/timer-ti-dm-systimer.c         |  63 +++++-----
  drivers/clocksource/timer-ti-dm.c                  |  15 +--
  include/soc/imx/timer.h                            |   7 --
  14 files changed, 221 insertions(+), 205 deletions(-)
  create mode 100644 drivers/clocksource/timer-mediatek-cpux.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
