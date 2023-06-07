Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142D672615C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbjFGNfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbjFGNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:35:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1898A1BDD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:35:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-652d1d3e040so3748203b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1686144908; x=1688736908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt5aghotCpqk7KxGy2xmtz+Xzjn0V+JF8TzHnw1tUFU=;
        b=23QJvzYKUPEpLA5BbZngjp7upUZYRzdXhU2KEt+tzd54O9+LwdHHoff1TBavV/M65T
         qL7cy9H8IqQelgWU2QK02vYBoHgiahPWt223nFIagID69DsvCG5j4JvTBzW4U3pYRagp
         GxpXOgNbrMO2fp8H7g/f7VvULlb9zA2GDzokgnQ02F5CzPWoo23w4CoM5ms7kXdQH0cJ
         3pTqEw7qUtDor/2ZUbuOhQvJbK0vpBTON6MdRQpsQ7jfOyQk+9u1sT0DCjjIJEO560A/
         cImYEDwTVDgfgS48QB/TC2aIiw8qB1r2j9mF+9y7unQZnn60yuSccGpzXjYhjkP5TQ74
         Tnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144908; x=1688736908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tt5aghotCpqk7KxGy2xmtz+Xzjn0V+JF8TzHnw1tUFU=;
        b=jfhZJQ+EqaEDosiR1KqjacaI3CkwmON6Shl48S7vehtX+kS4a+KHjyuxd1/EastG0f
         E90giOD1vzFg8VykUYcL4oGk+A3/2Jf/kRab21ojSggCpnSO26caDuLVhd44+/JVS0De
         sE9E7nAyxmj+HZGRzmZzUxvXcDhgGh9Sv+koB4PGVFbAuVFo88L3Rl2Kmoo51qmbj59F
         KzPJmH5IzcxLg2ABtyiFD3LpdAWrMez0+yebSDGFD2i9AnPJkNQyhLve97zwekDO+qjE
         QioR2Gls0oRseZ57z8tmrAM9Lqh/TWgSghwpFRQT3S3gXmOSP8CUBguJfvjUmPtL5Wfy
         Kp9Q==
X-Gm-Message-State: AC+VfDyL3lPrdxj02DuQjVQyvbfloh8YnG26/Ds9tCFcHazr2mV0MFov
        88ZePuob0Mi5eG+dTdkwXUjHnQ==
X-Google-Smtp-Source: ACHHUZ6wa5A02yErnRiD3wwIIVf+hicOoG8k26WAOjNmyJFhXIPuj4AH0DxD2L/nIEdXAK/EtuStqA==
X-Received: by 2002:a17:902:e742:b0:1b0:e0a:b7ab with SMTP id p2-20020a170902e74200b001b00e0ab7abmr4299474plf.31.1686144908502;
        Wed, 07 Jun 2023 06:35:08 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b001b034faf49csm10405680plb.285.2023.06.07.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:35:08 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/2] Add ili9882t bindings and timing
Date:   Wed,  7 Jun 2023 21:34:56 +0800
Message-Id: <20230607133458.4075667-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Ilitek. The ili9882t touch screen chip same as
Elan eKTH6915 controller has a reset gpio. The difference is that
ilitek9882 needs to use vccio-supply instead of vcc33-supply. 
From Dmitry suggestion, it would make more sense to distinguish the
binging of ili9882 and eKTH6915.

From The datasheet specifies there should be 60ms between touch SDA
sleep and panel RESX. so we can add the 65 ms delay in i2c_hid_core_suspend.



Changes in v3:
- PATCH 1/2: Introduce bindings for Ilitek.
- Link to v2: https://lore.kernel.org/all/20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/2: fix ran make dt_binding_check warnings/errors.
- PATCH 1/2: remove oneOf,just enum.
- Link to v1: https://lore.kernel.org/all/20230602140948.2138668-1-yangcong5@huaqin.corp-partner.google.com/

Cong Yang (2):
  dt-bindings: HID: i2c-hid: ilitek: Introduce bindings for Ilitek
    ili9882t
  HID: i2c-hid: elan: Add ili9882t timing

 .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         | 20 ++++--
 2 files changed, 83 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml

-- 
2.25.1

