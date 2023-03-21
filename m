Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09A16C3B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCUUAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCUUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:00:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E01B2CE;
        Tue, 21 Mar 2023 13:00:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id kq3so4843500plb.13;
        Tue, 21 Mar 2023 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679428851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zl3AN2bR2c47Gsz04WT/Fkytkbat7m4x1pFkQgEqWJ8=;
        b=cSPcqpd8F0HoCIdGtNrHuMjn1yM3WcSxvmCYEjWsx0NMXcC5h3PbVPsIQwNHJvQKf+
         hfEWS8C6wd7Ss6V95AMdDD386S3yp80/a+ycaOXHmDF1lFYuYcfQ26sYwN4gZuefb5EJ
         SYsHpE0Ry0lHI+fM+XD1pHWwRfDtMjcmGqKi+4+VV43kFQ+amBTnqzCDx0v0sX76AeWJ
         4TvmVEnrYwsrNat6xIATKHiAceH3g/A9A1z8oGY3OureUdOV1yY2KdTDOz4OQBNse1eK
         GgFknwAjEnxDqZhMAiSaSndS5I5hoBINVget8Cy7w4oDGUAh/BvSjmkXoK0NfqbmsbZ/
         XinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zl3AN2bR2c47Gsz04WT/Fkytkbat7m4x1pFkQgEqWJ8=;
        b=sjb0gCTemtQ6RrXEEJO8uUsPx+IKUC1cTH4QQ6+yV38MTi2R17HHKLJA4bi8hZGWFG
         hnsXbgb+EzI57e681nu161v38dsOJ3BFJ2qZsoJrOlnXdhCyPDvsLJSA6xz0HcV/7CB/
         Ky8FgG7VSphRHVV+r4hsmqy1EroTYwq52NuttaE+uy7ar+F24vkJjxgTsDvRN7pfAIUB
         1M5Sr89EnUi72i3mms+W47CXRDrtKB0kUxfIgCs2c2jr19FWNX/BoW92426whbcm5kx3
         6Bo6V6YJTagNdkjReT/S8q3irpI8XzjZpkOT/37N1WBnriUTaPo0ust8KyD3UAQTHYs+
         xn5w==
X-Gm-Message-State: AO0yUKXbSL6GSk10qjzrkxP211NR4VxweffwWUJShLnU1b2+GcLwXc97
        wEHilrm4JR/GpZ6WhEG9pGeq+uz0q9HFmgwyIkY=
X-Google-Smtp-Source: AK7set8TCXkyNT9UjVt6FtQxGfe71d6gix72pzxnU6Mmwt6e9uOMwyxYv2B3Rf8oiTRvvtiH+OICQw==
X-Received: by 2002:a17:90b:4d05:b0:23f:2757:ce99 with SMTP id mw5-20020a17090b4d0500b0023f2757ce99mr637987pjb.49.1679428851277;
        Tue, 21 Mar 2023 13:00:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id mt19-20020a17090b231300b0023b5528b8d4sm930557pjb.19.2023.03.21.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:00:50 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] Add CRG driver for Hi3798MV100 SoC
Date:   Wed, 22 Mar 2023 04:00:21 +0800
Message-Id: <20230321200031.1812026-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds CRG driver for Hi3798MV100 SoC.

v2: move bindings to a separate patch
v3: fix bindings commit message, reorganize patches
v4: add ethernet and gpu clocks
v5: add complex clock
v6: migrate devm api

David Yang (6):
  clk: hisilicon: Rename Hi3798CV200 to Hi3798
  clk: hisilicon: Extract common functions
  clk: hisilicon: Migrate devm APIs
  clk: hisilicon: Add complex clock for Hi3798
  dt-bindings: clock: Add Hi3798MV100 CRG
  clk: hisilicon: Add CRG driver for Hi3798MV100 SoC

 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 drivers/clk/hisilicon/clk-hi3519.c            |  45 +-
 drivers/clk/hisilicon/clk-hi3559a.c           | 111 +--
 drivers/clk/hisilicon/clk-hi3620.c            |  12 +-
 drivers/clk/hisilicon/clk-hi3660.c            |  46 +-
 drivers/clk/hisilicon/clk-hi3670.c            |  52 +-
 drivers/clk/hisilicon/clk-hi6220.c            |  34 +-
 drivers/clk/hisilicon/clk-hip04.c             |   4 +-
 drivers/clk/hisilicon/clk-hisi-phase.c        |  15 +-
 drivers/clk/hisilicon/clk-hix5hd2.c           |  33 +-
 drivers/clk/hisilicon/clk.c                   | 245 +++----
 drivers/clk/hisilicon/clk.h                   |  89 +--
 drivers/clk/hisilicon/clkdivider-hi6220.c     |  23 +-
 drivers/clk/hisilicon/clkgate-separated.c     |  16 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c       |  60 +-
 drivers/clk/hisilicon/crg-hi3798.c            | 692 ++++++++++++++++++
 drivers/clk/hisilicon/crg-hi3798cv200.c       | 401 ----------
 include/dt-bindings/clock/histb-clock.h       |  13 +
 20 files changed, 1060 insertions(+), 841 deletions(-)
 create mode 100644 drivers/clk/hisilicon/crg-hi3798.c
 delete mode 100644 drivers/clk/hisilicon/crg-hi3798cv200.c

-- 
2.39.2

