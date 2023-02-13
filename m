Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F9694540
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBMMHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjBMMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:07:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D31A667;
        Mon, 13 Feb 2023 04:07:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n13so8530368wmr.4;
        Mon, 13 Feb 2023 04:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qIe/r9mtEwhdvVyE7xopkyv6C9oZIn7clQlBN8qdMMY=;
        b=kepk6NN6rirGl0ugTuXjEO0p/+KlA4ZL8G9nVAH71WeykU6x0KkaXcLvHnMgdQymLd
         gsDiG2lRWktkwtQuN9cwvazad9kDEBORfoAnxYX05ziLGmOiM20cwndYpgpVv/X+RtHM
         vZT6CbQmaYvMQX4oHwkQk3AlDHWAmAP1/ZLXOFa4jQq1o6vsevphFHbWgQ48F5X5FB3o
         7i7HWWY1RuCSvLC38doiZdm7qaEr1DAgtmkWAHu6gcs8yj6/yWVg4JRWpAVHsYmB7hSy
         UOb5UKZt0Adi/QU31jEnsu9N4yxty4/o/2cCGcoJG8J4z54s28R/3TY7okXw184OajSs
         +EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIe/r9mtEwhdvVyE7xopkyv6C9oZIn7clQlBN8qdMMY=;
        b=u6DPZGqIZg5NpSk3YnKjDMWC5GwSxEnm/ZoPwaH1ILmlCWRpMtg+uwsVq5VAdnt5GO
         YVIX7TrSMqSQCvCcR44anUNgtEdQ6vfhSAtAC1UUrZ8oNTuFebti81BMZxXWcU93d6hV
         pMemN60E4A28NdzsT72EYJMnHMY8Admz1jxjiLfUXc5HBdXHF9dacis1rSDZtlJ9mHKo
         rVlcuvWumYwJUnF1L05eAU9iM66yQu80DuOdbsLGdvY4IIefodcgOHGut3h7wlSJgiGp
         3RGsk1UWY6Fqq2lcHupaLsqjjMWMHJ06eItZRO0XnX6OyH0iP6UJlvdHcYBO1iogkyLA
         qMCQ==
X-Gm-Message-State: AO0yUKXmUU0hQxLvDbvqGx+XBYO9DzGuev3dKUqjU2Z5xhWU2fQer9aW
        w+EbH0Omz+OEoNJADWfTWR2tLxgSuwk=
X-Google-Smtp-Source: AK7set/15D6mq15XzGu3c5gMXOqy6dzq7wfhOfQQCzO/fzVFdTPZAlofS7xN9HHMY7EqGV4jZVoDRg==
X-Received: by 2002:a05:600c:331c:b0:3df:ee43:860b with SMTP id q28-20020a05600c331c00b003dfee43860bmr18775270wmp.23.1676290000779;
        Mon, 13 Feb 2023 04:06:40 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003dc434900e1sm14798046wms.34.2023.02.13.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:06:40 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v5 0/2] avoid globals and arch dependencies
Date:   Mon, 13 Feb 2023 13:06:36 +0100
Message-Id: <20230213120638.850612-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
dependent operations in header 'asm/mach-ralink/ralink_regs.h' could use
a phandle to the system controller node and use it through regmap APIs
from the code. However this means to break dtb's ABI so previous series
patches related with this have been droped from this version.
Driver is also using some globals that are not needed at all if a driver
data structure is used along the code. Hence, add all new needed stuff
inside a new driver data structure.

Thanks in advance for reviewing this!

v1 of this series here [0].
v2 os thise series here [1].
v3 os thise series here [2].
v4 os thise series here [3].

Changes in v5:
    - Drop patches related with device tree ABI breakage and only
      maintain the rest.
    - Collect Arinc 'Reviewed-by' tag for watchdog node warning fix.

Changes in v4:
    - Add a patch to fix a watchdog node warning with 'make dtbs_check'
      because of a wrong node name.
    - Collect Guenter 'Reviewed-by' tags for watchdog driver code.
    - Add a missing 'COMPILE_TEST' to Kconfig which was lost when driver
      code was split in two patches in v2.

Changes in v3:
    - rename phandler from 'ralink,sysctl' into 'mediatek,sysctl'.
    - Drop error message added in PATCH 3 that modifies functionality
      and we only want to maintain current functionaloty by now.

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
[1]: https://lore.kernel.org/linux-watchdog/20230210121735.639089-1-sergio.paracuellos@gmail.com/T/#t
[2]: https://lore.kernel.org/linux-watchdog/20230210173841.705783-1-sergio.paracuellos@gmail.com/T/#t
[3]: https://lore.kernel.org/linux-watchdog/20230211073357.755893-1-sergio.paracuellos@gmail.com/T/#t

Sergio Paracuellos (2):
  mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into
    'watchdog'
  watchdog: mt7621-wdt: avoid static global declarations

 arch/mips/boot/dts/ralink/mt7621.dtsi |   2 +-
 drivers/watchdog/mt7621_wdt.c         | 102 ++++++++++++++++----------
 2 files changed, 66 insertions(+), 38 deletions(-)

-- 
2.25.1

