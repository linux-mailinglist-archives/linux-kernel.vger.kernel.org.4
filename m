Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E0737FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjFUKjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjFUKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8FE41;
        Wed, 21 Jun 2023 03:38:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988a5383fd4so607071566b.0;
        Wed, 21 Jun 2023 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343889; x=1689935889;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LLokvFJRr0ZS2/J+RyaPCEgCPP7mcKpknVtjbysX64=;
        b=psutatsGxydYgWSl+BY5wAswU+hFJg2oJ86pCvNQRPDPGiH0bhYaOW700wLsnW8bqZ
         5umR3jsZBh6u5Vq/bts7qxJkMphxfI9f+z2Aj3MMieAUwzu0250Vtpta4JHcZaSGLlYt
         mdCj1ORADCqEcsM6qXjyoCB41oYDLfQQWqiws+f9x9ejKSrimsHZLzzXYR4+d3Ae+MpT
         wgkyizyqx2zqp0jl+WxthhynKrS0xbCiLlmmSqzCvWuEnpZ8VvHiUgpuUts2sXqhaxPt
         YNUkrTxOVaNPKOUKE6urzJOc3k0ll+jIJfICB3v1sdeGP2D0ToyS6j/wZo7Oug3GWE0U
         wm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343889; x=1689935889;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LLokvFJRr0ZS2/J+RyaPCEgCPP7mcKpknVtjbysX64=;
        b=HIUW7MF1P04j5MEp5676zAi6XOPMJUxywE9Fgx1wEpzP6NHbySH8SGReeIqDljjjpH
         yJFhfCQNcowruzbuW0U8WpePZZ0xkt3Ob2P45KiwyIU76JtDs1gXA54bGOGxavyWhQ4a
         6h5xkbOnuHKVPTToQfkAzcSUcg8+BI+mSErlhGYQU+oXoyXtpPYVq8JssxXrBs/gtXhK
         Aq8KSZ/xMQRhSEMZhrcaIm2v4yXkjODiPlHtcL5ONecgr6UoxVqZTaUA0NZDkXpZYcAQ
         /7DaRwY81opS8ggg0Y4Q6WgWqd/uN+LrJKNmenbUTGBoPNs7OIGvCXSO+Vs/TUoKhthP
         kM1A==
X-Gm-Message-State: AC+VfDx0YbnRfc7uz09ZstkV45EFOB7tJ+f9+iqdK3LeJ61xFJ7jgod6
        yFFTmpkGXkJUFCuLzoPyDSs8mC7+jp2djA==
X-Google-Smtp-Source: ACHHUZ7ZWzBkH3e6JOfUWUjILkZGl3c2ywJZPQrzaeH/HIzRsnfvHwY8i0Va9FtFvoPo2n5ru41UGw==
X-Received: by 2002:a17:906:4fd1:b0:97e:17cc:cc95 with SMTP id i17-20020a1709064fd100b0097e17cccc95mr11112015ejw.36.1687343889306;
        Wed, 21 Jun 2023 03:38:09 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00987e76827b2sm2873055ejf.53.2023.06.21.03.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:38:09 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH 0/4] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Wed, 21 Jun 2023 12:37:59 +0200
Message-Id: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfTkmQC/x2MWwqAIBAArxL7nWDag7pK9OFjy4WwUAohuntLn
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

