Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D03614F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKAQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKAQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:39:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8D65C1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:38:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so10332145wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KTGPfY53P6cSiWbqgN1AbYmbLHz/QFsA7amJqzGEz8=;
        b=e7vTwDB3OIPV88ZtdS1sEM1PZr/DPAV0RQlbXC0cimd0OtKVHOVx9Ecgz/pxbZy8U9
         JQpl9oIt0uMmjbHEYGDwODVjgABm2pBhuZbWJcSWIEANSsKrPX9EE+XyTo6+rGMExzhy
         muBzw0Dc20kwtgyKyZMkMMj7fDHSmTUYZ6NhKvKECIFN8T/gSUjSUg/ArIyA+qijq1/2
         0fo90j/GaXMltviwO0T8HDhpvn19ppAEbHMU9ypCyCVXMWSLcq6su/zJ6AdU2bz80uMx
         oj76lvymBtISs5LWlso72a+/BDtvG/72JwCGUoX4d1VjVs9AhpKq40skwm3Mlo7Js1xy
         V0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KTGPfY53P6cSiWbqgN1AbYmbLHz/QFsA7amJqzGEz8=;
        b=txgz0LWpOErHawyMM+FoOXboZHtJ4BWR/69gCQ6UiKoWDay6e3iNFDk2RIdPtYzhH6
         CaJU1xD12mqb5W3K4AFLFAHoT+U8/Adz6oKZxdlbLprJjtspAqCyz0dFxaX+Z/VPqvqX
         GEAgSbbZjK3QWh+M0AP0vDIr7bUIOvA4R/qB8+BG41b3rGFi2qj6eKEaUGpIbjKl/Va3
         gikrU/6U+htUZWSxIZbepbG0y7OPhsKMS8lPQIIUux86NU5Wx/nYS5hvIcct6E5Ph1kR
         6HQtAjPERo4Dd3YGMa9h1T1qXCu9TrwFVZ643QBfaSWRg3Vi0bzgrQQ/2Zoq1xu6TBCG
         Sm5g==
X-Gm-Message-State: ACrzQf0WdJwGtLiAxaONLj6Q+e/mDKtRxZnmBpFFNGrnf5q01ttBG7+N
        TLEjxksouoJL9OWose0tjSnHIAirxXOl3cfU
X-Google-Smtp-Source: AMsMyM7XxZHfBXVFjA0JfDNS5ABfcNvLlbKskTDT1w/G0weDi65wVQttGrXGKSa6Yx1Z18SfxKBiIA==
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id fn5-20020a05600c688500b003bdd782623cmr12395355wmb.102.1667320694766;
        Tue, 01 Nov 2022 09:38:14 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h5-20020adff185000000b00236863c02f5sm10518064wro.96.2022.11.01.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:38:14 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 0/2] mfd: max597x: Add support for max597x
Date:   Tue,  1 Nov 2022 17:37:54 +0100
Message-Id: <20221101163756.3422371-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.

Changes in V4:
- Add NULL entry for of_device_id
- Memory allocation check
Changes in V3:
- Address code review comment
Changes in V2:
- Update depends in Kconfig.

Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add bindings for MAX5970 and MAX5978

Patrick Rudolph (1):
  mfd: max597x: Add support for MAX5970 and MAX5978

 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max597x.c                         |  92 ++++++++++
 include/linux/mfd/max597x.h                   | 103 +++++++++++
 5 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 6b780408be034213edfb5946889882cb29f8f159
-- 
2.37.3

