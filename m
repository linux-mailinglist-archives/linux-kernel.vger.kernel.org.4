Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BCD6DC033
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDINyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDINyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:54:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F43D3AAE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:54:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jw24so18423443ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681048440; x=1683640440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB9lCsnyj/fv7L0Qosd8AJfMlTik5ODV7VRxF/PVBcs=;
        b=ESoZyKZoFG2EPF5YMZ3oNkj5UzXFSYWo5FqHFQZSTdCZkRktB9PVXDheNY6P6HdnoE
         SdErYcJpzsx/DeRghx+9uPg7X+aPtxU7Zr1F7rzG9wVkdtureXIJQU378hX8ublD+OMe
         IFnQ/S/uYAvdPSe7wdRMMhvM0JompFL1KJjPt1kkvf2S7CdoqXr5I6cSpSqyL4sA6H2W
         fvtjUdDx2y5ZINxXD4GsteIxYv5P+604ylvARfWqawoIgVcS6Cdnlcm1nQH85FiLQ/Gs
         dFG31Pbg9hiwXApJBZWaT8RYlpGehssPn5wTcahQrGTvqlVof2joVMvp6yKWJqCugVyA
         JicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681048440; x=1683640440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB9lCsnyj/fv7L0Qosd8AJfMlTik5ODV7VRxF/PVBcs=;
        b=HRJzgQo+jldxJjR3uyrzFCwe708E554zhetP13JHA+3oxvEJyfz7vd9+PN2ildeT8c
         VuJGX0qJ0IDTPhcJgww80aXYCAYHZSiDNpSneNV639BHPig4/fZJTQMTOwNVWmubmdQ8
         Q4Mk+tADMpFbhBksP3VW0UxY3VQidJP9/FQNyGox6Ge1s9B5w+9Vpb/ljOCia2wCi5Zd
         RMRQe8mdITzbrAzYRTjkXxmgvaw8tgjZvcZe7RdrrGOVa/hp2ucYrOlUccv5XWqNwQQo
         FCE6BS3JWODiS0j9ffWghoE2RNXBn6vlsBHQAYPrfaxMrvSY9V/NBPRsfAhuTnyfBi5w
         Qolg==
X-Gm-Message-State: AAQBX9ckcb2y7ijnRpIjlxhNU5n44GouxOCPD0dLuUzV8nt7ZK7CILRE
        JjqjC0jSgTp+NRiFdonoerzy6w==
X-Google-Smtp-Source: AKy350Y4hyaFvX1ykWjokdiYB6CAdry15+gdGSTQ2WkgaX3R6TpXHUC6cxCMCtmPmG9Q2xsjX8Comw==
X-Received: by 2002:a17:906:4dd9:b0:8e6:266c:d195 with SMTP id f25-20020a1709064dd900b008e6266cd195mr5492930ejw.38.1681048440695;
        Sun, 09 Apr 2023 06:54:00 -0700 (PDT)
Received: from localhost.localdomain ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009476efd5244sm4202643ejc.172.2023.04.09.06.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:54:00 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 0/7] clk: imx: imx93: fix and update
Date:   Sun,  9 Apr 2023 16:53:39 +0300
Message-Id: <168104831086.1290263.186281171098530599.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 17:52:53 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V3:
>  Update dt-bindings patch subject to match subsystem
> 
> V2:
>  Separate the dt-binding clock header into patch 6
>  Address kernel test robot build warning in patch 3
>  Order the patches
> 
> [...]

Applied, thanks!

[1/7] clk: imx: fracn-gppll: fix the rate table
      commit: cf8dccfedce848f67eaa42e8839305d028319161
[2/7] clk: imx: fracn-gppll: disable hardware select control
      commit: 4435467b15b069e5a6f50ca9a9260e86b74dbc13
[3/7] clk: imx: fracn-gppll: support integer pll
      commit: 56b8d0bf3ea8b0db8543e04a6b97348a543405ab
[4/7] clk: imx: fracn-gppll: Add 300MHz freq support for imx9
      commit: e040897111a12b7647b8f758336b2f14991e9371
[5/7] clk: imx: imx93: add mcore_booted module paratemter
      commit: a740d7350ff77ce1ebbdc3b9c548dd3bcaf39b31
[6/7] dt-bindings: clock: imx93: add NIC, A55 and ARM PLL CLK
      commit: 5fd7b00ca2361c81f2026f82dff93e52afd97a0b
[7/7] clk: imx: imx93: Add nic and A55 clk
      commit: 6b60c3ae3e98d036945f2d5c11d35b4c178ea423

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
