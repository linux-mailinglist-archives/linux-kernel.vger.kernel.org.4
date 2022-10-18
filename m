Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334AD60238A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJREz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJREzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:55:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6384F68F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g28so13018843pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5tX9Wl81PhQGUCZyqodqMuBbo62lHvN02l/1DnN1CY=;
        b=lBUzF0qSP6OCY8LpeWHglSg+CFL48y3RuTSeZ1O4eOctBVERnsUQPOZCfSaOXx2FFe
         6sXFlLoCtPEmPSWnC9OsSS7FGu07HJG4ZRp6Z/t+un8YwAf3mWQ24BeJySA9IYqkIhzd
         xhKQv/2Dn1DIJGGN9jrRpHKuODXVuDYHvsqdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5tX9Wl81PhQGUCZyqodqMuBbo62lHvN02l/1DnN1CY=;
        b=cb71AgFt4IeLROthQfQTiKDxgUaQY2nzavwrZfBIjrH5dIgZ+OQ15UkjgOiHqG+GGS
         9xvmg88bTrDRC/2YNXk0SDg3t762X+4/ktH5Lo8MNIlNzy+8bTjJo7Tmg8zVsn2UQmEZ
         UHo7nSE9Z2xvQVQf2gh4DYzWsII0p9l7SgLsPJevfAElQuIdwkzDGmNg9CcW0Lpdn1G6
         kbWYFXCQN9285SM28XdrQ6RH9IVIG1BgwKYmsi8sduYpIMG+Ia7hEpA3CkLEyWpdGIYR
         7CLmrncLmxZXzzqoERxP8hOJsUtCkoXeb9YbUnx9SH8E8VxjO8V1CTCVvmmQ5FJREnMh
         V+oQ==
X-Gm-Message-State: ACrzQf08AXuyUmiO2LJW8RDzpLKZzJRAAPNFMoDGQp98TAAmlbSYq/my
        2Z3vD+4MypHaCDzFhcN2hiwemCPhrguo/A==
X-Google-Smtp-Source: AMsMyM5Wd89HmV/5Tx932iiSrIAAnLk4MrkQ59yCklu8Av5H3hJIDUephSs5/6hnLkdJMaJ15l72Aw==
X-Received: by 2002:a05:6a00:1406:b0:565:dc13:bb36 with SMTP id l6-20020a056a00140600b00565dc13bb36mr1386294pfu.46.1666068941843;
        Mon, 17 Oct 2022 21:55:41 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:17a9:73b0:c262:eccd])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017b69f99321sm7549220plf.219.2022.10.17.21.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:55:41 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 0/9] zram: Support multiple compression streams
Date:   Tue, 18 Oct 2022 13:55:24 +0900
Message-Id: <20221018045533.2396670-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This series adds support for multiple (per-CPU)
compression streams (at point only 2). The main idea is that
different compression algorithms have different characteristics
and zram may benefit when it uses a combination of algorithms:
a default algorithm that is faster but have lower compression
rate and a secondary algorithm that can use higher compression
rate at a price of slower compression/decompression.

	There are several use-case for this functionality:

- huge pages re-compression: zstd or deflate can successfully
compress huge pages (~50% of huge pages on my synthetic ChromeOS
tests), IOW pages that lzo was not able to compress.

- idle pages re-compression: idle/cold pages sit in the memory
and we may reduce zsmalloc memory usage if we recompress those
idle pages.

	User-space has a number of ways to control the behavior
and impact of zram recompression: what type of pages should be
recompressed, size watermarks, etc. Please refer to documentation
patch.

v4:
-- added IS_ERR_VALUE patch (Andrew)
-- documented SIZE units (bytes) (Andrew)
-- re-phrased writeback BIO error comment (Andrew)
-- return zs_malloc() error code from zram_recompress()
-- do not lose zram_recompress() error in recompress_store()
-- corrected a typo
-- fixed previous rebase errors
-- rebased the series

v3:
-- conditionally reschedule during recompression loop so that
   we don't stall RCU grace periods
-- fixed a false-positive WARN_ON

v2:
-- rebased
-- mark completely incompressible pages (neither default nor secondary
   algorithm can compress them) with a new flag so that we don't attempt
   to recompress them all the time

Sergey Senozhatsky (9):
  zram: Preparation for multi-zcomp support
  zram: Add recompression algorithm sysfs knob
  zram: Factor out WB and non-WB zram read functions
  zram: Introduce recompress sysfs knob
  documentation: Add recompression documentation
  zram: Add recompression algorithm choice to Kconfig
  zram: Add recompress flag to read_block_state()
  zram: Clarify writeback_store() comment
  zram: Use IS_ERR_VALUE() to check for zs_malloc() errors

 Documentation/admin-guide/blockdev/zram.rst |  64 ++-
 drivers/block/zram/Kconfig                  |  55 +++
 drivers/block/zram/zcomp.c                  |   6 +-
 drivers/block/zram/zcomp.h                  |   2 +-
 drivers/block/zram/zram_drv.c               | 458 +++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  16 +-
 6 files changed, 526 insertions(+), 75 deletions(-)

-- 
2.38.0.413.g74048e4d9e-goog

