Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B606EF13A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbjDZJdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbjDZJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:33:37 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71CC10EB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:33:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b50a02bffso5671470b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682501615; x=1685093615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tiC1EixoNe9TvcsXGi4HMFFCigO3LAC2XK4QXXLhOuY=;
        b=N/4d2/dnYSkhGgmo1yEJ21nMJwso80TVv1R2jKDFELl94n03lMwt6NogcEwg1IsE6c
         kSjyQUDyCFg3pECB7tQBBB3Q1iX4k7l08KYKz/UoU9ccAOok4Svwduyt0D01gNr1L2Ma
         LvwNagl9VKFmb+/D6nQBPH3LJbb40OXlhjzlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682501615; x=1685093615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiC1EixoNe9TvcsXGi4HMFFCigO3LAC2XK4QXXLhOuY=;
        b=OMbUZjvC584tyZWXjbkkcXevMSC8k99e1GFt1rqI7jJ3BM3iR+djjLafWuT4uG1Fyd
         5p3NmKThxtYsE2RXMgAPKFh3BaQNMNMnCKRLF0jbAKaXVPAoSbdKv/OMZYaPuJPM1cZp
         JO61XBn0xduVRNlaGXFJSJBUo+tnnimyVXn2B33rFW8ikkb8OUL3HRHRTrRN6AkTtNrZ
         tg4QHCxWPlPRKT5CWULhiBFvxlNCs2aWmQLWF1l9jIjioYf8z3SYWB994b3TAygovEtV
         t5bQeELW1mvfvpuYTBvCqGYCMZ8tCHpzUtKUv9nTjV//L3qVbF5noJUUzafQ/sWTqUMq
         jr1A==
X-Gm-Message-State: AAQBX9cUI3nF+QMBV9tCeHwlOz2oU6ESUTNU+7qroxsnt82tUjjmt0wq
        dDYgnjinpc5lk5tx+BG1pMS29w==
X-Google-Smtp-Source: AKy350aRbFyZHOGKWRhhNxNRmhRppBdI6Qj5Hf5cU5Xv1kPX2Am2QNrW4+QfzRy/3gQG4MmiMaD/Rg==
X-Received: by 2002:a05:6a00:10cc:b0:63a:cefa:9d44 with SMTP id d12-20020a056a0010cc00b0063acefa9d44mr23043975pfu.14.1682501615312;
        Wed, 26 Apr 2023 02:33:35 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:dcf6:797f:140d:6d])
        by smtp.gmail.com with ESMTPSA id g1-20020a056a00078100b005810c4286d6sm10730075pfu.0.2023.04.26.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:33:34 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Fei Shao <fshao@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix Goodix touchscreen power leakage for MT8186 boards
Date:   Wed, 26 Apr 2023 17:32:28 +0800
Message-ID: <20230426093231.1466984-1-fshao@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are based on the series in [1], which modified the
i2c-hid-of-goodix driver and removed the workaround for a power leakage
issue, so the issue revisits on Mediatek MT8186 boards (Steelix).

The root cause is that the touchscreen can be powered in different ways
depending on the hardware designs, and it's not as easy to come up with
a solution that is both simple and elegant for all the known designs.

To address the issue, I ended up adding a new boolean property for the
driver so that we can control the power up/down sequence depending on
that.

Adding a new property might not be the cleanest approach for this, but
at least the intention would be easy enough to understand, and it
introduces relatively small change to the code and fully preserves the
original control flow.
I hope this is something acceptable, and I'm open to any better
approaches.

[1] https://lore.kernel.org/all/20230207024816.525938-1-dianders@chromium.org/

Changes in v2:
- Use a more accurate property name and with "goodix," prefix.
- Do not change the regulator_enable logic during power-up.

Fei Shao (2):
  dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend"
    property
  HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend"
    property

 .../bindings/input/goodix,gt7375p.yaml        |  9 +++++++
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c       | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.40.1.495.gc816e09b53d-goog

