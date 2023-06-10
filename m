Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2C72AC2E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjFJOSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjFJOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:18:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578913A9B;
        Sat, 10 Jun 2023 07:18:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7ff69824dso16792645e9.1;
        Sat, 10 Jun 2023 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686406678; x=1688998678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18qfsJwML2WETjitb+8UZsh0CX3sJjeHPfRntT1ssOk=;
        b=abCNud8TN4GuZ1vG0H87kyReB1a7vZKcnWUabKUl5jvqkBI2yUIZ+h9NyEJUEZ6yEp
         +pkbu/a49F5nmgMTiFyYwqMmyP5ux/Rdy9taVXcxiv6x2lonN2uANfH/17dqs60qTJVG
         NP3s91IwhV7Lt5gOTpJqDYRmz575uGPgQ0MQB8SUYGn9atOsbrl6JSoccUUGD6RYoBci
         fRTgIMe23VO63g4SDYjMnwntzBFLriTwbLWqOYMxTGQ5UHBlwr9yTWLfvcO8yXN2tIZq
         nfUojlEEk+RGZK2aUmJz6clRyGx+6/E3p6rutPQbRujWPlTBHtWRftCo/hZ82Auf5QRl
         mIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686406678; x=1688998678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18qfsJwML2WETjitb+8UZsh0CX3sJjeHPfRntT1ssOk=;
        b=K9LqS1c2N4NevfvTf0TQjpzrq8pg4x+QwCLdIycQZ2dmRJKBHcgyxREkilFFSP+Cq1
         G5hjnetDjwvDdjVUxMotTwSYztAns2F+nlxF0QOcknu8ueoOnPAy78tMmLjWvb5KGpey
         hXfsph6OFszo5+n90C5yebry4kPrczPq6Mp49/K6tRkzEJhgzkl64H7eIBh8lR0JN463
         TG6hLrUbxBgOQwlJ0yWssvO4t+Sxt9aeE1nDxwQS7CO5qntlQZLu08PwcusowRbiXtq3
         hXWce/kpGDJ3xOrsZxdDCJ1Et4OQLaB2BSg91ZLmWLSGYRJvp5VD6H9cP/CbGmQC60+/
         rXVQ==
X-Gm-Message-State: AC+VfDzUFV7V1IPEgokVlMnyaKk09v2bOSpw+Pe0fomrHBzyaFclYlmF
        sE+BgCwiSehmGjvNhZY+hC2awDpVK9Ln1eaf
X-Google-Smtp-Source: ACHHUZ5YMqHGIZnwmXgTpw+GIEM8hWEPiU7hk3r0PV6Gw4QXYai2MKh6r6WMLxMO74CwCTZ3ueTXKg==
X-Received: by 2002:a5d:4090:0:b0:307:cf71:ed8c with SMTP id o16-20020a5d4090000000b00307cf71ed8cmr1170279wrp.35.1686406677900;
        Sat, 10 Jun 2023 07:17:57 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f735d6fa74sm5841488wml.9.2023.06.10.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 07:17:57 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/3] Add D1/T113s thermal sensor controller support
Date:   Sat, 10 Jun 2023 17:17:31 +0300
Message-Id: <20230610141739.999268-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Allwinner D1/T113s thermal sensor controller.
THIS controller is similar to the one on H6, but with only one sensor and
uses a different scale and offset values.

Maxim Kiselev (3):
  thermal: sun8i: Add D1/T113s THS controller support
  riscv: dts: allwinner: d1: Add thermal sensor and thermal zone
  dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller

 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 +++++++++++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 26 +++++++++++++++++++
 drivers/thermal/sun8i_thermal.c               | 13 ++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.39.2

