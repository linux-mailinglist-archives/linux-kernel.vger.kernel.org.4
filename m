Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76456FD8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjEJILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjEJILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:11:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E222122;
        Wed, 10 May 2023 01:11:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f435658d23so9695595e9.3;
        Wed, 10 May 2023 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683706293; x=1686298293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kaQpRP2PJulxYaO5bFooRdj1QYIO1irnm40lBiyMQfA=;
        b=sGsXHOCDB1/G09BwgMcl3P9fyGYxgKy3Lg32VYzLCmWTMGjuN0Og+jZ0pYkjWmJ+5g
         Zne7CNel0vAodrw5NQr0bOgH68uTNzlfPNUgOZih9LMJX34lTXhuUPDGfgqtgSPuZorD
         V5zDRnIsfctWawQ3dOXE/g5ejxcI6zl/SJ4lDMuFRKal66KSfKiuSpbsz5O/jm8G2AiT
         W0IKm5IiAosack2KCtEDLu4JqSlUXwA83mrxWFPMLAczYSXHSov4urgeJwcOT57yeSpM
         K1N5nEUZrTC25G/ngzvFsXq5BWuj820aa+EmvpGlp//SWdi2RunF+IErZPV9Y51Z5ml0
         7Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706293; x=1686298293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaQpRP2PJulxYaO5bFooRdj1QYIO1irnm40lBiyMQfA=;
        b=SvDMl6mqqlE2for7dseuPfPFulDKEQZmI9SKFCLO6Xo5B+lA9dR+cO3vbvokDsaKyq
         /NoyLQp3zEwbEZWTAp20LnfUZggFJTK2rkVIm6soJWOrJi/eVIpfehNy7kBv0rqzv7/G
         G9X0QmW1YUwRfaA7UDZ8NKuzvBK4p79rYdVs7Lk8giF4sJJ+xgm/lQHqSgDhjsMCPU1B
         Vomw78qWndQzoZa4K+zErCIMi+n67zDJh4wNaHTxeF+UVJqERbALPh/2at9yk2TB/RtX
         CuPOjwA7wnXFuusjsmldG86O2VXHHwlHm5l59paepkFkZmf9E6v5v5/fzwPdJ8oEystg
         Ep3w==
X-Gm-Message-State: AC+VfDygYhi+LSvLKMP1KqWpa4q4F7HbUDGKtTvj9rVwVGp+X3ioOP2y
        Ku5QONn+sHxnRi+HBCQjidQ=
X-Google-Smtp-Source: ACHHUZ6nA8An0kWETX3sBghZaBOHEHWZkW9kJemfajv/KifLNkZtMoHeOoheAEpkUZYo+RyRDOmVEQ==
X-Received: by 2002:a7b:c356:0:b0:3f0:3c2:3fa4 with SMTP id l22-20020a7bc356000000b003f003c23fa4mr11776779wmj.12.1683706292779;
        Wed, 10 May 2023 01:11:32 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d4dd0000000b003062ad45243sm16496375wru.14.2023.05.10.01.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:11:32 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/5] Allwinner R329/D1/R528/T113s SPI support
Date:   Wed, 10 May 2023 11:11:07 +0300
Message-Id: <20230510081121.3463710-1-bigunclemax@gmail.com>
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

v5:
  - fixed DT bindings (Allowed three-string compatibility)

v4:
  - fixed SPI sample mode configuration
  - sorted DT bindings list

v3:
  - fixed effective_speed_hz setup and added SPI sample mode configuration
  - merged DT bindings for R329 and D1 SPI controllers
  - added SPI_DBI node to sunxi-d1s-t113.dtsi

v2:
  - added DT bindings and node for D1/T113s

Icenowy Zheng (1):
  spi: sun6i: change OF match data to a struct

Icenowy Zheng (1):
  spi: sun6i: change OF match data to a struct

Maksim Kiselev (4):
  dt-bindings: spi: sun6i: add DT bindings for Allwinner
    R329/D1/R528/T113s SPI
  spi: sun6i: add quirk for in-controller clock divider
  spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
  riscv: dts: allwinner: d1: Add SPI controllers node

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |  10 ++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  37 +++++
 drivers/spi/spi-sun6i.c                       | 131 ++++++++++++------
 3 files changed, 138 insertions(+), 40 deletions(-)

-- 
2.39.2

