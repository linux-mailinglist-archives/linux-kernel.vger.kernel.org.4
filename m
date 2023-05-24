Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B970EC02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjEXDpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbjEXDpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:45:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B762E8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d293746e0so383134b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684899913; x=1687491913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbA/T1wO1qAyesSWdO0/kj1YL/bMGtGocXpaz0d8yIU=;
        b=VeBvQWErwn1MbzsyYFSjCJED65iyYAEZEdvLFM6dbmQuJTJ57UcMGrUP4f0bgPGfsq
         HlqoeMRLdlrFRGRtAhSJH6ZjWb2tThPW4ZaG8xzODYpHpYyQllT8J75KjZVBq2Bmbm17
         lJFgu97CjFoiv8UB6P2HHnp1+9ka+R3Ktowu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684899913; x=1687491913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbA/T1wO1qAyesSWdO0/kj1YL/bMGtGocXpaz0d8yIU=;
        b=OTW4TwZwbPII9RXXwblPsCO2swGXZjQJacGg0zheXXKFj7U5evKKLpy6NIP8mrutGY
         HoJNuKiPGJCiACH0CeaU0DJK+2+k8Z7qewrAgSs/n9aOJK8YudPfjs3qZbDiqJJQeo57
         dBY6bkX2xfF4RQhviKSNpifCnNocha0snu8o0i5sOqDCQ4uZHQUfyhpH0IZMmyJ9oYEj
         cF+290tUZys66CyHRb/BR9rboGVATbHPnmUDOjWFMnaD4+IKVz2zZ/rlsRmlraYgWdz9
         U6bHLDFKUnRcWd91CHkY/cUp6RO7pMUYtH0GWwPM7iGCXmSKl9Ml7r4btaGVwJgk1qLS
         rU+Q==
X-Gm-Message-State: AC+VfDzj2S/HumnVIvyVCuIyGNZRHLHqghubHmqEHJv5hpudOpZWUbGo
        hpR0CHb7DY4PKxrXixM2kBZCAw==
X-Google-Smtp-Source: ACHHUZ4sRjgaPzPxgJEkTuRdXIRIqTO36IIjJDWQCl5rH1I7eGu7CYzvObK22BZghfdqAFohs1OuPQ==
X-Received: by 2002:a05:6a00:1488:b0:64d:2ea4:937a with SMTP id v8-20020a056a00148800b0064d2ea4937amr1857653pfu.7.1684899913048;
        Tue, 23 May 2023 20:45:13 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3b18:4c0c:a178:5536])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78683000000b0064cb1fe7e44sm6357616pfo.219.2023.05.23.20.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 20:45:12 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/2] Fix Goodix touchscreen power leakage for MT8186 boards
Date:   Wed, 24 May 2023 11:42:35 +0800
Message-ID: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

[1] https://lore.kernel.org/all/20230207024816.525938-1-dianders@chromium.org/

Changes in v4:
- Rebase on top of next-20230523
- Collect the review tags
- Minor coding style improvement

Changes in v3:
- In power-down, only skip the GPIO but not the regulator calls if the
  flag is set

Changes in v2:
- Use a more accurate property name and with "goodix," prefix
- Drop the change to regulator_enable logic during power-up

Fei Shao (2):
  dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend"
    property
  HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend"
    property

 .../bindings/input/goodix,gt7375p.yaml           |  9 +++++++++
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c          | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.40.1.698.g37aff9b760-goog

