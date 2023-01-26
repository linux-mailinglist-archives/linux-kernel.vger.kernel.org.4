Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77C67C1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjAZAiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjAZAiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F23C2AE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674693453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cIF2aVRK+AqmwlzzDyjVxqCrFxQEIyaTAPpUrb+V7+U=;
        b=X5BM+fW5Od4gzM1ZTJv4mcldWeXTsWtNH6Q4D+KKzX3nvqCzpqj2g8tspQKwUSiw8mEtWj
        /w7iuoskp/3pFyfX1mseYjPNZtTRpAmpmkm2p+hRlRgOmhkA9GF+ZxjPIyB4UfWXRDBZZM
        t48VhsXjmxGHSRfKVoXUpQ8ZtaaJqUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-FxQcXgtyNV-KE0YuL0hB8g-1; Wed, 25 Jan 2023 19:37:30 -0500
X-MC-Unique: FxQcXgtyNV-KE0YuL0hB8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1CF2802BF5;
        Thu, 26 Jan 2023 00:37:29 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35396492C14;
        Thu, 26 Jan 2023 00:37:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v7 0/4] lockinig/rwsem: Fix rwsem bugs & enable true lock handoff
Date:   Wed, 25 Jan 2023 19:36:24 -0500
Message-Id: <20230126003628.365092-1-longman@redhat.com>
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

v7:
 - Add a comment to down_read_non_owner() in patch 2.
 - Drop v6 patches 4 & 6 and simplify the direct rwsem lock handoff
   patch as suggested by PeterZ.

v6:
 - Fix an error in patch 2 reported by kernel test robot.

v5:
 - Drop patch 2 and replace it with 2 new patches disabling preemption on
   all reader functions and writer functions respectively. The other
   patches are adjusted accordingly.

It turns out the current waiter optimistic spinning code does not work
that well if we have RT tasks in the mix. This patch series include two
different fixes to resolve those issues. The last 3 patches modify the
handoff code to implement true lock handoff similar to that of mutex.

Waiman Long (4):
  locking/rwsem: Prevent non-first waiter from spinning in down_write()
    slowpath
  locking/rwsem: Disable preemption at all down_read*() and up_read()
    code paths
  locking/rwsem: Disable preemption at all down_write*() and up_write()
    code paths
  locking/rwsem: Enable direct rwsem lock handoff

 kernel/locking/rwsem.c | 161 +++++++++++++++++++++++++++++------------
 1 file changed, 115 insertions(+), 46 deletions(-)

-- 
2.31.1

