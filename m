Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899716CAFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjC0UZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjC0UZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619235A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wcKujHYB21Yt8eeMYyiK9kzywJgJciYefXegY9za204=;
        b=gGIhlALCoEOX6CXNkAIhhHGJSMdUr3vL4kueD35xmz4LJWOwjb+pYuDr3rZFmJooYu7pX+
        eLMhDIRBJwh97v8rXuq7Fb6JZQjoAMXWuSMAMdNRafBvep1canPKe6lIGNDT7ABQ2VT7Ow
        zMuxWlhj7ZEHzkToTpHzxkHTJhHWibU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564--IK8iYC8NY2tzhaMCqBuzA-1; Mon, 27 Mar 2023 16:24:22 -0400
X-MC-Unique: -IK8iYC8NY2tzhaMCqBuzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CD983C0E44A;
        Mon, 27 Mar 2023 20:24:22 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32DD8202701E;
        Mon, 27 Mar 2023 20:24:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/8] locking/rwsem: Rework writer wakeup and handoff
Date:   Mon, 27 Mar 2023 16:24:05 -0400
Message-Id: <20230327202413.1955856-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to the patches in queue.git locking/core branch
posted by Peter in [1]. His patch series unified the reader and writer
paths as much as possible and making the code a bit easier to maintain.
Unfortunately, it did regress performance because it suppress writer
lock stealing via optimistic spinning [2].

This series include the 7 patches in his locking/core branch with a minor
change to the last one to remove the now unneeded rwsem_wlock_ehandoff
event. The last patch in the series restores the old write lock slow
path behavior of acquiring the write lock mostly in the slow path which
is necessary to restore the performance level back to parity.

[1] https://lore.kernel.org/lkml/Y%2FuN+89FlTw45uiA@hirez.programming.kicks-ass.net/
[2] https://lore.kernel.org/lkml/c126f079-88a2-4067-6f94-82f51cf5ff2b@redhat.com/

Peter Zijlstra (6):
  locking/rwsem: Enforce queueing when HANDOFF
  locking/rwsem: Rework writer wakeup
  locking/rwsem: Simplify rwsem_writer_wake()
  locking/rwsem: Split out rwsem_reader_wake()
  locking/rwsem: Unify wait loop
  locking/rwsem: Use the force

Waiman Long (2):
  locking/rwsem: Minor code refactoring in rwsem_mark_wake()
  locking/rwsem: Restore old write lock slow path behavior

 kernel/locking/rwsem.c | 466 ++++++++++++++++++++++-------------------
 1 file changed, 246 insertions(+), 220 deletions(-)

-- 
2.31.1

