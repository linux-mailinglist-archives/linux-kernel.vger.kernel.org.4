Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F973CAFA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFXNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFXNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:16:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480581FDF;
        Sat, 24 Jun 2023 06:16:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31297125334so1442226f8f.0;
        Sat, 24 Jun 2023 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687612612; x=1690204612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAPLdJ1hRBKYoDfC7BxuOkW8oX621hvqZ4G8PC6WVsc=;
        b=PH0n1FQU36Z0dHZzPpw68V3rlOsp7moXOEmfaBt3Wbhq8TqBVHJWT2PqEcFduHPw2b
         e8jze0QXE/vtzqa6M9HCgvp9TK5psbOBZ0x72hBRIwQZAbJ7eRs1Bw2udOznVh3/AdCd
         197AotubSzYP9d7b9++XatULfFDzyvw5rs6UO4nWiXCISgarNliSnlLoJwfNgB5lPyrY
         bz8R2pwk/HJLVZq1I6J01bZvQ28CP8hcsgf1o4+RiVCY957zfvLCaxZtjNg6uoPEBwLK
         7MwyExU4U1A1JjBWylSWEG8eZjK/zECNkmFH8n3aAyHy4O1QHGEPgZVcKI9TWwdLGEA2
         Lsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687612612; x=1690204612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAPLdJ1hRBKYoDfC7BxuOkW8oX621hvqZ4G8PC6WVsc=;
        b=lNDP+sN8+BBfN9ltbpJVXEWTQFwge0WWk1yHLndyMOBiO+ZGmpadclMUH7pjrXR6b6
         hcV9fUHoh9Y/nxDNAwQwfxTJczZ2IKW7P/csCf8cwlhuXPlcjnRHffsGutB9ejeT/67O
         eGKs/a7StEIZN3YQvcg4HrVYkLu72QUEXQUS2lgpNptk0UcUgH9kEH+L6F5RfPw3hOg5
         SLi8ebWTMieVHIktbFr68Z9mqCnN1DOoUH1tyO8bNjuAe11RFs9Bf3ktAb1pBc3sQTQX
         8HRa+OtE3JvhpDqALnaS6emO6hchUL3xG24fAVFW28vraxxiQ3uzDpIBPM+v4iGO8Zfb
         E1Ig==
X-Gm-Message-State: AC+VfDyyCB+VZyi9o3eqz1kj0GCNz2hP1hqVYp3fkEKpsnDJbJnIxN/5
        dbJpIuITMuLG/yUlISOG/HO62ePEOFYnRQ==
X-Google-Smtp-Source: ACHHUZ7P2aSXnvI92huJ7ELPjVwzFyP5E+B7pL/1YCe1HolDXBTc7AHjIzHzD9wkkH9ja9mRwcXpLg==
X-Received: by 2002:a05:6000:104d:b0:313:e740:4956 with SMTP id c13-20020a056000104d00b00313e7404956mr582260wrx.25.1687612612033;
        Sat, 24 Jun 2023 06:16:52 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003f9b0830107sm5107428wmh.41.2023.06.24.06.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 06:16:51 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Allwinner R329/D1/R528/T113s Dual/Quad SPI modes support
Date:   Sat, 24 Jun 2023 16:16:21 +0300
Message-Id: <20230624131632.2972546-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series extends the previous https://lore.kernel.org/all/20230510081121.3463710-1-bigunclemax@gmail.com
And adds support for Dual and Quad SPI modes for the listed SoCs.
Both modes have been tested on the T113s and should work on
other Allwinner's SoCs that have a similar SPI conttoller.
It may also work for previous SoCs that support Dual/Quad modes.
One of them are H6 and H616.

Maksim Kiselev (3):
  spi: sun6i: add quirk for dual and quad SPI modes support
  spi: sun6i: add dual and quad SPI modes support for R329/D1/R528/T113s
  riscv: dts: allwinner: d1: Add QSPI pins node for pinmux PC port

 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  7 +++++
 drivers/spi/spi-sun6i.c                       | 30 ++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.39.2

