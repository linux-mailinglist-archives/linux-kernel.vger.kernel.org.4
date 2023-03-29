Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE06CD3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjC2HwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjC2Hvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:51:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DE2D57;
        Wed, 29 Mar 2023 00:51:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so14159642plg.4;
        Wed, 29 Mar 2023 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680076295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYqpY0f00V4P+TW560vLs19Fw8W2KDErt5Od1ihFY7k=;
        b=E6eVJqPZlhkPM2Hl9CVIJfMNvUWYdRgqdd/lZNa7UXnsBqZEPBEK+kIJE5NQvGBHjo
         sl1NOhmKTRW+Byar1cfkUikaPyUePQOAerM99F2+3HMwVw4szPseSOtRijDPBazI/mwl
         RgdRsNYI+J1Bz6/7J9BGtp+XB5awjb9V+oWqyMkxYo+olRuFuuhlqbf6ULUyZLh0ly8Y
         hjXej7YZ9Cjf9WbVdeo/T+I5JVqRPgTs9liCDNmf2Hj69zu/IZBzkJyH5ldnTA6Jlqg9
         zirU3Rg7Ge/1rHad/bYjekwDsVuBSVYWF8WnwYsFPmnuU5U71zA9oDVwM0Fsr35ZJ2ru
         s/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYqpY0f00V4P+TW560vLs19Fw8W2KDErt5Od1ihFY7k=;
        b=P/6znPuEkfR/mGrWBRQYpRlzTfpVlSCvkFsq0AY/E1WMRf+D+oNRk1KRXenVE4gzb0
         BZ16b6f6AOZ+SFc4fNNSciGB2RaF2e4bYPVVrb54lsjUsO6S7vSD3gA4aLcf7MQtf0VP
         RJLmS6xXxf10tZ9JkZZB5EPnVQgUh+8YOnhanaHuNlnd/p1vp/KbP/kaprJPjVcjBKqT
         BwumJX4d2L/Pz8qL4YGGlgnsnifqlxfHJ6++zjTssUXM8kI+KhaLrzK2EKS8B8bKz7PI
         c4YybFX4jw57TvHlYmQWnHMl44FIKNykBwm41ijipd1kkNCEAcWgoApVscNAmK1zhn5z
         mPvg==
X-Gm-Message-State: AAQBX9f57tGXwq0zpjcUdvVRqly5/FCvC6jyCcBH5qzAQhvnc8TuLyK9
        4Q0U/N6uowUuv7VUebQTuGAAeE7dBs9XaGKM
X-Google-Smtp-Source: AKy350ZrgKGyeAQkc9qQrF+ZmE3KrgTp0o1lYuCNdrbwLftpbE5/CqepmlTJkP5Ev4B7YwauhxAV3w==
X-Received: by 2002:a17:902:ecca:b0:1a1:defc:30d8 with SMTP id a10-20020a170902ecca00b001a1defc30d8mr20356162plh.32.1680076295100;
        Wed, 29 Mar 2023 00:51:35 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019a773419a6sm22357976plp.170.2023.03.29.00.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:51:34 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] clk: hisilicon: Migrate devm APIs
Date:   Wed, 29 Mar 2023 15:50:49 +0800
Message-Id: <20230329075104.165176-1-mmyangfl@gmail.com>
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

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com

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
 drivers/clk/hisilicon/clk-hix5hd2.c       |  96 +++--
 drivers/clk/hisilicon/clk.c               | 429 +++++++++++-----------
 drivers/clk/hisilicon/clk.h               | 147 +++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 177 +--------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 206 ++---------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  47 ++-
 18 files changed, 973 insertions(+), 1562 deletions(-)


base-commit: fff5a5e7f528b2ed2c335991399a766c2cf01103
-- 
2.39.2

