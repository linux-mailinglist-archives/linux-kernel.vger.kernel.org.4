Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728A46435B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiLEUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiLEUcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:32:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46811B1D;
        Mon,  5 Dec 2022 12:32:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a16so17438031edb.9;
        Mon, 05 Dec 2022 12:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTQXUN+wCe+JcbeHhRBc8YaP/cWNJYqc3/JHgweB/7s=;
        b=eJbMydvvO3awrVg4S0NKuHBUTa464s6VAuVN0K9UYGOZJVtoM2FRo11yyVUVa/xMCv
         y1bPEUT5JL3DamSuImf0+xJ2eDGiDArAqLeA+xqiGbRo9Dj80PIwmLDo0JkK6DO9tUfe
         /Cy+Z3MyKBNWjGAZKoAoTQxa92FMBExLydUqRUynRTr8bCkRuFF3WoXNjrvdRbGAke3v
         9J7+rZvAXlsQSkRPNcw/u5Gy94kZAagNzLPmSOkOCyIlGKu1rPjzy+TT9FrmA1MgX1EF
         ix479cb9iolG/9gV194NtIjOPvMvJAgVqgc5zcCShEhgXwRqEJY9SLFLNzzgpU/WIKQz
         ZcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTQXUN+wCe+JcbeHhRBc8YaP/cWNJYqc3/JHgweB/7s=;
        b=e0XCFPE7PbCQEWTnCWUrX9X3VAaqv4yey9idDRSfgRLS9or+3Y/mLrYuO2BfjdgZ6x
         LXN+m/NAPGFhjs4/JE+S8nL8eW5Y2GK6N9J94J6OFsBj/G1RbqGmN2E86+a058yI08xR
         LORA4ulLztTEo0I1p4fy1vGowckKTZ8464VcokeFca31Nr9Olj/e3Ff3YlMrX5CelpGd
         HN8cP4f4xnwyMlBEl+pMDTXbrhXTupO0SKMKRA9u9sgYVhUNwqSLl22SNJEyKEWfBnF1
         q3cPkZoNbZGp8z+l6HFFF6dABzohD2dueuIeYgXKY9ba31vaK+/sFQDASpY+b8DxHAM5
         g4Jw==
X-Gm-Message-State: ANoB5pl9IWj6JFmWMqDYhCuW3tbqv3hWbibhMgJ5fXTmSg9OpgEoUIMY
        f3RQUfpCXCrelZ33lL+LImA=
X-Google-Smtp-Source: AA0mqf60d6jUSas5D6q/PR4Q7d6BaJJbLfeHZDdlbJ89AgCKuzGTDZEoy0HPtGTgbqM+7C33Ydhz0Q==
X-Received: by 2002:aa7:cc12:0:b0:462:79ec:55eb with SMTP id q18-20020aa7cc12000000b0046279ec55ebmr2675878edt.151.1670272352519;
        Mon, 05 Dec 2022 12:32:32 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b004615f7495e0sm209632edw.8.2022.12.05.12.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:32:32 -0800 (PST)
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
Subject: Re: [PATCH v2 05/12] riscv: dts: allwinner: Add MangoPi MQ devicetree
Date:   Mon, 05 Dec 2022 21:32:30 +0100
Message-ID: <1912378.PYKUYFuaPT@kista>
In-Reply-To: <20221125234656.47306-6-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-6-samuel@sholland.org>
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

Dne sobota, 26. november 2022 ob 00:46:49 CET je Samuel Holland napisal(a):
> The MangoPi MQ is a tiny SBC built around the Allwinner D1s. Its
> onboard peripherals include two USB Type-C ports (1 device, 1 host)
> and RTL8189FTV WLAN.
> 
> A MangoPi MQ-R variant of the board also exists. The MQ-R has a
> different form factor, but the onboard peripherals are the same.
> 
> Most D1 and D1s boards use a similar power tree, with the 1.8V rail
> powered by the SoC's internal LDOA, analog domains powered by ALDO,
> and the rest of the board powered by always-on fixed regulators. To
> avoid duplication, factor out the regulator information that is
> common across boards.
> 
> The board also exposes GPIO Port E via a FPC connector, which can
> support either a camera or an RMII Ethernet PHY. The additional
> regulators supply that connector.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


