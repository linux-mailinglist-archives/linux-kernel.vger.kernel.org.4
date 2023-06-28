Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0359741B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjF1Vz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjF1Vyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97492127
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HfHdG/KQ5Uxfq5f0w/MDNpC44bP5ckORXtaAeg9+TI=;
        b=ZXrUgH2nVSv0WUOunmRgqKL8X0seYS0+KTaECkZc8pfdt2tM/4mkOI0VGWm33gBhmhEUBJ
        HxD5NBJ+wNy81U//o49gLi8MAIPDLc59BOPC9JRG958q3y6SsitFnueHSCrSbmmRY7AHNl
        Ze9ZGr81znxkjQO4FUyiFH1HvNY7+sg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-kSXfzjzJNNu6lqB3GXRxFA-1; Wed, 28 Jun 2023 17:53:22 -0400
X-MC-Unique: kSXfzjzJNNu6lqB3GXRxFA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635f8ae5f88so39436d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989202; x=1690581202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HfHdG/KQ5Uxfq5f0w/MDNpC44bP5ckORXtaAeg9+TI=;
        b=GoDaY9wQRXOwQBbqFfNXAW8wQtt/fuanxzhap9543mwplBHrKLNQ5up4jvJXmhSyCG
         mgdQ+oWR2KBjdewXyXLVjjMZ1EcE7rk+vEHazpwD3dteLNZji/l4CWldQ1nsa5jbvqEB
         D4Zhh83r0FADAia/6qp4/X7Ei+hIZEfXkFYZUL0l++HGM/QPDmRcBIul1nRooEzhC3ma
         0DxFScfvSCRveab7eZOVQwCoxINMii6j/+S9oZXoO+XzHd4ApbSB5vz++wpfrSQuMRAV
         fXHH1uBgEH2EjEzceqDAnp1c8BOXpdYazy6OudpMWAaw+SHs21qOFZhTRGBnk7a3HOGO
         xW3A==
X-Gm-Message-State: AC+VfDxn4EqsJZ84td0o0bfpPXy652+wV5sEkLAqKi/aOwnNYv24wRAB
        Y1LxsoWazhZrq/TdXu2N4RaQzGuYKkPcV+I2J6w7bHZ2Yh3jJVkGrneP23HUq7tVOlhJjoW1dQt
        wLZrpyXImamUXtaiNNOAL1dVx
X-Received: by 2002:a05:6214:260e:b0:626:2305:6073 with SMTP id gu14-20020a056214260e00b0062623056073mr6706614qvb.4.1687989202308;
        Wed, 28 Jun 2023 14:53:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hmEwEfHLsDUveWKtt2eKqu3uz2U6qRFVCfBKaJKRVOW25O/2xvrvScvNnG1pcxxvjL3xB5Q==
X-Received: by 2002:a05:6214:260e:b0:626:2305:6073 with SMTP id gu14-20020a056214260e00b0062623056073mr6706604qvb.4.1687989202071;
        Wed, 28 Jun 2023 14:53:22 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        James Houghton <jthoughton@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com
Subject: [PATCH v4 7/8] selftests/mm: Add -a to run_vmtests.sh
Date:   Wed, 28 Jun 2023 17:53:09 -0400
Message-ID: <20230628215310.73782-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215310.73782-1-peterx@redhat.com>
References: <20230628215310.73782-1-peterx@redhat.com>
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

Acked-by: David Hildenbrand <david@redhat.com>
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
2.41.0

