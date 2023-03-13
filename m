Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4266B7267
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCMJVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjCMJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:21:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237A498B9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:21:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso7352917wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678699268;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=NyKmnb2IGGlRYKdA8v+Oi9cQGOt819vf2di9Hwq+CB0=;
        b=mSVsf+a/ifTL56wAV9Qw2FDlsV5LEVpddsOHAnmgmNWX8ZYxk80hyF4aQqagAEUpRc
         jDtW5tGU1a1sIXrahUuJD2t838vwVvvnj4Ixlt8aS35T1up5M9BaMB/TiJMSOI2IGuV9
         4DpczCsw5ChdGLdIiV66BOPSrFanB1m6q32U2VqzOEmNpUIv9k55vB8EjTbMZCdowJuu
         /SVQvLaRF7kjaEKEuU54weShdspUHgoj7wr916M1wsEnxth4j2CBMJB6SrbWvLaot6br
         AjjW9ZVSxTuneR96w0vxXlzXrgJAt5qX1svj0H5QfW8P15XTzrOhQpO06GBAV80jJ6Q2
         9YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678699268;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyKmnb2IGGlRYKdA8v+Oi9cQGOt819vf2di9Hwq+CB0=;
        b=UnOWl6KeAMeLV6dG98XCzdzdCv1zSakc/EjFeTBgzQNQImTi/swiZGce6TfHyAW6XB
         tYBNI3Sh9SCe/gU7Pejxfp2YrIfXpKV4jNVQwixcCLg9IeJrJeJAi/dXfVxafKMQX1Eq
         6RFgRmy6M6Xv/1DxxO6pGQK4jV/Q9LMa+FfoH8V4pi2gy6JcriPbHyg532HxsAqx1aFK
         ZDt7jyg/gwTcWv2DNsMhrl/NwxU6WOH+frpO3+LzqRQxWmc1ua1YQs6FkRbx1NDzTEXM
         XKqO6LB06ZvClcb+s/xmuqmQfJtQXdLLfDbAcbeIg3EinLBLOnvtZUJk6DGVolRC/L7U
         OvWA==
X-Gm-Message-State: AO0yUKVhKjEEaHj6VptmC7pGTjNOCOzvLJa1Dfs3qlyGBhJq986+SBPY
        QO1cLJpDfhrKMsiv/hshYGrKbw==
X-Google-Smtp-Source: AK7set+ffANocDz449+nx/CU8mE/uaLR+A5C2On6Z7RmrE6Px8IYI5sqoAqzr08nkoqwgeu6K+3K2w==
X-Received: by 2002:a05:600c:1c9a:b0:3ed:2418:6cbe with SMTP id k26-20020a05600c1c9a00b003ed24186cbemr2701778wms.39.1678699267735;
        Mon, 13 Mar 2023 02:21:07 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c378400b003e215a796fasm8292361wmr.34.2023.03.13.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:21:07 -0700 (PDT)
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-3-ddrokosov@sberdevices.ru>
 <1jr0u2azfi.fsf@starbuckisacylon.baylibre.com>
 <20230306200549.7iuedbl27ejfhf6b@CAB-WSD-L081021>
 <1jlek60zun.fsf@starbuckisacylon.baylibre.com>
 <20230309182857.a2fzotcejueio23w@CAB-WSD-L081021>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/5] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
Date:   Mon, 13 Mar 2023 10:18:02 +0100
In-reply-to: <20230309182857.a2fzotcejueio23w@CAB-WSD-L081021>
Message-ID: <1j5yb50zxz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 09 Mar 2023 at 21:28, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

>> >> 
>> >> This last poke should not bits otherwise handled by parms.
>> >> This is a rate init in disguise.
>> >> 
>> >
>> > I believe, you are talking about hifi_pll clk_regmap conflicts with
>> > hifi_init_regs. The above init sequence shouldn't affect pll regmap setup,
>> > it doesn't touch them (we assume that default bit values are all zero):
>> >
>> >     .en = {
>> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> >         .shift   = 28,
>> >         .width   = 1,
>> >     },
>> >     // init_value = 0x01f18440
>> >     // en_mask    = 0x10000000
>> >
>> >     .m = {
>> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> >         .shift   = 0,
>> >         .width   = 8,
>> >     },
>> >     // init_value = 0x01f18440
>> >     // m_mask     = 0x0000000f
>> 
>> mask is 0xff with width 8
>> 
>
> Ah, you're right. Anyway, I think this is just init value and it's okay
> to set it during initialization and rewrite after in parameter
> propagation stage.
>

... But the magic pokes are there only to initialize the unmanaged part
of the clock regs. I'd like it to be clear and stay that way.

So please, clear the managed fields from the initial poke table.


