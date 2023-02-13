Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13ED695110
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjBMTuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjBMTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B54903E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676317732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wK/ZJtbM9ewLIIH0vsoc94MJXY7Bbi8NV6SoT+SooT4=;
        b=Mmu1oAtLuNyatV62r2oU8EwVcHXxpiSzuyns5SO5hil8iARddVdGhIhuQj5yieAUMPP3yn
        PxZtQeD4zSYqfattLmp8esLKUpGZgP1L2urfJVApWFw8Tv9pvlC6/j6nsyDY8shdRbN4qh
        2FURJ4NEjc/wj2mS9BWatXRtd2lgSes=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-BP1odCMUNKWig5O9cNK5Cw-1; Mon, 13 Feb 2023 14:48:49 -0500
X-MC-Unique: BP1odCMUNKWig5O9cNK5Cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23E50385F362;
        Mon, 13 Feb 2023 19:48:49 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2501C16022;
        Mon, 13 Feb 2023 19:48:48 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 0/2] locking/rwsem: Miscellaneous rwsem enhancements
Date:   Mon, 13 Feb 2023 14:48:30 -0500
Message-Id: <20230213194832.832256-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series is the same patch 4 of the v7 patch series
[1] with some update in commit log and comment. The version number is
reset here as the first 3 patches of the series have been merged. Patch
2 is another minor enhancement for some specific use cases.

[1] https://lore.kernel.org/lkml/20230126003628.365092-1-longman@redhat.com/

Waiman Long (2):
  locking/rwsem: Enable early rwsem writer lock handoff
  locking/rwsem: Wake up all readers for wait queue waker

 kernel/locking/rwsem.c | 89 +++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 18 deletions(-)

-- 
2.31.1

