Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C26E32E7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDORgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjDORf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:35:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251664204
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:35:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f16b99b9a1so1808375e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681580153; x=1684172153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YLwTQZZnbXOgemqdrps8fA9Gldg2HuKE0/7cxnQpFQ=;
        b=BZSqQJv3XnqFbncHNAUnIbrnEZTazUXyXqnQBodiqdv6Sc8AvKh0+EypVUwcQa8/HB
         zmKaE6zO5hijvjrc6LQZdaaUAIdLp0EGebp6fbEOCMlkqQYfVD/NuZxAlKoUNeOKeSee
         fvuRkiWClqmEPh8+uXZtR5D6Jkj5O2nIAuum0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681580153; x=1684172153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YLwTQZZnbXOgemqdrps8fA9Gldg2HuKE0/7cxnQpFQ=;
        b=g1JnHDwphOK9K0IYsxQY++Dr1KGE/sP4dThu/+fyy3NYq6qdLlgmE0FRFg7ieef5EH
         nqNcMHqAXJoDvTggiEtaFYMozdkdnj6MH6ZnbnDqJJ3rkGE3JCa+0O4pBY2SH/+0vzkY
         UtfD1TttuzV6aQB0Qq9cKISRRkJYTu9g1F2fIs+vAfnUE23A1WZXsM8wUNGh8WE5LfwP
         bfoA0E+wWaSNeUR7BbayCLA2K4Za3LiAJP4fC6IeV0g/X2QYfP96fRD+Mz3Ub7vjK2cH
         m18KxXI4xAqX4cOiO1wynb71rncuDtIc+0B3BoEX9hCAZeXego+tmK9RG00L0blsWKjN
         aUBQ==
X-Gm-Message-State: AAQBX9cfZoHrP3v6lKGfFNmUYwQDX0LlKc3e/ikDy1Kj6Rwu+m0f5pcn
        ufFPpC8EIG7Ha7+qXzI+yS0UMJGR5qYNjKHCDI3gWKqF187N8GGHZFdr3kiSInXsHMk78XgzvRC
        YD6kFcSNgjnCLE2kXv9s9e2CYbKPAllIoX/EFf1sg+I46HkEAtUYV85OIPsqgymxp4S6eqqP1PB
        DffD/xSjb//5AtrOnS2CpBYTQw+Q==
X-Google-Smtp-Source: AKy350YbXzxUdBpmSye2FEZzRGDHVLP+Xq2ULJ4U8fGtYPvpRQYHtI710wIppnaJCfw5+p6ySvF/uA==
X-Received: by 2002:a5d:4c45:0:b0:2f9:4fe9:74df with SMTP id n5-20020a5d4c45000000b002f94fe974dfmr288262wrt.17.1681580153223;
        Sat, 15 Apr 2023 10:35:53 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6a04000000b002f0442a2d3asm6174805wru.48.2023.04.15.10.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 10:35:52 -0700 (PDT)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        vbabka@suse.cz, 42.hyeyoo@gmail.com, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        ilay.bahat1@gmail.com, aksecurity@gmail.com
Subject: [PATCH v5 0/3] Replace invocations of prandom_u32() with get_random_u32()
Date:   Sat, 15 Apr 2023 20:35:49 +0300
Message-Id: <20230415173549.5345-1-david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Hence, we have added the necessary changes to make those randomizations stronger,
switching  prandom_u32 instance to siphash.


Changes since v4:
* This fifth series changes only the arch/x86/mm/kaslr patch.
  In particular, we replaced the use of prandom_bytes_state and
  prandom_seed_state with siphash inside arch/x86/mm/kaslr.c.

Changes since v3:
* edited commit messages

Changes since v2:
* edited commit message.
* replaced instances of get_random_u32 with get_random_u32_below
      in mm/slab.c, mm/slab_common.c

Regards,


David Keisar Schmidt (3):
  Replace invocation of weak PRNG in mm/slab.c
  Replace invocation of weak PRNG inside mm/slab_common.c
  Replace invocation of weak PRNG in arch/x86/mm/kaslr.c


 arch/x86/mm/kaslr.c                           |  18 +-
 include/uapi/linux/netfilter/xt_connmark.h    |  40 +-
 include/uapi/linux/netfilter/xt_dscp.h        |  27 +-
 include/uapi/linux/netfilter/xt_mark.h        |  17 +-
 include/uapi/linux/netfilter/xt_rateest.h     |  38 +-
 include/uapi/linux/netfilter/xt_tcpmss.h      |  13 +-
 include/uapi/linux/netfilter_ipv4/ipt_ecn.h   |  40 +-
 include/uapi/linux/netfilter_ipv4/ipt_ttl.h   |  14 +-
 include/uapi/linux/netfilter_ipv6/ip6t_hl.h   |  14 +-
 mm/slab.c                                     |  25 +-
 mm/slab_common.c                              |  11 +-
 net/netfilter/xt_dscp.c                       | 149 ++++---
 net/netfilter/xt_hl.c                         | 164 +++++---
 net/netfilter/xt_rateest.c                    | 282 ++++++++-----
 net/netfilter/xt_tcpmss.c                     | 378 ++++++++++++++----
 ...Z6.0+pooncelock+pooncelock+pombonce.litmus |  12 +-
 16 files changed, 815 insertions(+), 427 deletions(-)

-- 
2.37.3

