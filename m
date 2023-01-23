Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90C5678287
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjAWRFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjAWRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:00 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F035BA0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:04:59 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id i5so10897087oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tEp2G4dGisYIHzLbR1AMHRXXY1SBTNtHpC/PjpSBWI=;
        b=GXchdEYV915lcUCoyEySJKhcbfa9bh3M70ihhcAKlld/RmSSTtlUH/TOxwNAWJuxV+
         Wcnr0MbuphPFMsa/qdYPTda+af+Fcs7iIZhzoxlXFiZfLujwphfWbYhmistNL0+diHNT
         Fc/4re14/et4rJRYFvB2Rgn+0ncTTx2lNeY9CjriQWh9t5KVJNly0wT9NkhR0xrgfzHJ
         YNgwj5uvUnskfh2fTfEI/mvc3DBEHMj/GwoXsTssUCs6bjDDb6quHtCCPBkL9WhB1fdO
         Fada+1E5EjujgNh5tDD0QuQOKg/+GwZqxh+ami1l+nZK9A7Re5RrPdGvHdh6NRuiZxXO
         NWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tEp2G4dGisYIHzLbR1AMHRXXY1SBTNtHpC/PjpSBWI=;
        b=5NUe86X38+PDWlEbQa/wJnmgcrfdZBaCBiyzkBJnMzIxS2Btbvr2OUJetFfGkLO13L
         UdQu8SxEyWhM6jQIZUNdWe7mUg2Ne9XxQ9/JbAmGhxxgrku2Y9RmNlSv1LiRJvciAHon
         mgqjxpnUp9yvgU7BABN5xojOW27K27h/QTdQGDhJiN2OXeQqPqZQ7yTqWyeUw5ZD71ut
         VQheswptNr6zbKOf+9iH56iZlLM8KkoQwbjxuX7PlK3hVrIsO0hAK4WHIY5LHvfBiztp
         L++jou6BcmlM9iBI6aw7gsM/1VZN8jpEzmdf1yyWDMXG16XVuWyfPlP5zbcVj9K1cVfo
         kUSQ==
X-Gm-Message-State: AFqh2kpiTqkj4ZPbXWrG3UVmy87VMx67D4t9Ye+W0aQZBGR9c3ECgBHU
        Cg5UzrsJgXTstdQn2nn4bYbjdL5y87yVBvoRhFyMAu91blPMT7w30vKdfAP3cV6Djnv1tTErrDX
        LVPKhmUUUWBxN1pvBUZSEAcW7wiszq0ojeZ5QCywi7G4FQBEQGLhht/Vb2JEVUqxaIRV4YEmzG2
        Watw6OUsobfMZF
X-Google-Smtp-Source: AMrXdXttYcTkf89LOPFadkiPP31A+ZtsBCkOaq4o9W+QeFbP6D0RWr8WpEhSKbYkDO+sZ3hLIWPMdw==
X-Received: by 2002:a05:6808:6086:b0:364:ceba:2001 with SMTP id de6-20020a056808608600b00364ceba2001mr12059634oib.31.1674493498389;
        Mon, 23 Jan 2023 09:04:58 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:04:57 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 0/9] mm: kmemleak: fix unreported memory leaks
Date:   Mon, 23 Jan 2023 11:04:10 -0600
Message-Id: <20230123170419.7292-1-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of issues with kmemleak that lead to missed (not reported)
leaks. Parts of the kernel keep references to allocated objects which
are not properly communicated to kmemleak. This causes kmemleak to fail
to report some memory leaks.

I have also written a kmemleak test. It is a userspace Python script
and a device driver that communicate over ioctl, allocate and free
memory and verify that memory leaks are reported correctly. You can find
it here:

https://gist.github.com/george-enf/2d7cc288202b94defbe253f4ca26357b

George Prekas (9):
  mm: kmemleak: properly disable task stack scanning
  Revert "mm/kmemleak: make create_object return void"
  mm: kmemleak: propagate NO_SCAN flag in delete_object_part
  mm: kmemleak: add kmemleak_noscan_phys function
  mm: kmemleak: do not scan sparsemap_buf
  mm: kmemleak: do not scan cpu_cache of struct kmem_cache
  mm: kmemleak: erase page->s_mem in slab_destroy
  mm: kmemleak: erase page->freelist in slab_destroy
  mm: kmemleak: fix undetected leaks for page aligned objects

 include/linux/kmemleak.h |  5 ++
 kernel/fork.c            |  3 ++
 mm/kmemleak.c            | 98 ++++++++++++++++++++++++++--------------
 mm/slab.c                | 20 +++-----
 mm/slab.h                |  7 ++-
 mm/sparse.c              |  3 ++
 6 files changed, 88 insertions(+), 48 deletions(-)

-- 
2.37.1

