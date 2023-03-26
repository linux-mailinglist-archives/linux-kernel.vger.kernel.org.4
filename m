Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB76C9295
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCZF2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 01:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjCZF2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 01:28:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC912684;
        Sat, 25 Mar 2023 22:28:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z11so3640845pfh.4;
        Sat, 25 Mar 2023 22:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679808489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlFfAJUvKczTOkYz9X2Qooa6CRtdSnd+xdhPi/7m9Ic=;
        b=L7QPuLz52mZgbRhF8kodkVZI8KohR9u4d/6qGl3XTnyuCoiw3xafMbQqXT6VLs8P0Z
         mo5B75+4NI68F7GeS5fhi7vgEIgzXzj5fn2laRyZ+apJr9pO1lzLghYY7aZQPAKalXAb
         oSowzpiu6Sd5hsnhMKDlA7NJs+beMgcLtmN8jAbr4ziQ9iF+2t+kafIK32bUyzJPoVZ2
         I7LCBqRgtwlSLYZy37IUH1zUCASMKls0ifBaPcDywQ7Y35MVW3MFwxB9IG2O18Tb9wkH
         73JpzOZRcPWnAkz/n79aptdvoN4pNfjjWJZ/i1aQFmaGdXKrE6EnrJ+uguwD/vmZeskm
         uP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679808489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlFfAJUvKczTOkYz9X2Qooa6CRtdSnd+xdhPi/7m9Ic=;
        b=aseg7+sZooAdSFsuWtz3KbzCMp2B4jumqwuU597YVMsyxheBBl615cfMhHUg1+BOzT
         fvR9sk4jwDBlu+IQA37uJkzS4T0mCLBrAllQekwMlOEqkqSw2474ym/GS+BgyIFAJ2rF
         4gwmzMNf+Xi31/h52iR73Cc/10X32AqAU9FB7CRXufG5BLJ/sCA03l/LAPuA9pL28+cD
         MT/TskX2DDT3aez6/VuSega6Baao9bm9Dcnzr2oMkZj0XOtsLIh3FCG2tzqvZKTIRgO/
         91rHonmnNliVOhwPDZPFtuGBT2fA5W6p4kAP/rlLG/yPMgh5xL+ySbVXBKwzDtEoQn1k
         aKCw==
X-Gm-Message-State: AAQBX9d66LETPKd41gNwOqGix6GogTPfs09xmMX9nUlpwvV7GIdZV0qP
        YELsundKJGzkEirCsMoWDDNpvgZvzFuRLZPv
X-Google-Smtp-Source: AKy350bBvgrqC0e9d5NlAmPja6o7DsXjICg6612sMXhN5Eqs39M42xT8/G+33qQx6foyBlxpHwbcjg==
X-Received: by 2002:a05:6a00:4e:b0:628:a3d:8aa7 with SMTP id i14-20020a056a00004e00b006280a3d8aa7mr8168682pfk.31.1679808488703;
        Sat, 25 Mar 2023 22:28:08 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id b14-20020a63eb4e000000b004fb5f4bf585sm15966915pgk.78.2023.03.25.22.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:28:08 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] clk: hisilicon: Migrate devm APIs
Date:   Sun, 26 Mar 2023 13:27:46 +0800
Message-Id: <20230326052757.297551-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.

This series is a partial improvement of
https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com

David Yang (4):
  clk: hisilicon: Add helper functions for platform driver
  clk: hisilicon: Use helper functions
  clk: hisilicon: Convert to platform driver
  clk: hisilicon: Migrate devm APIs

 drivers/clk/hisilicon/clk-hi3519.c        | 134 +------
 drivers/clk/hisilicon/clk-hi3559a.c       | 253 +++----------
 drivers/clk/hisilicon/clk-hi3620.c        | 215 +++++------
 drivers/clk/hisilicon/clk-hi3660.c        | 207 ++++-------
 drivers/clk/hisilicon/clk-hi3670.c        | 270 +++++---------
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 230 ++++++------
 drivers/clk/hisilicon/clk-hip04.c         |  41 ++-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  93 +++--
 drivers/clk/hisilicon/clk.c               | 429 +++++++++++-----------
 drivers/clk/hisilicon/clk.h               | 147 +++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 177 +--------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 206 ++---------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  64 +++-
 18 files changed, 989 insertions(+), 1560 deletions(-)


base-commit: fff5a5e7f528b2ed2c335991399a766c2cf01103
-- 
2.39.2

