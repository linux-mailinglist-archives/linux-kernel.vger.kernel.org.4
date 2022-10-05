Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB73E5F5477
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJEMa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJEMaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:30:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209A25E8C;
        Wed,  5 Oct 2022 05:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BDD5CE12FA;
        Wed,  5 Oct 2022 12:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00E2C433D7;
        Wed,  5 Oct 2022 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664973048;
        bh=MUH/5Nr9NH5nKvpp0g6W1q0YMvqiwhZO2hEEaGu7mjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uNkQZys6eTVye1mUdQlmmPlOzfcPR4HVn4+cBENggnv0hjY/R7ncfpjGyssN4t7u8
         WyaJfbsbSONZ2w6dut04UzBU0rH7Gn2fAz1bkhWqMEg46XGLTruf4qerOC7A3wL30x
         khjyz5RvzQv/QfzwqN5AY3MOZOsEMICr0XTM7isnK2VSaZQ4nvG7x8uZOn8o5AoUL0
         pse87rtFEj08C3l2ZgjOtQlXsF7uKe4/vPMMupSJO4Ee4ZfHEaDM2CHGr2LeTdHSqO
         CsjHkDbQ0la+igFccgmQTJ4hVhhh0wIo5URoSih3Mt8J1L0qzpxPIiD6c9WHWLnHno
         Lw4pIiRn2pptw==
Received: by mail-ej1-f49.google.com with SMTP id kg6so19777019ejc.9;
        Wed, 05 Oct 2022 05:30:48 -0700 (PDT)
X-Gm-Message-State: ACrzQf1OyarxO8lzeZ4ZwAIwxKx1UgUIc40qYEmdQXWsfdkgsYK/Na5G
        sD9xrgiNQbZTrvDabwIfa50GCEdsaUtse853C+M=
X-Google-Smtp-Source: AMsMyM5L8hCj4bFlWh0VlM5kabk6auuvY8ux7t4b2Vc2ydVwZHKt3XLpUTraCw25wFlUiOkTFbotGZGrl8iYa+Ajy/Y=
X-Received: by 2002:a17:907:a05a:b0:78d:225c:bbc3 with SMTP id
 gz26-20020a170907a05a00b0078d225cbbc3mr4319639ejc.224.1664973047171; Wed, 05
 Oct 2022 05:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <Yz1t6rPLOzKT8Id+@debian>
In-Reply-To: <Yz1t6rPLOzKT8Id+@debian>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 5 Oct 2022 20:30:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7FoDEEtqF_ZOwTGPeGK-4wpzsxEqvO+iuq=KpEuDUofQ@mail.gmail.com>
Message-ID: <CAAhV-H7FoDEEtqF_ZOwTGPeGK-4wpzsxEqvO+iuq=KpEuDUofQ@mail.gmail.com>
Subject: Re: build failure of next-20221005 due to 4078ec1ef5ed ("LoongArch:
 Use TLB for ioremap()")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sudip,

This seems a false positive. When the implementation of iounmap() is
empty (but this is completely legal I think), these drivers will cause
"unused variable error".

Huacai

On Wed, Oct 5, 2022 at 7:43 PM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The builds of loongarch allmodconfig have failed to build next-20221005
> with errors
>
> sound/soc/mediatek/common/mtk-btcvsd.c: In function 'mtk_btcvsd_snd_remove':
> sound/soc/mediatek/common/mtk-btcvsd.c:1394:32: error: unused variable 'btcvsd' [-Werror=unused-variable]
>  1394 |         struct mtk_btcvsd_snd *btcvsd = dev_get_drvdata(&pdev->dev);
>       |                                ^~~~~~
>
>
> sound/soc/sof/intel/hda.c: In function 'hda_dsp_remove':
> sound/soc/sof/intel/hda.c:1185:26: error: unused variable 'bus' [-Werror=unused-variable]
>  1185 |         struct hdac_bus *bus = sof_to_bus(sdev);
>       |                          ^~~
>
>
> drivers/mfd/asic3.c: In function 'asic3_mfd_remove':
> drivers/mfd/asic3.c:940:23: error: unused variable 'asic' [-Werror=unused-variable]
>   940 |         struct asic3 *asic = platform_get_drvdata(pdev);
>       |                       ^~~~
>
>
> drivers/gpu/drm/exynos/exynos7_drm_decon.c: In function 'decon_remove':
> drivers/gpu/drm/exynos/exynos7_drm_decon.c:771:31: error: unused variable 'ctx' [-Werror=unused-variable]
>   771 |         struct decon_context *ctx = dev_get_drvdata(&pdev->dev);
>       |
>
>
> git bisect pointed to 4078ec1ef5ed ("LoongArch: Use TLB for ioremap()")
>
> I will be happy to test any patch or provide any extra log if needed.
>
>
> --
> Regards
> Sudip
>
