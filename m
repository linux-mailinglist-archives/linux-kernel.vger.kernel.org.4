Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CAF706653
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjEQLOb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEQLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:28 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1F197;
        Wed, 17 May 2023 04:14:27 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ba8253f635cso807896276.0;
        Wed, 17 May 2023 04:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322066; x=1686914066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVBIz6rSwiHp26lFXXNQ629YWWG9GU5r7sKV57I7n4Q=;
        b=AzGuKNthPYcqqKMl44MvO5s74gdNod1LPP3ckziOGqeQz+puSxGOGLidahOI6ZmU0g
         DHIqRTKmFsQ8nOA9X9kl7EvcNng+vtq8xQ22TUirwfOAiYh7W/LC/TFCrL4K8we6PZ5v
         gEjWs18lOL7pkIqhX+gbI1pu43kIgScKftFvVtJ5zkXOzykSiUmucPMtIIFZawiClNnK
         8eng/ZEYamAjiNpmqoBcJ89HrfjqmdxzVpLhqS6E5weDkLlZbE2/Rj59anmQBNtXbsSP
         Y5xHLYAPRzGhgC1rYHZVImG/PBx6c0s6LAKhy35h9JEzdr3QmqHiUHlo1n5X0apM1Pds
         hufw==
X-Gm-Message-State: AC+VfDyOd5jyengiJkA5yXgcaXPCcGVW2aY4JpJ0aolO4tjGlhn0uCuX
        WG6anPO5btdoWfQB4JL20gdo7kDMvaaPyA==
X-Google-Smtp-Source: ACHHUZ4RuvOCRc0A5+n0i/h8HuUD8evNweuEFJ3zZDqGmnRFAmQzoBBOlfj9D6X7mBd5gbc+OgnOkw==
X-Received: by 2002:a25:ae05:0:b0:ba8:7da5:da46 with SMTP id a5-20020a25ae05000000b00ba87da5da46mr190924ybj.40.1684322066583;
        Wed, 17 May 2023 04:14:26 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k13-20020a258c0d000000b00ba012dbdf0asm482494ybl.3.2023.05.17.04.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 04:14:26 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ba8253f635cso807881276.0;
        Wed, 17 May 2023 04:14:26 -0700 (PDT)
X-Received: by 2002:a25:558:0:b0:ba8:27ff:b2b5 with SMTP id
 85-20020a250558000000b00ba827ffb2b5mr4015501ybf.26.1684322066059; Wed, 17 May
 2023 04:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230515181606.65953-1-blarson@amd.com> <20230515181606.65953-9-blarson@amd.com>
 <BN7PR12MB2802CE1DBDB6ED8413AECD53DC799@BN7PR12MB2802.namprd12.prod.outlook.com>
 <168e9039-feb0-0f4c-8aee-96a3bae7faca@amd.com>
In-Reply-To: <168e9039-feb0-0f4c-8aee-96a3bae7faca@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 May 2023 13:14:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLOTn7HfoWR7mGrKXvZxiciGseOBYbV7bYqUuGJcr=yg@mail.gmail.com>
Message-ID: <CAMuHMdVLOTn7HfoWR7mGrKXvZxiciGseOBYbV7bYqUuGJcr=yg@mail.gmail.com>
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
To:     Michal Simek <michal.simek@amd.com>
Cc:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "Larson, Bradley" <Bradley.Larson@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brendan.higgins@linux.dev" <brendan.higgins@linux.dev>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "hal.feng@starfivetech.com" <hal.feng@starfivetech.com>,
        "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>,
        "j.neuschaefer@gmx.net" <j.neuschaefer@gmx.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vaishnav.a@ti.com" <vaishnav.a@ti.com>,
        "walker.chen@starfivetech.com" <walker.chen@starfivetech.com>,
        "will@kernel.org" <will@kernel.org>,
        "zhuyinbo@loongson.cn" <zhuyinbo@loongson.cn>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, May 16, 2023 at 9:42 AM Michal Simek <michal.simek@amd.com> wrote:
> Also in DT patches I have seen that you didn't switch to 2023 year yet.

If no substantial changes were made in 2023, there is no need nor
desire to update the copyright year.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
