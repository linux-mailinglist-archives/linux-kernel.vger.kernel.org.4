Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819E609C42
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJXIQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJXIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923B83FA01
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=II9JgjXmJ1/1u2CpjGXaWwKe+WW1rdQe/wCmpKMP6aM=;
        b=JgrF9EyjNHEJYlFJAZ32Xx6VvsLY3n8VobP5XITfLLJZmikEcJL11kJVSrtnTcT2K01il5
        r06xEUWyTbtgNUBBl0QlQBsEdPCdXi9Z/9cUiB5ur5A+tzm4tIplBZ64HqcV6v95kLLZwr
        /zSJCa84e6AcV3FgeLOKIHg/l+N5WVg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-bJGbBwAUPae4Iz-zpeIZZw-1; Mon, 24 Oct 2022 04:14:51 -0400
X-MC-Unique: bJGbBwAUPae4Iz-zpeIZZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC69F3C10147;
        Mon, 24 Oct 2022 08:14:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 546C940C94EB;
        Mon, 24 Oct 2022 08:14:47 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/8] mm/percpu: use list_first_entry_or_null in pcpu_reclaim_populated()
Date:   Mon, 24 Oct 2022 16:14:29 +0800
Message-Id: <20221024081435.204970-3-bhe@redhat.com>
In-Reply-To: <20221024081435.204970-1-bhe@redhat.com>
References: <20221024081435.204970-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To replace list_empty()/list_first_entry() pair to simplify code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 26d8cd2ca323..a3fde4ac03a4 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2143,9 +2143,9 @@ static void pcpu_reclaim_populated(void)
 	 * other accessor is the free path which only returns area back to the
 	 * allocator not touching the populated bitmap.
 	 */
-	while (!list_empty(&pcpu_chunk_lists[pcpu_to_depopulate_slot])) {
-		chunk = list_first_entry(&pcpu_chunk_lists[pcpu_to_depopulate_slot],
-					 struct pcpu_chunk, list);
+	while (chunk = list_first_entry_or_null(
+			&pcpu_chunk_lists[pcpu_to_depopulate_slot],
+			struct pcpu_chunk, list)) {
 		WARN_ON(chunk->immutable);
 
 		/*
-- 
2.34.1

