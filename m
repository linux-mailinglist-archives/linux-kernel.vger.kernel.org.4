Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67166DBAEF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjDHMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDHMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:36:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68335CD;
        Sat,  8 Apr 2023 05:36:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a34e3526fso27545766b.3;
        Sat, 08 Apr 2023 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680957363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOWahdTnRG3Wj8yi+V6U+R9QIgRUu+TUuu4yKrmq1Po=;
        b=HZ6hA51qYqRkCOfrq5rl07wWJs6ZXodOnniOCbtg/CbbYj7+Cvt0H/2M7mWU6STdP6
         YOCr/NpmbIHfxI8gLFijenNJ04LxQ730dvOfjolF7mWWPKQXUTIfOcMcQ8Djt9ZaNlCK
         3q7IN9EcIndh/yIHLuDs4+yc5QTbEwwipGOCD/1O49JHGcjZDx1hiRG8lyW61fC0imq9
         HAfOFK9k3mx2rVUGqodOLjVeclsDfg2D7xqcLRNbvJDv3humib9EhZuqgkVPXTnqKT9H
         2thBmOmXK9xUVo2lVb+zmIWvxFP45GPo5CTKAeIY7J7yaNWWC7foDjqVPTsmipJ+Pn+s
         jrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680957363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOWahdTnRG3Wj8yi+V6U+R9QIgRUu+TUuu4yKrmq1Po=;
        b=gHF8pbEfX+cP2CUm0YB1Vkh4nvO1ZyyhjS0oT2iOR7qtmjK856XtUYMbdZHhfI2Mfv
         9XhwkYT3iZ+D8NgkPCwrSkVFZlP39T1yJqLB1oTBLwXDw3zzYoXRZZRdE8X+xuR85Ati
         /BAdVkMI/ZxSb7AVBVoZY8RNcE41MB0UH2Ss7z8w8PW1IyXwRAOMdeKjuN7JJnNq4Ch2
         ydY0SMiRujiX8uukCGQK3uwOkqpcpudywO8pH77+IEz6mvbgQLyona2PCUMYyCZmv/TH
         ijoVqeyQm8sGAz2Xu4/cVSt9C5xJpTciuAqouwlUr9NHnY5iy5vbk6YquZqRPlIIToc3
         wIVQ==
X-Gm-Message-State: AAQBX9dh+NPdF2jUxkmlk+DyLMUlsD1x/L1jNUwUcxlMDtyBZ6SLwe0v
        Qz0r6HQQ9Dz9Qf2ZkK4LRYs=
X-Google-Smtp-Source: AKy350Y1drrvxW3UM2vKy8JNJ5ywWt6Gxl4RwyNbLie7SrkT0Gou8ZfxNt9jwSJcq2xa5fyzHkUS/g==
X-Received: by 2002:a50:ee06:0:b0:502:2a76:5781 with SMTP id g6-20020a50ee06000000b005022a765781mr4928298eds.5.1680957362692;
        Sat, 08 Apr 2023 05:36:02 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id h2-20020a50c382000000b004ad601533a3sm2898806edf.55.2023.04.08.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 05:36:02 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 06/10] riscv: dts: allwinner: d1: Switch dma-names order for
 snps,dw-apb-uart nodes
Date:   Sat, 08 Apr 2023 14:36:00 +0200
Message-ID: <1945003.usQuhbGJ8B@jernej-laptop>
In-Reply-To: <20230321215624.78383-7-cristian.ciocaltea@collabora.com>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-7-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 21. marec 2023 ob 22:56:20 CEST je Cristian Ciocaltea napisal(a):
> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> dma-names properties") documented dma-names property to handle Allwinner
> D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
> reverse of what a bunch of different boards expect.
> 
> The initial proposed solution was to allow a flexible dma-names order in
> the binding, due to potential ABI breakage concerns after fixing the DTS
> files. But luckily the Allwinner boards are not affected, since they are
> using a shared DMA channel for rx and tx.
> 
> Hence, the first step in fixing the inconsistency was to change
> dma-names order in the binding to tx->rx.
> 
> Do the same for the snps,dw-apb-uart nodes in the DTS file.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Applied patches 2-6, thanks!

Best regards,
Jernej


