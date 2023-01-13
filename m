Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7C66A529
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjAMVdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAMVdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:33:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3830A551D2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:33:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so22219486wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DulfpiWVACNY7vp+xSY6Fk7JE1ac/cRf69P+yA1+iPc=;
        b=OMvkJdCMDVcFb2pGG4WRLRksICWi1gIZPmzZiTosmRfFNz2+6l+N/vGC/vu2qm3qgi
         3Fk9L8AAwVGXWW7h8bR2wjymZjpfgSfy8b2z2OII1mrESjHVH1w4cKO+AfqFQan7SMun
         5E6th7Gwc/6ZQ4nBD+ZYeIpd/apnz16lbj8F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DulfpiWVACNY7vp+xSY6Fk7JE1ac/cRf69P+yA1+iPc=;
        b=PrF/IvthrunqK9Nz05UO+0vhPOCG/ouprPCmuMTJwOH5coGG2hKnzDByLUmFpE0pq6
         Jhk5ZZhwz3DM2WJDw698Lk29f9s4z7qK55NDcMFe0ebldFlV0CoNRgnqyPdkaJpnf5Dn
         fJ9UX2avqXjyA8HGbDqQErlgpeqCP09dkpDo9RG9NFnrmvcq//dddYApT8TO3yeAuTE8
         Vyn77SbauOVAYMyYhtuShTKqDY7+Etx/fHfgdUX7hhASmXUdNCCOSAumngmYgfTy2TZ1
         dq1I7Rp5mwYzF5AY8JZRThNvXSpyt0ZW8iDijAcKB7B9E2QQUnh/H0+7c3Rzg7MbFkMC
         Ss5w==
X-Gm-Message-State: AFqh2kpmntmAW0wCsOoYt5agmV0MeYyXgOqcsNfGE5qTD5cIUUoda78r
        GkF8VtNnBHW6xqZ/38xRp77aD+SRM8SdBnQO3gRVf9gV3+D/Nlatn+CM5R2z5wtNQ7aeFZfnLy2
        K/YhvUkN7YE3Z8LiorEcC7j06xYxyevf3OjrZU9tdP0kidtz7DbY0H0RzSCSi7l+W5xfhPp/CBG
        as/SyJavQtWnqJsfDHPLRMoqM=
X-Google-Smtp-Source: AMrXdXuUV2xGbb9vfEdsDtIQRasNUQH1BvH6Pn7fL2OM2r/X1cFqBikc4ImJ95Nsn2N6HxbjyaBygA==
X-Received: by 2002:adf:e19d:0:b0:28f:29b3:1a7f with SMTP id az29-20020adfe19d000000b0028f29b31a7fmr39754710wrb.36.1673645593492;
        Fri, 13 Jan 2023 13:33:13 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:2dd5:e78e:71c0:661b])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d67cd000000b002bdcce37d31sm6880471wrw.99.2023.01.13.13.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:33:13 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        vbabka@suse.cz, 42.hyeyoo@gmail.com, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        aksecurity@gmail.com, ilay.bahat1@gmail.com
Subject: [PATCH v4 0/3] Secure prandom_u32 invocations
Date:   Fri, 13 Jan 2023 23:33:10 +0200
Message-Id: <cover.1673470326.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

Hi,

The security improvements for prandom_u32 done in commits c51f8f88d705
from October 2020 and d4150779e60f from May 2022 didn't handle the cases
when prandom_bytes_state() and prandom_u32_state() are used.

Specifically, this weak randomization takes place in three cases:
    1.	mm/slab.c
    2.	mm/slab_common.c
    3.	arch/x86/mm/kaslr.c

The first two invocations (mm/slab.c, mm/slab_common.c) are used to create
randomization in the slab allocator freelists.
This is done to make sure attackers can’t obtain information on the heap state.

The last invocation, inside arch/x86/mm/kaslr.c,
randomizes the virtual address space of kernel memory regions.
The use of prandom_bytes_state() is justified since it has a dedicated
state and draws only 3 pseudo random values, but the seeding state takes advantage
of only 32 bits out of 64 bits of the seed.
Hence, we have added the necessary changes to make those randomizations stronger,
switching the invocation of prandom_seed_state to a more secure version, which
we implemented inside kaslr.c.
---
Changes since v3:
* arch/x86/mm/kaslr.c: secure the way the region offsets are generated in the
  seeding state - Adding a revised version of prandom_seed_state
* edited commit messages

Changes since v2:
* edited commit message.
* replaced instances of get_random_u32 with get_random_u32_below
      in mm/slab.c, mm/slab_common.c

Regards,

David Keisar Schmidt (3):
  Replace invocation of weak PRNG in mm/slab.c
  Replace invocation of weak PRNG inside mm/slab_common.c
  Add 64bits prandom_seed_state to arch/x86/mm/kaslr.c

 arch/x86/mm/kaslr.c | 26 +++++++++++++++++++++++++-
 mm/slab.c           | 25 ++++++++++---------------
 mm/slab_common.c    | 11 +++--------
 3 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.38.0

