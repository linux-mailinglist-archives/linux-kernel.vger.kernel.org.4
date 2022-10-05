Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86C5F58D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJERIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJERIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:08:01 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515269F57
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:08:00 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-miWDTMJbMfezS5CRUDpT-w-1; Wed, 05 Oct 2022 13:07:54 -0400
X-MC-Unique: miWDTMJbMfezS5CRUDpT-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D329F811E81;
        Wed,  5 Oct 2022 17:07:53 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F5D12024CC6;
        Wed,  5 Oct 2022 17:07:35 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     kernel test robot <yujie.liu@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     lkp@lists.01.org, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: Fix mq permission check
Date:   Wed,  5 Oct 2022 19:07:30 +0200
Message-Id: <20221005170730.835761-1-legion@kernel.org>
In-Reply-To: <202210052100.86dbb00a-yujie.liu@intel.com>
References: <202210052100.86dbb00a-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot found a typo that causes mq_permissions() to return a
useless value.

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210052100.86dbb00a-yujie.liu@intel.com
Fixes: 7608b6a72ed0 ("sysctl: Allow to change limits for posix messages queues")
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/mq_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index ff1054fbbacc..ce03930aced5 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -102,7 +102,7 @@ static int mq_permissions(struct ctl_table_header *head, struct ctl_table *table
 	if (uid_eq(current_euid(), ns_root_uid))
 		mode >>= 6;
 
-	if (in_egroup_p(ns_root_gid))
+	else if (in_egroup_p(ns_root_gid))
 		mode >>= 3;
 
 	mode &= 7;
-- 
2.33.4

