Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD96435B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiLEUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLEUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:33:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253C11151;
        Mon,  5 Dec 2022 12:33:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bj12so1248439ejb.13;
        Mon, 05 Dec 2022 12:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y4+o5+3VTQ2cJHFB9l2XaUG0/wHW8D/s+vsN99BVaE=;
        b=iOXDEcLuqwSherSXE4U5w9gQCgyvR2cm/LugX2hw47DYz1qiypw3Az7NEAsK9etGZ1
         R9Wc7jHvQ1EDOovASiJdlnEZGoS+sZ55uSBB0iBfoFUKeUQsE1Co9JftkJgDgt+zhpVp
         A9TV6HOF3p7oJWQ8fnSast3ZANpdE1lqxkLUJZGE4YaIktmGrooce/zw3aTJCl9ZR/Aw
         +Iy2UZXquCzjBtHeODlWshoR6nVHh0cUPm9VnYmACQXSHaMbg7muAuZnY/P5n1J35DfT
         PmM405Xz/pL16rowVhHyRjWe2vqChetT73pJ564SYg1ChclWQJG080/7wX6OPnvshXWS
         nuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y4+o5+3VTQ2cJHFB9l2XaUG0/wHW8D/s+vsN99BVaE=;
        b=Ei+O3qpUV/osqemaOnC8Jy2qteSFc50Ktn6dR1ELPM0bXOu05+LSy/EVi3y+8DOPbN
         DbSBCdXgLdhHs8vDEwQHtHCAI8aE4FRgNwvL1luPySdPxPvL4rD55wYr1ha+UtmG7NOD
         //M+2PiPNeL35Fj826chCu/q7wYOOhR9ZaBDZq3r6PL7e8+tfdXxTmikSmrZnsXvBOGg
         oCoNipP7rvtkWzI+v+iUxaMzg20ODeCBJNeP/VdRA7B/QDqwRErIy82Lom9aZjT7vri8
         0pRNBJVUD8ny3V1xoa+/ugPBTY8riF5PdtXaEH+kDVqvyTklkMQwmEZTpQlZqF6zbte0
         UbbA==
X-Gm-Message-State: ANoB5pnfe2ghhPESXNSBgtlglDZuIMiga25dxEyS+wTjYiZwKilAO2rD
        8PshJCyMxJX14D9RdGjUFjo=
X-Google-Smtp-Source: AA0mqf7L5DepZPykpakDz8MEhCAqHhMgcvBT0fnFKGlH2luNDKCM3xQ0hRd5HOR5Fvc1yUeli+Pdog==
X-Received: by 2002:a17:906:3da2:b0:7ac:a2b7:6c96 with SMTP id y2-20020a1709063da200b007aca2b76c96mr68446980ejh.412.1670272388905;
        Mon, 05 Dec 2022 12:33:08 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b00779a605c777sm6581013ejg.192.2022.12.05.12.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:33:08 -0800 (PST)
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
Subject: Re: [PATCH v2 06/12] riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
Date:   Mon, 05 Dec 2022 21:33:07 +0100
Message-ID: <7457885.EvYhyI6sBW@kista>
In-Reply-To: <20221125234656.47306-7-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-7-samuel@sholland.org>
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

Dne sobota, 26. november 2022 ob 00:46:50 CET je Samuel Holland napisal(a):
> "D1 Nezha" is Allwinner's first-party development board for the D1 SoC.
> It was shipped with 512M, 1G, or 2G of DDR3. It supports onboard audio,
> HDMI, gigabit Ethernet, WiFi and Bluetooth, USB 2.0 host and OTG ports,
> plus low-speed I/O from the SoC and a GPIO expander chip.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


