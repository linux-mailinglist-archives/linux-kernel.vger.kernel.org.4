Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834E160DF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiJZLaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJZLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B11DDEC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r18so14444542pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UlcqHJTxWpBCQSOBGpz23ymej0kP4Ky/Ub6kb29VjcI=;
        b=D1uZ5Qngpyal5W7zsSpY3pKUSRQBuko1HALHelbDwkgJSXHiR55b712Jgelc9plbjP
         5GOszbnAKr6bi9AZDih7QDPY0welW+lpMJz6UGatk5XBlbxs2roNRLFCKUmZxv6fP3JV
         GEeBLp3RML9mUfO1izOwqpMareEU8odQ1+J/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlcqHJTxWpBCQSOBGpz23ymej0kP4Ky/Ub6kb29VjcI=;
        b=bW6W940QB3NcidYBOUpeXOos5vUxOqVf5nvBckbCVV/iAf+vvVCrtWOwXO8w2tLgr0
         vK2y2ADtKXpMG37WxK3KsuwYOjU6Z2Ks/Qk5eh9f8IeC30wrefEJKu6goY+ix3nYPg82
         OHLtpJytxDuh9Tzedr03VBiFR71KkVU9HZZvCkNiE5KRQuMbjAODWz9h8lQ3eChniiRA
         qjOo9IXCbHQppV3rVFgCT9B0pTFGvaev4q4Y42VacdnqNXnyZgPbdETNYtSN1bBG1Gra
         SUDIfpOEgwBcLAERd1wfGOOifSqJFe+3lpIVCxA6iB/xPSrENtfTke5gOGY+W5H2g+XX
         JbGA==
X-Gm-Message-State: ACrzQf1UoehQ1lYjc8Q1TV/rHGv+ZfTKerqvr4HCBnt/JRbBUjB8nN3S
        jBr8CORiUMuJ6vDtw9S5tEVvhw==
X-Google-Smtp-Source: AMsMyM4Gj3CqIvbqhXM40PM/XV6jYpl+nGQ9OM9VFSoOKgZ10F/rxzemjRmIGDIKdkJ9T/ef9ps80w==
X-Received: by 2002:a05:6a00:32c9:b0:56b:a54e:68be with SMTP id cl9-20020a056a0032c900b0056ba54e68bemr19434184pfb.16.1666783803883;
        Wed, 26 Oct 2022 04:30:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:03 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/9] zsmalloc/zram: configurable zspage size
Date:   Wed, 26 Oct 2022 20:29:24 +0900
Message-Id: <20221026112933.4122957-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

