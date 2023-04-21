Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259C06EB477
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjDUWNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDUWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:13:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EC173F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b87d23729so2291074b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682115200; x=1684707200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSr2mFFtQdWo1iBpXBc7j9YbR2hNDpQIj/zleW9xjcI=;
        b=m9bQpTdgAXyi+Ql87hiRr7t0ia1FABR7x6Q01Dm0rrdHasFiZdYvOXNxUAJwhifag9
         VTU48ZQzikde41qEBqP6U/YoJtfW9184JP0baUWX+VM7+NI5IciHoN7VntqcBJVnLgcT
         M+wX4hHaBkLwUDXmQgBgqA4E2w6ec+mgez+n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115200; x=1684707200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSr2mFFtQdWo1iBpXBc7j9YbR2hNDpQIj/zleW9xjcI=;
        b=dCeidgmVA+BK0IzccNF9e5SSNnvcJajV7/91Zhbkb0wxTHgyjyJlu5fD7YOuyGAP9V
         RwhqjeKrPik8w7FD8amBHySUEv0iRShP0JaGy4/XQS/iajMnCOpnvLoIMIb3rFpTjm7r
         LyKgwwAeewqBIcTECubLktTF848D3Je3Gusb7fI2P2mgwnm1wptsIuUXBo8iE1IghwoS
         K48r7BBS1WuM4MlThF4Tk7EppCQncuzZKLcBc0dWXN4J0Zef4/UjfCRJi5ZBuzbg9a+w
         xxBhcLtgHXUgcQpzqNRtXLHJbYnBS5C/ynwAOAZ4fJEM634qvEDbxrQLS/sp6Z2sj94H
         3QFw==
X-Gm-Message-State: AAQBX9f/hbOpWxxVWGymcSZAqFU+ZiHdNxRV0OwhlYnoaWzrkB8xaClQ
        EpQ1xxQ5qaqtOEJfMw+uZdz6ug==
X-Google-Smtp-Source: AKy350YVcVPbgtRqAo1fCHULXp4ZM49l+s1v38up9iF15ajAkeVGyo7cRolT6tAKFDfkP2NORUfzqw==
X-Received: by 2002:a05:6a00:24c9:b0:624:2e60:f21e with SMTP id d9-20020a056a0024c900b006242e60f21emr8355217pfv.29.1682115200014;
        Fri, 21 Apr 2023 15:13:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:87cc:9018:e569:4a27])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm3424715pfb.104.2023.04.21.15.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:13:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v2 0/4] migrate: Avoid unbounded blocks in MIGRATE_SYNC_LIGHT
Date:   Fri, 21 Apr 2023 15:12:44 -0700
Message-ID: <20230421221249.1616168-1-dianders@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series is the result of discussion around my RFC patch [1] where
I talked about completely removing the waits for the folio_lock in
migrate_folio_unmap().

This new series should, I think, be more palatable to folks. Please
let me know what you think!

Most of the description of why I think we want this patch series can
be seen in patch #3 ("migrate_pages: Don't wait forever locking pages
in MIGRATE_SYNC_LIGHT"). I won't repeat all that information here and
would humbly request that anyone wishing to comment on the overall
patch series respond there. ;-)

[1] https://lore.kernel.org/r/20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid

Changes in v2:
- "Add folio_lock_timeout()" new for v2.
- "Add lock_buffer_timeout()" new for v2.
- Keep unbounded delay in "SYNC", delay with a timeout in "SYNC_LIGHT"
- "Don't wait forever locking buffers in MIGRATE_SYNC_LIGHT" new for v2.

Douglas Anderson (4):
  mm/filemap: Add folio_lock_timeout()
  buffer: Add lock_buffer_timeout()
  migrate_pages: Don't wait forever locking pages in MIGRATE_SYNC_LIGHT
  migrate_pages: Don't wait forever locking buffers in
    MIGRATE_SYNC_LIGHT

 fs/buffer.c                 |  7 ++++++
 include/linux/buffer_head.h | 10 ++++++++
 include/linux/pagemap.h     | 16 +++++++++++++
 include/linux/wait_bit.h    | 24 +++++++++++++++++++
 kernel/sched/wait_bit.c     | 14 +++++++++++
 mm/filemap.c                | 47 +++++++++++++++++++++++++++----------
 mm/migrate.c                | 45 +++++++++++++++++++++--------------
 7 files changed, 132 insertions(+), 31 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

