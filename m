Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28768622AED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiKILu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKILu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:50:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE81C126
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:50:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so1609021pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fD/HQF6HxapCqTpoXXzXl5JbbzI2VtbNVLVtgj7Z2vQ=;
        b=RhShf17fILimFsOPFe+/KrLFpCALNSEahDTJ3X6S5NNNdXcCWnSJrZME7yfGuEkQxZ
         gd5950jwzhQoG7mJKQjm3hha/ceoQVuR9jNntXiJBAr237RL5WdN9ZHj2W1MjXie495H
         hnriGG70Q53DtIUIphbDQ6l6eKnlqCtmKv1aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fD/HQF6HxapCqTpoXXzXl5JbbzI2VtbNVLVtgj7Z2vQ=;
        b=NBNLGFfFPRFrF+fBUQJzR9BnFA93CrFOZydXMc4NRTHTQcZoVGY3Bs2vaK51bHPuR1
         n7D3tNRtBA6LpssG4G3YvCTY4yp155QnMyzuh6H6iGuzM/lh+5kaLeaqbcZqOP94d2Hw
         A8pg/IbT16euZc8BMZWT8aRNJVjNgzaQGlrJxZQZ7H5sJxss9/qiPL4+1PHisf/73RkJ
         QnlM6CM/b50u3vR2RaVtY9NN1w78BtJH4ztfgeS/joTMklEfj4Og2LQYSFZPvhN7fBwj
         D2lMimXga5s1gWLyIUjIpscQ8wn/UKmzziS9zXQmwQo8HAA/MwrOgdgQIfh0GB1oyS9a
         djnw==
X-Gm-Message-State: ACrzQf3ue/1LaHAPwjA6sG49EY3SRsJw+Homw6o181eXp6NaOloN+AiT
        PkGt3KMze+MuHGwkyO9bWkQ2Rw==
X-Google-Smtp-Source: AMsMyM5mwzK8guwIbu0zULgXWDM56Ayuz8XmyTNVrreNEf9XtB6ON2f2dC/7sWjGZ0eRkGUKUX2K5w==
X-Received: by 2002:a17:902:ef51:b0:180:7922:ce40 with SMTP id e17-20020a170902ef5100b001807922ce40mr60060435plx.8.1667994654359;
        Wed, 09 Nov 2022 03:50:54 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:50:53 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 00/13] zram: Support multiple compression streams
Date:   Wed,  9 Nov 2022 20:50:34 +0900
Message-Id: <20221109115047.2921851-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

	This series adds support for multiple compression streams.
The main idea is that different compression algorithms have different
characteristics and zram may benefit when it uses a combination of
algorithms: a default algorithm that is faster but have lower
compression rate and a secondary algorithm that can use higher
compression rate at a price of slower compression/decompression.

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

v5:
-- Addressed (very valuable) review feedback from Minchan
-- Extended documentation
-- We now do chain recompression, tryin algos in order of their priority
-- Support up to 4 compression streams
-- Added named parameters to recomp_algorithm and recompress sysfs knobs
-- Cherry-picked patch from Alexey
-- Store algo priority in mete flags
-- Renamed some fo the flags
-- Added incompressible bit to block state output
-- Added incompressible writeback
-- etc.

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

Alexey Romanov (1):
  zram: add size class equals check into recompression

Sergey Senozhatsky (12):
  zram: Preparation for multi-zcomp support
  zram: Add recompression algorithm sysfs knob
  zram: Factor out WB and non-WB zram read functions
  zram: Introduce recompress sysfs knob
  zram: Add recompress flag to read_block_state()
  zram: Clarify writeback_store() comment
  zram: Use IS_ERR_VALUE() to check for zs_malloc() errors
  zram: remove redundant checks from zram_recompress()
  zram: Add algo parameter support to zram_recompress()
  documentation: Add zram recompression documentation
  zram: add incompressible writeback
  zram: Add incompressible flag to read_block_state()

 Documentation/admin-guide/blockdev/zram.rst | 100 +++-
 drivers/block/zram/Kconfig                  |   9 +
 drivers/block/zram/zcomp.c                  |   6 +-
 drivers/block/zram/zcomp.h                  |   2 +-
 drivers/block/zram/zram_drv.c               | 604 +++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  22 +-
 include/linux/zsmalloc.h                    |   2 +
 mm/zsmalloc.c                               |  21 +
 8 files changed, 685 insertions(+), 81 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

