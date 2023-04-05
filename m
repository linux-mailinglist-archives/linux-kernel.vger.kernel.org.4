Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D716D7F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbjDEO06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjDEO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663AE4EFD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680704740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/PrTUC1frDc4ONSybRkUjf9mg/0PMjE5a3fC6SdvA4M=;
        b=O8kDLQgiUJvQ9zjmJMtBFdJpgb3lKU/Jp9CYkg3Lzys6I4SL9ihO7l50sZOdPPAP4f8SsP
        ZKvuWpEVQ4nNIH+UNhkl2Z6y1pyJMudPJjLxR5AFWQtc4PAe6xqSMW7LQ4VZhLhpPJJDRt
        rKzXTSLaZlUWzxgHdbE+5VfqXcKKcPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-69bBNsnbO2ix0dbsL13xbg-1; Wed, 05 Apr 2023 10:25:37 -0400
X-MC-Unique: 69bBNsnbO2ix0dbsL13xbg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C2CC85C069;
        Wed,  5 Apr 2023 14:25:37 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01FDC400F4F;
        Wed,  5 Apr 2023 14:25:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v1 0/2] mm/userfaultfd: fix and cleanup for migration entries with uffd-wp
Date:   Wed,  5 Apr 2023 16:25:33 +0200
Message-Id: <20230405142535.493854-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One fix (I have a simple reproducer but it's too long to paste it into
the commit) and one cleanup.

uffd-wp migration entry handling for PTE/PMDs should now be fairly similar
code-wise.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>

David Hildenbrand (2):
  mm/userfaultfd: fix uffd-wp handling for THP migration entries
  mm/userfaultfd: don't consider uffd-wp bit of writable migration
    entries

 mm/huge_memory.c | 16 ++++++++++++----
 mm/mprotect.c    |  2 --
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.39.2

