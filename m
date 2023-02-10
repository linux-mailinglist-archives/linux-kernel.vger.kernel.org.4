Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926DC691EED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjBJMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBJMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:17:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE742595D;
        Fri, 10 Feb 2023 04:17:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r2so4875029wrv.7;
        Fri, 10 Feb 2023 04:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GtawY8oWeIYXuXjdwYHjs+M4IPl6CxeJndbzMfY3rXE=;
        b=ZLbagUerUCMRDorxs7LjYGEZVZHaLVrU1ymNqbf4btprlyG9XlRo+3geo4H8C01Rrv
         4O2i3yuJe1vnZZ8dxj0yaHohcw2aatbENfHmdQJ1H4121NvSV6wW6Ev5cC24iGdzLoPH
         c3CQH28Y5SWNDXOfLanPtNjA7SrGTipnlsX5gysH4kPi1ouyMHXBgkssv6Q6Y8edy+uO
         /Uz6GCI9lPi9aHDBYVn5j1gUcCGY/i6I0sawMjmvQMB4i+NbAsp8Zxt6nJRD8+pumDMH
         T5jAcpZalzOUh0398D5qLA3V7TXrK//FjmHdvJ36UpsfwqjkKKvHAeiB1oRi01ivtAG4
         cm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtawY8oWeIYXuXjdwYHjs+M4IPl6CxeJndbzMfY3rXE=;
        b=zacS3JIJ0rPlHvuUIu6rCeyEsxIXVCOT5Efmgz+ADFRQqRSMCICZKKVMt53jglNNQK
         aK8KMgOz7XZXEF1q5XbcWIBK1fOy2GVNpnQfz3U2B6cfgtm6yjADrDyKnbMVDLq5IhtD
         IWHJwZkCOXbzNxUHW7onKrjZD7++dzcQGZuTsWYREma06Jm0SdhGNV9AiU6PWMmng4aL
         Tga66AOsk28s/48BwglIXx0PbI++HZwKD8mED6vbbJRwJKaStiRk6kJm6BL237ZNgsYu
         C28K11afCA+s3MkmzMdnH+1dViQ8rYCL/zytg2dL/78GF5AEfXYSuxNQ5t+GjmGo5EJK
         HUNw==
X-Gm-Message-State: AO0yUKUbQmlIZdVNVni1XJ/ANliOojSPoYIboM1DyDQ5wuqIyI6Qt0vR
        f706HZ2NeNzpCE7a96C8aqwDHOdUyc4=
X-Google-Smtp-Source: AK7set9CAtxT4PjlgHq8ePvxDqcO+KlDANJLH1mjo4a83S/dD+G8qXEZct2MSDkWc4IvIWTIp1UXVQ==
X-Received: by 2002:adf:f350:0:b0:2c3:da3f:1def with SMTP id e16-20020adff350000000b002c3da3f1defmr15630308wrp.7.1676031457500;
        Fri, 10 Feb 2023 04:17:37 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm5359820wmo.2.2023.02.10.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:17:36 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 0/4] watchdog: mt7621-wdt: avoid globals and arch dependencies
Date:   Fri, 10 Feb 2023 13:17:31 +0100
Message-Id: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hi all,

This series make an update in the MT7621 SoC's watchdog driver code. This
SoC already provides a system controller node to access reset status
register needed for the watchdog. Instead of using MIPS architecture
dependent operations in header 'asm/mach-ralink/ralink_regs.h' use
a phandle to the system controller node and use it through regmap APIs
from the code. Driver is also using some globals that are not needed at
all if a driver data structure is used along the code. Hence, add all
new needed stuff inside a new driver data structure. With this changes
driver can be properly compile tested.

Thanks in advance for reviewing this!

V1 of this series here [0].

Changes in v2:
    - Remove no needed compatible 'syscon' from bindings.
    - Rewrite new syscon phandle description in bindings.
    - Remove 'syscon' from compatible in 'mt7621.dtsi'.
    - Split PATCH 3 into two different patches:
        - PATCH 3: removes static globals using a driver data structure.
        - PATCH 4: remove ralink architecture dependent includes and code.

Best regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-watchdog/20230210065621.598120-1-sergio.paracuellos@gmail.com/T/#t

Sergio Paracuellos (4):
  dt-bindings: watchdog: mt7621-wdt: add phandle to access system
    controller registers
  mips: dts: ralink: mt7621: add phandle to system controller node for
    watchdog
  watchdog: mt7621-wdt: avoid static global declarations
  watchdog: mt7621-wdt: avoid ralink architecture dependent code

 .../watchdog/mediatek,mt7621-wdt.yaml         |   7 +
 arch/mips/boot/dts/ralink/mt7621.dtsi         |   1 +
 drivers/watchdog/Kconfig                      |   2 +
 drivers/watchdog/mt7621_wdt.c                 | 121 ++++++++++++------
 4 files changed, 90 insertions(+), 41 deletions(-)

-- 
2.25.1

