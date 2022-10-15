Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9EF5FFB72
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJOR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJOR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:26:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64B04E1A1;
        Sat, 15 Oct 2022 10:26:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r22so9427107ljn.10;
        Sat, 15 Oct 2022 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0cVxdBBSHVvduTYNnYRUBvFwKlUY75whFehhw2E/JyU=;
        b=HSlSXTZ2FRZfiUZLskuI5wNhZ1LrdBwjUeOcL0ctyh2dOlkES/HzWo474QEKCfsR47
         6KnX58UQGBSkc8wf6YKbKY8SO/iB1i+l8rzkV58zCB+7djpxCyim3m7Ape2P10grgN0/
         AulXNi89oEGROmHDBlCnPxyeFwvoZBHvjODD5cURWXqkTX7mhsGDhD6+/b5i5R3ImH1E
         KbHiKaI/VmiwvnsnxQcgi4c026J8wP1hVV8C08yg8/WXFygpgUPS1kFDLKp6sBc+WBnR
         AUXKZudruV2PTMDHAGuyHT1+nYroGHCuWJx/GHzRdA2551okPjNx4hcAQGvQ+heDueFB
         FOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cVxdBBSHVvduTYNnYRUBvFwKlUY75whFehhw2E/JyU=;
        b=N5I+zG2PWnkdFkznF4iNWsov/AowQjvhuu/SShPbkFFVF0EtMdW97mYaNO5Sb0IOjC
         oo8wwt9Yga9DbekdpLITqi9DOzbm2dJZxmheZyeNkmiMbMOGHxpI2Y1y7p4JLN7UBzBg
         x40hcGVbr9VxBZ+v6OzNAhSPDFLxTA2Na/B7lH2r9V1+/2qT71nVo1ARJGUZOAXwQ/d1
         exdyiknrnts3D5dwNUV+583E3CCJzFVwIrsPvRgDm+GdzC1Njjhq0gb94XnGCCkopfO2
         LOFsD/Aqp/38L8fCmeciUSj5x/arnlEJzcpAzIBPowqQnc58jAFkI+l80CYYwHFhXReg
         7aXg==
X-Gm-Message-State: ACrzQf2MZy/aB+7xEaKJgEIefD4BX4CjuuSU07rUJGN3P6BoykyfPeXg
        MuZt9xXSoBZnewKTEodi3+U=
X-Google-Smtp-Source: AMsMyM7H8hQvbiS4Jkz3sZJqrr5yOgjY7phUuU5lOsyocc0IYfsgeAYrMXDhdwoebqcVwTaxf4gPcw==
X-Received: by 2002:a05:651c:a12:b0:26f:db13:4bd8 with SMTP id k18-20020a05651c0a1200b0026fdb134bd8mr1352582ljq.354.1665854776951;
        Sat, 15 Oct 2022 10:26:16 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a9-20020a056512200900b00494747ba5f7sm790308lfb.272.2022.10.15.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 10:26:16 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] gpio: tegra: Convert to immutable irq chip
Date:   Sat, 15 Oct 2022 20:26:01 +0300
Message-Id: <20221015172602.84855-1-clamor95@gmail.com>
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

Svyatoslav Ryhel (1):
  gpio: tegra: Convert to immutable irq chip

 drivers/gpio/gpio-tegra.c | 56 ++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

-- 
2.34.1

