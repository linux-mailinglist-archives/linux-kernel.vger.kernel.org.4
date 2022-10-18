Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD8F602783
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJRIuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiJRIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:49:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C12D13A;
        Tue, 18 Oct 2022 01:49:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j23so16999399lji.8;
        Tue, 18 Oct 2022 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ASVdbX1uwutQ8LkCPHmupGy4+8wzihgP/ZAbqQQYpHA=;
        b=b4m7Xe7OTeZrDyEgwGeokF3uW8vjY4assmR6FL1H8txH1a8jkLZN4sJCp73IJASr0x
         lcpMC3Fnnkag1twnuNDLoOgTXxjCPm8CF8uj/KiICpVlZHDHgkxKZDHIT1N0375aR4Yu
         83RBKJKbHCLhDE4KrvEm6ECCZpMxWwLZTAy3z+zozAcW4E+mO9f1KSER/FRnpfswLW2i
         xUTVL2shoQtbTpfSi3cHVO1Eqjx22oOJCa+Yj/h3RvsQgU8lTaXs7R0TJFW2zPsOpCZ8
         aVp0Ij45XmO7FrRplXplG9s6KcLHH1znjIQxDllTQkIrroX+xUiWTZjiUCi/dvTQm5eW
         q+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASVdbX1uwutQ8LkCPHmupGy4+8wzihgP/ZAbqQQYpHA=;
        b=6jlrGj8LTsiPh2I1k5pgxQvj4n8u7VoZ1jucoz3FhqXg0PRC9BfiIUzy7Q98ki/TJG
         LbmKFwv+E3gt4otLbN9Xt/sBSpwQoXsExgNN07B2imH5DW3a/WGc3KIWtKX71WJHFWMW
         kEdNfr+yVedmrg7YkGFZ9oxY8C5kqKj3c0l+pDHe8EwRj5Xj7gJ5spDAnRosND06v4c+
         qg9QqzdDk4iWUckaOpuWvPqHNSHYCOhBihytQ3a9PX2GCO/rvcGh4p6CS91ZPKIQwMUP
         rlKcI3hpJfVv4jvITTfAlaMARGi9Rb5aGKNCneIl+XjKf0pRappnhSJm4WQnIajED7q8
         XM+w==
X-Gm-Message-State: ACrzQf22AFcZmkOIcpmSCKc4eJWTaIjKLF/0qg7Qb7RJUKmfE6y+g2L3
        d/aDbVTO5OdJq9uzLkc+WQw=
X-Google-Smtp-Source: AMsMyM4CUZ5Fp8sE8xJuSbzZ0w/BVMtoUt9oFVWuH5RqKh/1+zq4ocbxiiOeHU3YdoCESH1L9hkMvA==
X-Received: by 2002:a2e:9181:0:b0:26e:91d8:5796 with SMTP id f1-20020a2e9181000000b0026e91d85796mr708968ljg.398.1666082966108;
        Tue, 18 Oct 2022 01:49:26 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id e10-20020a05651236ca00b004949f7cbb6esm1771890lfs.79.2022.10.18.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:49:25 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] gpio: tegra: Convert to immutable irq chip
Date:   Tue, 18 Oct 2022 11:49:03 +0300
Message-Id: <20221018084905.21717-1-clamor95@gmail.com>
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

Update the driver to use an immutable IRQ chip like tegra186
Switch to new *_PM_OPS and pm_sleep_ptr() macros.

Svyatoslav Ryhel (2):
  gpio: tegra: Convert to immutable irq chip
  gpio: tegra: Switch to new *_PM_OPS macros

 drivers/gpio/gpio-tegra.c | 60 ++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

-- 
2.34.1

