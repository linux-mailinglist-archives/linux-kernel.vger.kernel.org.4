Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CE60B7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiJXT2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiJXT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33997D1CB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666634289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BKsIeHeTa8oYpszhjqyCKaOjh+pr8dDdDzbYGV4SIoQ=;
        b=SsPZQ7g8UDWrwxssM/GZHB2PjI/LmpN2Q9PeG8JRkvzOBCZa1JKj7kjwXmKbyf679Nmwpl
        QmMrNt5B39Ql1rzBtNxtqebU08aPjXo2nWSquWX0pg29T9alvenpXEYOlbD3c9jrgW61pm
        hf9CicA8FNCzEThre2IwI4hdo6KCaUs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-6U8GaSwEOh6tl65uRXdbHw-1; Mon, 24 Oct 2022 13:44:50 -0400
X-MC-Unique: 6U8GaSwEOh6tl65uRXdbHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38EB63C32C44;
        Mon, 24 Oct 2022 17:44:50 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90A1E492B0A;
        Mon, 24 Oct 2022 17:44:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/5] lockinig/rwsem: Fix rwsem bugs & enable true lock handoff
Date:   Mon, 24 Oct 2022 13:44:13 -0400
Message-Id: <20221024174418.796468-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
 - Update patch descriptions in patches 1 & 2 to make clear the live
   lock conditions that are being fixed by these patches. There is no code
   change from v3.

v3:
 - Make a minor cleanup to patch 1.
 - Add 3 more patches to implement true lock handoff.

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

