Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD468A61D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjBCW0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjBCW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:26:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E469503
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:26:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so10170335pjq.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHxAFePE6v7rT4zOswJZdtSc+7UyWrXh0p5Q9UZZyzE=;
        b=lKfqlinQAeUhCIbSFIAy3NQ96mYo9oFgw3RGTz4iYu0FpfOVZfGxOdGngYCk6NwoU2
         7UARxZhoaYrcQPanC+zuDeqJRcmjmhq82eYXVYI8LCKnrB1lj3npybqxkBhC7JK2Qwky
         /bAIc02GG0JqaH/u0uHl0lUyF1KWhV1iJ7Dwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHxAFePE6v7rT4zOswJZdtSc+7UyWrXh0p5Q9UZZyzE=;
        b=HHjGL7cF0ZtNf6CC1KNoWaHneR1p9Lfc5Q+ICGNAWrcm4C8zijpT86YOgRrhtIIqfm
         5N9IGlTXg2rF2DQ5gKTa+jM+YfNAa4oH7jzGZhXJu9uMi+GirvcVA3HRpXR0ycmyXrxg
         bg+SjdjITBGRW4BaP/TrOKYlHhWp3/SAD9NXiVdxbj2NtlK2nH5V41aiOTovmZdwDcaj
         PScFKvX1ih1qAj4p4XAnLiMgHeXSrwDZtuvbSss4TT2lSXo7lBlylbRM5WpsaytA7WtS
         y7noLZLv0lgBfDhju+7ldq2xkwTuvgluSmPHjYa7ZH5uo305Mj2GI4COmcvA1KkXSUXO
         iBNg==
X-Gm-Message-State: AO0yUKU0gYz74CYxmi7liG44upm5iqjzvoYCmU3m/OjxU+xOrZi4QrvR
        sXfD6/yjYIcv+75Z7HsujiujJg==
X-Google-Smtp-Source: AK7set98RIMuVhD340OlniJTOMaJOWCS/UuD2DMsBdRnheHbwkuTw6SV50oE5XAftSx9a+3PbDm2Og==
X-Received: by 2002:a17:902:ec8c:b0:196:1087:ee04 with SMTP id x12-20020a170902ec8c00b001961087ee04mr14679200plg.18.1675463179244;
        Fri, 03 Feb 2023 14:26:19 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:44f:ac27:361d:7805])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b0019602263feesm2095071pla.90.2023.02.03.14.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:26:18 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15.y v3 0/5] phy: qcom-qmp-combo: Backport some stable fixes
Date:   Fri,  3 Feb 2023 14:26:11 -0800
Message-Id: <20230203222616.2935268-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the qmp phy driver was split it looks like 5.15.y stable kernels
aren't getting fixes like commit 7a7d86d14d07 ("phy: qcom-qmp-combo: fix
broken power on") which is tagged for stable 5.10. Trogdor boards use
the qmp phy on 5.15.y kernels, so I backported the fixes I could find
that looked like we may possibly trip over at some point.

USB and DP work on my Trogdor.Lazor board with this set.

Changes from v2 (https://lore.kernel.org/r/20230113204548.578798-1-swboyd@chromium.org):
 * Keep conditional that can't be removed from last patch
 * Rebase to latest 5.15.y stable tree

Changes from v1 (https://lore.kernel.org/r/20230113005405.3992011-1-swboyd@chromium.org):
 * New patch for memleak on probe deferal to avoid compat issues
 * Update "fix broken power on" patch for pcie/ufs phy

Johan Hovold (5):
  phy: qcom-qmp-combo: disable runtime PM on unbind
  phy: qcom-qmp-combo: fix memleak on probe deferral
  phy: qcom-qmp-usb: fix memleak on probe deferral
  phy: qcom-qmp-combo: fix broken power on
  phy: qcom-qmp-combo: fix runtime suspend

 drivers/phy/qualcomm/phy-qcom-qmp.c | 89 ++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 28 deletions(-)

Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>

base-commit: 9cf4111cdf9420fa99792ae16c8de23242bb2e0b
-- 
https://chromeos.dev

