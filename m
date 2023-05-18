Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9015708A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjERVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjERVIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:08:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790419B;
        Thu, 18 May 2023 14:08:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510eb3dbaaeso1694787a12.1;
        Thu, 18 May 2023 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684444083; x=1687036083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ1nJRxIw8TnLlb1uSAgTqg+C0cT9QEqF+EZc+fkSGE=;
        b=qcFIYBlhQxLx5FpKG/1H+u3N7ybS144V6jLsrdWYaTAUef1G3Uq6pjVipT0EPjzIsf
         fPa8M+8MqZNU68NgmxUnn81uBLw1UNoTwoH3v2vWcg7UC+FCOIGTjWLJPA4yh8qlEdyb
         R+7ZPZHirHFLCQMwATJX8ntw+HT3nWxvNcrlcSMBPCg4ZU+q1EaQQI0txdXcibMPs1d9
         NpTb0gJp8+JAhUWbyqtJmcus1ooyPCHUsrg0VQlE/S+izxUyzCjl7Es6/+qJx2NzRUDC
         h18rwgSxqbISnBdUfohbj4b9Bkcgue6noAzU77rh7XqPZVJGZRrqX39lxW3rEEF9WTWh
         lc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684444083; x=1687036083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQ1nJRxIw8TnLlb1uSAgTqg+C0cT9QEqF+EZc+fkSGE=;
        b=Qx8BTdniY//t4z27aFG06aBwpsYUxnYJalZU4cKek9TMgIssVFnWHoXwA2wAB9thHD
         vhmxqyHznBb5gjCoC4J9aNZK2JtOFEG1QMdX5GZ/m68yOOnJkWwRuqY8oi7a1ShyHAw0
         spTKrtv3dJekCSsvkPwk4sRgNdMh29hxkDNfX3yclRjQapPIr+dn5ojw7I3E3BRILFy3
         4H2ZwJ45qY6mZE44CxA8HYwEjQjV9oSn0m7J/JAwAqKHx9pHETVuOdaLzMtFMpg9qrnO
         x0lEJte5cBTKt72Pgy9jun4CbPZa2447hCMdFW7mwoj68qQfeeRAofFrTXk8hAOCq4jY
         J3jw==
X-Gm-Message-State: AC+VfDxju/J9iRIYuoaWI6cRDTF6X1Rwsv59ut+gKWr6AnDfrYA3GPsF
        aQSpJnF/HoIIFM7P54QJwCU=
X-Google-Smtp-Source: ACHHUZ52SILasiNNx8sRkg0S1vg75C4xH/2WANsiZSXCT1GQIAgCV8NbifpGXn/D63ZPnP28Jh2UMw==
X-Received: by 2002:aa7:df0d:0:b0:50d:f9b3:444c with SMTP id c13-20020aa7df0d000000b0050df9b3444cmr6065388edy.17.1684444082935;
        Thu, 18 May 2023 14:08:02 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id bc3-20020a056402204300b0050bc41352d9sm949023edb.46.2023.05.18.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:08:02 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roman Beranek <me@crly.cz>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux
Date:   Thu, 18 May 2023 23:07:59 +0200
Message-ID: <4828357.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230505052110.67514-2-me@crly.cz>
References: <20230505052110.67514-1-me@crly.cz> <20230505052110.67514-2-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 05. maj 2023 ob 07:21:07 CEST je Roman Beranek napisal(a):
> TCON0's source clock can be fed from either PLL_MIPI, or PLL_VIDEO0(2X),
> however MIPI DSI output only seems to work when PLL_MIPI is selected and
> thus the choice must be hardcoded in.
> 
> Currently, this driver can't propagate rate change from N-K-M clocks
> (such as PLL_MIPI) upwards. This prevents PLL_VIDEO0 from participating
> in setting of the TCON0 data clock rate, limiting the precision with
> which a target pixel clock can be matched.
> 
> For outputs with fixed TCON0 divider, that is DSI and LVDS, the dotclock
> can deviate up to 8% off target.
> 
> Signed-off-by: Roman Beranek <me@crly.cz>

Applied, thanks!

Best regards,
Jernej


