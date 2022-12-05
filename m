Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59076435E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiLEUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLEUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:43:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A064F4;
        Mon,  5 Dec 2022 12:43:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n21so1344005ejb.9;
        Mon, 05 Dec 2022 12:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnklUjZR0c0LO76Qxp3fFJe2+d2XTdjb5Unf9l7Eej4=;
        b=JisIvPJPKq8kJkC4FZ65uRGFoc8C2ST0BWcamsPcGoJVojWLeuhkcdcBu8kWzrSGxW
         FnoK/OwPhoIIaQHiIB8OBNrWD0BFgDf2uAYDl7NjhqgjRYBRPpyqwQTglWZFHlzuORab
         VTIOYZhUjAvIz604UoXuhX0vT1yApC0HEYvaKhqf0iajLQttT4p49iBarJ9a8BDa9N1F
         TZPhez1EI8nO8hJLG5G8G1SaVlyntKsYFmiNS26EM1BowF6XLqjC5NHmd6Nmpg5M9iAC
         XEixmz6/1CB2jQR7DIT5ZnyVGTMTPJhgwJIl4XHXBa7DbstdN21ktJRal/w57uzCLu3C
         qIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnklUjZR0c0LO76Qxp3fFJe2+d2XTdjb5Unf9l7Eej4=;
        b=noe4F3quxeb1QvNSwotZCWlAnmtZPNEEgR0PJJVi8g+reJhadC7YyrD9n49vQwxM48
         G+Mp0MwoFio4Kxi7ZGh9UxCDfc5D08FaDA4yctperB0SkoJPLbWXcMhoUF/TYYkkZdeK
         4Mhwm4VS0oy8J8ZQkXAyca+UFrr/E431GxjUeFCzNaCVC4rnzVbFuzRgpUDUzRAHwnZs
         uWtrry5q8W6i/TAXl/xxUJKnPlIiHMrfhj3YM7WKd5Mw2wUj1A4RGRyb3ky9FG8gKUcE
         UvO2UsD4W6Z7/RuWknZcNa14r1MyWl2LizNwoz8aWVU4dBxFcUXnaKkK7dVXVgAORiGe
         N3mA==
X-Gm-Message-State: ANoB5pnX7IzjH5SIoCaLs0nJlttWg2FqHG8s0oLhUaxIfWE/8SNooBWb
        79lUG5JGjplp0DzhVKlxUio=
X-Google-Smtp-Source: AA0mqf4Rgh0vFFu8IOxnenPhjBpxMR088qnLDKQ9JbQ9ahZsFefNRzOOwPqw+kMG9BcdAGy3Tb4GJA==
X-Received: by 2002:a17:906:dfe8:b0:7c0:8711:7a4 with SMTP id lc8-20020a170906dfe800b007c0871107a4mr27160145ejc.667.1670272996604;
        Mon, 05 Dec 2022 12:43:16 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170907784e00b0077a11b79b9bsm6583034ejc.133.2022.12.05.12.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:43:16 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: Re: [PATCH v2 09/12] riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
Date:   Mon, 05 Dec 2022 21:43:14 +0100
Message-ID: <1742993.VLH7GnMWUR@kista>
In-Reply-To: <20221125234656.47306-10-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-10-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 26. november 2022 ob 00:46:53 CET je Samuel Holland napisal(a):
> The 100ask Dongshan Nezha STU is a system-on-module that can be used
> standalone or with a carrier board. The SoM provides gigabit Ethernet,
> HDMI, a USB peripheral port, and WiFi/Bluetooth via an RTL8723DS chip.
> 
> The "DIY" carrier board exposes almost every pin from the D1 SoC to 0.1"
> headers, but contains no digital circuitry, so it does not have its own
> devicetree.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


