Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A585EA144
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiIZKrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiIZKok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:44:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F054CBC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i6so2046351pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0SGdeGxPSfgmPzoXpghs78M4KATohQn7tWSlIXxxmu0=;
        b=J3XtwwiGn04xGBGF5757B1oFtDTeixKKD2CZ9ZPPzOdVT26SaixnJRYDHHkqrSGycq
         iprjQFQHKHmAfmIr95ebOe/MJgaMsexsdTqW84jgqEdoRsXDEYSn4+6VGtpubEB62NAR
         vdfZGCEwMeEUQ2s3/CwM+lITvKjDjEG9jDbis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0SGdeGxPSfgmPzoXpghs78M4KATohQn7tWSlIXxxmu0=;
        b=YqV+NKouB8eWiZOHbCHMByD5j0XVBV6+Lhr3WP6t1WOIUBcgcqDs9vOUEM9ngjyCE2
         UjLSthHvfZweIpo6xrdNvdipiuf6KVomzrffDASKs/g+Wf4SVXQRqdxEOc97zuFHgnBW
         q9fphJCRApUu3l2Zju3eBfcgVUZGA1B33ZKszeeaEjGaL1eE4FgUGEr21vsYtx702GPj
         8/KSFDeKGx/Ell/ybSeCFnDyPeP24qpbRiW65b6ErfdwMMMLxobI7zcjuLeYA2D+uqMQ
         VnadcEyaLZKNPpZRatBq0O0dFVVnRPlOWqF4hhMi1qQ881LocBTu0xmOh41ZAaDx99pF
         6k+g==
X-Gm-Message-State: ACrzQf2yn/yzOrNwzb2bqHqsO9niL0YczVmVQA599/Qqgm2evLCyl1Y1
        90/lHPdym6MbhRZRGa67i9GE2g==
X-Google-Smtp-Source: AMsMyM4UA9RJ4j31Tk60EzVOIh2W+Ow8CAri0MOHZIk8ZChEjnJ232vP1SwnFwo2NvjYg1CUbJrJBQ==
X-Received: by 2002:a63:5762:0:b0:43c:c1b5:3e75 with SMTP id h34-20020a635762000000b0043cc1b53e75mr1487624pgm.380.1664187934413;
        Mon, 26 Sep 2022 03:25:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1340:7319:2f7a:3be9])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm11750236pfp.163.2022.09.26.03.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:25:32 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] clk: mediatek: More cleanups
Date:   Mon, 26 Sep 2022 18:25:17 +0800
Message-Id: <20220926102523.2367530-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some more cleanups for the MedaiTek clk drivers.

Patches 1 and 2 fixes and cleans up some parts that were missed in the
previous clk_hw conversion series.

Patch 3 drops the duplicate registration of the top_early_divs clks for
MT8192. Currently this only contains a fixed divider.

Patch 4 prevents having a duplicate OF clk provider for the topckgen
controller, but removing the previously registered instance.

Patch 5 deduplicates the parent clock lists for MT8192.

Patch 6 adds proper error handling to the clock probe functions for
MT8192.


Please have a look.


Thanks
ChenYu


Chen-Yu Tsai (6):
  clk: mediatek: fix unregister function in mtk_clk_register_dividers
    cleanup
  clk: mediatek: Migrate remaining clk_unregister_*() to
    clk_hw_unregister_*()
  clk: mediatek: mt8192: Do not re-register top_early_divs in probe
    function
  clk: mediatek: mt8192: Avoid duplicate OF clk provider for topckgen
  clk: mediatek: mt8192: deduplicate parent clock lists
  clk: mediatek: mt8192: Implement error handling in probe functions

 drivers/clk/mediatek/clk-mt8192-aud.c |  15 +-
 drivers/clk/mediatek/clk-mt8192-mm.c  |  17 +-
 drivers/clk/mediatek/clk-mt8192.c     | 296 +++++++++-----------------
 drivers/clk/mediatek/clk-mtk.c        |  12 +-
 4 files changed, 130 insertions(+), 210 deletions(-)

-- 
2.37.3.998.g577e59143f-goog

