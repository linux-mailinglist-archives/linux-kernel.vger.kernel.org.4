Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22590736003
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFSXMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFSXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DFDE6C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EQ9G/WyCR5BzbeYKEOc/c4ex09bzeUnnwnMR75AIjI=;
        b=M88cQhai4OsCyETed1vR9EwN40oL2oyty2cgTKtukIKUS+SSmXrAgcBq88xeE0ROqLxFgv
        ok/MVC+6aPpG1eXcCt5+YL6bWwvIGJuVnyjg68VzjuZYpRe/YWTeJ9jf0Tw67wdeoxr++4
        FOj9oirxKOhZAJuPj5gBZM4SkWTOiSM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-fECThjJKPNa7mK2VvHfJTA-1; Mon, 19 Jun 2023 19:10:57 -0400
X-MC-Unique: fECThjJKPNa7mK2VvHfJTA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3fde794cd50so5980721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216257; x=1689808257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EQ9G/WyCR5BzbeYKEOc/c4ex09bzeUnnwnMR75AIjI=;
        b=XErrbztvtNkkdYevFOcVfg/GyMY/og/9VM6Ls5s541AwLi2bAIi0ehmwJ23f7D2qwT
         CRrrinkRfLpPcXB65CGqKPjXXoZJqDrvuS/QKmNo3ZPsUSsXUE3o88JlXkAPXXKiuWBg
         LcKsDX6KlRNI33GBjUQ2PvrIgCM+8tHt1+frwU+8Ua4RIwxBvBtvFczxs+6jGFhvqlCr
         1uKW4OS4OKqsJ/hUoYOZYVs0hUXkN6nZ0AnYrE3mqPQHUtF8d5t15iXZx1wkIHdqrBoZ
         xrGQmhPh+4O9xNtV7wV9M90HaHwGcA4ZVjgpNsUONvfPCaLLSOYR+746RaeXygY16yIp
         y/7w==
X-Gm-Message-State: AC+VfDx5B6ZEyxs6kx0X7aYk/Vs2BlZ7v+a3KCPWXRp8x6+mpBsdsc06
        2m3vS7RY8gQM9+cIHrxQs4Ls5nufoMMtOHRVZyLgxkgBflPTpRYcZ27HPGFh28HeCgq5k5BH44F
        fmsALLdaHr43/nUUlp5afHBVC
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id kc28-20020a056214411c00b0062df62b0907mr14179212qvb.0.1687216256827;
        Mon, 19 Jun 2023 16:10:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QlF4GkYWNboxTnBtKcrBbY45j5tqglo1WSMcbfSsLOwxwdtYl1NbYzYEaZwqHBtQcKataQQ==
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id kc28-20020a056214411c00b0062df62b0907mr14179194qvb.0.1687216256500;
        Mon, 19 Jun 2023 16:10:56 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 7/8] selftests/mm: Add -a to run_vmtests.sh
Date:   Mon, 19 Jun 2023 19:10:43 -0400
Message-Id: <20230619231044.112894-8-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619231044.112894-1-peterx@redhat.com>
References: <20230619231044.112894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to specify optional tests in run_vmtests.sh, where we can run time
consuming test matrix only when user specified "-a".

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3f26f6e15b2a..824e651f62f4 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -12,11 +12,14 @@ exitcode=0
 
 usage() {
 	cat <<EOF
-usage: ${BASH_SOURCE[0]:-$0} [ -h | -t "<categories>"]
+usage: ${BASH_SOURCE[0]:-$0} [ options ]
+
+  -a: run all tests, including extra ones
   -t: specify specific categories to tests to run
   -h: display this message
 
-The default behavior is to run all tests.
+The default behavior is to run required tests only.  If -a is specified,
+will run all tests.
 
 Alternatively, specific groups tests can be run by passing a string
 to the -t argument containing one or more of the following categories
@@ -60,9 +63,11 @@ EOF
 	exit 0
 }
 
+RUN_ALL=false
 
-while getopts "ht:" OPT; do
+while getopts "aht:" OPT; do
 	case ${OPT} in
+		"a") RUN_ALL=true ;;
 		"h") usage ;;
 		"t") VM_SELFTEST_ITEMS=${OPTARG} ;;
 	esac
-- 
2.40.1

