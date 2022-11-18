Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619EB62EBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiKRCVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiKRCVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0374AAA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668738028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZQW7EJ9eJ3AI4uQYGbmB9y5OJ7c4Huh2ZC5cQT+rt4E=;
        b=Be7mD39R8ZbCcWvb9VQ72H8zjeCuzmbv5lDoM7QAU5MVtKbJwf86Sw/al68nQ9J7Z5vIDx
        mhoJpNKLIakncA3gATBoQ+2tcR5la3/LEz/dOhcgPQ7OYN8abdMoLfg/wC8/cY9QGGlolg
        AIXbLB0E2XJc7ehpyNXj67yOLx/jKTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-8PrljJU3PV605bKQE2JGcA-1; Thu, 17 Nov 2022 21:20:23 -0500
X-MC-Unique: 8PrljJU3PV605bKQE2JGcA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F970101A528;
        Fri, 18 Nov 2022 02:20:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38F3D49BB60;
        Fri, 18 Nov 2022 02:20:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v6 0/6] lockinig/rwsem: Fix rwsem bugs & enable true lock handoff
Date:   Thu, 17 Nov 2022 21:20:10 -0500
Message-Id: <20221118022016.462070-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6:
 - Fix an error in patch 2 reported by kernel test robot.

v5:
 - Drop patch 2 and replace it with 2 new patches disabling preemption on
   all reader functions and writer functions respectively. The other
   patches are adjusted accordingly.

v4:
 - Update patch descriptions in patches 1 & 2 to make clear the live
   lock conditions that are being fixed by these patches. There is no code
   change from v3.

It turns out the current waiter optimistic spinning code does not work
that well if we have RT tasks in the mix. This patch series include two
different fixes to resolve those issues. The last 3 patches modify the
handoff code to implement true lock handoff similar to that of mutex.

Waiman Long (6):
  locking/rwsem: Prevent non-first waiter from spinning in down_write()
    slowpath
  locking/rwsem: Disable preemption at all down_read*() and up_read()
    code paths
  locking/rwsem: Disable preemption at all down_write*() and up_write()
    code paths
  locking/rwsem: Change waiter->hanodff_set to a handoff_state enum
  locking/rwsem: Enable direct rwsem lock handoff
  locking/rwsem: Update handoff lock events tracking

 kernel/locking/lock_events_list.h |   6 +-
 kernel/locking/rwsem.c            | 240 ++++++++++++++++++++++--------
 2 files changed, 182 insertions(+), 64 deletions(-)

-- 
2.31.1

