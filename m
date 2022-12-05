Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D46435E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiLEUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLEUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:42:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711522A736;
        Mon,  5 Dec 2022 12:42:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b2so1364260eja.7;
        Mon, 05 Dec 2022 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWNOm6qDMo1xXbSWez6F0Vr3ScX8LNHNqSo7KMJ1CZg=;
        b=WcyOKlKhgWRKmKCex9KlNc4vfbJR7H9xX1lhfVBHgrnjX9BxyDol24Beb/sw3+wrfl
         mcq+5f+42JfTTsKBIN+3/X7aXUJfdCdsi3t/AOgpNk5McBsN9bAqOMaSo6+UnShYLzof
         XEvPKBEPeYVl2RAHjS/TSCKSPoE6+N7IXSKVeNdWvsaPiIwAcCidfuYmpjgUlmMgq8ua
         JC+0lKYH9TLCiiBBFlEC9vYU5DPQcvVms7Z1Mq+7xZZBhko9icQUHK/XLhjNfS36BGzT
         9NpapC09/jdDbzgE2b3elsxEWUFveTv+GgE/W02C6nxz8cFP4E0zfq6K3FuFHvngzk2F
         ZAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWNOm6qDMo1xXbSWez6F0Vr3ScX8LNHNqSo7KMJ1CZg=;
        b=Ifr+4BnwuVyS4eJ/KSqnS0IVtf4V+FC0+alarXDbWmLV36ihUWplcdaN/gbhLBW6jD
         R2Je0dSVAzFJsYsov2/h0OJfYc/adjSgCLFpdweqW3ff7QiLcYHMM9ZgsUXyugOPaarq
         BG6Pq1igIFchIXgBFA+PJCGctsvmcioZ/qnhoFseVKRBXVYfTyK6pq1uJ7nZXhjTEnVE
         wEM4xPaoLfwSRb4dCgrDqqp4Kke7410Jqsj3sbcdS/n8GIkdtsDPgkurmgHGhAG5bzS3
         iC6CD+b3ZUKRKAZ5E53X3FZ3RAcNYtPfX8xnu2dLXTEAEJSfQBCh2wGJxFnaNR/HWfOl
         TEzA==
X-Gm-Message-State: ANoB5pkaanIvJBn3SuBzIc2RCVdPkl9/XIPI70bZv3FB3VqxsAcLP5pb
        k2A7mzoASDN9JYFyj0cYqIM=
X-Google-Smtp-Source: AA0mqf5rroUoM42vHCkdHZZd5l3XiigQTzlVKoW/izJnAPaZeqagB11YRTTqF98uLV6H4yaznZoCtg==
X-Received: by 2002:a17:907:770b:b0:7c1:277:caf3 with SMTP id kw11-20020a170907770b00b007c10277caf3mr2397713ejc.247.1670272923966;
        Mon, 05 Dec 2022 12:42:03 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906310600b00738795e7d9bsm6582019ejx.2.2022.12.05.12.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:42:03 -0800 (PST)
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
Subject: Re: [PATCH v2 07/12] riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
Date:   Mon, 05 Dec 2022 21:42:02 +0100
Message-ID: <3466608.iIbC2pHGDl@kista>
In-Reply-To: <20221125234656.47306-8-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-8-samuel@sholland.org>
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

Dne sobota, 26. november 2022 ob 00:46:51 CET je Samuel Holland napisal(a):
> Sipeed manufactures a "Lichee RV" system-on-module, which provides a
> minimal working system on its own, as well as a few carrier boards. The
> "Dock" board provides audio, USB, and WiFi. The "86 Panel" additionally
> provides 100M Ethernet and a built-in display panel.
> 
> The 86 Panel repurposes the USB ID and VBUS detection GPIOs for its RGB
> panel interface, since the USB OTG port is inaccessible inside the case.
> 
> Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


