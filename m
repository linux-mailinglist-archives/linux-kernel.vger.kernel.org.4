Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5226C6106
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCWHpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCWHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:44:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148DD1A49B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:44:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so82674434edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679557494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4R+XqDwitKzHSbNlWfSFxubfsoLnWPASyL0OVykMXvo=;
        b=bLw1bDQORi+pc5ri62XUS3TVHspZGiw0+3x56SaqahrTKl/kDZd/H4qmzgOqZHOGuw
         pG+OE3uUV+bg5Y76eOglqWU1LLuBQ7NZTHcErsQ1vWtA/tRXjT1q57XDZ2RgArXFqrJZ
         69NnMa2ALasJgQ1Vxg+PXKuqpYZQE+UKggUUVsdGFHPLvtKnRkgDTaSlZyNchq+AdraD
         KptCHij1Ni+jN+GXgApMutwAqd6+g1BLumCFOmY6AZqyujLRhDzr0+l7lHa+zHdPjtsR
         iUqnrHsJ44UtkyLrX5orwsfW8A/G6PDCoIh4UUZ4H/YSKn/NNn4A4gSb5B4KpDriwxWI
         stdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679557494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4R+XqDwitKzHSbNlWfSFxubfsoLnWPASyL0OVykMXvo=;
        b=JUs9ub9U9p8khxNlhNMXMy+ZuR3DfdkYmC9FZXOTH8rdpdi4A2d1zQIDT7uUzCrjvY
         D4Qi2kf6h2atDyS3/QgxubFQRrSC95fodE3xmDRPz7cJlUgij6Emhim+Kkty2Ejyl2vE
         MT0R+fjNBE0O5f9VJxxSAJYk+fp1e7Zoj3i9OuZPStmjGNelVqNiAAQt1jjOHSzljjvA
         2wOUPI49Dg6Kcux8ncFLryYnXJTikr56Yd595M+5Uxd3mZt7pyvmn131bvm5Jk3ak9uP
         Hn1HsL8Kq30fzW6OcbFUQuzp9/r2NDuKIzEpS8dOEkajq2sNPaJm2Rzf58LBGzoyzjQe
         zOeg==
X-Gm-Message-State: AO0yUKXoLywXnVCPgfFGHh9aOnabZ4BnzZ8w3a3j3mx2Z4ChUVINrdXB
        fJO7mvoJuGJpfNsIA8ZJywLMQw==
X-Google-Smtp-Source: AK7set93K2HThaxkUBaSz2h8xuqo8oQShPcZGfa8uP9rLFxOoJs0TMYTve5JnGY5LDkSKUpsBfrtKg==
X-Received: by 2002:a17:906:46d7:b0:930:7164:e8e5 with SMTP id k23-20020a17090646d700b009307164e8e5mr8300809ejs.38.1679557494534;
        Thu, 23 Mar 2023 00:44:54 -0700 (PDT)
Received: from fedora.. (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709061c8100b0092669fb4ba1sm8255405ejh.130.2023.03.23.00.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 00:44:54 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v10 0/4] Add support for Maxim MAX735x/MAX736x variants
Date:   Thu, 23 Mar 2023 08:44:15 +0100
Message-Id: <20230323074419.2494609-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
  i2c: muxes: pca954x: Add MAX735x/MAX736x support
  i2c: muxes: pca954x: Add regulator support
  i2c: muxes: pca954x: Configure MAX7357 in enhanced mode

 .../bindings/i2c/i2c-mux-pca954x.yaml         |  43 +++++-
 drivers/i2c/muxes/Kconfig                     |   6 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 141 +++++++++++++++++-
 3 files changed, 175 insertions(+), 15 deletions(-)

-- 
2.39.1

