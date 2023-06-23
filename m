Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B867273B17F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjFWH2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFWH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:28:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32120212F;
        Fri, 23 Jun 2023 00:28:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98d2fb1bb23so33189766b.3;
        Fri, 23 Jun 2023 00:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687505295; x=1690097295;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hif18NmNHcCf8pS1rdbTF8MbepiaDUYPJ+s4jFcyoN0=;
        b=hNuBXbi3JdXGgHgVofB5O2U8MRc1O7hie9o+1x3yCqjp+fbjBr6z01Ht8yLKdo6y3q
         YjyJ8SsyKgHgdbkiO2zB+MD+077hlpEVc5TOXFPK4f1c5J+NcWHR02Z5WrxIfupI+vgs
         yIpaMHmJCvjYCoTDl/x51Uumcs9XIwOKjRMVNmP8lTvOVrOsHaYgdBUO9bdR6zN2zJpc
         EoBaetZyzFfQ6fL3DJ8OVUKMNt/GkW7H1IFCDgUip+loEL0l1AqCj+4rNbCtMvwuSvhT
         VabsuDD7e7yn8WTdFLhiiWSE9GAJGLfa4nWASEilyyuw2j9/rfm4cm8s0qS4P4RiCouI
         af2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687505295; x=1690097295;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hif18NmNHcCf8pS1rdbTF8MbepiaDUYPJ+s4jFcyoN0=;
        b=eWfQW8FDKL2IxqRDqZdfFXVXsQaf6W0jGm8WWZtF4w+VG8r9Z/stHlHfqstQOxWUlS
         Ofrhc/1AF8SNaVTK3TdpfvJD6d88p9XsgLuySMIaveiGs22KqEjdOb7FSEF8wDsyEgX/
         rGEpO6afiVdQG2BZ3OnXSFw7rIvW29mAjaZCf/l3X9FhMFW0rnf+gv0EUbjwLaZCsalJ
         nbRqYxNxLhSgNFWAvQWyOFYnkRJoSz/fjN7TTrZmKgyTskdM8LQak7T9myDJIYM1JvF2
         PNredcfa3Iu6QFEM8qHTlt30vuyy0u8reQVUxzgaHvVHMNEUCvEMzlmR1YGrDnO1sGz+
         KJiA==
X-Gm-Message-State: AC+VfDw1ULeT4YBWAQB+fCVF7gtwcJDGdOCo/MEboluc0GLDEC33NEeV
        rEr7ZENV9ZogbUZzutCdre8=
X-Google-Smtp-Source: ACHHUZ6aF5UaOG3/gTIurANlToukglyACwUFramAMhX6Bn64f5qT3YbeyYqan6MEvat6RN04CXnG4Q==
X-Received: by 2002:a17:907:2688:b0:988:4a48:6ff3 with SMTP id bn8-20020a170907268800b009884a486ff3mr15514086ejc.30.1687505295388;
        Fri, 23 Jun 2023 00:28:15 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090614d300b00982d0563b11sm5637811ejc.197.2023.06.23.00.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:28:15 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v7 0/3] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Fri, 23 Jun 2023 09:28:11 +0200
Message-Id: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxJlWQC/23PwW7DIAwG4FepOI+JYHBCT3uPaQcwZEHrkgm6q
 FOVd5/T2xaOtvz9tu+ippJTFefTXZS05pqXmYv+6SRo8vN7kjlyLbTSoFArOd1AUnBggxlj7FH
 wZPA1yVD8TBPPzt+XCze/Shrz7RH9+sb1lOt1KT+PTWu3d/+Grp1UEjwaF8DQYMNL/cjRX/0zL
 Z9iT1h1Q2lWPXoLhlXfwVFBQwEr7SmQAvLOuKMyDWVYJYsBCGNA1bjQNpTd/+ocOeK3DI5HhQ2
 FrNB3EceBEg7/Lty27RdryMTkuwEAAA==
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
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
Changes in v7:
- 1/3: %ld -> %zu (thanks to lkp)
- Link to v6: https://lore.kernel.org/r/20230620-hx3-v6-0-6a1d6f8ce689@skidata.com

Changes in v6:
- 1/3: %d -> %ld (thanks to lkp) 
- Link to v5: https://lore.kernel.org/r/20230620-hx3-v5-0-319c9c4c846f@skidata.com

Changes in v5:
- 1/3: use ARRAY_SIZE(supply_names) for MAX_SUPPLIES (thanks to Alex)
- Link to v4: https://lore.kernel.org/r/20230620-hx3-v4-0-e56b3c6db60b@skidata.com

Changes in v4:
- 1/3: set num_supplies=1 for the existing hubs
- 1/3: drop duplicate num_supplies in onboard_hub struct
- 1/3: clarify connection between supply_names and MAX_SUPPLIES
- Link to v3: https://lore.kernel.org/r/20230620-hx3-v3-0-2acbc03ca949@skidata.com

Changes in v3:
- 1/3: fix nits mentioned by Matthias
- Link to v2: https://lore.kernel.org/r/20230620-hx3-v2-0-76a53434c713@skidata.com

Changes in v2:
- don't re-order by VID/PID (thanks to Matthias)
- 1/3: replace (err != 0) with (err)
- Link to v1: https://lore.kernel.org/r/20230620-hx3-v1-0-3a649b34c85b@skidata.com

---
Benjamin Bara (3):
      usb: misc: onboard-hub: support multiple power supplies
      usb: misc: onboard-hub: add support for Cypress HX3 USB 3.0 family
      dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family

 .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.c                 | 40 ++++++++---
 drivers/usb/misc/onboard_usb_hub.h                 | 14 ++++
 3 files changed, 123 insertions(+), 8 deletions(-)
---
base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
change-id: 20230620-hx3-cb935b4fdd76

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

