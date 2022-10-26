Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5460E9DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiJZUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiJZUGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:06:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A7923D4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 20so16023882pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=reYTGbFPdclPcD2z+9ilEBAxZuR3E49Fi6l8bS5z4WI=;
        b=aBtyYt4P+vrjfIes9GrPnp95ytz1pJMQqoVJ9IaOTyatT7BoXUjWDPFe7pG+Lk4T79
         NQuMNp02jNFbg3gNY3A6L5qaM0I+ipLR0tic74LTR25pkvpbJp07lDvXeYm6xmOtG/BH
         op+IP2TMH34vf4h8sRylM7+9xt8LxOPbRNiyKSalamzvKDJEYWNI1aILFBGmb3njkqQj
         nmHPjxnsNzYpDqpjCzaSPqJSK4Jb7RJzZna4H+HWIdBQVl05zEPXIXq+Aztx7KiAF66s
         k+AD9Z375sO6Ti0vlaZIne8oZPdVrcblEhURsgaKd+UYVIlFWZLvTrt9geLhnDGjsBya
         qkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reYTGbFPdclPcD2z+9ilEBAxZuR3E49Fi6l8bS5z4WI=;
        b=g17CQlYUj87ZvGfxnR4Ggtbn/xGNAZ35MqCyIxtZUPYNqL/cM896Fr/LHZ8dFQvMwu
         0ALNGrmL75k+FvEb+S7wx032e0Z/Bv2PUjW+O9DIppfd31cBtb0DJPB7gVRGzGFEn4So
         Ti7bCt/MKNcIXqtMnRr1BpAatQWm6p8RyHlXnjivvOGJwIoKdqbK3Ogc9jfrKnmgBlv8
         StxSJ6Zs/IME28BdomXU3HZz5ERe9Oel6z9urLdraRBektmzmjwUJ2RfyWda3+6eZM1b
         oYM2v3C8nljFrKgJEowZnK+sCTGQC9pfs4gG/s3rfcccvvpkuXpmA6e88D6yjAd2ROxH
         89pw==
X-Gm-Message-State: ACrzQf1o0QVDmCU/XiavTmd26/XWIF/OBzUzgzYgUeW87Pp8u4uAGK8f
        /zVwq3eJCHQfe4AmeE4SU78=
X-Google-Smtp-Source: AMsMyM5QuZrhcCnyRx3su7R58u0nee6W0dVwUX1JfGG1ey4UKXMlqlErXifS4buOqGUUdXFb/d7cbA==
X-Received: by 2002:a65:6bd4:0:b0:443:94a1:429c with SMTP id e20-20020a656bd4000000b0044394a1429cmr39156742pgw.606.1666814774292;
        Wed, 26 Oct 2022 13:06:14 -0700 (PDT)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b0017c19d7c89bsm3296439plx.269.2022.10.26.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:06:13 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH 0/5] Implement writeback for zsmalloc
Date:   Wed, 26 Oct 2022 13:06:08 -0700
Message-Id: <20221026200613.1031261-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Unlike other zswap’s allocators such as zbud or z3fold, zsmalloc
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

 mm/zsmalloc.c | 336 ++++++++++++++++++++++++++++++++++++++++----------
 mm/zswap.c    |  37 +++---
 2 files changed, 293 insertions(+), 80 deletions(-)

--
2.30.2
