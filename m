Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C25F49C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJDTeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDTeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F569F45
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664912047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4nzBQiXcgt3UF9Pzmx/yx9uJYBtOMvv3jFBGynNQW0E=;
        b=UTg/C/cGQWPjMgNX2nPW5K+BPM548NoAcP3aZejjIkAKjBxFcBQRlZ2oKC+dpVIso2Z3DD
        Nnltr6PTDa9tlDcDyo6zsMgV3p412UPtkfCh8Pkb2XlU8CED8SqvzSiIdqthelNt38fQ1I
        yOqS0nopnK5Ot77iBqx7sr2n6R45Sqo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-L52bmSLdMr2U7Rn2SLfVTg-1; Tue, 04 Oct 2022 15:34:05 -0400
X-MC-Unique: L52bmSLdMr2U7Rn2SLfVTg-1
Received: by mail-qt1-f200.google.com with SMTP id bn4-20020a05622a1dc400b0035d24923a7fso9918924qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4nzBQiXcgt3UF9Pzmx/yx9uJYBtOMvv3jFBGynNQW0E=;
        b=0d3YL7HD3Tgkfu+lEGdVXONHkuUEi7366n0K2mGfhjqXzDBj0I3zYxkutrPsnnZxvC
         7mQa1CJobecxp6RMO1pfoKCugnzRBVeWg7r9ogtHTRsKzS3Wb0zdt1V55dV1jyWy45aX
         bSaBbMd199io/uT172gjQnxVYk3tHKWdl7uSJpMiT4ttrkJzjRVNv6DbrW2tSZPoHHAD
         /5F4sk2d2HboI5wGnKSiITmvOD//ebmG4oIqampClbXOAqzH2aHVxMblSKo58RwUwIyG
         36fY2w6qyAQ/srC6mz828UAJ5btd/ti0j/36BhGhN5s+DK25AiX1NqIohkOW4Y5xMOUT
         nlYA==
X-Gm-Message-State: ACrzQf2TplaAHH+0KCZq2MvAEiAVplA4fg4grUBCV406c4IfwfAu4p8d
        H6lNfOLKp4UOHprNk8SNw73yeMAfCn7UgKIEluiBINYGBG1QOcm3pTxWbJ5ADxF5OdHxDBqK44D
        tNWqchQL3G8U1uk8J+pREs0Tf
X-Received: by 2002:a05:622a:4c11:b0:35c:bbb2:d177 with SMTP id ey17-20020a05622a4c1100b0035cbbb2d177mr21244336qtb.314.1664912045441;
        Tue, 04 Oct 2022 12:34:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4kmipNt7Cgqge3wbSWm8qUnwYOKzrhBe+9IEVXWDGwMDz0ZKmsU4IruRK26u/ijQtioiyaFw==
X-Received: by 2002:a05:622a:4c11:b0:35c:bbb2:d177 with SMTP id ey17-20020a05622a4c1100b0035cbbb2d177mr21244308qtb.314.1664912045240;
        Tue, 04 Oct 2022 12:34:05 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id z5-20020a05622a028500b00342fb07944fsm13299811qtw.82.2022.10.04.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:34:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 2/3] mm/hugetlb: Use hugetlb_pte_stable in migration race check
Date:   Tue,  4 Oct 2022 15:33:59 -0400
Message-Id: <20221004193400.110155-3-peterx@redhat.com>
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

After hugetlb_pte_stable() introduced, we can also rewrite the migration
race condition against page allocation to use the new helper too.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f059acc38f3..63fe47a0240a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5623,11 +5623,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			ptl = huge_pte_lock(h, mm, ptep);
-			ret = 0;
-			if (huge_pte_none(huge_ptep_get(ptep)))
+			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
 				ret = vmf_error(PTR_ERR(page));
-			spin_unlock(ptl);
+			else
+				ret = 0;
 			goto out;
 		}
 		clear_huge_page(page, address, pages_per_huge_page(h));
-- 
2.37.3

