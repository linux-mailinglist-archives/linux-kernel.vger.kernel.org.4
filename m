Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2E699EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBPVKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjBPVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002362BEC4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676581789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xKNGh9keASsZSfBQu26SbKq2nldZyWkA5k1/GS4NlTE=;
        b=KmcVFbpgw5RDdXSZfsZxmzi9PDV4vnFiVdcotSvYuRBGLO5mUoyjTKKSzc6W9fdPfagVb9
        EppXGOuf7KOQYfABetREFH1ygKT9kgq0/sM/YuDRqPbO5yT1xY2Z0OvleaTkUifavr+QBj
        UuMar5lvUc6XRgPa3g3ykBJkdFbFp+s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-nI9MhWZzOVuSfARE0LPIOA-1; Thu, 16 Feb 2023 16:09:45 -0500
X-MC-Unique: nI9MhWZzOVuSfARE0LPIOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A82A29AA388;
        Thu, 16 Feb 2023 21:09:45 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7D1351FF;
        Thu, 16 Feb 2023 21:09:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 0/3] locking/rwsem: Miscellaneous rwsem enhancements
Date:   Thu, 16 Feb 2023 16:09:30 -0500
Message-Id: <20230216210933.1169097-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Break out some code refactoring into a separate patch.
  - Move the early handoff code from rwsem_wake() to rwsem_mark_wake() to
    cover all wakeup conditions as suggested by PeterZ.
  - Simplify the all reader wake up patch.

The second patch in this series is similar to patch 4 of the v7 patch
series [1]. So it should provide similar performance benefit.  Patch 3
is another minor enhancement about reader wakeup for some specific
use cases.

[1] https://lore.kernel.org/lkml/20230126003628.365092-1-longman@redhat.com/

Waiman Long (3):
  locking/rwsem: Minor code refactoring in rwsem_mark_wake()
  locking/rwsem: Enable early rwsem writer lock handoff
  locking/rwsem: Wake up all readers for wait queue waker

 kernel/locking/lock_events_list.h |   1 +
 kernel/locking/rwsem.c            | 133 ++++++++++++++++++++++--------
 2 files changed, 99 insertions(+), 35 deletions(-)

-- 
2.31.1

