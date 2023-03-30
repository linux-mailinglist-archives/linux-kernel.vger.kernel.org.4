Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866156D0AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjC3QIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjC3QH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EC9750
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/DyAZC+/gpTxCJoW2F/j7VlnCZ3k9Ngitz86Xlm4uL8=;
        b=ImGjAq/vfgu9OJ6UsCoB5E9lsITQmAo2Uwh23JSIAtWsl6Qt1/uYA6SCcIw2P5qmo6MjMS
        t4RvxpeGOIiet0I/x7OVwUOzZ5y7YnvqVUrUxfzEAOx/sRrwgmyvR112fojmgLMbJ4jquT
        I48Bgh2Q5Z1/UDIcri2qlL9BRDzYvcM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-9yfrOVvNODSqDwV4bD_0Qg-1; Thu, 30 Mar 2023 12:07:11 -0400
X-MC-Unique: 9yfrOVvNODSqDwV4bD_0Qg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-57c67ea348eso12976106d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DyAZC+/gpTxCJoW2F/j7VlnCZ3k9Ngitz86Xlm4uL8=;
        b=jcILiYd9VU7MqIOCqpGoiFp4vH3t0QOenrAIQQfFVpnzHVxJe19EwI2+vO4bsZUkJC
         hFPKXWMVCX7pkRr+H0AHTK37OLfchBjuRMZWzc0pa2sV3eKUq484qcyleA1wxSddV//4
         JTxXpypnJz1kR1Tn7pY7hvMCI7ochxv0Qb3ypsgDUAxgkbY9uk4yPMWC7jR/ntZmiW49
         fpIwxvT1jWm+wiPhkqKasKY5dZkDVH1tmO5V1VKt9/3cLPHNbJcRCCIbGZiF5IR7KBXG
         UJFSHMTHQJNkuKFV5UsgGgZYK24q113GMRCCrie3AC+LzLkWrPyfHF6Wc6CbOxfiIg9+
         Kd8Q==
X-Gm-Message-State: AAQBX9fgF0/0JVUAtVW2b9DC2bgGRGDJdwUX4z0FTa+umM/XmeCF3xdY
        vCWv8oI+tguDIUpNmvzaupW3GcppW9hEUTw0IgUJswVW2HZOl+XY9QRufTW+kqZu3PgknX0pWVJ
        Wy7URwAZM5DR91vVCGQT97mJ4
X-Received: by 2002:a05:6214:528f:b0:5a5:e941:f33d with SMTP id kj15-20020a056214528f00b005a5e941f33dmr3644486qvb.3.1680192425765;
        Thu, 30 Mar 2023 09:07:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y8AnvqrQxdANaOHqwR9jEVyFMo9wivJ8eoja66xX8MtAvhRbrTVRkVpNxVq9kH1pnRwQAeXQ==
X-Received: by 2002:a05:6214:528f:b0:5a5:e941:f33d with SMTP id kj15-20020a056214528f00b005a5e941f33dmr3644457qvb.3.1680192425523;
        Thu, 30 Mar 2023 09:07:05 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id b17-20020ad45191000000b005dd8b93457fsm5467877qvp.23.2023.03.30.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 06/29] selftests/mm: Link vm_util.c always
Date:   Thu, 30 Mar 2023 12:07:00 -0400
Message-Id: <20230330160700.3106955-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do have plenty of files that want to link against vm_util.c.  Just make
it simple by linking it always.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 47516a78d447..b35f3eafde3c 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -105,17 +105,7 @@ TEST_FILES += va_128TBswitch.sh
 
 include ../lib.mk
 
-$(OUTPUT)/cow: vm_util.c
-$(OUTPUT)/khugepaged: vm_util.c
-$(OUTPUT)/ksm_functional_tests: vm_util.c
-$(OUTPUT)/madv_populate: vm_util.c
-$(OUTPUT)/soft-dirty: vm_util.c
-$(OUTPUT)/split_huge_page_test: vm_util.c
-$(OUTPUT)/userfaultfd: vm_util.c
-$(OUTPUT)/gup_test: vm_util.c
-$(OUTPUT)/mrelease_test: vm_util.c
-$(OUTPUT)/transhuge-stress: vm_util.c
-$(OUTPUT)/ksm_tests: vm_util.c
+$(TEST_GEN_PROGS): vm_util.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
-- 
2.39.1

