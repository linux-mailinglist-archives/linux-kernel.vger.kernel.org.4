Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972AC68B081
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 16:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBEPGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 10:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 10:06:08 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DC1CADE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 07:06:05 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id k17so1123763ilq.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q29h+5pa7qc4gtg9UpocpWF+VOGMppgUk862ZKA99Fw=;
        b=Q8paXj+i9kUYQZdNbgySo+rSKgTuuDvRZ8oyYlUNobDeshOPwsNcC5oAUQZENp0OpQ
         MBIbMLzR90RiEy4KLZKKy1+iwyAvlDxZcS+j8Q/NcBRGn2kgOSsb1ANJx2voSJhUYtR8
         +tegpCiM7H0L3skPO6aXPD5vVeEsmVdm86GZLoVQKdORsEoS9gSqGqC2xwsfOjArlfXa
         G0WcXx6uKfoBRYdUao4ET39ZGdAZVYOkbcPJsbA7yKY6RxULXYSLBF+jKWl8vF0eKA1b
         emT9JJCyhU1KPehUT24mNPt4Hqxq9t9hr2Y9NqtcQFtBxjOEdjXAFQp1j68gHw1SEgeH
         7g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q29h+5pa7qc4gtg9UpocpWF+VOGMppgUk862ZKA99Fw=;
        b=aoLVGWlhyaJbhKSiYLlVt+JzFv8XIDxETMH/OnSlDxtGmjr+oFIbk3iUagrX91bMCt
         twKvwdZG+D9tDr8R+yFJhf5jHnOCfE8B9BEb5ANgwv2BvcV7RqMAlZW0zjLQ6Wo3PmOz
         mOqMoJCesoM0zNOVm/TCFJJQa3clVPPtwHFzO8RfIHfXUkWoQlO9PXyCLyDpHFQX55qw
         wP6UGnGPG5sZBtWfOPr8HRTzLvxanEbpsbKM99tjCbN1gCCUEWUlnq+/9m4f11HfEypu
         ZoxwgdvEpkry3siTUFCvmSwVifG7UrLUjNBknmOsEnW8yIeDomFAOK10yrNliqtAo1cN
         34Dg==
X-Gm-Message-State: AO0yUKX0lA3tHSbHaCAvDVqNry1brJBmjzcU5/8JgoSJHpVGPBU878dl
        aC3x2qvc0t/SA3s03IOM8uY=
X-Google-Smtp-Source: AK7set+uhZqKYqaiCDbU8803ot5KJZixWzHyUTIMAAk6k/pqJ9UEHUzBbVA8eXhD5fKlTpyscRUnMA==
X-Received: by 2002:a92:7512:0:b0:313:bdde:613a with SMTP id q18-20020a927512000000b00313bdde613amr1009143ilc.28.1675609564999;
        Sun, 05 Feb 2023 07:06:04 -0800 (PST)
Received: from haolee.io ([2600:3c04::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id co12-20020a0566383e0c00b003b7d56593d6sm2666082jab.160.2023.02.05.07.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 07:06:04 -0800 (PST)
Date:   Sun, 5 Feb 2023 15:06:02 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, haolee.swjtu@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: eliminate function call overhead during copy_page_range()
Message-ID: <20230205150602.GA25866@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_normal_page() is called so many times that its overhead is very high.
After changing this call site to an inline function, copy_page_range()
runs 3~5 times faster than before.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7a04a1130ec1..2084bb7aff85 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -562,7 +562,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  * PFNMAP mappings in order to support COWable mappings.
  *
  */
-struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
+static inline struct page *__vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t pte)
 {
 	unsigned long pfn = pte_pfn(pte);
@@ -625,6 +625,12 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 	return pfn_to_page(pfn);
 }
 
+struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
+			    pte_t pte)
+{
+	return __vm_normal_page(vma, addr, pte);
+}
+
 struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t pte)
 {
@@ -908,7 +914,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct page *page;
 	struct folio *folio;
 
-	page = vm_normal_page(src_vma, addr, pte);
+	page = __vm_normal_page(src_vma, addr, pte);
 	if (page)
 		folio = page_folio(page);
 	if (page && folio_test_anon(folio)) {
-- 
2.37.3

