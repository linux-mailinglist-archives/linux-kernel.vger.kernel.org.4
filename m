Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0773FB09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjF0LXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0LXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD9BDD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687864954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tWgJbMty0vF+sRGgcNfqljzE54wPeczugMOQkaZlck=;
        b=UQL7o5DxCmyRQ6Kwx8ymw7P6YeQg4INegkBQPQC3r+mbLYhy3yhApFGEDq60z9zmuyMam2
        1SXaMgSn9/fbA0/z7C/zwzRBkzL66mV0mdQRTN9mEOVaW2Q8IYTcuasq/WgI57Rtv5Z7f9
        IUMY78UMPD2UWARWz/+SsB5GQeXDuOc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-FJnFfwwzPY-Qr_PfD7F3LQ-1; Tue, 27 Jun 2023 07:22:30 -0400
X-MC-Unique: FJnFfwwzPY-Qr_PfD7F3LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C720F381494D;
        Tue, 27 Jun 2023 11:22:29 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1185200A3AD;
        Tue, 27 Jun 2023 11:22:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 1/5] mm/memory_hotplug: check for fatal signals only in offline_pages()
Date:   Tue, 27 Jun 2023 13:22:16 +0200
Message-Id: <20230627112220.229240-2-david@redhat.com>
In-Reply-To: <20230627112220.229240-1-david@redhat.com>
References: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check for fatal signals only. That looks cleaner and still keeps
the documented use case for manual user-space triggered memory offlining
working. From Documentation/admin-guide/mm/memory-hotplug.rst:

	% timeout $TIMEOUT offline_block | failure_handling

In fact, we even document there: "the offlining context can be terminated
by sending a fatal signal".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..0d2151df4ee1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1879,7 +1879,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	do {
 		pfn = start_pfn;
 		do {
-			if (signal_pending(current)) {
+			if (fatal_signal_pending(current)) {
 				ret = -EINTR;
 				reason = "signal backoff";
 				goto failed_removal_isolated;
-- 
2.40.1

