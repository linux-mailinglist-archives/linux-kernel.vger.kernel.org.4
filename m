Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49255F4DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJECk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJECkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:40:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314C422F5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:40:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so539802pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=f87IwcAw5i2jjrf1Q8jHapWamnUQKlhS2oABC9XY7ec=;
        b=BB94WrWWoDrvCg152OwakTsFmFpjT3lqUErRaKqZ7y88IsPjwZ42cf3K+gifoa5BNr
         0iRFeUJchFHJQdC5TOUqkliWicaxIohHGyDGq+vC5AfP7xt1PLNnzAKRpdaU6oM/t+Z1
         XE6fAf2K8iEBemdRxiUzniBQ76ySaY7oODhVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=f87IwcAw5i2jjrf1Q8jHapWamnUQKlhS2oABC9XY7ec=;
        b=bRzXhaqCNK5Mp4TJOtIXZuPJkbgHe1RcisoMESmu1Aq0jD9I84JfnF7nI2OKMCUoW8
         C4UbyMno2IajLTYFL+cXZYDsTefOqF4imfK/WLri6FOvOcCj1vNMXRDnP5eqiAS2ZvtG
         nrQlfc0E3KCK84mhHfRQZqxoEf+iYExFsC+3XwZIfm9ypDEDxZurqxV/P7iXAhahDHee
         F/6BEb/g/yc2fkuZkrI+73EweoR/CRdJ4iGNIGmOFRXjjNKtt7Eq6rkXTjU+vs2TgmZl
         RzmqAXWIOxI7SNDRj081RSKrnbmKqy28wIV1FQ0kEJAZVNqhfC0clPWxbci85kRYYTk6
         okBA==
X-Gm-Message-State: ACrzQf32LSt5+YkMuJvmwjcmThFAR1pvMvZO/pPKASjMyIcS4OLULUtD
        3yYP0hfuUZ2lWe49UbY1KsrZNg==
X-Google-Smtp-Source: AMsMyM5nkTyHEGUw2H7T+iFG6K6Iy68KKNDBMGWj4x4qbUnd5s7Ci3R2WDN8i+6xedNGpEMAzyJ+tQ==
X-Received: by 2002:a17:902:c385:b0:17e:deec:4702 with SMTP id g5-20020a170902c38500b0017edeec4702mr15204352plg.121.1664937622273;
        Tue, 04 Oct 2022 19:40:22 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a9d9:6396:ee12:8be8])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b00561e010a309sm1673579pfl.19.2022.10.04.19.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 19:40:21 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/8] zram: Support multiple compression streams
Date:   Wed,  5 Oct 2022 11:40:06 +0900
Message-Id: <20221005024014.22914-1-senozhatsky@chromium.org>
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

- huge pages re-compression: zstd or defalte can successfully
compress huge pages (~50% of huge pages on my synthetic ChromeOS
tests), IOW pages that lzo was not able to compress.

- idle pages re-compression: idle/cold pages sit in the memory
and we may reduce zsmalloc memory usage if we recompress those
idle pages.

        User-space has a number of ways to control the behavior
and impact of zram recompression: what type of pages should be
recompressed, size watermarks, etc. Please refer to documentation
patch.

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
 drivers/block/zram/zram_drv.c               | 436 +++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  16 +-
 6 files changed, 506 insertions(+), 70 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

