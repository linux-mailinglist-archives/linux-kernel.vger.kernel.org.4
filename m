Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844C073BA34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjFWOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjFWOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC9C2695
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EQ9G/WyCR5BzbeYKEOc/c4ex09bzeUnnwnMR75AIjI=;
        b=Te/9SbCUR3wosLUMCz0Kgo/EYnebpEtmVUEKvx2xWgPU+fNw71rWMEsbF89SqlQUwdC+Dv
        olOmR7V1cEiMjlRfcR9uRCzlLIH+P9JqooNgRYZVv6t/0PbgnTLWERMl8zuGsmH38E0+rK
        L7YpMAZ2h/+rnjmVsHHXQymqxqd+0uc=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-0rnWH1vaMrGklHoJAUwyFw-1; Fri, 23 Jun 2023 10:29:50 -0400
X-MC-Unique: 0rnWH1vaMrGklHoJAUwyFw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-46609b859f3so46927e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530589; x=1690122589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EQ9G/WyCR5BzbeYKEOc/c4ex09bzeUnnwnMR75AIjI=;
        b=L5mfwJRPcK419wZbXqDYuffMvvJ3D6zv5+J369H9x9NWoAy7aP7i+mUDIU2DUprAzH
         2nN8uTZ4wff15mycs8x0naLj1Wfw0M27LpQ2aR7Uta65kANHEhQUyNhWneMQRGxsVVM9
         ObiIPfn094mSew2OwiCWJyL+220UPzYpXAgR33Ynn7cfM6NJo1st5L+RzCLfvecUaol5
         SUr862aHWYYMaZCKQkCidTkVCb2sWzQz9tpEiV7p2Sxt+4TOJGUKtFgVR0Sree+WRwQ/
         vrg3ir3HXmzjSSvZVlOhmFFd3AQrdBaOxig/vx76LQSbFBnjGURVBQkusOOCkc5/T4gc
         A4SQ==
X-Gm-Message-State: AC+VfDxEwSelHHYpfGJMGWCZ7auZCzBEJqBZfSUw+hT0mtansfQPWnVZ
        ytgtbqwhGSA3F2yNA7boSMnDSiE2WlrF5tOfiQNP7JK0lnbxT55SWxHzS0uAVtKKiykJmRaq85S
        2JP9WLWL8H1FEwCc4CsncKADw
X-Received: by 2002:a05:6102:2158:b0:440:a365:ad50 with SMTP id h24-20020a056102215800b00440a365ad50mr6848581vsg.1.1687530589438;
        Fri, 23 Jun 2023 07:29:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OV7Q+bQTZ8nHFXS9cjC6+LnDnU4rBFQijCL6Szo7CDKJQ/6LTVykZKitewlwT3KIiAhTFvw==
X-Received: by 2002:a05:6102:2158:b0:440:a365:ad50 with SMTP id h24-20020a056102215800b00440a365ad50mr6848561vsg.1.1687530589175;
        Fri, 23 Jun 2023 07:29:49 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 7/8] selftests/mm: Add -a to run_vmtests.sh
Date:   Fri, 23 Jun 2023 10:29:35 -0400
Message-Id: <20230623142936.268456-8-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623142936.268456-1-peterx@redhat.com>
References: <20230623142936.268456-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

