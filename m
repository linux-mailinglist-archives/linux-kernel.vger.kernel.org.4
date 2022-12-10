Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4797649180
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 00:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLJXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLJXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 18:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57DD12084
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670713265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RAobAJDhnMfMrw100Rt9Jr3gbpGAJeof0vxby2hwwp8=;
        b=BJAOWQhMDVWXKD7sR3YkSgfMqnAheySKwyQP6/9JMK7zlQaAysnpEPEb8qs/yWz3WuSDcB
        F0LOj/gJjLSAPNNhjsY8aogcJbY65tbcFqhHz6+HTutbyy1gCDw8O1wO+duryePB/rzX1/
        ExoHU2TEeWVYWfOCWC5mhr2QB9Ldiqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-ezcSLyDeO-2eKLQy-x5yRw-1; Sat, 10 Dec 2022 18:01:04 -0500
X-MC-Unique: ezcSLyDeO-2eKLQy-x5yRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF95E85A588;
        Sat, 10 Dec 2022 23:01:03 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B8140C6EC2;
        Sat, 10 Dec 2022 23:01:03 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] mm/kmemleak: Simplify kmemleak_cond_resched() & fix UAF
Date:   Sat, 10 Dec 2022 18:00:46 -0500
Message-Id: <20221210230048.2841047-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that a KASAN use-after-free error was reported in the
kmemleak_scan() function. After further examination, it is believe
that even though a reference is taken from the current object, it does
not prevent the object pointed to by the next pointer from going away
after a cond_resched(). So the heuristics is now changed to restart
scanning from the beginning of object_list in case the current object
is no longer in the object_list, i.e. OBJECT_ALLOCATED flag not set.

While making the change, I also simplify the current usage of
kmemleak_cond_resched() to make it easier to understand.

Waiman Long (2):
  mm/kmemleak: Simplify kmemleak_cond_resched() usage
  mm/kmemleak: Fix UAF bug in kmemleak_scan()

 mm/kmemleak.c | 59 ++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

-- 
2.31.1

