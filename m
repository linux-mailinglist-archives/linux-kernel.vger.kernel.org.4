Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B85F49C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJDTeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJDTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789E696E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664912048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifodv0MqT+m7iheWymJyjwtmpsW2iF/ZrnT+XTcpadM=;
        b=d9bqvHzOhvjAjaAowAOgLbQHIYHrP2vCIVNUVKlxP2ESgp4TtQejHTmjV6FZeipTXu9Ymz
        4xLntxeBBCfYlqudq8UE3uKeuy4CX+b4vUCN4IbkmgDtSYnCcEPNIFhgr3OR7JAsicpi1L
        15P+edQIQvH0hZkSqe1jjgaFDu5AuyM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-imGXpfA2O7-jPwyrPfRubg-1; Tue, 04 Oct 2022 15:34:07 -0400
X-MC-Unique: imGXpfA2O7-jPwyrPfRubg-1
Received: by mail-qk1-f199.google.com with SMTP id k2-20020a05620a414200b006ceec443c8bso12548386qko.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ifodv0MqT+m7iheWymJyjwtmpsW2iF/ZrnT+XTcpadM=;
        b=Wk7/dW7zQHDB4NFCDw/mL3n6MU1ANfljop0CSvbPjdqTRRuEVAzi6AxLE0pUpSbMzD
         ua9572AB62WABRUJUOaKlZY2G72+RDdyexgyZb81G7MIlV4TSzUNFme3JZRv5QA3fq4Y
         jAYWEM+2F4LC+5G0ze+BmRMbxYwDNzlwO6JXu9goh5yCfHcAqrCCXx5HxPLfZ+IMSu6q
         ngOE78vG0WcETqzD+S0sTdWYM1D6WpubaOh40LZSS7A1xUiFOsAqhdzsZF+/RnCvtq+N
         UuWIWE78O461lpBWXd8X65ONL/sySIor4F3nLR6r1ShepIYRtklf2ZjwvM2RqwN5h4oZ
         FGAw==
X-Gm-Message-State: ACrzQf0JLETye78aQJ0bcNi9TDIoLMe9YzL4es/hHQV7Dui1nqrKaYDg
        6pFQokOQ7H/lCK1l9JvkF4OGpD6/njDGFx0yhAe9zBohFDdfXSq1eMksACodCNtHJVojcwFknnT
        OeT3HCJIgSSgXewXYVHP35yIH
X-Received: by 2002:a05:622a:164e:b0:35b:a852:52ca with SMTP id y14-20020a05622a164e00b0035ba85252camr20719339qtj.2.1664912046726;
        Tue, 04 Oct 2022 12:34:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4arrLFNIId2qTFtBrd4SBa+FZyl8Drmu4Nnvp22VTiLuMn7OhMRWmkaEkQqUdfhfxWBgrhdQ==
X-Received: by 2002:a05:622a:164e:b0:35b:a852:52ca with SMTP id y14-20020a05622a164e00b0035ba85252camr20719325qtj.2.1664912046503;
        Tue, 04 Oct 2022 12:34:06 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id z5-20020a05622a028500b00342fb07944fsm13299811qtw.82.2022.10.04.12.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:34:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 3/3] mm/selftest: uffd: Explain the write missing fault check
Date:   Tue,  4 Oct 2022 15:34:00 -0400
Message-Id: <20221004193400.110155-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004193400.110155-1-peterx@redhat.com>
References: <20221004193400.110155-1-peterx@redhat.com>
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

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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

