Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA66C6D0AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjC3QIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjC3QIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE9B9EE0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASfRfnQJTCdEglytu7DR/J7BYjWDsPlfNboYF8myg6I=;
        b=PGXCY5M6uUnCD/BeXnzDKcl0fDTXAAjNvz52OAHFA4JAQBOYz2lwPuz0jLLzGovVCwHUsB
        MQcphRsgYLkY7vASdD6xpV4wnrT69B1ACQ8rvfQfU8iTzW4zrQ6EK1iVlHm7CmkBCkuh2j
        +mEx+xs0JF1mSucFjSBE5K09ZQEG7rM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-wGpkg7j2OGm4_IpG_jxung-1; Thu, 30 Mar 2023 12:07:18 -0400
X-MC-Unique: wGpkg7j2OGm4_IpG_jxung-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-746bae78af3so60157885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASfRfnQJTCdEglytu7DR/J7BYjWDsPlfNboYF8myg6I=;
        b=gE7BtTKQsYzebb4aHofOTIkNAODIp1rEKlkU9bWqFL71eErsxiz9euOrdsUYQZnLJk
         5LEPZXtSJWRReyeuwc2l/tb9gJ88R7xJrgspCDP9jn4VE9gF03gYXVJJZCJ+AHu1lWBa
         c6awuLq7QreM0X+KSZziG0fzewgb2mP+OV54y8GiTx4X6H98h4e948Pd4D6D1kFCwlyf
         xyb+vTBH4c5ngzcADwLbguK/Asiy0Kck5Xaci3i8xZa/eGmBnBdJxKxYUdsBpzXH43f8
         lOgDdMpZB+zzmYzKuRe9YRysTcdmT2GJICFvIcOFo9f9kryGFaUA45Hz7xeaJD/7lyXx
         l9gA==
X-Gm-Message-State: AAQBX9d+dfRbaFXc7NQVsbW/3Xz/CiOd4CjHrelp1yTR2UctiRsU+EEp
        7TqA4AmqbAaNH0DGBYXalGflDij6uRjqGzJyC1XqiIEoAJbZlxWOutI5LaVxN7nq4442VBG213t
        8dOtA+a+WPFZpZOlg2+57odZ2Z0m9VXMh
X-Received: by 2002:a05:622a:1802:b0:3e2:4280:bc58 with SMTP id t2-20020a05622a180200b003e24280bc58mr4246277qtc.3.1680192437027;
        Thu, 30 Mar 2023 09:07:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350a/m9csPZTjry35+9guJnM30T3PDQjzdsPf9pXQljVsY4zoOcdyzpO3PTr9qXcknHqkrIxBoQ==
X-Received: by 2002:a05:622a:1802:b0:3e2:4280:bc58 with SMTP id t2-20020a05622a180200b003e24280bc58mr4246240qtc.3.1680192436773;
        Thu, 30 Mar 2023 09:07:16 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id s80-20020a37a953000000b00741a984943fsm11749352qke.40.2023.03.30.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:15 -0700 (PDT)
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
Subject: [PATCH 10/29] selftests/mm: Test UFFDIO_ZEROPAGE only when !hugetlb
Date:   Thu, 30 Mar 2023 12:07:14 -0400
Message-Id: <20230330160714.3106999-1-peterx@redhat.com>
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

Make the check as simple as "test_type == TEST_HUGETLB" because that's the
only mem that doesn't support ZEROPAGE.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 795fbc4d84f8..d724f1c78847 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1118,7 +1118,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 {
 	struct uffdio_zeropage uffdio_zeropage;
 	int ret;
-	bool has_zeropage = get_expected_ioctls(0) & (1 << _UFFDIO_ZEROPAGE);
+	bool has_zeropage = !(test_type == TEST_HUGETLB);
 	__s64 res;
 
 	if (offset >= nr_pages * page_size)
-- 
2.39.1

