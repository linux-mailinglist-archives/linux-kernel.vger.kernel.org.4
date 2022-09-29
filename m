Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF55EF66F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiI2NZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiI2NZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:25:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51759C2E3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:25:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u10so2081267wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RW7ncZAY7OrMBeBOTpHZlZibwg5fo660fDSD0T+gY1o=;
        b=QWbrn4Nnk3TL9dl2ez4m5K3xiGaoNBKHJiOshTou2bIHZHZmU5Fh9o7u9qQ6VDP459
         MuZ6n4rM/QAKstADVfgy/ZZRNBwYqLwVe2RT1Qj1tSEv50DW6Y0FL6VYptNGd/AJX2q4
         5lrzilT3DKIFhW9qV73/KaKq6ztiCu6/JvaPilPVzIusThFTl0YTvVaqHqXgIZe2vMQk
         H6CCd75Do2waWcknXs2fRlF3d4NfMWOqOXzkYHzfsptwrN8AQ8bHKkdlXQaI1JP6oj96
         9MzuFnA3DfKWvvaL3mtL6pWaflA4Z89+HIvKmgpHGQh0obozXMtIk6cEVD4M2xzw2FQG
         IoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RW7ncZAY7OrMBeBOTpHZlZibwg5fo660fDSD0T+gY1o=;
        b=m4cUrnZpYseVNJhHI9z4gIGKiVgde6Yyn6iJ4K7SEJGk/COHd6uV5ysj1p9mbzsMM3
         kg2MiC9GKQurCgO0K9hc+QDo+Llo4KXIh4hDbmYwtlLBfN/RKumRlDYD59KIlnoEQ03r
         K2by4Ivk/aX5XkfA0tj02xbrff4SxLINF35EArhDPf0yoZEGRR3pmqgjDzUZKNR8nUQC
         P5mJ6TahX4FAml9qFpUN15Ff6qHD8Gy8fjdCp6w09ha+lRdYarT33JKvDGOEOGUgtSHz
         iYq7ApEfOQywIHWBU5wngqe5ycXg3ufHWcFc7jgFhrloCDas6Py1jkU8uratv0MuO26W
         7o/Q==
X-Gm-Message-State: ACrzQf3gkTuhDuSfdjcPOt1wDz+zA6oQDDK9909PZsysn2zKV1sHiEKy
        RgI8IoKebNhXzscvZWx7X24AEg==
X-Google-Smtp-Source: AMsMyM4bDN7OIpIDodu1rwe7wboEpVTHP/M6Kywp+RsHnMgdARBvpHAcL0lB13B2UNED665e+1feLA==
X-Received: by 2002:adf:e60d:0:b0:22c:d483:5ee1 with SMTP id p13-20020adfe60d000000b0022cd4835ee1mr2234279wrm.641.1664457932052;
        Thu, 29 Sep 2022 06:25:32 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bu24-20020a056000079800b00226dedf1ab7sm7032222wrb.76.2022.09.29.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:25:31 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, msp@baylibre.com,
        Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH 0/2] Add input_supply support in gpio_regulator_config
Date:   Thu, 29 Sep 2022 15:25:24 +0200
Message-Id: <20220929132526.29427-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is simillar needs and implementation as fixed-regulator.
Used to extract regulator parent from the device tree.

Provide implementation and bindings for vin-supply property.

Jerome Neanne (2):
  regulator: gpio: Add input_supply support in gpio_regulator_config
  dt-bindings: gpio-regulator: add vin-supply property support

 .../bindings/regulator/gpio-regulator.yaml        |  3 +++
 drivers/regulator/gpio-regulator.c                | 15 +++++++++++++++
 include/linux/regulator/gpio-regulator.h          |  2 ++
 3 files changed, 20 insertions(+)

-- 
2.17.1

