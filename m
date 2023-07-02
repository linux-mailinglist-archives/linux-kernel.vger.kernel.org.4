Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7774525E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGBUfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjGBUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:35:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DAEE56;
        Sun,  2 Jul 2023 13:34:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so1139871f8f.3;
        Sun, 02 Jul 2023 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688330095; x=1690922095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urzo+tFsGAkOnz5ecpB6iDl1xPRU1BRxrnQ2HFHQvFc=;
        b=JzpxMDAE4UcE4qgKpe2qIYa1+chuZrFCRU5IBISMlKC+1W5ZrRnTTJtoWOhZPEWjE9
         P0DG8/CQ4j8Ufs9qfrVLSY4zr7NrFnk6Qosqy8NxOCFg707x3R5WyAqWo2zE4NCAbWig
         SReNgwntctr7AaU1AiUNleX6xt0G/S0OQ1kXb5qFn8qk1SqDuNwh4HhRAVGqmFmWZsjM
         6VLRcowSvOLGLgfSGWzZ3rlAzkmQ+vZynmeC1ceyDimJfuOW/DQGb4q9lPbGPVl6ugMR
         N/JgfMbzQV1ZJob2PK/kRlxrzoa/OJtEUzVg0lsHRctldfKLmKQdicP344vj6D4OYyXg
         bU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688330095; x=1690922095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urzo+tFsGAkOnz5ecpB6iDl1xPRU1BRxrnQ2HFHQvFc=;
        b=C2Qyz+6t382NWfYKtp0bbRp19HH7sayonoTUk+ppSoIGi0mByj9nWMu4E/wXGUYEv0
         TYqwEnNRkSz6UK2PbWHabtqX8qPYRLl6OrgKVpTbNAy830xLYOWgQmvI1sURogQAG+nZ
         f8BQG4uiTikvKKzlRJBhHIV3HdIGyX6i/kyujg9aiFe3mChDBnzNv9PYRsHSGgEZycDV
         XqgaltEch1KJtjyHDq2CM5IeLxZD/cbNYb4rYO6ZYsyHuCY/d6as8IhgYy52WeRK1Ob4
         XtvuPxakcwv6JlKWki95XY3khbDPxadoebJy4kqeAIicQryS9SJXyT/4tk3BwP4KYlf1
         Kalw==
X-Gm-Message-State: ABy/qLZm2auINwSQg9guab/OLExv9ct6UHLuHxWemKC4ajqEvIflTfyq
        I3zGkr4TbB/S/zMzdHfV9N0=
X-Google-Smtp-Source: APBJJlElm9XqeQdO3+GTDFDpJLzuHY/UR2rcUieG+OuqysMrqplFSVn/oZ4mIw5L5cVrvaghmfyvnw==
X-Received: by 2002:adf:f504:0:b0:30f:be04:5b5e with SMTP id q4-20020adff504000000b0030fbe045b5emr6227046wro.37.1688330095191;
        Sun, 02 Jul 2023 13:34:55 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b4ae:ae48:2e1b:1dcd])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm24000478wrv.74.2023.07.02.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:34:54 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v10 6/6] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
Date:   Sun,  2 Jul 2023 21:34:29 +0100
Message-Id: <20230702203429.237615-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Explicitly select the required Cache management and Errata configs
required for the RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v9 -> v10
* No change

v8 -> v9
* No change

v7 -> v8
* Included RB tag from Geert

v6 -> v7
* Included RB tag from Conor

v5 -> v6
* New patch
---
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index de31589ed054..67604f24973e 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -334,6 +334,10 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	select ARCH_RZG2L
+	select AX45MP_L2_CACHE
+	select DMA_GLOBAL_POOL
+	select ERRATA_ANDES
+	select ERRATA_ANDES_CMO
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
-- 
2.34.1

