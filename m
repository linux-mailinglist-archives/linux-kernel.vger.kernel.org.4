Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4666B6FE5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjEJVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjEJVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:00:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26ECA;
        Wed, 10 May 2023 13:59:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9660af2499dso1116906266b.0;
        Wed, 10 May 2023 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683752385; x=1686344385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7iiVpNS2TbezgmpT9ZKv1CtTBR6JW8urFYOpMbLQIE=;
        b=Ve84bY8EFJx6v5kYiXJIW4l38TbjweukQ9WPJ6EbKvaOLLh081oFWKHsluTDupOCmg
         EgQ2VgSu1zl+F5zx/otyUBmafq657FY6qzHR/gAXtygP1fxPk7pW/RnQSI5wFSPnZFww
         6RmKXFADFOlhsqW9PTuM++FK0p9pu7tusMpanqQTRHMNjv+Dy1GL9aZud/QcI+dsFCnQ
         vQCa0EYiDIPqjztsz31dqgLbRnBBGZwwXX/NitSrvpYh3Q6U75nBzB9X6SqeNPZUp5Gv
         bZbHAXNCNx3VUDFbS4roIkGZCwnZGai/7bkWX2JlW+XPd9KR3JjArqQIkml0W+1MR9Vj
         WvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683752385; x=1686344385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7iiVpNS2TbezgmpT9ZKv1CtTBR6JW8urFYOpMbLQIE=;
        b=AZ3hv6RypA3US+s1HHGb02iQP5XdT2vppzMpaom9pMvzx/x1/Ad3AX6rQkq/V/V2l4
         bvwmHNomaLJslWyxlbGAGshoPmlSGej2LvC+Wp98vktsbSE9+WOoYQ1ug/RN3AgQsGTR
         9t1R7CIYw95NW31XqEI//pMtDlP6Y/lotwS3Ts0QplSeEUnZ6dZxfWdDAQBOCD8zjnzt
         80pkGxLSYwqUGyqn3Vl2xH2NJ/stIQbbtARPN6JZ9Z2x42P9GT1sfVzkOjixYD9pErbs
         iq982efLe7cN31DeodxidgY5rPLGWk5SD1VPZZeGO4nvycX2b33rxsDIBcZcCZQNHZ29
         jOSQ==
X-Gm-Message-State: AC+VfDyVgLyH0m7ID9OZIqBPIfbgbfySjX+048u/Q2/AptdXl4tFKznR
        Phf6cfvWU9SiMr3Kxw8v6/M=
X-Google-Smtp-Source: ACHHUZ6672faX07heGWs3B0PV7ZJkqYGuQNoX8YzdTu1PeXrQ3hCuaiW5DPyaliV7S7XcyE3AyDzgA==
X-Received: by 2002:a17:907:94d3:b0:96a:58a:6cd8 with SMTP id dn19-20020a17090794d300b0096a058a6cd8mr6734541ejc.9.1683752384784;
        Wed, 10 May 2023 13:59:44 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090653cf00b0094ebc041e20sm3072028ejo.46.2023.05.10.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:59:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 5/5] riscv: dts: allwinner: d1: Add SPI controllers node
Date:   Wed, 10 May 2023 22:59:42 +0200
Message-ID: <1932306.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20230510081121.3463710-6-bigunclemax@gmail.com>
References: <20230510081121.3463710-1-bigunclemax@gmail.com>
 <20230510081121.3463710-6-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 10:11:12 CEST je Maksim Kiselev napisal(a):
> Some boards form the MangoPi family (MQ\MQ-Dual\MQ-R) may have
> an optional SPI flash that connects to the SPI0 controller.
> 
> This controller is the same for R329/D1/R528/T113s SoCs and
> should be supported by the sun50i-r329-spi driver.
> 
> So let's add its DT nodes.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


