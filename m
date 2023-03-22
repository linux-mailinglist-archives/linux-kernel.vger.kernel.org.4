Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19066C50F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCVQmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCVQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:42:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F1561312;
        Wed, 22 Mar 2023 09:42:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso24021505pjb.3;
        Wed, 22 Mar 2023 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/8XZE/yFGszOzfw0A58HIjFpMY0V+dYfoL8G0BVVcs=;
        b=fM8RkQKsMmwWsUP7O7/y8UnpeZSLgcrKAtMjc3SSpkkDVndUCJ/+Pjl1hx2cHVKhDw
         aKV+ENzYx+MTURok8OKsaMEPtVH+rldgsL+4UlUmVwJ0QoxWEMQ7ZlQQGZopCF8KfnXr
         +4Y4cPX5jHKSeP6iKDPAmJo9z+u8j1rqHswrPbOs4ZkbVJ8vlXTAFhAYo0s80vrLWXOP
         zw7mxAiiReBD85l+K/jALk4gIqvnP+LuSZXLc2KsoS1B3lVcr04WoDVMTWX9edmy1SiV
         iKT7qgxJqL2TzQ0CZ1RFk/AK4uxQtDFgN8ZX0xg2pWJurDlvomiAZlZFOwhYNt1vwUTO
         C1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/8XZE/yFGszOzfw0A58HIjFpMY0V+dYfoL8G0BVVcs=;
        b=NmhSrUQE4PodH4JYVgkOdE1lrVkb5NK+j5sEShXIiNo6xl1d4AGyG7hKM/b2Cweh3T
         /1ckCh7gTsJCzp+D0FTlbCSP9KZCpDZRzva5d1MjuRstN1a4GCwVVqPUssWJAg+mnhsF
         Ot70jM+1qZng3vh2DwAXaRuWzXKr/qoIreTziD5yn3JmgCHbMv1zTOxKnBZdGPKkJQ+w
         tXFc9wwDOAkSrP2LIZUiYfp3MALuUhg5OWbLpIvrNTzzInOqEllbA2mWZQGlDP8xHX7B
         RB9yCeIRFPlmy6KcEzbsGLppFkN+uWEiAv4GcnzuGdhfMwq9ymoGxgRkIsCLHUMolMz/
         WPPA==
X-Gm-Message-State: AO0yUKWRpqTJ6C7DdgN46U78cmT/0TNqSBBu4J4fMNbksiOWSjX+IbEx
        svE4XXKgJsfLRS7SOUa6mOI60TInfUt/uTlQkP4=
X-Google-Smtp-Source: AK7set9ZfbnDEO3Ylc5yn357paNbmmijhhNTFDuNLoU+2z5afNKrEOAw6Ae99HVNGoctPuiMgy2XgQ==
X-Received: by 2002:a05:6a20:4d92:b0:da:acdf:d241 with SMTP id gj18-20020a056a204d9200b000daacdfd241mr130784pzb.45.1679503332548;
        Wed, 22 Mar 2023 09:42:12 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:42:12 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/9] Add CRG driver for Hi3798MV100 SoC
Date:   Thu, 23 Mar 2023 00:41:48 +0800
Message-Id: <20230322164201.2454771-1-mmyangfl@gmail.com>
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

This series adds CRG driver for Hi3798MV100 SoC.

v2: move bindings to a separate patch
v3: fix bindings commit message, reorganize patches
v4: add ethernet and gpu clocks
v5: add complex clock
v6: migrate devm api
v7: fix devm api migration as requested

Links:
v1: https://lore.kernel.org/r/20230303151417.104321-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230304063333.162309-1-mmyangfl@gmail.com
v3: https://lore.kernel.org/r/20230307032243.14988-1-mmyangfl@gmail.com
v4: https://lore.kernel.org/r/20230315211628.963205-1-mmyangfl@gmail.com
v5: https://lore.kernel.org/r/20230320204042.980708-1-mmyangfl@gmail.com
v6: https://lore.kernel.org/r/20230321200031.1812026-1-mmyangfl@gmail.com

David Yang (9):
  clk: hisilicon: Rename Hi3798CV200 to Hi3798
  clk: hisilicon: Extract common functions
  clk: hisilicon: Remove hisi_clk_alloc
  clk: hisilicon: Add helper functions for platform driver
  clk: hisilicon: Use helper functions
  clk: hisilicon: Convert to platform_driver
  clk: hisilicon: Migrate devm APIs
  dt-bindings: clock: Add Hi3798MV100 CRG
  clk: hisilicon: Add CRG driver for Hi3798MV100 SoC

 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 drivers/clk/hisilicon/clk-hi3519.c            | 134 +----
 drivers/clk/hisilicon/clk-hi3559a.c           | 253 ++-------
 drivers/clk/hisilicon/clk-hi3620.c            | 214 ++++----
 drivers/clk/hisilicon/clk-hi3660.c            | 204 +++----
 drivers/clk/hisilicon/clk-hi3670.c            | 267 ++++------
 drivers/clk/hisilicon/clk-hi6220-stub.c       |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c            | 229 ++++----
 drivers/clk/hisilicon/clk-hip04.c             |  38 +-
 drivers/clk/hisilicon/clk-hisi-phase.c        |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c           |  90 ++--
 drivers/clk/hisilicon/clk.c                   | 428 ++++++++-------
 drivers/clk/hisilicon/clk.h                   | 146 +++--
 drivers/clk/hisilicon/clkdivider-hi6220.c     |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c     |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c       | 177 +------
 drivers/clk/hisilicon/crg-hi3798.c            | 498 ++++++++++++++++++
 drivers/clk/hisilicon/crg-hi3798cv200.c       | 401 --------------
 drivers/clk/hisilicon/crg.h                   |  11 +-
 drivers/clk/hisilicon/reset.c                 |  64 ++-
 include/dt-bindings/clock/histb-clock.h       |  13 +
 23 files changed, 1463 insertions(+), 1786 deletions(-)
 create mode 100644 drivers/clk/hisilicon/crg-hi3798.c
 delete mode 100644 drivers/clk/hisilicon/crg-hi3798cv200.c


base-commit: 6015b1aca1a233379625385feb01dd014aca60b5
-- 
2.39.2

