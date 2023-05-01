Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAC16F2FCC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjEAJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjEAJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 05:15:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DFB19A
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 02:15:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f4b911570so380534966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682932555; x=1685524555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YtmvOeilmhVHyd1dQuCvNsFKggHZjbxbr+S8ElJIO7Q=;
        b=SNzA8ELtFQE/fEVJamckwgqlIBHWBjj2fQELsmCqG7ACxRaigRSVHxZjobxxK1dUFT
         lGJzLBwGYckD+3W6toIa6Q2klJY421zqELONjupLq688j2fCiVzL62MsJddpC52wbZdD
         qD0bWYfaF3oZw29NhPZy86rb+6UkIh2S5BKLhZNtGIa7JTT1ZuRgzago9yAxNTlgCz20
         9Q3h9W5uDPOtzR5rfZaG0vmPbIWeLABaaB1dZsmOZ8f081hQ4QXeMlcnhuLSrb9+ITNn
         crcwNBXN+/1C2cQCAeMzlEnilV7wEBS7hzaj9KX37lf5O5gQ8Vb7v3/QCfyUnQvCF96I
         bUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682932555; x=1685524555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtmvOeilmhVHyd1dQuCvNsFKggHZjbxbr+S8ElJIO7Q=;
        b=Yjjmmh6P36522VMZe41odahChtVr0/JjuDSFoCT+bSKbCkan16omM8n+9xMfjUqJ+c
         qgK5KjoL0Oib/YlssU9fZqe7iXbqookNTvtKXc1Zvfcjviq05tqYJwoE2YyOt0XfAHKx
         UHy5uBJ538BiMA/CiHsu1EqruPQgo3/8HImjAGSh3tK8S6EIztUenwr0xzuo77bfzKWh
         xZcr4RMMGYxrvxzoQ8Lt9c389EMUYe/6xBrNvsyzVdprv9OMghXnBT1GshNjKHjmBY34
         g0WhNCt9NC7J5vXfOLJnIanj1Lwa+9DBRptVKMg+CSkT4qIX20PFYkIzPOEeNGTFSznT
         q1Dw==
X-Gm-Message-State: AC+VfDwDZOCQU+t9uTo7iaDqOrI/petOpR5RprHa7ezcycCRMq3P4Ru3
        SG3bTh4wlC1GKiV0jEk6Nr6Mm95lvR+1giKcoC0=
X-Google-Smtp-Source: ACHHUZ5717sV/DZ7A8+jLhKvnIMN5FTVduFXroDj89mvIVk1v2SZO7huNxeGAZcPck+5ZROAGryXJA==
X-Received: by 2002:a17:907:a40d:b0:878:545b:e540 with SMTP id sg13-20020a170907a40d00b00878545be540mr10783737ejc.51.1682932555146;
        Mon, 01 May 2023 02:15:55 -0700 (PDT)
Received: from fedora.. (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id xa3-20020a170907b9c300b0094e954fd015sm14714266ejc.175.2023.05.01.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 02:15:54 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 0/4] Add support for Maxim MAX735x/MAX736x variants
Date:   Mon,  1 May 2023 11:15:47 +0200
Message-Id: <20230501091552.847240-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v14:
- Added comment for interrupt support

v13:
- Fix dt-binding
- Fixed nits

v12:
- Add separate patch correcting interrupt support in dt-binding
- Fix typo in commit message
- Make vdd-supply non optional

v11:
- Fix dt-binding example

v10:
- Small updates to dt-bindings
- Make vdd-supply optional
- Drop MAX7357 enhanced mode configuration

v9:
- Fix 'then' not aligned with 'if' in dt-bindings
- Split enhanced mode configuration into separate patch
- Add MAX7357/MAX7358 register definitions
- Rename config register defines
- Update comments and explain non default config being applied on MAX7357
- Check for I2C_FUNC_SMBUS_WRITE_BYTE_DATA functionality

v8:
- Move allOf in dt-binding and use double negation

v7:
- Reworked the commit message, comments and renamed a struct
  field. No functional change.

v6:
- Fix typo in dt-bindings

v5:
- Remove optional and make vdd-supply mandatory

v4:
- Add missing maxitems dt-bindings property

v3:
- Merge dt-bindings into i2c-mux-pca954x.yaml

v2:
- Move dt-bindings to separate file
- Added support for MAX736x as they are very similar
- Fixed an issue found by kernel test robot
- Dropped max735x property and custom IRQ check
- Added MAX7357 config register defines instead of magic values
- Renamed vcc-supply to vdd-supply

Patrick Rudolph (4):
  dt-bindings: i2c: pca954x: Correct interrupt support
  dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
  i2c: muxes: pca954x: Add MAX735x/MAX736x support
  i2c: muxes: pca954x: Add regulator support

 .../bindings/i2c/i2c-mux-pca954x.yaml         | 45 +++++++--
 drivers/i2c/muxes/Kconfig                     |  6 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 92 +++++++++++++++++--
 3 files changed, 128 insertions(+), 15 deletions(-)

-- 
2.39.2

