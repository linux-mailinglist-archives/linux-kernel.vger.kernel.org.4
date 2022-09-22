Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5E5E5F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiIVKE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiIVKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:04:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C8AEDBF;
        Thu, 22 Sep 2022 03:04:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k10so13809499lfm.4;
        Thu, 22 Sep 2022 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=sR4P6OF9nNhFdMs6z46bc5wC2+2OXmKOYyGSABw3QRs=;
        b=lVU9xIhWyANIEQXZqcprTFf7LDhD8rj0LBH469KaC31jkZobAkIPhTuB4StWQKEgio
         5K1oabEEbPYKts6RlE6+NLeG1eCzIKokIEUT5EU8KvxpqsfY3y+ynEw4VG7yBVp5waDJ
         JqcgPq0KIF0tL9ZviurPNr/Q0ntr/K3ESTJowOlusMlxfU7Rg5wlUut3PQWSRTj17ElI
         RtIVYwGokJPcwN7wTa/Z2IGfz6dAhCQedub4LNWGSoU225mCF5nYfMXOja9SFlU782NU
         DGgb9r4HV6dsg5C/6d81NuttfRM10JBNSCJb4kea62NHb6mpNk+lmWmYIx5BjVc5QeKI
         mkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sR4P6OF9nNhFdMs6z46bc5wC2+2OXmKOYyGSABw3QRs=;
        b=BJ5/AN5LA2lJNjrpOCwEGu5vezmBtfGIqILJX9cDH/Ci0RTzyOKuYqsBdCDKsCZSjZ
         EmLXlQbhiCSpeAQ0rl+omdLZbVDJAjlAisdLbcppR2rBArE3QUPKgVkJz4jIHlVmSN5o
         slChSA9xF6+QGTxQfwbu+0dnZyiizOFvckCeWhvTSkqT88y5kB5pVhAJ6uuaqPDAgHn4
         GPuRuUy6gkD/pLrB4t6UfDIOlZFwQ0T+Y6tg7OC23ftWrrDwMjoVMjHams7NMvMeS791
         gLFe13DFzyBFoRns2VJor4fNEIxEcbmsgQtGP3OhU0W6S2zTiqm+9CApUgrXB6+xsiOm
         9AxQ==
X-Gm-Message-State: ACrzQf3gZ65cARC4YDt3LYzV+qB7z0UbSVT6CH26y+FnI+7KguLj8TCU
        +n/o/yzD112mEra8XmABCMQ=
X-Google-Smtp-Source: AMsMyM7pi578yM27/7YOy70OP0AEwas1MlyhCT6wlicrXeuX5rUj+d+qNda4p5wbHNXc/sQzq1bb5Q==
X-Received: by 2002:a05:6512:6c4:b0:498:f6fd:e82f with SMTP id u4-20020a05651206c400b00498f6fde82fmr863147lff.105.1663841060543;
        Thu, 22 Sep 2022 03:04:20 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.59])
        by smtp.gmail.com with ESMTPSA id t13-20020ac24c0d000000b0048b064707ebsm864320lfq.103.2022.09.22.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:04:13 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] gpio: tegra: Convert to immutable irq chip
Date:   Thu, 22 Sep 2022 13:03:38 +0300
Message-Id: <20220922100339.12565-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates gpio-tegra to use an immutable IRQ chip for all tegra
just like it was made before on t186.

Svyatoslav Ryhel (1):
  gpio: tegra: Convert to immutable irq chip

 drivers/gpio/gpio-tegra.c | 56 ++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

-- 
2.34.1

