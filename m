Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824DE64358E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiLEUWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLEUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:22:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F276338;
        Mon,  5 Dec 2022 12:22:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f7so17433502edc.6;
        Mon, 05 Dec 2022 12:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkl0GaWgeqVQmFYobiRcFtfUz3ufHqhTS+/iP5/CmzY=;
        b=b2zK3kxwbCERv7eiKN8zG2OpB/f3DOYQlaYVNclSh7psvFOndpURX2gBPS7wIUTzVP
         klxZ6VI6nnErkb2f+B/jUZylC/c/Aq+B8Z38vBEU0TlHSK4wvAqR12UeEmrIcL3a5dHE
         WdltyzxWxKtBcOhMl2zaV6JgO4PKSAUnkKmH6B1HGGe41iezzP0OVh+KgQCs/tnz/UnG
         nQgrGyCLV1JmDpEXUSOFrY/B7pYg8e7JCaZMmfY4PS7Ma4VRcC9hEd5j5e9eJzZnkWtY
         W9KO+tJm+gpFTy/o1PLnHD8TP4GyXCc9lfa6f0lqbIJgepsJoYcxQFs24WuHTgRFnhCS
         viHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dkl0GaWgeqVQmFYobiRcFtfUz3ufHqhTS+/iP5/CmzY=;
        b=JQwkE7LfibY+l0XpxoX6rVo+7G2WLvdGVcgD1FUVhdi6FwsFr0mTU///Bed3eijlPn
         pPt+XdjObv0Dyi6LZnwXmwIqqbFyAZPAnQRGjUp6GY+QA/Mf0ASHzsYH9DazRlWVFUiA
         1WP53xsiNGpzrn5F+jOzO0TMZqXk9vO5HQS0UwuinXLo3i9cB05/+KUwhgCriUTbAUUx
         urBb0l3uNv6sNeq08F35Sfrfp/Pe9vOBxdk8JLzUrkEzkDU7nSzjjkPbXwbTLmHpOfCp
         1zljacHe9ysIBdba6Eg5PBV7AWvjHRj7+K0LLJDd+R9f7RO9W89FWqIXT7bpsiG+qKAK
         qOVA==
X-Gm-Message-State: ANoB5plGMO7wISAVFOl3tKcSuLfT8Xdx7Dxnoh+QwSecGTMpu/66bD4W
        wncv8HAjfDgmGbKlt34X9ms=
X-Google-Smtp-Source: AA0mqf6OusveNiyokREy9CpPUEzcYnrvTHBiSncuuqjcAmK6ab/MZsPZLAbESEuZEGGmnGGJ5ab0WQ==
X-Received: by 2002:a05:6402:28c9:b0:469:ba7c:bc75 with SMTP id ef9-20020a05640228c900b00469ba7cbc75mr1454416edb.286.1670271762323;
        Mon, 05 Dec 2022 12:22:42 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm6546663ejc.211.2022.12.05.12.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:22:42 -0800 (PST)
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
Subject: Re: [PATCH v2 01/12] MAINTAINERS: Match the sun20i family of Allwinner SoCs
Date:   Mon, 05 Dec 2022 21:22:40 +0100
Message-ID: <3201066.aeNJFYEL58@kista>
In-Reply-To: <20221125234656.47306-2-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-2-samuel@sholland.org>
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

Dne sobota, 26. november 2022 ob 00:46:45 CET je Samuel Holland napisal(a):
> Allwinner sunxi SoCs with a RISC-V CPU use the sun20i designator. Match
> that pattern in addition to the designators for 32 and 64-bit ARM SoCs.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


