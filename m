Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B885F0653
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiI3IYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiI3IYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:24:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA81102A5F;
        Fri, 30 Sep 2022 01:24:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 129so3578152pgc.5;
        Fri, 30 Sep 2022 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0RqxEQAHQZEaHAKWXAUWV8kcDN7zBdalBBC9QBhUnUA=;
        b=avdijZLh9gRBjuFE3iPocj714zAL/+oHfJLBqEA2IaZy5+ZzZy2rF78rxJ5BhaKTdf
         hFrnYKWFpXm7xFgiMtDPSMX8GnniBd+RI5tFie82BzvQkh0TUKdwCS9Lhl0tMArj3E9G
         3+GnOPxy331az7AUR5UPcf4vHsmsCSwJ1PM07wLyWyuldxEhnVfhQ8dFMbpOjyFUB9BR
         +/1nBGxMDdP6nznzktchogxuZwh4LMTcbGo/NqmorUjvqH1+dIGuR8E/DfHu7qfxKIU2
         cRCxaWz1hCdc9q6gLF5KN25enZu2tkx2zxAvZuSh3TElK04/KHXm76pYCfv8xx8kv60J
         TBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0RqxEQAHQZEaHAKWXAUWV8kcDN7zBdalBBC9QBhUnUA=;
        b=29p9530bKOEgaeZYlq75ETBpRLrIJxaSMEdlosc6wOwZAtrfxF0n9smo8/ivdrxYch
         dYpyj5KkFoUPpa6FXyJRtZ2ZKlN+0zPy/UlhpZK41TgE1vxDHRhDxqFL476vgzJ9mVAV
         RBvs7SMJNDlAgnQDlKQQW/ndsdFSmOgF9SsQs74lEb0Wl6dYiMzFFtHhHzhP5Xv0OSTK
         JpFzA9FwAaDHNBQbDruQQ8CwM2Oarja/S+kGRcTjujfFAmA7m1gJWtkjqvAwu4GM5KDj
         2Vo8FfzJ96X1JIChfV0IlACPkPaK2JgmMsE2o+mGzgAvVN17jJ2DjrKOc+qu8KV73Tcw
         myyQ==
X-Gm-Message-State: ACrzQf0r/pq+rAxtoDItVnAlOQLRxbuR4zC3AA3W9puywJSbejM+Eigc
        idQSoAJ4H2lnNYppWKYKqJw=
X-Google-Smtp-Source: AMsMyM5NiWR90FD7scZ4nGM5ILSvhBeP+6QeUo/NBXXx+X1cLHbgeKyo83Lx0JxoERWiXG/FA1uxFQ==
X-Received: by 2002:a05:6a02:192:b0:43c:a0cb:44d3 with SMTP id bj18-20020a056a02019200b0043ca0cb44d3mr6859464pgb.139.1664526256594;
        Fri, 30 Sep 2022 01:24:16 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 63-20020a620442000000b00540d03f3792sm1132083pfe.81.2022.09.30.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 01:24:16 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/3] Convert Unisoc GPIO bindings to yaml and add support for UMS512
Date:   Fri, 30 Sep 2022 16:24:02 +0800
Message-Id: <20220930082405.1761-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes on V2:
* Addressed review comments:
- Fixed typo;
- Added description for 'reg' property and modified its maxItems;
- Removed redundant examples;
- Rephrased commit message.

Chunyan Zhang (3):
  dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
  dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
  dt-bindings: gpio: Add compatible string for Unisoc UMS512

 .../bindings/gpio/gpio-eic-sprd.txt           |  97 ------------
 .../devicetree/bindings/gpio/gpio-sprd.txt    |  28 ----
 .../bindings/gpio/sprd,gpio-eic.yaml          | 140 ++++++++++++++++++
 .../devicetree/bindings/gpio/sprd,gpio.yaml   |  75 ++++++++++
 4 files changed, 215 insertions(+), 125 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml

-- 
2.25.1

