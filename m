Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8D6B6422
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCLJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:33:09 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836A1ADF9;
        Sun, 12 Mar 2023 01:33:07 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id v10so3872956iox.8;
        Sun, 12 Mar 2023 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678613586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdsqofhLttt0MpRBJLtGTF5SUT9ITI8Www9f0JAEXBk=;
        b=MfndUlLJPvJCoyPJ8fOJJRJaFxMWDl2BNPL0RcZjv7BMciDD0LpIMfo0h+Y1s46LR3
         VSJbYM3EVOEGX36/6w9gubw4jNAA8YVaVsq1CsV3FnuyQhWTQSQI5HiZKKtbBauMmPVw
         IwgVVkDQPmNvHrCco3JMmCe6WSuBlEBxRDTV587BIrI5tqlYt9XAMfwy/d8WFh6WTBRk
         fOsBCW7MauEhHntY1K89WcKG92Z7O66ULMusJlpYJl5O49Gi2npqZZcn6HohhpZuohML
         Iv1ILP7gm4dS/b8YfMy4UQEbgUgbbaEkS5AmKlJVD+tTkkhfpDntsWFoA1n6npT5QF2D
         +zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678613586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdsqofhLttt0MpRBJLtGTF5SUT9ITI8Www9f0JAEXBk=;
        b=T1JwML4mMJlryRFZnQFHopyk3iYaEWsTm0Ju5C0XN/jXqQOsy9h1KQlasidJIQ3Zv8
         cFDfZdbwKsXw7h34jOy+ck9VKOkUhnR7Tga+E77dH9Ae4VF/SdgFBCUMyE1xJ0Fvvrco
         SIwcYeP6KTug7u2BhyDO6IdVWq30BZTpLyKQe361tzixXk1oSvPlI+nG8FR9ZT+WUQTj
         2sIOJnzGux5sbBrT8uVyAeRGs2ldTL0Tzw/tEr5NTUjLH4MQq4tetFHfmbn9AM7ZQ2co
         AKWPFFqbAWdKTS5nUybKwn4kzHgwAmxWcI6AlqJugZctbHhVmSq8TGUy/cnBbKJ5FRUs
         hrzQ==
X-Gm-Message-State: AO0yUKX0yrU6aIQth6nw3Za1si+mTackJWDw+rwhsekJwR0qDaE+MKPh
        5dFgSnK1GGLXOmwLlLuCAlU=
X-Google-Smtp-Source: AK7set8jiwoKhPgExjaAR4cuHgYmoGP0q866KT8cGjRVW8GVRILI/jQrHePl43lr25hqCKML3le2AQ==
X-Received: by 2002:a6b:b40c:0:b0:74c:83ab:280c with SMTP id d12-20020a6bb40c000000b0074c83ab280cmr4490128iof.1.1678613586463;
        Sun, 12 Mar 2023 01:33:06 -0800 (PST)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r7-20020a6bfc07000000b00716eb44b97esm1585031ioh.27.2023.03.12.01.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:33:06 -0800 (PST)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH 0/5] Add support for Focaltech FTS Touchscreen
Date:   Sun, 12 Mar 2023 04:32:44 -0500
Message-Id: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Focaltech FTS driver supports several variants of focaltech
touchscreens found in ~2018 era smartphones including variants found on
the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
This driver is loosely based on the original driver from Focaltech and
the patches submitted by Caleb Connolly previously[1] but has been
simplified and largely reworked.

Kindly let me know if any improvements are needed. Thanks.

[1] https://patchwork.kernel.org/project/linux-input/patch/20220123173650.290349-3-caleb@connolly.tech/

Joel Selvaraj (5):
  dt-bindings: input: touchscreen: add bindings for focaltech,fts
  Input: add driver for Focaltech FTS touchscreen
  arm64: dts: qcom: sdm845-xiaomi-beryllium-common: add touchscreen
    related nodes
  arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce support for
    fts touchscreen
  arm64: dts: qcom: sdm845-shift-axolotl: update focaltech touchscreen
    properties

 .../input/touchscreen/focaltech,fts.yaml      |  81 ++++
 MAINTAINERS                                   |   8 +
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  17 +-
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  39 ++
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts |  27 ++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/focaltech_fts.c     | 448 ++++++++++++++++++
 8 files changed, 625 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml
 create mode 100644 drivers/input/touchscreen/focaltech_fts.c

-- 
2.39.2

