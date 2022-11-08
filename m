Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC6621D08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKHTcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:32:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639C66CA8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:32:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o7so14729947pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fmsZ6yPuBdWLDut9uV/WRXSBm+/VHvg2djO9W463cg=;
        b=IMAaWFuKFcdE6LFTCDhevmWnDnKjOGMzE+wgopbdHEH218c5ommJirHhEKylMJUDIA
         iT292IbLb/clBh8CvHU0ileiPa59zhyUrnHtX6crGjDqH+DjJ6GhxjVnsx1LrH9coV9N
         MlLh2PiPaQOEO+bvvvuYbcJNgnvihUrrTg1aOPXm/nH6Oj0VWECb312Ri9KUnPUFb17U
         CLqDGl257cKfAWwSThX/muWWmMAvghVvWhZ/cMKPaKOiwYViDzM2EL4a1fAch6c0WMdR
         0nBwj91j0CYADx2/IOwtKuv263DON8uk9FwOqYrMQ/AQ0BEZ4Y/HO+jsNQzoBB1o0Q9c
         wvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fmsZ6yPuBdWLDut9uV/WRXSBm+/VHvg2djO9W463cg=;
        b=REQOcyhaUuxDkD2MKBBApztb72sn6y9k6KERGgWZrdhqeYAnYOdHTjO1JIWXxiN0tF
         9908bkHu6ehQ7jt9xvAVWM74ehe6tEtcjxURBtwggsMvwM28kzCANjQkedXzMyi45gcH
         cHTeJSYvKE1ydnGUDMrGXs/4yeEqBxhA1aaLmYS5BfE2JrhAMt7mhsr3H/gmP7aIrUWU
         RWsGxOmsxymvyA23QHX9i0NXPVO6YacaValjTG7sbPi1i0JMW1b+h/Azs6wzEY8crf7E
         BmEZB16hcyDybuFe5BCt24wra3A7CENz3SZXJE9bu3AnVBEHS3qZyZb6z03Uzh3b1Tl/
         iW1Q==
X-Gm-Message-State: ACrzQf0PfBmhYUB+25NwZIS3/VtX/x/8wu117+lLjsfHBPi96y/bTKsA
        1JMN/WEM/f6caCwbfLfO5uY=
X-Google-Smtp-Source: AMsMyM6T2QQzwBmkEJ7EbwneH7m8cOzAbxK9NTXlZ65s+1gH2SHBqnhSEb+xGz2GPHBRSJc3A5f/0Q==
X-Received: by 2002:a17:90b:3705:b0:212:e2e5:c0c0 with SMTP id mg5-20020a17090b370500b00212e2e5c0c0mr59748756pjb.239.1667935928316;
        Tue, 08 Nov 2022 11:32:08 -0800 (PST)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b001869581f7ecsm7373877plk.116.2022.11.08.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:32:07 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v3 0/5] Implement writeback for zsmalloc
Date:   Tue,  8 Nov 2022 11:32:02 -0800
Message-Id: <20221108193207.3297327-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v3:
  * Set pool->ops = NULL when pool->zpool_ops is null (patch 4).
  * Stop holding pool's lock when calling lock_zspage() (patch 5).
    (suggested by Sergey Senozhatsky)
  * Stop holding pool's lock when checking pool->ops and retries.
    (patch 5) (suggested by Sergey Senozhatsky)
  * Fix formatting issues (.shrink, extra spaces in casting removed).
    (patch 5) (suggested by Sergey Senozhatsky)

v2:
  * Add missing CONFIG_ZPOOL ifdefs (patch 5)
    (detected by kernel test robot).

Unlike other zswap's allocators such as zbud or z3fold, zsmalloc
currently lacks the writeback mechanism. This means that when the zswap
pool is full, it will simply reject further allocations, and the pages
will be written directly to swap.

This series of patches implements writeback for zsmalloc. When the zswap
pool becomes full, zsmalloc will attempt to evict all the compressed
objects in the least-recently used zspages.

There are 5 patches in this series:

Johannes Weiner (1):
  zswap: fix writeback lock ordering for zsmalloc

Nhat Pham (4):
  zsmalloc: Consolidate zs_pool's migrate_lock and size_class's locks
  zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
  zsmalloc: Add ops fields to zs_pool to store evict handlers
  zsmalloc: Implement writeback mechanism for zsmalloc

 mm/zsmalloc.c | 346 +++++++++++++++++++++++++++++++++++++++++---------
 mm/zswap.c    |  37 +++---
 2 files changed, 303 insertions(+), 80 deletions(-)

--
2.30.2
