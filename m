Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8464A68D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiLLSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiLLSIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF121A4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso10100988wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsnaVNQZa+bH87IGKD3eNLndnfCgVPoadhiR+NchvNE=;
        b=MT58fo+ATFwyk3UB1TFDLScBKvBdngb9oD90Zf8vqqvtOuqyd99P5DB/6HSLC/k1FK
         s8e5ZSr2YOf2rZpDKdRtmujoDYCTHOQmKo3x4IUb+RGcv1OKXogUN0uosW1tbZ77FIvM
         A3rL97Yu2DvehEAOBsg6ajZcxFsAIl/vJf7ax9MBPYkl6Wb9FVLSBHZeFTXJJfjjRIge
         dJgSkpAAiD0F+k4D5eNxeMKWlsYbeHcHyOZDjCGuyG+98ahJ6AApDER7xde9xo1jVGbG
         HHlDmO9vnVgR882LgOKyeYzuqrVBJNXudtHhYAqyp39K10HQRCrg9l3X1qMdFYXG7gA/
         kHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsnaVNQZa+bH87IGKD3eNLndnfCgVPoadhiR+NchvNE=;
        b=HGQpLJQVqKb6nt9cqmiZBLmjqz7XMmZG2nrkNnB9AjGHqSRbO3InQhq3kQp1gtEV9h
         rQ5mV5+hBANhDIL+Ks3iIIg5UIr7efWtLmQ0FFbgg9nKH8t/hTfts9BAJx/+iQl3QnDg
         LPQQfv1Vh9pksXcfogZApHJ6pdFfg91VurX4XxspwrbhUPNK9+zam14M/717dFdomTv6
         SOgKnmJDJ1xKUe4mmsco4MYQwY4xLdOl4RC80x98jTMOiHek1jaS7yToA5IwZ9LLjZIh
         VXzCAmujMjnKNIcv2w/aWfegs4zNvzZ9iXRY2h6qHixn0ISotsVQUYrJFzyGrnbRStYQ
         4QTA==
X-Gm-Message-State: ANoB5pmWAAAEjvy8Yc94ZKpYkVG9u8DD0zf4+up6oEN2+uvHbezuZNoj
        qnrTv0CCTMWGh7yBT4NXIkUIEQ==
X-Google-Smtp-Source: AA0mqf5PnTDqvX0IOnkaB4yW9YsKVl/w+0U3ILEYH/VWAetLNkr+dG+H1b5iE3e9mPj0f87dcdIZhg==
X-Received: by 2002:a05:600c:1c21:b0:3d0:6ef9:9f2c with SMTP id j33-20020a05600c1c2100b003d06ef99f2cmr13333276wms.16.1670868461400;
        Mon, 12 Dec 2022 10:07:41 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:40 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 00/15] Add support for enhanced SPI for Designware SPI controllers
Date:   Mon, 12 Dec 2022 18:07:17 +0000
Message-Id: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is v2 of the patch series adding enhanced SPI support. Some Synopsys SSI
controllers support enhanced SPI which includes Dual mode, Quad mode and
Octal mode. DWC_ssi includes clock stretching feature in enhanced SPI modes
which can be used to prevent FIFO underflow and overflow conditions while
transmitting or receiving the data respectively.

This is almost a complete rework based on the review from Serge.


-- 
Regards
Sudip

Sudip Mukherjee (15):
  spi: dw: Introduce spi_frf and STD_SPI
  spi: dw: update NDF while using enhanced spi mode
  spi: dw: update SPI_CTRLR0 register
  spi: dw: add check for support of enhanced spi
  spi: dw: Introduce enhanced mem_op
  spi: dw: Introduce dual/quad/octal spi
  spi: dw: send cmd and addr to start the spi transfer
  spi: dw: update irq setup to use multiple handler
  spi: dw: use irq handler for enhanced spi
  spi: dw: Calculate Receive FIFO Threshold Level
  spi: dw: adjust size of mem_op
  spi: dw: Add retry for enhanced spi mode
  spi: dw: detect enhanced spi mode
  spi: dt-bindings: snps,dw-ahb-ssi: Add generic dw-ahb-ssi version
  spi: dw: initialize dwc-ssi controller

 .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
 drivers/spi/spi-dw-core.c                     | 347 +++++++++++++++++-
 drivers/spi/spi-dw-mmio.c                     |   1 +
 drivers/spi/spi-dw.h                          |  27 ++
 4 files changed, 364 insertions(+), 12 deletions(-)

-- 
2.30.2

