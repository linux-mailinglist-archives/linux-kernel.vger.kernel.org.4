Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485775F3ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJDAhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJDAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC628711
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664843832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4xYjXYzlE422UA6NYhxH1mMMh8xu1ZsHfGS6BWev5s=;
        b=IaPiIOq7aSEDrY8e1winsP5ESwc4IhjhaC4BkPSMsZ5stIEbgxbrG11agWq0Vyf7AIWWlY
        aj0xWuK/CMd15u1IhFldXbADwLsUq7I+MAgLA/GD3PNqnp5RDdEQedPgAU6t5GN1l2cTmP
        yxBRt8Eyb6Hsi2iJWg8i+qsDrLhddlo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-4MrAOj3LPDyY1ipQ3V6s9A-1; Mon, 03 Oct 2022 20:37:11 -0400
X-MC-Unique: 4MrAOj3LPDyY1ipQ3V6s9A-1
Received: by mail-qv1-f72.google.com with SMTP id ks15-20020a056214310f00b004b18ea4bc05so2418969qvb.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x4xYjXYzlE422UA6NYhxH1mMMh8xu1ZsHfGS6BWev5s=;
        b=0azERg11iDOl8xydFnCQuSesA+yMCEOyBOVJrq0qIOe5E4zZdsa9HlAif6pXXeKngR
         ywi5ANUk+9FJb8Y6SjV8oYCo0lJddD3flT4/XlGOEe9uXreUgtCQhnn00dr4ZrpuoZYM
         J3vNTR4J/G8fWh91yBMR9mQplu3V22zfuU11MT1+Xo2IEDsLjJGxTAfbode+V+a0V3K0
         ekNzjaL7KHGt8/CZt3/WwLwIjCFiXPK2cYU2L2eUK2XVKxTXzXUsqX0fbM3ETlLj0HtF
         IHsozGeRDTyjvbaimXuRdhaot8zNq/vLdwZaX0+t/0FnveebVBqTKLfnNdAXjrAcCUC/
         lMxw==
X-Gm-Message-State: ACrzQf38QqSa53vFQuM/Den+j8617FkEk9IzoowI3qpkySab6WxbsfxO
        mkPZ42F9nL7zTkQUHEczB4kxYZZWnkrQvf3r7PpxqeWopnaaSNxqy8aSj7FunzJgDVoyN9lcQ+R
        Qt3xr16/YGmZNLI2zqN9AJTggCZJNWCcrRfRz6r2K/ngtTsbIkLzNJtkKuaiBS8/mXAeU0pjLFQ
        ==
X-Received: by 2002:a05:620a:d94:b0:6bc:5a8c:3168 with SMTP id q20-20020a05620a0d9400b006bc5a8c3168mr15260777qkl.56.1664843830741;
        Mon, 03 Oct 2022 17:37:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5mTbnDGFwa4OqFZLWTwpewQHP9t+R+EHTP9kL897GWBWxesSU9GeVQIGXXHofPQ4um9Sh1gw==
X-Received: by 2002:a05:620a:d94:b0:6bc:5a8c:3168 with SMTP id q20-20020a05620a0d9400b006bc5a8c3168mr15260759qkl.56.1664843830507;
        Mon, 03 Oct 2022 17:37:10 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u30-20020a37ab1e000000b006bb9125363fsm12228104qke.121.2022.10.03.17.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:37:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] mm/hugetlb: Use hugetlb_pte_stable in migration race check
Date:   Mon,  3 Oct 2022 20:37:04 -0400
Message-Id: <20221004003705.497782-3-peterx@redhat.com>
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

