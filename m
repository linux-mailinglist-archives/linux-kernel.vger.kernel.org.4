Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6629E6DFB99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjDLQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjDLQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6599C86B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASfRfnQJTCdEglytu7DR/J7BYjWDsPlfNboYF8myg6I=;
        b=ahtANicEzbRH5R6netmR2G7yRkzNf9ZEzlf5ApMhgYmG88s3/i62Ciqs7BRXBhsGp5NOhW
        jgpZLEu6PwB+rXw42EQmlIkdkFEAuAKT44K7rqABYPpETPPfbl5RLGC277yc8vkNmr+tqG
        s59opmNiJJDYTK6IoInZ5RAQj3hlIYk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-7CtgX-HeNjCEZSfHkPZmqw-1; Wed, 12 Apr 2023 12:42:40 -0400
X-MC-Unique: 7CtgX-HeNjCEZSfHkPZmqw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3e63ec50808so4676051cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317758; x=1683909758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASfRfnQJTCdEglytu7DR/J7BYjWDsPlfNboYF8myg6I=;
        b=BrlTy5npKntJN1FLw/x4MTNyFfn/GetgOc7XSfCikKhX/kILYeI+1tUaIKPJ8iUi5H
         1j0vD+N3h8XC/DhWyY/K74NHzmem2Y3jye8FmZyV1+LeYoDGr65H+/LnIVdHiit1sL2u
         CbOZNxjqUxFaej+4PKJnNem1gU+qSNtN+2wTO464d81egrDXked1kfrnDUToYfG5KlA/
         +bRT2x9IYIeUuLtOXS9SAY/MOpcQ0Oi6Dz3rrNe7hAAQqhkrnWOpGMzv9PL9kOmz6J7J
         u6xUWrKnHopz5bjd0sCgRLn4XencaJd3gvCkya1LS15U4na8ttTAEwqYSt3lA/p2/ybc
         Ld3A==
X-Gm-Message-State: AAQBX9dDIydKArOI7B0srGdPm+3qI8QVnC8oSZxbBnTyGAtV0jVefunI
        Cc1cWiJTc8pCHls/Dlr3M3CAqiRWywjj5FFZzq/soINc2Yz52MVVgacbfnjXuWyBRqez91MNFc5
        qFaiX5QgvsngqXiUr23KE6F0f/X2A/MgHkcX/uyZf7alhRjcd/mGgkpPNgPRc9oDIz9KM3e9UAm
        PSxzCmhQ==
X-Received: by 2002:a05:622a:1a16:b0:3e6:30c4:656f with SMTP id f22-20020a05622a1a1600b003e630c4656fmr31834209qtb.3.1681317758554;
        Wed, 12 Apr 2023 09:42:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y20Rk7NxXI1ENaDroyw/86rbNj0zbsfBVSdikymF4/GfJyJsnmj2oK5V1sNnQfT5FqPQ8k/w==
X-Received: by 2002:a05:622a:1a16:b0:3e6:30c4:656f with SMTP id f22-20020a05622a1a1600b003e630c4656fmr31834180qtb.3.1681317758231;
        Wed, 12 Apr 2023 09:42:38 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g26-20020ac8481a000000b003e38c9a2a22sm4334704qtq.92.2023.04.12.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:37 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com
Subject: [PATCH v2 10/31] selftests/mm: Test UFFDIO_ZEROPAGE only when !hugetlb
Date:   Wed, 12 Apr 2023 12:42:34 -0400
Message-Id: <20230412164234.328168-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

