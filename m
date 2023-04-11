Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA42B6DE2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDKRnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDKRnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:43:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E64F137;
        Tue, 11 Apr 2023 10:43:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 20so10404418plk.10;
        Tue, 11 Apr 2023 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHN+T7G6mWgrt+GPxH8Y3vfnE/oCvVXhlPd0WPZa4C0=;
        b=Iljm/6Dgj9Zg+wo86q3DupzYS/mlYhhb5GuE+Y+Bkva5L8C19OudQDHeyaSR9+saVI
         E2zYGONtapK5MnRmfVUDPelQGHzFyPKaOpA/b7S/NK6tivNtZWt82yq17Ij1X/RE4F3r
         owjXRe+ZMgud8VONQGRKuditdA/QaEt/Dr1FgsUUe5FztIlX9gX0Xh0th/gLXk0aNnuH
         3xn9m3uV6Tw6rx8IA9Q+1I0IjrI0l8smZdiTYC7Tz9ARHdDkj8kGWDq/g09uN5xjP39T
         mxA4vlsRZyO27yNCTItnN7Dt9hE33WOn3DqGFoT4mGQpGgue7CrmLHbSsO0hJXhxOCAG
         t2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHN+T7G6mWgrt+GPxH8Y3vfnE/oCvVXhlPd0WPZa4C0=;
        b=4f1YqTz3912yj1kfOuYZ+GrFSO3R9HcnH1rPmnJOECgH9HGUztlpJ9JeSNcCnpE5zJ
         PD2axrx5dIUasnFbz2Zgi/m4O6t4s0qDWkgGQSmK5SM84dRmX0NEyfvoO1TPa6eb6BhS
         sRIy8UGZF9w0nTiyscTJLedQMe7TcIcMrioKrZEZiialfXkCzqQ3ykmjcec6t+r5ttAi
         DlU16vzc1G5DKE1aa67fJ08xIcjYMyDwkQPJ0gNggVzoquXOXRrh5e1M7iBv7fDC7HZY
         812nwjDxsDkXaHpTlKuaKfJTSkBLJ/JhV4cVLL8eA53YXP4BDa8VCAW4zGAZBoYQwtDl
         mIKw==
X-Gm-Message-State: AAQBX9eJagi3LpsFnOYTlzU0Zu+QOvuKQubjtdpsXKiI5IcZ0W7IQIMK
        aNd7TUZbzYryi0wNuK16xMinR/jTWoKM4sCuPmE=
X-Google-Smtp-Source: AKy350aYfwApn1Q3poaPk1VHqhVzBoRTpd5SmVdOBvkm61+59VAZEsUER9aVmc4nBQwSv/KCIkuObA==
X-Received: by 2002:a17:902:ecc3:b0:1a2:8866:e8a4 with SMTP id a3-20020a170902ecc300b001a28866e8a4mr21355885plh.1.1681235023676;
        Tue, 11 Apr 2023 10:43:43 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:43:43 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/13] clk: hisilicon: Migrate devm APIs
Date:   Wed, 12 Apr 2023 01:43:09 +0800
Message-Id: <20230411174329.424763-1-mmyangfl@gmail.com>
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
v4:
  * typo: hisi_clocks_get_nr() should check clks->nr first
  * unexport hisi_clk_unregister_fn() as no one use them outside

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230329075104.165176-1-mmyangfl@gmail.com
v3: https://lore.kernel.org/r/20230410110733.192151-1-mmyangfl@gmail.com

David Yang (13):
  clk: hisilicon: Add helper functions for platform driver
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

 drivers/clk/hisilicon/clk-hi3519.c        | 128 +-----
 drivers/clk/hisilicon/clk-hi3559a.c       | 253 +++---------
 drivers/clk/hisilicon/clk-hi3620.c        | 212 +++++-----
 drivers/clk/hisilicon/clk-hi3660.c        | 192 +++------
 drivers/clk/hisilicon/clk-hi3670.c        | 248 ++++--------
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 229 ++++++-----
 drivers/clk/hisilicon/clk-hip04.c         |  39 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  98 +++--
 drivers/clk/hisilicon/clk.c               | 458 +++++++++++-----------
 drivers/clk/hisilicon/clk.h               | 141 ++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 172 +-------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 201 ++--------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  43 ++
 18 files changed, 941 insertions(+), 1556 deletions(-)


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

