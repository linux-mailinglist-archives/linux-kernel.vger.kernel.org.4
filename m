Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDF6FF793
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbjEKQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjEKQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:39:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B81996;
        Thu, 11 May 2023 09:39:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so13222167a12.0;
        Thu, 11 May 2023 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683823141; x=1686415141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa3SOvISZGaKHOA8+TPFpP/9VnubTDpNEPMLKFetZ+8=;
        b=K8TNyHobvnQWygzUwnU3H8Zqy+ySP0IfO9S2cuZ+akESC67EELHYE+Q5xiI8i6m+RT
         znFamR1F1Ylt3QWPBLwrZ7XCQzoOhzTOUZ3zKhE+zuoH5XoVG59E9Z5XuuxN+U52Wj2Q
         lavQ5Ycrjk2ECWezh08gdoDrnPOgFnXitYwZC+UBRhsxRMnjwJV6qkg2ePCgmg0zuZSp
         JbA7jsqLwva/hzFGFu2Sv1w5USSD/WBEOJSjIySsHEdShB0Qr/EgdWtPREoGrBcwM18W
         3BS9NiTSizMZJg9F3yFtRmmEzUg+zLr/+0uH4M6rcxrMVJvPGQxyqhE7ZX9FDfHOGJw2
         2ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683823141; x=1686415141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa3SOvISZGaKHOA8+TPFpP/9VnubTDpNEPMLKFetZ+8=;
        b=G9O0hE5UeZCrBlu1GnEauui/sWYb2Jy55eac5o5SrKk1uyYa1mGVsz9MJNkT4ybQqv
         x9YW0vKlPWY2bEFhIHaUS3E+7mR+SlhLpklHreusbsRIYlRrO4jPADHBN4RoH/mIfY3a
         oQHCk/q8BzNosn/z9DwcI4tYk1nw6KjVpaWthkjtjiTW/w69NAJ0VhAfWAJLXRgh5WWI
         LtUSfmlVqCObYTcnsJ/3QhGLT50JHqYBo1HDz1Ea/oupLttsy/tnv3ztVhXrjDyxcxHy
         saTggx5b2Ae7XDHNX2uid4WAP4anl61SgGEUee5yK9HqgYKU3m/s9xw6ub6BtEbhY1yX
         YYgw==
X-Gm-Message-State: AC+VfDyakWnNiDNhEyPAd3+RLF7nkeBMlp9TUkGMDr0lOsH4Kb5iGAm4
        Vojkrm8Vq62SyVtvzH51JOQ=
X-Google-Smtp-Source: ACHHUZ6FTNvxZ52Lw7NBAuRpzL4lNKYkUViPH7hIkSsrbZqqnREejzk9ADHcMFBkgEvRr4ylKMP7ZQ==
X-Received: by 2002:a17:907:98d:b0:96a:37af:ff37 with SMTP id bf13-20020a170907098d00b0096a37afff37mr4554954ejc.15.1683823140726;
        Thu, 11 May 2023 09:39:00 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906a00800b009658264076asm4198381ejy.45.2023.05.11.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:39:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/5] spi: sun6i: add quirk for in-controller clock divider
Date:   Thu, 11 May 2023 18:38:58 +0200
Message-ID: <23071886.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20230510081121.3463710-4-bigunclemax@gmail.com>
References: <20230510081121.3463710-1-bigunclemax@gmail.com>
 <20230510081121.3463710-4-bigunclemax@gmail.com>
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

Dne sreda, 10. maj 2023 ob 10:11:10 CEST je Maksim Kiselev napisal(a):
> Previously SPI controllers in Allwinner SoCs has a clock divider inside.
> However now the clock divider is removed and to set the transfer clock
> rate it's only needed to set the SPI module clock to the target value
> and configure a proper work mode.
> 
> According to the datasheet there are three work modes:
> | SPI Sample Mode         | SDM(bit13) | SDC(bit11) | Run Clock |
> |
> |-------------------------|------------|------------|-----------|
> |
> | normal sample           |      1     |      0     | <= 24 MHz |
> | delay half cycle sample |      0     |      0     | <= 40 MHz |
> | delay one cycle sample  |      0     |      1     | >= 80 MHz |
> 
> Add a quirk for this kind of SPI controllers.
> 
> Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


