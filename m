Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8D62472E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiKJQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiKJQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:39:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0621B4090E;
        Thu, 10 Nov 2022 08:39:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so1523334wmi.3;
        Thu, 10 Nov 2022 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPS72kHKQGCf5rLpmI57VmrB9xABKgUVDzpM2NFF7pk=;
        b=ieZkuqknPgQ1qIuwdL7tqsFx53KlGtnhpSZWz6dyzv+0AX/WN4yTshjlzEsoDn0neA
         j1cshfm7J9ra5YO7QcgFbbYZK1Qd/XoEm7USrlv7gKiTiuQdyrrEvpHPDq1g4wVNWL1T
         tmMjvhI9GCczAPBSWZcfOo9G/EgPgLunGaXWSDErpRS8RHFKafxXJS6lhRnht1wi4oV2
         1xoafM/fficGAsjqcMwQlPQMpM2RHDgSpj5OjhyrliRaCbs3qYn4QM9MEl2g4HWLlrwD
         muIABmKwgDELkyPb57QWLmXVeWK8eepYw9GSr9aqQ85xm7mTsPmyVnc5PqihjVtwGhM5
         lHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPS72kHKQGCf5rLpmI57VmrB9xABKgUVDzpM2NFF7pk=;
        b=7hMv73ZiDD5Jry9Sl0aVaumF3w+wXvlKFxrrMguWHOX788i3X+ANap776E3JZpXimP
         v/YTby6oaxZzOVVBsYiKnyxgLg2qhzJejweYgDwpIJCzsnT0RSKqaO8ynnIPGWcW3cq9
         JwV5H/yz6eoGZRjTHE5LeUjToTDZAmc6NAqvoSoOYtzP2RKWsUjMTE1Pip7rKkFxwWV5
         GlMLkGD4z2+8PZku4gMJ8c8K5+VQCJdPCi3cpWgJuZgYf17eq8Ne/3Bh4vxW5XBZHxn4
         fi/AOMTlEaglMBj54b2pXpNJMH+nvehjVpAPB4/W/wEdGQqenzQXrTkjWa0wK9u+2LUt
         2YDg==
X-Gm-Message-State: ACrzQf32Xj7ZjmpAGVM6vek5VLPkZTjwZEW9vMfaMmTJnSdtMl8OE9/C
        IGEpu8Bv4qGTJy3nFY/Ccp0=
X-Google-Smtp-Source: AMsMyM4kWjP3Ps1lpVM2FnwvJjVD0UIUXoLYdRV7LJzafR4tqCx3dJxXZx4aVFIcbfv9CiCM85nmSw==
X-Received: by 2002:a7b:cb49:0:b0:3b4:b08a:89b with SMTP id v9-20020a7bcb49000000b003b4b08a089bmr43457111wmj.173.1668098340528;
        Thu, 10 Nov 2022 08:39:00 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id f24-20020a1cc918000000b003b4935f04a4sm128730wmb.5.2022.11.10.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:39:00 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Misc SOQuartz Enablement
Date:   Thu, 10 Nov 2022 17:38:41 +0100
Message-Id: <20221110163845.42309-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables the following functionality on the SOQuartz CM4
module, specifically when paired with the CM4IO board:

 * GPU (patch 1)
 * Video output (patch 2)
 * HDMI (also patch 2)
 * HDMI audio (patch 3)
 * PCIe2 (patch 4), CM4IO board only

The last patch needs specific enablement per carrier board due to the
power regulator the PCIe slot feeds on (3.3V specifically).

Nicolas Frattaroli (4):
  arm64: dts: rockchip: Enable GPU on SOQuartz CM4
  arm64: dts: rockchip: Enable video output and HDMI on SOQuartz
  arm64: dts: rockchip: Enable HDMI sound on SOQuartz
  arm64: dts: rockchip: Enable PCIe 2 on SOQuartz CM4IO

 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts | 10 +++
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 72 +++++++++++++++++++
 2 files changed, 82 insertions(+)

-- 
2.38.1

