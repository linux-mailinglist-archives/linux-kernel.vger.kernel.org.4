Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D986F951B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 01:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEFXel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEFXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 19:34:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081489D;
        Sat,  6 May 2023 16:34:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so38197523a12.0;
        Sat, 06 May 2023 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683416076; x=1686008076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d9CMRNtxtAY+iVGmS9Nhh6aBEK5BkbQct2dEiCYBRLY=;
        b=REqdkMLCTy5UbebEqan+d2erjtQW+iSjh884sXj1Iqi4KYxB131TlOq+KW3UENuDWX
         THEXQaq1WHPMypuFmc4Ml820f1CQcnJiRhg6tIzULFl0U7XUdt/BtJkTqvBlwVHTKmZo
         RrSbBWgY5Z/a+YK/iUZyJUaxTyRDa7mKvcJHTFETzU4XSaLZ732eP3d9cicNn1c/FHPN
         C+JXs5T4yrUw/3HFnYtgw6Wf5giKRXIvUIVVXxDtuo2MW2/ES9apApq6gqqD8xswEo9j
         zbpg1K+6pf1+scu4m7KByOUFr/PIsJColgxbgMqpEgGBOkmBp8U6eoMr4U4Ufiv3pJG6
         9psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683416076; x=1686008076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9CMRNtxtAY+iVGmS9Nhh6aBEK5BkbQct2dEiCYBRLY=;
        b=PdsvNdGlUoRbXcbbZgMmFu+Iyi1BqLfcrBEooC4jalQH4tm1FP+Sptesf4uuME0bF/
         d221ERnLS58MemaHLvl+nhJGRczw7tdOPSqfW4SVXX7aXGIjpfBC1J48TGIfjBjmrWLu
         /Tk0ievhjH88D+2zyr9k5lbbecWyGaDrzIo1JDxZ/FRXynZJD5Z1RrEXqY8OXJPyXhGV
         pICUv2aPoNJQ1MTxcXuFMl6iXIn7yTxAAk/a5WTulGx7Iue1J8iLNCepCWh6jx8CZv7G
         0d47lJh9MQlIzU7KXxXsTkTmhs+R4sUhIqhgDd8nUJZbFil7VTtoW2uEnf1f40QekobQ
         3gXg==
X-Gm-Message-State: AC+VfDyn8PaBYPf98pIO+4rFISBYNvpIceYYf1Eug6KBjwzNfaqlrAWM
        BOtPHFrdVbRpWgDrGHUSnVeun878lvFFs5qecE8=
X-Google-Smtp-Source: ACHHUZ5pLbXef8h/yugyYWaRiTv4z9p+9JV6clL+Ey23A/L6IzrVNYFXYzqgEhKueJGdu7i1soJsP6surAam4+MVHnM=
X-Received: by 2002:a17:906:6a03:b0:933:4d47:55b7 with SMTP id
 qw3-20020a1709066a0300b009334d4755b7mr4790270ejc.2.1683416076334; Sat, 06 May
 2023 16:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
 <20230506073018.1411583-4-bigunclemax@gmail.com> <20230506225848.3278d7ab@slackpad.lan>
In-Reply-To: <20230506225848.3278d7ab@slackpad.lan>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sun, 7 May 2023 02:34:24 +0300
Message-ID: <CALHCpMg31VLy7=epEs4LTpUcWT+gLDJ-9bWGJMgYrTP1ozOX_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] spi: sun6i: add quirk for in-controller clock divider
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't we need to set tfr->effective_speed_hz to the actually programmed
> clock rate here?

Yes, we should. Also we need to configure SPI sample mode by setting
SDM and SDC bits in the SPI_TCR register.

Please check a new version of this patch.
https://lore.kernel.org/linux-arm-kernel/20230506232616.1792109-5-bigunclemax@gmail.com/
