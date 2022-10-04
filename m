Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0E5F3AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJDAhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJDAh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA3F29C91
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664843836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5RzxXUZxi/MrG066VL+DnGEo1qQl33988Rm0NK9+zA=;
        b=DHShSmSC9PZgLXWMSMLDn8Yfia/4DziRQxksoWvAUKjR5oRWm3gEQSFILIX23t+hE/BwmY
        qy3IPbypaZLuEaEvmPgB1lLceAipaWurepzSLXODvuqZywMPkpjWBvwydcQaAM6kooU7OX
        uO5iaONhwNQlsStFH8H2DNvM//1tKME=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-3JUJXy9kMfeLAG5wQKV7Dw-1; Mon, 03 Oct 2022 20:37:12 -0400
X-MC-Unique: 3JUJXy9kMfeLAG5wQKV7Dw-1
Received: by mail-qk1-f199.google.com with SMTP id az15-20020a05620a170f00b006cece4cd0beso10479595qkb.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/5RzxXUZxi/MrG066VL+DnGEo1qQl33988Rm0NK9+zA=;
        b=Doqp7fD2nLsoqNpmlmv/yi7EfwyEw64QF8JuNnEPL0j+T1QrcV0oBBbqJ+GR3/n6DN
         Ks3OKXMJEFUpmKAVYFdjKQcPQKSJdqIyE1BtbeSR/k7e9xhZMmtiLwMMmZchlKrc37Jv
         7nHJ3t3LqeDwbukZr/TxsXmb2EQDn58JreYhY42fxJUTOccX+PXZ4TA1YAeyB4QDUctz
         0NNtynh87LJUj68ryPBuS3tA5+Y/eyInzRAQ33fwFWAyVhCEtCky5+aQ2mvmaS1FchtE
         eGpMm3St8xiTvspv/4If4/ymfSh/PiWAtzW2ZA2kZ9SRfEmq1sZxEyxYS8Wz9EXgWU5H
         UgRA==
X-Gm-Message-State: ACrzQf25whJPupVdApCIA7u3ULN7VMu1GsENgjn0HJABv6s+StYID9sr
        r0trVEH0xMa9kjuPUBIAKxJnW+aVL8fUqpoTgn9hoDumNR3WFGVs8XBXCN3p5JYwS/BGhRBCeAE
        6J6+nM6hfLnOp0sZO3V+K1a8rarHOKcLZfCv1Fc7n05qZqss67bQqTLQE4P+aXaC2kwbjJyZQQg
        ==
X-Received: by 2002:a05:620a:46a4:b0:6ce:c4af:5a54 with SMTP id bq36-20020a05620a46a400b006cec4af5a54mr15459023qkb.377.1664843832023;
        Mon, 03 Oct 2022 17:37:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5UooKxylyfkc7pYh77HC484ZRa3g4v9oRRuF3krQ3VgFlBVG5fQ7DBFiKYYqVi1SHhupwxmg==
X-Received: by 2002:a05:620a:46a4:b0:6ce:c4af:5a54 with SMTP id bq36-20020a05620a46a400b006cec4af5a54mr15459007qkb.377.1664843831739;
        Mon, 03 Oct 2022 17:37:11 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u30-20020a37ab1e000000b006bb9125363fsm12228104qke.121.2022.10.03.17.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:37:11 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] mm/selftest: uffd: Explain the write missing fault check
Date:   Mon,  3 Oct 2022 20:37:05 -0400
Message-Id: <20221004003705.497782-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004003705.497782-1-peterx@redhat.com>
References: <20221004003705.497782-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not obvious why we had a write check for each of the missing messages,
especially when it should be a locking op.  Add a rich comment for that,
and also try to explain its good side and limitations, so that if someone
hit it again for either a bug or a different glibc impl there'll be some
clue to start with.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 74babdbc02e5..297f250c1d95 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -774,7 +774,27 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		continue_range(uffd, msg->arg.pagefault.address, page_size);
 		stats->minor_faults++;
 	} else {
-		/* Missing page faults */
+		/*
+		 * Missing page faults.
+		 *
+		 * Here we force a write check for each of the missing mode
+		 * faults.  It's guaranteed because the only threads that
+		 * will trigger uffd faults are the locking threads, and
+		 * their first instruction to touch the missing page will
+		 * always be pthread_mutex_lock().
+		 *
+		 * Note that here we relied on an NPTL glibc impl detail to
+		 * always read the lock type at the entry of the lock op
+		 * (pthread_mutex_t.__data.__type, offset 0x10) before
+		 * doing any locking operations to guarantee that.  It's
+		 * actually not good to rely on this impl detail because
+		 * logically a pthread-compatible lib can implement the
+		 * locks without types and we can fail when linking with
+		 * them.  However since we used to find bugs with this
+		 * strict check we still keep it around.  Hopefully this
+		 * could be a good hint when it fails again.  If one day
+		 * it'll break on some other impl of glibc we'll revisit.
+		 */
 		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
 			err("unexpected write fault");
 
-- 
2.37.3

