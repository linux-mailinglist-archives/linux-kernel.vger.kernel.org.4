Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25CA6DE035
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDKP7W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjDKP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:59:19 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB8F9;
        Tue, 11 Apr 2023 08:59:10 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id sh8so21568744ejc.10;
        Tue, 11 Apr 2023 08:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681228749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+t+hSLymjtcl9tDYP+77CnMcRbQzN7gTbEgZPOkpgNo=;
        b=eJ/PIU//IcsWj32g+XcGXJ4OcrjnsnjsGUGPqs2uZsAIXaq9iOp0s7qchxxDH39dy2
         oP0FXrGlFCnEq6XM9pkY0Y+A+SFZfgQ/YoV/j3MpcWfwSMm/a0J2XjGmeVRHevnehikH
         CqbdnMv2Czw3Os59fatiftCiXtnv9gQMdft/AOsg0Ppb6ISlbmR523328hs9aDUc0TEt
         LtT4SOC9SEFuaVBMpvf0w3/aE5o6a7zNtgdImKwzb1zGd02f+/Lx70LyKrRWSRzWtsPp
         q1McPGq7zWhchHu7T+3NUdzWlxlqFmFuamyWuDTDi3n9c59hDUONNLTH/Fx3q6zWSKDU
         Ws7w==
X-Gm-Message-State: AAQBX9d3Yuv33NqlntxUndYoR8fNIw8Pk4YpIC7HP+y913Y2vIdw+909
        jMdBnAenON7weO/RAtPHkAaONd8dM+7umj9koyM=
X-Google-Smtp-Source: AKy350bNaptOkAI1KLdu2T1meyD/APPTK9ZKzELBXmDXzLaPX7iTDs2GdfkgJS/ZGwOadRpz+hvMivBZgH9t1VCwwCU=
X-Received: by 2002:a17:907:8a0e:b0:94e:7ce:4d1f with SMTP id
 sc14-20020a1709078a0e00b0094e07ce4d1fmr1675049ejc.2.1681228748909; Tue, 11
 Apr 2023 08:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
In-Reply-To: <20230411083257.16155-1-mason.huo@starfivetech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 17:58:57 +0200
Message-ID: <CAJZ5v0j_MCv6e08qYKMhiZ2kKzovO+W4scMAKUokNJvt2myS-A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add JH7110 cpufreq support
To:     Mason Huo <mason.huo@starfivetech.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:33 AM Mason Huo <mason.huo@starfivetech.com> wrote:
>
> The StarFive JH7110 SoC has four RISC-V cores,
> and it supports up to 4 cpu frequency loads.
>
> This patchset adds the compatible strings into the allowlist
> for supporting the generic cpufreq driver on JH7110 SoC.
> Also, it enables the axp15060 pmic for the cpu power source.
>
> The series has been tested on the VisionFive 2 boards which
> are equipped with JH7110 SoC and axp15060 pmic.
>
>
> This patchset is based on v6.3-rc4 with these patches applied:
> [1] ("Basic clock, reset & device tree support for StarFive JH7110 RISC-V SoC")
>     https://lore.kernel.org/all/20230401111934.130844-1-hal.feng@starfivetech.com/
> [2] ("Add X-Powers AXP15060 PMIC support")
>     https://lore.kernel.org/all/TY3P286MB2611A814E580C96DC6F187B798969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/
>
> Mason Huo (3):
>   riscv: dts: starfive: Enable axp15060 pmic for cpufreq
>   cpufreq: dt-platdev: Add JH7110 SOC to the allowlist
>   riscv: dts: starfive: Add cpu scaling for JH7110 SoC
>
>  .../jh7110-starfive-visionfive-2.dtsi         | 40 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 25 ++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c          |  1 +
>  3 files changed, 66 insertions(+)

Viresh, can you have a look at this, please?

It is very similar to the ARM thing AFAICS.
