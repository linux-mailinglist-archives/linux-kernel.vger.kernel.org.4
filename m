Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B34601B19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJQVOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJQVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C0183A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666041281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OFj+fpTcybhy1EO/TBp6S/h5BFRJbIkWDHIGTag8Fxc=;
        b=L7sgrU+XMrreS7mtCcR58rg6ajkEwiO2tK4Pz17MTQdMN40yqUWLmyjeVyyetxMQL0rqih
        bzN+WgdMoYOrUYjVBhquCuu/Kk9P5pTEqWujIDw2yyf6hZom5YtaQfREFHSy18ctyf80Ij
        NrGZbNGmtFqJoXeACn+l1HFUo7/INPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-65OJOv85O4-RjKwZGFgZLg-1; Mon, 17 Oct 2022 17:14:36 -0400
X-MC-Unique: 65OJOv85O4-RjKwZGFgZLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C619486F12E;
        Mon, 17 Oct 2022 21:14:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2DD440C206B;
        Mon, 17 Oct 2022 21:14:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/5] lockinig/rwsem: Fix rwsem bugs & enable true lock handoff
Date:   Mon, 17 Oct 2022 17:13:51 -0400
Message-Id: <20221017211356.333862-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
 - Make a minor cleanup to patch 1.
 - Add 3 more patches to implement true lock handoff.

v2:
 - Add an additional patch to limit the # of first waiter optimistic
   spinning in the writer slowpath.

It turns out the current waiter optimistic spinning code does not work
that well if we have RT tasks in the mix. This patch series include two
different fixes to resolve those issues. The last 3 patches modify the
handoff code to implement true lock handoff similar to that of mutex.

Waiman Long (5):
  locking/rwsem: Prevent non-first waiter from spinning in down_write()
    slowpath
  locking/rwsem: Limit # of null owner retries for handoff writer
  locking/rwsem: Change waiter->hanodff_set to a handoff_state enum
  locking/rwsem: Enable direct rwsem lock handoff
  locking/rwsem: Update handoff lock events tracking

 kernel/locking/lock_events_list.h |   6 +-
 kernel/locking/rwsem.c            | 172 +++++++++++++++++++++++-------
 2 files changed, 138 insertions(+), 40 deletions(-)

-- 
2.31.1

