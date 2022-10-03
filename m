Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25E5F32FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiJCP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJCP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE832F384
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664812599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4xYjXYzlE422UA6NYhxH1mMMh8xu1ZsHfGS6BWev5s=;
        b=W6BKXoMOoyaFuL7XYVYX6JVBYsxcFlnLs2kA/NBKDwmJdWdWqDU3ipcJ/nNPM6K/xeXtnj
        qYs3N5B5mcf+30xDCDLk1CRFPgI66tNst0uFslDFXbkiM3nK49TMlR1lEW16b8gE37x1xx
        u3E3NqFpKst6tWhr2bKijuPOFsAd5Hk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-i-AYDZM1Nm23zwHOHTRGrQ-1; Mon, 03 Oct 2022 11:56:36 -0400
X-MC-Unique: i-AYDZM1Nm23zwHOHTRGrQ-1
Received: by mail-qt1-f199.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so7552005qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x4xYjXYzlE422UA6NYhxH1mMMh8xu1ZsHfGS6BWev5s=;
        b=yrHHGix8jPH6XyR/Ahe1FvPCSO557A1WwsQnYIff3Hfew/lEBzUatafByqV2nmSwEj
         0X2J0HWpzftn8S5GNb1OCAYMh0wFyxlWGQbyB5C4xp3lME2Qa1oyDh95DRTpQi+KqmV1
         d8BBqi01bo3iSberjDI9Y3mCajB2XUW//u61lT9wODWO/5Bw/xaRMgAEXOBMe2VzYEVT
         pqmypLZXB/vFPUT3EF0d/QRctBiYZjREtAB2FIOcyvPf19LKWDSMyYZ50IubvhO39bJQ
         ccYrhXZA8nLSR1qGy29+PrC88F5zKz6cS+KXlX+9TsLHrDcNBIKslXziAtPX0fewEa4l
         +eKA==
X-Gm-Message-State: ACrzQf0bsbx5VzVlLgRavEBGAyse58nCVzb8qFh/C1S0zHkWdyJ3e+yn
        YzNJwvAOzkyBoI1GjhOoxzhi/rzR+fkZ5uL3APaEWPpivX42WV05Of+94TaHWLnC1+bagpFRtUG
        vznKGAZEyZ8aJ7yol75nhR3GsQywtKyarwhDwko6rq1FeYY1BKm09ZO9MDr0Zo9Dp3vwOwOnzOQ
        ==
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id n8-20020a05622a11c800b0035ce912a8eamr16371767qtk.17.1664812595508;
        Mon, 03 Oct 2022 08:56:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7jmUpIO0vv9JXx3e6EMgXhYeRsvGCHvJYDkuTWLTvnmvX6dtNKe0ySPp+Up7ucpY2Yh41crw==
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id n8-20020a05622a11c800b0035ce912a8eamr16371738qtk.17.1664812595208;
        Mon, 03 Oct 2022 08:56:35 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006cf38fd659asm10956732qkb.103.2022.10.03.08.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:56:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 2/3] mm/hugetlb: Use hugetlb_pte_stable in migration race check
Date:   Mon,  3 Oct 2022 11:56:29 -0400
Message-Id: <20221003155630.469263-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003155630.469263-1-peterx@redhat.com>
References: <20221003155630.469263-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fa3fcdb0c4b8..e762c5369a6f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5620,11 +5620,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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

