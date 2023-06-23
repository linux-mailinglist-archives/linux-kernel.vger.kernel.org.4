Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F573B0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjFWGUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFWGUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:20:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B1E4B;
        Thu, 22 Jun 2023 23:20:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9883123260fso21373866b.0;
        Thu, 22 Jun 2023 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687501248; x=1690093248;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOeXHWWsEf0fdPbBS+RJHR7ZXJnKX17x69BQGKjrFBM=;
        b=DbyJIz6dE0yyARTOtWQ2bsxR82zz5xqSK+X2b8CuoJGLjHeX2Qn21TmUBz2uTnpLQj
         Ls8vljZsc4yHu820gnYHqv+fZfCv59wCxrc7veO7FfqoYrMIh8+U8S34aoSi31JVj2ri
         O3tkWnK5Xa64zWY3XTF4toT0/+Rc94YyZ7WjNzJcZ3yMR+cjH0t76WB4qk/J36wW+veB
         XQ+kmcnTI9M47SwcuNKbi7WJTfIbDoJtzowSk/5Q4buGiQoJFEN6dTyy2CGb9ej5i4wv
         QSCB1LOuJynXBAlCTuCbh1mSR2H7x09DgG+6yc5TEvnZipsaBgL1vDQwXvELPN83EVFY
         ljHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687501248; x=1690093248;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOeXHWWsEf0fdPbBS+RJHR7ZXJnKX17x69BQGKjrFBM=;
        b=hqL7BUQaZKesPr81/TKZgcKkmug6+qWE5TlhUYPfYjOvqi2WM543baqysSCejodHeZ
         Ez3bSJORrVcBU8qXNifHBlAiAFmQnpLr3k7cL29a113MrBW29fybvJkOIFz110jrn0Lc
         cAuoQbc0McHhx0MKFqJMQrZNbGVocPOVm3eqN9aBOI8jP4gvfDbL65n/BJEMrgBJ+h9A
         NadQsGmLDu1MpCPHXUWALSLtVlOQpQaLWX7mGKYAhlmxIhSL0z3pICImDVRvfDAqPGuE
         6EdhTkIJxldgQS1Q0ppKuu3Q6xOXALNDEGEpAG3g684TF/ynit9/LKSiEhZjJL9iBj2H
         SR7Q==
X-Gm-Message-State: AC+VfDy0oViHiER05iApRy7lrYO3cPKWkImyzbd5Va01G3eWss6zACVV
        F94EjpzouP2+UU0FhrfwxxQ=
X-Google-Smtp-Source: ACHHUZ5dSDuCAHlNxeydeb7GQwLNQK7ED8cWsgwnebpq6jXIFSLeF+UvI8VWmMZASbQzOfWAOD9m7g==
X-Received: by 2002:a17:907:6d8a:b0:988:9621:d855 with SMTP id sb10-20020a1709076d8a00b009889621d855mr11503564ejc.61.1687501248259;
        Thu, 22 Jun 2023 23:20:48 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906725400b009878b0b5302sm5630346ejk.98.2023.06.22.23.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 23:20:47 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v6 0/3] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Fri, 23 Jun 2023 08:20:35 +0200
Message-Id: <20230620-hx3-v6-0-6a1d6f8ce689@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALM5lWQC/23PwW7DIAwG4FepOI+KYCBlp73H1IMxpEHtkgnaq
 FOVd5/TW1WOv+XvBz9ETSWnKj53D1HSkmueJw7uYydoxOmUZI6chVYalNNKjneQFDzYYIYYeyd
 4M2BNMhScaOTd6Xa58PC3pCHfn9XfR85jrte5/D1fWrpt+lq6dFJJQGd8AEMHG77qOUe84p7mH
 7E1LLqhNKveoQXDqu/gXUFDASuNFEgBoTf+XZmGMqySdQHIxeBU44e2oex2V+fJE59l3PCq1nX
 9BzGPoaSFAQAA
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

