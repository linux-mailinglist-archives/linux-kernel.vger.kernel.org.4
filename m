Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED045F8A42
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJIJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJIJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:07:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9762167EB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:07:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c7so8069699pgt.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmNZ7Fvou49eeIhvfz5hM/EsgwFjPxztP9XU1GE9RsE=;
        b=FexyzJTrCIszuDKNIyZmrwHuOIeMpJ2NrZxAGtH8ix/tVqOAo8HGuSefr2oSApIHns
         vskIoS7yhfRz4RxCpIaU6cfjkMvun80zZuoPJi7BjV6129r0CzUu3Gee8cgfFBrhnCZn
         f26mrzo6T62wBh+UPbUO11ZTcQ0jlCSuXu55M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmNZ7Fvou49eeIhvfz5hM/EsgwFjPxztP9XU1GE9RsE=;
        b=R7ezwQxVBOjfNvaveJ+ZD2K6UAAgwPHfOj0Hndb8olR7PtSOZpLKj7JEQKB+j30Upc
         0pnubIEt+Vn5o3OSY1ifkdUTkxxZcrvumD4+V+obHJr1WQ34Kv+7V2OkKFxH6rNoSDli
         1HtauLS16Zk7Q4dIh2og/TaeJzWAv2RaB7EFUGhiqEB+rhHvGELKc5o/MZD8HoDaEnJu
         wWDPEwScMtKPtUzFfZRz/4nnPOvOGqMb/4W/Sp39OaVgUkumwMr8XUbpeA+vbcJKmfHr
         H25tbfLcJAfpq+2A4cQdoMsU9LA4SC83Tm2pe48pSC0FB7txNArjl1T+px3EJrUP5VjP
         TZkg==
X-Gm-Message-State: ACrzQf1nlVPa36MYxs5/crcZs4I0NR++MrTV9S1UEcU+boRSPHB0y6Z7
        4dojHiVfUhtZXYDKsCoMO4UsbA==
X-Google-Smtp-Source: AMsMyM6i0znQqZ8p7YT6afOgbTg5EelaP7ZkWjPWVpm3n6Jk5WRvk6lpR70aeaG4k8u8dn6EmCDNxg==
X-Received: by 2002:a63:5656:0:b0:446:8eb5:a2c5 with SMTP id g22-20020a635656000000b004468eb5a2c5mr12032763pgm.336.1665306446391;
        Sun, 09 Oct 2022 02:07:26 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8517:d51e:5fe9:9be7])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm4335148pgq.43.2022.10.09.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:07:25 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/8] zram: Support multiple compression streams
Date:   Sun,  9 Oct 2022 18:07:12 +0900
Message-Id: <20221009090720.1040633-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

v3:
-- conditionally reschedule during recompression loop so that
   we don't stall RCU grace periods
-- fixed a false-positive WARN_ON

v2:
-- rebased
-- mark completely incompressible pages (neither default nor secondary
   algorithm can compress them) with a new flag so that we don't attempt
   to recompress them all the time

Sergey Senozhatsky (8):
  zram: Preparation for multi-zcomp support
  zram: Add recompression algorithm sysfs knob
  zram: Factor out WB and non-WB zram read functions
  zram: Introduce recompress sysfs knob
  documentation: Add recompression documentation
  zram: Add recompression algorithm choice to Kconfig
  zram: Add recompress flag to read_block_state()
  zram: correct typos

 Documentation/admin-guide/blockdev/zram.rst |  64 ++-
 drivers/block/zram/Kconfig                  |  52 +++
 drivers/block/zram/zcomp.c                  |   6 +-
 drivers/block/zram/zcomp.h                  |   2 +-
 drivers/block/zram/zram_drv.c               | 441 +++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  16 +-
 6 files changed, 510 insertions(+), 71 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

