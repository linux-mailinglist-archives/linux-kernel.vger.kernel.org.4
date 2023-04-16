Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DC6E3A70
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDPRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:21:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A991FEC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:21:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so524204f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681665660; x=1684257660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YLwTQZZnbXOgemqdrps8fA9Gldg2HuKE0/7cxnQpFQ=;
        b=iWlAYsnwgQX8Cv+0u7jNsJWFqYxZ/C8lGVSRKgRj3qP9oakqkaEJs2uFMcFTHctaw7
         eti0dU8HdJ+9qMsAbXIjxj582Q6F3mBHIm6bv9udoEKE0ghGEoQIbvTBDlfzT8G+iPXs
         VSmBSe2HoXbw5z84nYJNq0q5chYouFQSyPLZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681665660; x=1684257660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YLwTQZZnbXOgemqdrps8fA9Gldg2HuKE0/7cxnQpFQ=;
        b=cRVVYlJ5fBF48FsOR9SFTmu908ZQXyRVBHRR2KvES6hDl/cwKeqqtBLKkE7EM+bsBj
         puVbGyTJD6wzebbGfZtrTMjZudLmLYH2YSeAOjEY25zvVCWIDPsX3H1gHa49+0xITsg2
         pWzh+mv7O3xZckZ/J6ga46KRKcfq/wFhp0j2h7wXT73TR94jinduffaRlNYaGUfn8H2Y
         wbcK1oj/Si4nAH0+Kv105eYrF3jNlZwHlseUqv3wxNFpmQB5PhK8u9HaHwd2gp8NDvCL
         2V91kgerkFQ008XUapgBrSKIYFKPqfFeGMPhijM4LdhiXuPdiTJAS+cJYiVf0QuZtBgt
         LB8Q==
X-Gm-Message-State: AAQBX9dEDHD+xRNvySQKdFuc5M24gKO72737Ef2OzBGnRdk4qdpqWlzl
        iQNXogt7e4swX4cipuXL4grmtGpTTHJX0vbnhVbLJ5ig84wVBGCt0ovCJQespZLy32+dyhVA9RC
        14mniK/mHLYmGg3f13clnWqQzii6iWhJp3mfWk7WcCp1l/20ceqcpXTjEbpLe2vzkST2wPLehRo
        1aVzKJ/FYWU8izg8fITKjnjmBUQAK7
X-Google-Smtp-Source: AKy350YuviM0vIUObaHotGRnvr9Vjw1j/ME0ncg+8Bba8DVf81OeLpLoAEtituVxJhkT4xf7F/zZUQ==
X-Received: by 2002:a05:6000:151:b0:2fa:9036:9cf with SMTP id r17-20020a056000015100b002fa903609cfmr302208wrx.37.1681665659757;
        Sun, 16 Apr 2023 10:20:59 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id s15-20020adfeb0f000000b002c55306f6edsm8496525wrn.54.2023.04.16.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:20:59 -0700 (PDT)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        vbabka@suse.cz, 42.hyeyoo@gmail.com, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        ilay.bahat1@gmail.com, aksecurity@gmail.com
Subject: [PATCH v5 0/3] Replace invocations of prandom_u32() with get_random_u32()
Date:   Sun, 16 Apr 2023 20:20:56 +0300
Message-Id: <20230416172056.13086-1-david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

