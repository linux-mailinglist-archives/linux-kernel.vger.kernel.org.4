Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B3064DE27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLOQEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLOQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FD1AA07
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671120191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wHW291lHqyZueeOZojJhSJ9Wkscs64vZJ6pNmv0fUDk=;
        b=eNkvhrZf1MESYljOrECVY/m+I3SPCO6NO7mFpLbRCfulPgMEiOC9Cjiw3EW+CUN9BxsszF
        0dfBqQ7XW3EhV5kzLLk0GFEWFgG6ygzn9a+P1s5hH/4xSn0NMdB20w2YW0KLFgrw6moBjV
        xmfNCjz4H8KPloQX1JNPFIJOr5iSOwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-UV1-hDmNP22VFnpWwnjtpA-1; Thu, 15 Dec 2022 11:03:09 -0500
X-MC-Unique: UV1-hDmNP22VFnpWwnjtpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97D28858F09;
        Thu, 15 Dec 2022 16:03:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 184C24085721;
        Thu, 15 Dec 2022 16:03:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] mm/kmemleak: Simplify kmemleak_cond_resched() & fix UAF
Date:   Thu, 15 Dec 2022 11:02:57 -0500
Message-Id: <20221215160259.261136-1-longman@redhat.com>
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
after a cond_resched().

To fix that, additional flags are added to make sure that the current
object won't be removed from the object_list during the duration of
the cond_resched() to ensure the validity of the next pointer.

While making the change, I also simplify the current usage of
kmemleak_cond_resched() to make it easier to understand.

Waiman Long (2):
  mm/kmemleak: Simplify kmemleak_cond_resched() usage
  mm/kmemleak: Fix UAF bug in kmemleak_scan()

 [v2: Update patch 2 to prevent object_list removal of current object]

 mm/kmemleak.c | 83 +++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

-- 
2.31.1

