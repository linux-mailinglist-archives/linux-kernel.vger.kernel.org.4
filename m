Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6522C72FE81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbjFNMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbjFNMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200DA109
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686745420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jFRmKE1gKyWwlU8dIHCT74Dsw8jBXXe3UgEOZvAo7zE=;
        b=O7lU3DQ9yjdW4CgonJ0628Y/7ywtF5+ixhxq7aiywk9ViaAecjXTLsTXQCnwaRAICiNz+0
        NSiXlulCVS/qFkb0RiHpLPa8VHG4CeLIwPl2s82Mbk49UPld5HG5P2XuCQXT3DwoVBXiGq
        PA5flDfW1HPKasbvNX2GqUonGD/G80M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-loLNedIZPRWdGegD93GlIw-1; Wed, 14 Jun 2023 08:23:34 -0400
X-MC-Unique: loLNedIZPRWdGegD93GlIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC0B3C1C4C9;
        Wed, 14 Jun 2023 12:23:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4693240B4CD8;
        Wed, 14 Jun 2023 12:23:28 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH v10 0/2] kernel/fork: beware of __put_task_struct calling context
Date:   Wed, 14 Jun 2023 09:23:20 -0300
Message-Id: <20230614122323.37957-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
locks. Therefore, it can't be called from an non-preemptible context.

Instead of calling __put_task_struct() directly, we defer it using
call_rcu(). A more natural approach would use a workqueue, but since
in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
the code would become more complex because we would need to put the
work_struct instance in the task_struct and initialize it when we
allocate a new task_struct.

Changelog
=========

v1:
* Initial implementation fixing the splat.

v2:
* Isolate the logic in its own function.
* Fix two more cases caught in review.

v3:
* Change __put_task_struct() to handle the issue internally.

v4:
* Explain why call_rcu() is safe to call from interrupt context.

v5:
* Explain why __put_task_struct() doesn't conflict with
  put_task_sruct_rcu_user.

v6:
* As per Sebastian's review, revert back the implementation of v2
  with a distinct function.
* Add a check in put_task_struct() to warning when called from a
  non-sleepable context.
* Address more call sites.

v7:
* Fix typos.
* Add an explanation why the new function doesn't conflict with
  delayed_free_task().

v8:
* Bring back v5.
* Fix coding style.

v9:
* Reorganize to not need ___put_task_struct() by Oleg's suggestion.

v10:
* Add a patch preventing a splat when compile with
CONFIG_PROVE_RAW_LOCK_NESTING.

Reported-by: Hu Chunyu <chuhu@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paul McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Luis Goncalves <lgoncalv@redhat.com>

Wander Lairson Costa (2):
  kernel/fork: beware of __put_task_struct calling context
  sched: avoid false lockdep splat in put_task_struct()

 include/linux/sched/task.h | 38 +++++++++++++++++++++++++++++++++++++-
 kernel/fork.c              |  8 ++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.40.1

