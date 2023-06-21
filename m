Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740237386F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjFUO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjFUO1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:27:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7110CE;
        Wed, 21 Jun 2023 07:26:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9875c2d949eso754521566b.0;
        Wed, 21 Jun 2023 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687357600; x=1689949600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5rPM0WguDAMwCA5XqQogz3H0yEU1YB8VWluN4BWIeQ=;
        b=jBSAStfU4lku5pBMpH3sWLC+Ujqmcu9+Nd5nhm3hGiKuj6mX45h1QgUQuwKLib0UAN
         4MLqlu1IlOpcMWqD/y+5NwNjUESAbJfNfnip4FYg32QkDEGpgy7ebj1nS41zdCZfc0Hx
         dxVK50WtLdgqj8f4slqSN37YjzauGF7t+2inHbWKpZs29DsKTqJWn7v9L9PMvHp6JokZ
         9u71sILkXlogaGZ0wqvD05qal9022qQKCdiFIaF/v0zwcO3ni8CmeCigCDMaPiQ0CfWX
         pqXNnpyB29sdZnmY30gtW5+b0XB2uz0OEMrFnX7lOYRcLr8mxBV591in9OLvT5jEzUNY
         hYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687357600; x=1689949600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5rPM0WguDAMwCA5XqQogz3H0yEU1YB8VWluN4BWIeQ=;
        b=MMDSz3ZRJobGyYTvj2USdGwT1mxIODgLuEvd6lgf9NN0u+KzNs4pmuAWe9jwVb72CP
         JbE9JQTcunK0Hufa2JOnPrUO4hPZPMo4pes6lZ1iqiEyI4WzNd7IGdcYVTQ/Kt7PIBFB
         cqJi01OioRev95dajxFZxiEqDAAAMXjllTSETvwm0GeSlgTqjeijyKEFqVU7T0+0vRfa
         tvJ3HBrPHuQSIR9PCDxDJGtp/0KY0PUlbp82834Q9eZx+a4WtVv8gJ2LSu7ucdUUcd2g
         w6LRkSqx967go4oEy6NMtqmyUp9zgTTYwxJAscVhsYzEppEIzfFFeJUoZUrP8cgaJHhN
         P1OQ==
X-Gm-Message-State: AC+VfDwNccNXghQFXBeqdAng+v5OgVw3kTw8ovY1stSPHI1vQudFmLOc
        QmcD0aytU0lJA+4Vg5QQNEA=
X-Google-Smtp-Source: ACHHUZ5DSv7pLmI/Ye7LenYpCm1tMd5gPnrocg9qtG5kyJ8ODEUJjMunRTn43j4cj7w0DnK0QGnctA==
X-Received: by 2002:a17:906:eec1:b0:974:1e0e:91ee with SMTP id wu1-20020a170906eec100b009741e0e91eemr15114334ejb.13.1687357599691;
        Wed, 21 Jun 2023 07:26:39 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906644b00b00988956f244csm3266156ejn.6.2023.06.21.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:26:39 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v2 0/3] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Wed, 21 Jun 2023 16:26:26 +0200
Message-Id: <20230620-hx3-v2-0-76a53434c713@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJIIk2QC/1WNyw7CIBQFf6W5azEUKFpX/ofpglflxgoGalPT8
 O9idy5ncjJng+wSugyXZoPkFswYQwV2aMB4Fe6OoK0MjDJOJaPEr5wY3fNOi9Hak4S61Co7opM
 KxtdteE9Tla/kRlz39G2o7DHPMX32p6X92f/o0hJKuJKi11yYc6ev+YFWzepo4hOGUsoXN0SaY
 60AAAA=
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

This series adds support for the Cypress HX3 USB 3.0 family (2/3). For
now, it just contains the USB-related aspects and ignores the option to
connect it via i2c (3/3).

As the HX3 family operates with two power supplies, multiple power
supply support is implemented (1/3).

Thanks & best regards,
Benjamin

---
Changes in v2:
- don't re-order by VID/PID
- 1/3: replace (err != 0) with (err)
- Link to v1: https://lore.kernel.org/r/20230620-hx3-v1-0-3a649b34c85b@skidata.com

---
Benjamin Bara (3):
      usb: misc: onboard-hub: support multiple power supplies
      usb: misc: onboard-hub: add support for Cypress HX3 USB 3.0 family
      dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family

 .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.c                 | 39 ++++++++---
 drivers/usb/misc/onboard_usb_hub.h                 |  8 +++
 3 files changed, 116 insertions(+), 8 deletions(-)
---
base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
change-id: 20230620-hx3-cb935b4fdd76

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

