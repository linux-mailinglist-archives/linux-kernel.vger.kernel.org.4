Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADF6D5C27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjDDJnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjDDJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:43:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4661C19BC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:43:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h25so41609516lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680601389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRzv9smVSuXlAiuE6nE47MRg/YlyfJfzc/qVDw1E+Jg=;
        b=YeuAYOJg8RKBKpsfUQjs/kgAenYVEmVwzqJbLFsEPK/KvREOv8xHEoKRmXoFF7sPyG
         v2qbxWjM6hY16GcIoIv5VlHp1y3IWXkCvM033GOY60rNXlDxTma6lriRVkpEecryoOuI
         4Swi+Hc4peb5e13297zht3+L7ukFfdsHE1oflRo/336tvzgz+SlmDq1uV/oG7cqiw3SQ
         ZDDW8p1Fg9K6mHpto+5dHuUssMgWQG9JwDkCUgkJMewCircHt2XNc5aqRRfRZVCQGN5L
         UcbwPZmtLWSbcIk7BUNj1Q0lKn6PxJYm2CxlJ+uzg+3ec3cyst41vGif/jvVpx6dTIIj
         Wt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRzv9smVSuXlAiuE6nE47MRg/YlyfJfzc/qVDw1E+Jg=;
        b=ifvkZseQxVNU/V8H8AdFfwMdr1cJHh3AFHsajcVfhnJ11Ee+D/4tZtlxiJcxnfh453
         Pv+SLDbAtyL5YQwVDZu2GZmp3h23q9uOG2BwBvX7BbvpR5atB5CoQWx53HPl7q49OCEw
         LQ8V+zfm3RBdp7PbF8lqhy+EfSrkPaCUPhhjee4BiywRcmLsuGQQNh0nxIv5MTg4LyLg
         UBDDxbNMTG6X3uNnXub+jN/pWQtVpvoM2+yTrLANR1UVY2+7AKJtg49bUtZSQwJB/536
         FLuLOSdproIxrDs1MnmVpiNfyfvOIVP8J5hdWVOKttVt4bKIm+DMcf7y+nTexn6/48+I
         rkjg==
X-Gm-Message-State: AAQBX9c1Q3/2e+jPH3uYqG5KopscqYGdklk0lkJl6zE9n4ewUzT6aZ/R
        6poD5/UcQTTtJHrNk4YJbABhPQ==
X-Google-Smtp-Source: AKy350b7Z4E6Q1dfw8Fpr7MDoDfW/n0vIeQesGBJNCLP89rnF9qd2fn2IS/qJGPHUXKFEfnY+2tHEg==
X-Received: by 2002:ac2:4c34:0:b0:4b6:f51e:b8b6 with SMTP id u20-20020ac24c34000000b004b6f51eb8b6mr517329lfq.56.1680601389522;
        Tue, 04 Apr 2023 02:43:09 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l25-20020a19c219000000b004eb258f73a9sm2218443lfc.163.2023.04.04.02.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 02:43:09 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/9] Convert low hanging pinctrl irqchips to be immutable
Date:   Tue, 04 Apr 2023 11:43:02 +0200
Message-Id: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACbxK2QC/22NSw7CMAwFr1J5TaS0qcrnKoiFkxpiiYZgU4RU9
 e64rFmO5o3eAkrCpHBqFhB6s/KjGLS7BlLGciPHozF0vgu+98HxNM0vjHcT8kyZq7rjAdMY+j2
 1wwAWRlRyUbCkvKVX/sz1T7dNq5Dp3//5sq5f3vhqFo8AAAA=
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This repeats the two-fold exercise in the GPIO subsystem
by doing the same for pin control: let's switch over all
easily identifiable irqchips to be immutable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (9):
      pinctrl: iproc: Convert to immutable irq_chip
      pinctrl: nsp: Convert to immutable irq_chip
      pinctrl: armada-37xx: Convert to immutable irq_chip
      pinctrl: npcm7xx: Convert to immutable irq_chip
      pinctrl: equilibrium: Convert to immutable irq_chip
      pinctrl: mcp23s08: Convert to immutable irq_chip
      pinctrl: st: Convert to immutable irq_chip
      pinctrl: stmfx: Convert to immutable irq_chip
      pinctrl: sx150x: Convert to immutable irq_chip

 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c    | 38 +++++++++++------
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c      | 23 ++++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 34 ++++++++++-----
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c   | 34 +++++++--------
 drivers/pinctrl/pinctrl-equilibrium.c       | 22 ++++++----
 drivers/pinctrl/pinctrl-equilibrium.h       |  2 -
 drivers/pinctrl/pinctrl-mcp23s08.c          | 36 +++++++++++-----
 drivers/pinctrl/pinctrl-mcp23s08.h          |  1 -
 drivers/pinctrl/pinctrl-st.c                | 16 ++++----
 drivers/pinctrl/pinctrl-stmfx.c             | 36 ++++++++++------
 drivers/pinctrl/pinctrl-sx150x.c            | 64 +++++++++++++++++------------
 11 files changed, 190 insertions(+), 116 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230403-immutable-irqchips-98acd347e166

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

