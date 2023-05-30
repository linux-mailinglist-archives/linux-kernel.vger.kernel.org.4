Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F5715802
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjE3IIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjE3IIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:08:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94318F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:07:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30789a4c537so2505781f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685434072; x=1688026072;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=7n8N6QNiTQMJPyVtwSxAx8mmzrd7/rI2HSTVudMzAVs=;
        b=fi5gqWIUfInaquUT/xDkcznLV+4/PY3SXP2W8rdQkTvvGGtPBH9A3YN11agDLi3fuY
         a7O17jFyRjhoeSTmmFHiLt0obXDlbgGaDE4qpav93lpyvAWCw7VoTVC36Sc0JPXWuFDd
         gYUw7KRn7cm6vPAuP4Zy36y8AcSEzsDdvfPiHjnDTwLufiaJyFy23LGlQPA5tgEsZHGn
         wK+Yugb1SLokn65hoSEl1U3WV439e2uolYCx29ccQOx9KievdUH2hSrCkzJK6zaHwc27
         diKWNkH9HL9+C8OVLIpS6TRZ9ot70lFcJK3T6Y0lzSKpYJZSMeYMsllU1sWW0d67fROe
         mqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434072; x=1688026072;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n8N6QNiTQMJPyVtwSxAx8mmzrd7/rI2HSTVudMzAVs=;
        b=U254uhmKBSEe5V6VjJ3WdPuZ8uMKIXjP6Dd3cLlIKsSgOQRkNSNNowaAkCsjqXGh84
         dZ73pZ8mKTDrERcxl6A3dH3+U9sEu4T7Cw2D2qiaEI8t8GjOIMGafPruPc4cqhyfgkp8
         2ctL5AEvC66jT7SZ0VT2vJXFO1ZA/GYibb1SvtM6ooTNOzdq00mwsfMSBxGMHyU7J/11
         OGZ3Z0cXY7+X3EMJmM941xKFMeGvyvWGVc8EwyKk5vSTFcTfbJEs/G3GnnP3HFN6ImAQ
         hRYa5fKUTJ8LdxGrgUp2hF+79wekjy4q8G6nYESffwNpNzzMn5xw2osL/3qgn4y7WqLr
         cH5Q==
X-Gm-Message-State: AC+VfDwxFseQ1TzeioNutUbKgtpaehCHkKk7kgya4wHlluhNAP1bZy42
        UPvz57nWvqGAvlLIV4ot9LDw4Q==
X-Google-Smtp-Source: ACHHUZ7QwCpJcGXyXy3ikiWMlyuNkz5JS54y0WLuFaWgUV84kbbYoN/r8K1PFoC2133vUyrQFchJ7A==
X-Received: by 2002:a5d:51d1:0:b0:30a:e66d:25b7 with SMTP id n17-20020a5d51d1000000b0030ae66d25b7mr912985wrv.13.1685434071999;
        Tue, 30 May 2023 01:07:51 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f4-20020adff984000000b0030ae849c70csm2387441wrr.37.2023.05.30.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:07:51 -0700 (PDT)
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
 <5cb38be4-a27f-dc1a-cbb9-c195505a9e7c@linaro.org>
 <9fa0662e-8854-05f9-da7f-ec8e08d2badf@linaro.org>
 <d5c030f9-2f4d-25cc-b922-d00f5033ac37@linaro.org>
 <6228670c-3e06-3061-f304-a2c641962ffa@linaro.org>
 <9cba6384-123b-1cd1-ed02-08365a0ed529@linaro.org>
 <2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com>
 <aa22c05d-9db7-eff1-d203-cb795359252b@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 01/13] dt-bindings: clk: g12a-clkc: export VCLK2_SEL
 and add CTS_ENCL clock ids
Date:   Tue, 30 May 2023 10:06:01 +0200
In-reply-to: <aa22c05d-9db7-eff1-d203-cb795359252b@linaro.org>
Message-ID: <1j7csq5jjd.fsf@starbuckisacylon.baylibre.com>
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


On Tue 16 May 2023 at 11:00, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 16/05/2023 10:44, Arnd Bergmann wrote:
>> On Mon, May 15, 2023, at 18:22, neil.armstrong@linaro.org wrote:
>>> On 15/05/2023 18:15, Krzysztof Kozlowski wrote:
>>>> On 15/05/2023 18:13, Krzysztof Kozlowski wrote:
>>>>
>>>> Also one more argument maybe not relevant here but for other cases -
>>>> this makes literally impossible to include the clock ID in DTS in the
>>>> same kernel revision, because you must not merge driver branch to DTS
>>>> branch. SoC folks were complaining about this many times.
>>>
>>> Actually we handle this very simply by having such patches merged in a immutable
>>> branch merged in the clock and DT pull-requests, it worked perfectly so far
>>> and neither Stephen or Arnd complained about that.
>> It's usually benign if you just add a new clk at the end of the binding
>> header, as that doesn't touch the internal header file in the same
>> commit. I'm certainly happier about drivers that just use numbers from
>> a datasheet instead of having to come up with numbers to stick in a binding
>> because the hardware is entirely irregular, but there is usually no point
>> trying to complain about bad hardware to the driver authors -- I unsterstand
>> you are just trying to make things work.
>> I agree with Krzysztof that using the same identifiers in the local
>> header and in the binding is just making your life harder for no
>> reason, and if you are the only ones doing it this way, it would
>> help to change it. Maybe just add a namespace prefix to all the internal
>> macros so the next time you move one into the documented bindings you
>> can do it with the same immutable branch hack but not include the
>> driver changes in the dt branch.
>
> Ack, I'll try to find a simple intermediate solution to avoid this situation.

I'd in favor of keeping things simple and just put all the IDs in the
bindings. We have been doodling with the idea for while, I think now is
the time

>
> Thanks,
> Neil
>
>>      Arnd

