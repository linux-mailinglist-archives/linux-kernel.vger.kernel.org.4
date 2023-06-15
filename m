Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7773158F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjFOKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjFOKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:38:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC512121
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:38:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7ff69824dso4535425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686825498; x=1689417498;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HhDvY5NOJAhj9HpoAeApwW1Xx3nbYDTiIZwJoccQUI=;
        b=SNg6Oeo5SgROXY7rp+MSqrTKj/Ab2XYTPYa7yeactT2L5VC2QhH1RD7NqyBIEZ6kCf
         3iT+uwZPq+L3N3ARWPGthtf0dngxReaq4LDrcT3nhbAFF0nWSo1KkCzdAbkHBgxaD/lO
         itFgK671PZW7Sdh0D9gFnoKDxeII4hQX3zqD2/YWrMB+ODE+/4yg6YxjSUUISuPlxmGd
         9KCwHfcouBOtRHQJNB7/E01+xlZud4iFDXUar5y+2y9UGq63YRi+I9Ms1fiYuu7TW4SL
         KhIwx4bM9WeT0YQwpaRgI8xrXJHt+y6WKK7V+0XdDKHrffly+IT/uyOEQw5pySCeGHVV
         /IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825498; x=1689417498;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2HhDvY5NOJAhj9HpoAeApwW1Xx3nbYDTiIZwJoccQUI=;
        b=YrxzYxCCLd3bm52IcT1p1H9ST1gQwikcdrxHhFYMjgTIzHR+W+P5bNvazgAs8CAtNe
         gtFUqpTD8q6Y1KXQKX5gUwCzbA8ypSj1p7ui4w1C+gVV3Gx0Mmyakj6B3bNUISBeE1xs
         zrinab0kgKqStIrI05blwRnDCYTqtsNA3V9wMkbZ+2HKuM2GyWVVb6O6dASkBwGJXh+5
         bgi//E6mGAoioVTu+t5Mp3sduhpkOwjnzEF1pLZ2kok7aDZe0pA93+LoIPVlZwmimhSO
         +dkaFMTb4/UVzILgvqTahBVSUyr++uq1uVJJzYRr00STqOGttc0NNqX+sNTvbigbN5EU
         pOcQ==
X-Gm-Message-State: AC+VfDzBX8Mdr3dDyU6qD0hVwK1zQjZHx+E2Dmai5IkOYj0ojE0jY/fp
        L+v5+HP89vJZXwPVzfY+ECJrPw==
X-Google-Smtp-Source: ACHHUZ7aLxl6u8Xy8keJRrva8YV/gEx7RIIAOGjxj2M3OsUhXtIj8GbKGcAVpQ/yJBbdCRNp057N8w==
X-Received: by 2002:a05:600c:5562:b0:3f7:ba55:d03e with SMTP id ja2-20020a05600c556200b003f7ba55d03emr3885162wmb.6.1686825497863;
        Thu, 15 Jun 2023 03:38:17 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0acc00b003f195d540d9sm20041465wmr.14.2023.06.15.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:38:17 -0700 (PDT)
References: <20230614084808.98819-1-jiapeng.chong@linux.alibaba.com>
 <CAFBinCBZFxx55HQM4a99vVwvXFaQThn8_F5B4uNS5x1AYzOupw@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] clk: meson: pll: remove unneeded semicolon
Date:   Thu, 15 Jun 2023 12:36:19 +0200
In-reply-to: <CAFBinCBZFxx55HQM4a99vVwvXFaQThn8_F5B4uNS5x1AYzOupw@mail.gmail.com>
Message-ID: <1j7cs52ep4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 14 Jun 2023 at 22:09, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> On Wed, Jun 14, 2023 at 10:48=E2=80=AFAM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
>>
>> No functional modification involved.
>>
>> ./drivers/clk/meson/clk-pll.c:373:2-3: Unneeded semicolon.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5533

Removed this bugzilla tag and added a fixes tag:
Fixes: b6ec400aa153 ("clk: meson: introduce new pll power-on sequence for A=
1 SoC family")

>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied through the amlogic clock tree.
Thx
