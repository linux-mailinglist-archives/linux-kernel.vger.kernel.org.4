Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1B738051
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjFUKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjFUKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06AC210E;
        Wed, 21 Jun 2023 03:37:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-988e6fc41ccso343128866b.3;
        Wed, 21 Jun 2023 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343843; x=1689935843;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LLokvFJRr0ZS2/J+RyaPCEgCPP7mcKpknVtjbysX64=;
        b=aJaEcdo/WXsjqvY6b3OmYlnmUBegG+pi6a/jfHi7NPGD0Ghq3KAxY/9j91CCoIbkys
         e6jFshOjb9E6+DDuezEGFRwhQFZh7ghMopz7vwnC3gm8DPGyL0/q+XmfDUh/tMUCrLX7
         e+9ddaQ1WTrWpR9zBbKhpD75Teh+wF/O0BnbchgJvmdE2rC+DeHLSJtiLn+6qbmaah7t
         p8Aq0fmRYpb6W/G5Lbu0VVrIiiu3ppt57JbokvDwxte75C5KTKVKwZnTOtLpSczgBVSQ
         piNkUosIQ6D9WNaNyuXD4wsqCQ5GNGpLFmth/J7O3zUEvEWPiVZVoZtqdavA56uAneLI
         IX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343843; x=1689935843;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LLokvFJRr0ZS2/J+RyaPCEgCPP7mcKpknVtjbysX64=;
        b=YLXa/IxmzT4TVEFs/s0xYHFubOVe8N8c2XBpcHN/oRmMQ0MmOm20ABaFq1zPPqmrzV
         T039jI2SpyyYvM7Mv/aeje/aU9wJA9RgTdSJB8+noYxidmP7MNUcVBDhmKI5QbS2WvZP
         g0vcLy09AuOGn8JcJSBY15hYIQJUK12on2SSHEQ3M2DhslOVgmbnTL4Y3jNha2/447qB
         dBMfE4lERd9EaXfwKmoyAX6mKk+jW4FBP2WvZTGF6y8uU4w74AzeJ1ER1s2p78PMXmrC
         iQw6cIGjLXuFHc+aIMyI5Rj4ArAClKQ/g6jkIDWhZJgdUqm4w7XKST8mIGSCOt1nvQF4
         wiRg==
X-Gm-Message-State: AC+VfDwC0xqnHmp86c+gFbQ/I8Taj3sFUgrvyOn9BIzcUGD1Rr4TwYUS
        GYnwHkJAkfB3iznx3EMoRYA=
X-Google-Smtp-Source: ACHHUZ4AMAXLQ2VODo60XAY+XGQ82nEkQz5gsitczhta2Sp8+R5DzfROGEx23e5eqEQo/KvZh5C/CA==
X-Received: by 2002:a17:907:1b08:b0:971:eb29:a082 with SMTP id mp8-20020a1709071b0800b00971eb29a082mr11779512ejc.49.1687343842917;
        Wed, 21 Jun 2023 03:37:22 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id c2-20020a1709060fc200b0098880feae36sm2931758ejk.153.2023.06.21.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:37:22 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH 0/4] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Wed, 21 Jun 2023 12:37:15 +0200
Message-Id: <20230620-hx3-v1-0-690000b6d60d@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANzSkmQC/x2MWwqAIBAArxL7nWDag7pK9OFjy4WwUAohuntLn
 zMM80DGRJhhqh5IeFOmIzI0dQUumLihIM8MSioteyVFKFo4O+rOtqv3Qw9cWpNR2GSiC9zGa99
 ZnglXKv96Xt73Az3SbARqAAAA
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series adds support for the Cypress HX3 USB 3.0 family (3/4). For
now, it just contains the USB-related aspects and ignores the option to
connect it via i2c (4/4).

For a better overview, the current entries are first re-ordered by VID
and then by PID (1/4).

As the HX3 family operates with two power supplies, multiple power
supply support is implemented (2/4).

Thanks & best regards,
Benjamin

---
Benjamin Bara (4):
      usb: misc: onboard-hub: resort by VID and PID
      usb: misc: onboard-hub: support multiple power supplies
      usb: misc: onboard-hub: add support for Cypress HX3 USB 3.0 family
      dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family

 .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.c                 | 55 +++++++++++-----
 drivers/usb/misc/onboard_usb_hub.h                 | 16 +++--
 3 files changed, 128 insertions(+), 20 deletions(-)
---
base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
change-id: 20230620-hx3-cb935b4fdd76

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

