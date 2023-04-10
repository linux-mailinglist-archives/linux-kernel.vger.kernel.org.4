Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA96DC609
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDJLHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjDJLHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:07:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D130F0;
        Mon, 10 Apr 2023 04:07:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso7043678pjs.0;
        Mon, 10 Apr 2023 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681124869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zD/kkTUg/x/mBBCVVvYrEKgZzKWeeY0HaOqSAjzGPSA=;
        b=CvrIJrvuIYBx9FWijEaieZ8Pv7VrCT+Nnq3Ms0uYt+cai9AxJyxYtayiNHsCZt4e4f
         bq5le1TP2P6XS4crAEvjS8iI+ovpm63ls40bLVqccDpnnNAPgtYcbz72qHQMugK2RHC/
         ieFtgrE4/9al3X/Me3fP4Jeoep4rU2RWDnygMEq85e2Xj/pfc8HxKp4C+EboueZOgpEq
         FvUczCH1MkVpkKSHUsHVBxvpOFAr8/VYFlPQ+0LbSe73b7yXsXgPco98QBBEMf8BlBHf
         bfdsdjDXyXuR4U3qMnKLve/s1Mkglmyku/REiPWoQwD3bReRbm7dZifJBsz8uIMEVoqO
         qmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zD/kkTUg/x/mBBCVVvYrEKgZzKWeeY0HaOqSAjzGPSA=;
        b=i5Y4Btj0mcLGEM51qi+Y+0y+XpahDVQ9bt3XSl2s4ARSoVJb9gbgBfo/S+c6C1CfD1
         GsEpamdkgQ7X6FlVpq4EB4JPgbAluVlYNuwX0QLhrIwgVnBJPfn56Ewv4qrTh6oYFR2c
         d9Ytnzq6ELiPiyg2D9hYdN+HG+Vase4zsVWzQdvSeswzorfnUSNf2btMl/jrsXF5aQ/N
         BuHCRNqitIhntqegZDQc/NvR2sTtxjaNiVBZB50iLzf/bu/QK3m+SBgxy48ZE2RfBZLM
         6Z5MUHmbZ/g/4Ax64NSkKkMpGUOr2pDxXAX3TsGkM6mDa96okpQ+QW3RBsiUW1euRm5X
         Yv3Q==
X-Gm-Message-State: AAQBX9d/26/aVDwC/w7QMhJfe2OiaNEbjpLhcqlsn6iVwae67L4Xx5BX
        r1yxh+8WOwzS9gVYmNZT39qUI0RjyX22H9fg/VE=
X-Google-Smtp-Source: AKy350bJde+pxt7G9IIfEIr8J7Jr4BZ5KPKHVqHY7NU37oi2+YS3QXB56trH9BpMTPXE3zlCWxSddw==
X-Received: by 2002:a17:903:192:b0:1a1:a8eb:d34d with SMTP id z18-20020a170903019200b001a1a8ebd34dmr9274606plg.46.1681124868933;
        Mon, 10 Apr 2023 04:07:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:07:48 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] clk: hisilicon: Migrate devm APIs
Date:   Mon, 10 Apr 2023 19:07:12 +0800
Message-Id: <20230410110733.192151-1-mmyangfl@gmail.com>
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

This series is a partial improvement of [1]

v2: fix test robot error
v3:
  * size_t for all these num types
  * hisi_clk_unregister() change into separate patch
  * keep relevant header inclusions
  * split driver files changes into separate patches
  * explain hisi_clk_register_fn() checkpatch warnings
  * not fixed: MODULE_LICENSE("GPL v2"), as stated in SPDX-License-Identifier
  * not fixed: "hisilicon,hip04-clock" un-documented, as none of dts files in
    arch/ use it, better to ask hisi people why they pushed this driver

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230329075104.165176-1-mmyangfl@gmail.com

David Yang (14):
  clk: hisilicon: Add helper functions for platform driver
  clk: hisilicon: Rename hisi_clk_unregister macro
  clk: hisilicon: hi3516cv300: Use helper functions
  clk: hisilicon: hi3798cv200: Use helper functions
  clk: hisilicon: Remove hisi_crg_funcs
  clk: hisilicon: hi3519: Use helper functions
  clk: hisilicon: hi3559a: Use helper functions
  clk: hisilicon: hi3660: Convert into module
  clk: hisilicon: hi3670: Convert into module
  clk: hisilicon: hi3620: Convert into platform driver module
  clk: hisilicon: hi6220: Convert into platform driver module
  clk: hisilicon: hip04: Convert into platform driver module
  clk: hisilicon: hix5hd2: Convert into platform driver module
  clk: hisilicon: Migrate devm APIs

 drivers/clk/hisilicon/clk-hi3519.c        | 128 +------
 drivers/clk/hisilicon/clk-hi3559a.c       | 253 +++----------
 drivers/clk/hisilicon/clk-hi3620.c        | 212 ++++++-----
 drivers/clk/hisilicon/clk-hi3660.c        | 192 +++-------
 drivers/clk/hisilicon/clk-hi3670.c        | 248 ++++--------
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 229 ++++++-----
 drivers/clk/hisilicon/clk-hip04.c         |  39 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  98 +++--
 drivers/clk/hisilicon/clk.c               | 440 +++++++++++-----------
 drivers/clk/hisilicon/clk.h               | 147 +++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 172 +--------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 201 ++--------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  43 +++
 18 files changed, 936 insertions(+), 1549 deletions(-)


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

