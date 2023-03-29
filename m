Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF58E6CEEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjC2QHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjC2QGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:06:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E665BE;
        Wed, 29 Mar 2023 09:06:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so65316238edb.13;
        Wed, 29 Mar 2023 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680105931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXQRlBCYnqGo9Fi48YDM5Iz/n3EKV6wgfQDls4v49ZQ=;
        b=ZP8azEYR3T/kmocgq8bSZlNTouSdAv0pqNbONNvK6pjIOYfvW0EWRaDVO44E5sowbA
         4MGZKJiXz7VE108ciJQNXn5/hHquTqMqhb6tRaq9zC55es7aV4eyXx5sWcvFrwBw8u31
         DcptBNfTU6x5mTKuHF7vCiSdOphP7f1dZ5xyT7jA8pE036EK0r7Mwyj+wpf0qOtr4/dO
         PtsdhtBZV/jUZWdd6KSP5EkVxa9qFL2fQNK4V/Imeno6KN+BWXvR2ysex446RXd1SjcJ
         RuPjjhn8s3ln2xq7NpQb+o1cGn+mn2pwwyW/FTHZVbW4BbukRommLkvptqsBpXQc4gTR
         WTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXQRlBCYnqGo9Fi48YDM5Iz/n3EKV6wgfQDls4v49ZQ=;
        b=Bbh9UL2Re6XbSbaYcMh3fAwCaCC1EP33Yp8IXh7/JfAGGVEqF3VQQoEAVXKAdKsq3V
         /rWzdv9nDVKZXSsueEXewWP1uS/3EohRrzfjgFrmKcvbwtoquM3ggKo8YWDfvkQFkmfj
         nvSFp4JxMgKklXpPaw/rhFFPonVbP2DTarrC3UgQuDaxieh/DGpYs2hFJh/jOjkaZ0gW
         JY6FfdUxs0gj0kIysxHYoasIE6vKyeB8BJyEp8oWpdJa8iPdjcrUuRJALNKemtck2ALM
         7QJHaxYiUYAFXsGFIgDL7SQK8stCdT0WdOzkm23414I8VsQPZhy1tnkJJW1ZME4PrIg8
         eedw==
X-Gm-Message-State: AAQBX9fezxGL/+NnpystWuV1EgrAhMw9/cNKlAir6oDjKlGpOwm71qz0
        wMPhanEUiNvMNJuyWrzKxzw=
X-Google-Smtp-Source: AKy350Y0SxvEseTuQQeEwplPrjnDboy+i5rUViT0BUXK5Dv5qulkowom3JNTJJ/XP46pJIz4L/hzEA==
X-Received: by 2002:a17:906:f1c7:b0:933:c474:420b with SMTP id gx7-20020a170906f1c700b00933c474420bmr20841888ejb.19.1680105930843;
        Wed, 29 Mar 2023 09:05:30 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906079300b00932ed432475sm15417251ejc.124.2023.03.29.09.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:05:30 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 15/19] cpufreq: sun50i: Add explicit include for cpu.h
Date:   Wed, 29 Mar 2023 18:05:27 +0200
Message-ID: <2672894.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-15-581e2605fe47@kernel.org>
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
 <20230329-dt-cpu-header-cleanups-v1-15-581e2605fe47@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 29. marec 2023 ob 17:52:12 CEST je Rob Herring napisal(a):
> Removing the include of cpu.h from of_device.h causes an error:
>=20
> drivers/cpufreq/sun50i-cpufreq-nvmem.c:42:19: error: implicit declaration=
 of
> function =E2=80=98get_cpu_device=E2=80=99; did you mean =E2=80=98get_devi=
ce=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>=20
> As of_device.h is not otherwise needed, it can be replaced with of.h
> (also implicitly included).
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


