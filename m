Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE560EEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiJ0E1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJ0E06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:26:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82535DBE42
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:26:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m2so398898pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLpRMNQkYbVj6lyrmRrOxuuwmgiytFPuZn2IVFPntgM=;
        b=h0chSoTr9LjZO+zENyYG/Z5Q+FKzIaov9HQFxUG64gBu+2GKz2R/9u3u7+0MU7R0wt
         vlHlWa+fYEWocbNl7x13wdFDgrbF00lwqinD3Zy6lyfAqx3xQPrUO/ffW5tSXdn0Ca8O
         Yyvq6cq3UbLn/hUgrAJYeuLOza1Wv9SvmKomk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLpRMNQkYbVj6lyrmRrOxuuwmgiytFPuZn2IVFPntgM=;
        b=mCbGOQHoVx7oQSZCv+vaWumge8HJP0R4y49eap8x3yNVzNvn2lGsk0+HCpKqKUNmMD
         or2voWJalCs2YbnsDN1OuZcVSWH/4klWIIUth3RCOg+GAW9CkKKmRMWKiw6xRzE74Gj9
         VILvkT+7wvyL81JuVUgyTfUn9h7+je2C50J2xyfIM+F1g51Rrh1gt2akGTe9WorKxmla
         oK5ph55R1eOHArywKOKcrh/ZQRcbpZMF1/9UTmqb6BCATSpqPZB/uXZyzVi8qoMrnDA5
         GD4UaAO4gVnpVx8Opgmk2NzWtmdD+MOsG205ppCEiZKJl7TE/KqGMPIeyvhtrQOIPKeQ
         YKrA==
X-Gm-Message-State: ACrzQf33dYTtVyKtH/D8Wfv7wVIymDtK0zEFjTn8+O/tvAtiEi2IjGLX
        sariJCyD2wO+Sqv0fgkEtHDX0Q==
X-Google-Smtp-Source: AMsMyM7ej7d6DvNI5V90T+YskrHYFramiQG9gIeKgZ32QfvvxlFWmQ4IoOb5JP8QfhN8qhwkK7U9EQ==
X-Received: by 2002:a17:902:848c:b0:17a:b4c0:a02b with SMTP id c12-20020a170902848c00b0017ab4c0a02bmr47126465plo.122.1666844816979;
        Wed, 26 Oct 2022 21:26:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:26:56 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/9] zsmalloc/zram: configurable zspage size
Date:   Thu, 27 Oct 2022 13:26:42 +0900
Message-Id: <20221027042651.234524-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	Some use-cases and/or data patterns may benefit from
larger zspages. Currently the limit on the number of physical
pages that are linked into a zspage is hardcoded to 4. Higher
limit changes key characteristics of a number of the size
classes, improving compactness of the pool and redusing the
amount of memory zsmalloc pool uses. More on this in 0001
commit message.

v3:
-- Removed lots of text from 0001 commit message. Now it's shorter
   and simpler.

v2:
-- Cherry picked a patch from Alexey (minor code tweaks to move
   it ahead of this series)
-- zsmalloc does not require anymore pages-per-zspage limit to be a
   pow of 2 value, and overall doesn't use "order" any longer
-- zram does not require "zspage order" (pow of 2) value anymore
   and instead accepts an integer in [1,16] range
-- There is no global huge_class_size in zsmalloc anymore.
   huge_class_size is per-pool, since it depends on pager-per-zspage,
   which can be different for different pools.
-- There is no global huge_class_size in zram anymore. It should
   be per-pool (per-device).
-- Updated documentation
-- Fixed documentation htmldocs warning (Stephen)
-- Dropped get_pages_per_zspage() patch
-- Renamed zram sysfs knob (device attribute)
-- Re-worked "synthetic test" section in the first commit: more numbers,
   objects distribution analysis, etc.



Alexey Romanov (1):
  zram: add size class equals check into recompression

Sergey Senozhatsky (8):
  zsmalloc: turn zspage order into runtime variable
  zsmalloc: move away from page order defines
  zsmalloc: make huge class watermark zs_pool member
  zram: huge size watermark cannot be global
  zsmalloc: pass limit on pages per-zspage to zs_create_pool()
  zram: add pages_per_pool_page device attribute
  Documentation: document zram pages_per_pool_page attribute
  zsmalloc: break out of loop when found perfect zspage order

 Documentation/admin-guide/blockdev/zram.rst |  38 +++++--
 drivers/block/zram/zram_drv.c               |  63 +++++++++--
 drivers/block/zram/zram_drv.h               |   7 ++
 include/linux/zsmalloc.h                    |  14 ++-
 mm/zsmalloc.c                               | 114 +++++++++++++-------
 5 files changed, 178 insertions(+), 58 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

