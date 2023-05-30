Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B177168FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjE3QPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjE3QPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:15:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A111B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:14:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so33292805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685463268; x=1688055268;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8E/XALJcqXkwZP5gRRQxOrP1E6GYgsvl1mdzFrPwoHs=;
        b=j7m5TLNGHYPks/DB5NwpJEaJxEUZvnwmAKhmJYFtmqFeCgOHe8TS50IiAFQL2HcLgq
         lM7rpvgWzLPAF2PY6LDDwM+Ga+MCp4PWHjlq7IoaCp0mQytpFLLwlWqJW04FEdagUmh1
         5F5WPw8m/NgBWnJ7Nlj+Y6b95Qp2ZvzXWn9jVPme1qcq6vYBxnWUtONnLfZ/2sDty/i2
         lI1Mz/lSVzybNmw7d+ig33KtqN4Tmb7TGgXwql9s0F86XgS906kfLIhMAmD3OiOoOZK4
         9jJb5VblFBNf9mKmyd9FZKKovWKueEBnzstsZUeIWoH9XIp6thMxkGUc7GNJRDbPCIc2
         JlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463268; x=1688055268;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E/XALJcqXkwZP5gRRQxOrP1E6GYgsvl1mdzFrPwoHs=;
        b=IqydsypsqzqqCb0tq+Idnfv2EWfRTNB8KCciRn00KA7i2XfNccJgvZf0dK1nWM6QQf
         LCEqJIkAQ2j80k/yNTDz3DxITV0KxB0oTMbt/TkJq+J0578OLFaaTXPM84aw+m2cLC8p
         og7eAxofvcUVM184zu5FC38YC2ZDUotYjDER6aof2RQkaqJ8aoK0SR08Qqm4/T7j79zu
         8yiRH2l1he0It/KQuBFimYElxJyPstk+ILsH/BvW/0flm1WBBXmtH5gzDEm4UMspJceF
         BdoFisT/XqgS+u/MokyxsbyqRjt3pSsAS6vliRXyt1iMBc4zHyLx8UYF8is2B0H9AgKl
         NHIw==
X-Gm-Message-State: AC+VfDwr/XQHlFoU/V3kIrwKj/U8YuWFagrSYYz5aaH2WuiQOOBSza0N
        K3zPydTpdNhBKXC9g/vbpigkpg==
X-Google-Smtp-Source: ACHHUZ6WWApvC/NMBiE72EVqrmA/84lk/cV8yiAqD8+jVocG4E4+KuL2cR+91Sc1Wzm58YlqYiG3DQ==
X-Received: by 2002:a05:600c:2214:b0:3f6:2d8:4823 with SMTP id z20-20020a05600c221400b003f602d84823mr2080466wml.3.1685463268024;
        Tue, 30 May 2023 09:14:28 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003f4e8530696sm17729719wmj.46.2023.05.30.09.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:14:27 -0700 (PDT)
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 0/6] add Amlogic A1 clock controller drivers
Date:   Tue, 30 May 2023 18:14:01 +0200
In-reply-to: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
Message-ID: <1jilc94x0d.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 17 May 2023 at 16:33, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> A1 SoC has four clock controllers on the board: PLL, Peripherals, CPU,
> and Audio. The audio clock controller is different from others, but the
> rest are very similar from a functional and regmap point of view.
> This patch series add support for Amlogic A1 PLL and Peripherals clock
> drivers.
> It blocks all A1 peripherals mainline support and a couple of patch series,
> which were already reviewed and acked, but weren't merged due to pending
> clock controller drivers series, e.g.
> https://lore.kernel.org/all/20230418111612.19479-1-ddrokosov@sberdevices.ru/
>
> TODO: CPU and Audio clock controllers are not included in this patch
> series, it will be sent later. The following clks from these controllers
> are not supported for now:
> * Audio clks - vad, mclk_vad, mclk_d, resample_a, locker_in, mclk_b,
>    pdmdclk, pdmsysclk, eqdrc, spdifin, mclk_a, audio2_toaudiotop,
>    audio2_tovad, audio2_toddr_vad, audio2_tdmin_vad, audio2_pdm,
>    audio2_ddr_arb, audio_audiolocker, audio_eqdrc, audio_resamplea,
>    audio_spdifin, audio_toddrb, audio_toddra, audio_frddrb, audio_frddra,
>    audio_tdmoutb, audio_tdmouta, audio_loopbacka, audio_tdminlb,
>    audio_tdminb, audio_tdmina, audio_ddr_arb, mclk_c
>
> * CPU clks: cpu_fixed_source_sel0, cpu_fixed_source_div0,
>             cpu_fixed_source_sel1, cpu_fixed_source_div1, cpu_clk
>
> Validation:
> * to double check all clk flags run below helper script:
>     pushd /sys/kernel/debug/clk
>     for f in *; do
>         if [[ -f "$f/clk_flags" ]]; then
>             flags="$(cat $f/clk_flags | awk '{$1=$1};1' | sed ':a;N;$!ba;s/\n/ | /g')"
>             echo -e "$f: $flags"
>         fi
>     done
>     popd
>
> * to trace current clks state use '/sys/kernel/debug/clk/clk_dump' node
>   with jq post-processing:
>     $ cat /sys/kernel/debug/clk/clk_dump | jq '.' > clk_dump.json
>
> * to debug clk rate propagation, compile kernel with the following
>   definition:
>     $ sed -i "s/undef CLOCK_ALLOW_WRITE_DEBUGFS/define CLOCK_ALLOW_WRITE_DEBUGFS/g" drivers/clk/clk.c
>   after that, clk_rate debug node for each clock will be available for
>   write operation
>

Applied, Thx
