Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE069FA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjBVRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113228D0E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677087520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlZAfWTuJXkBs46DXI6mtkWkRzzW2ABpGzcojN9g6uo=;
        b=AIzwnXBBcZBTME/983Qgz3Cm0BMREnAbxIK6hhlGNrIyO5OdpL8Ec6Nd77hiMR56zMhSbu
        XsN0Qs6Eay6m7g3LQxpw009s5hJbK5gLi9CJU15u2tJdGxBo3cDpTRJYbOLrZTPuqhauRV
        XFL363mL+FykT0PkKi033rfTRO/03+s=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-bBKbBE4GOWiQYy7HyZLBig-1; Wed, 22 Feb 2023 12:38:38 -0500
X-MC-Unique: bBKbBE4GOWiQYy7HyZLBig-1
Received: by mail-qt1-f198.google.com with SMTP id e17-20020ac85dd1000000b003ba2d72f98aso4282001qtx.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677087518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlZAfWTuJXkBs46DXI6mtkWkRzzW2ABpGzcojN9g6uo=;
        b=LJDnboA3r1IkhfeLka2TJ04T322nx23DpfYPDRJv5FN/u6V0nL6mrQeQKZvg3F06Wm
         NK3KXt05lDROiC4RzNErNyUIv8O9362tXDM+X6tknlfA16CXwp+VzlCbAFFC9Buv2B+4
         Uds11cjFaRRHb4H7UMTsbi40OcTU7Qhzxpo0MSww7k+v+xxDJ0YX6p9Uy7I04U53z0Fu
         RQXJcXQ+FWhXgAUah+7iycWSA0tGuSTStAp5SKitiPdhNc07BKuoC/zol28kZZY+zSr7
         c8f0SwplSr8oKxtRAmAKH7VFGFWuLnpAG4d71XiEcj1mLOqABodeuzzb3PbCA+RgWa6w
         ogRQ==
X-Gm-Message-State: AO0yUKVEm4c/eJHaaKsx4k+iC2FTnmdKhQMkw7ARlSvzlkUibFGw8eba
        gXCVbyGH+rHYRRajcTzN5i3hxl/AX1X/vPgXnRCgw8I1Nw91VBEJWAcZlr22I0CR1Cxh6oRC7gO
        atRhqlyQJZMXs2xv8OX1NqL9M
X-Received: by 2002:ac8:58d6:0:b0:3bd:1647:160b with SMTP id u22-20020ac858d6000000b003bd1647160bmr19096802qta.2.1677087518245;
        Wed, 22 Feb 2023 09:38:38 -0800 (PST)
X-Google-Smtp-Source: AK7set8cvK6Lhac8CLf7MjNiS0kkrtU05xWHkW5wbZo6gEjGoD1r7QQMMDIClIyubuIcHlBBqiWx5w==
X-Received: by 2002:ac8:58d6:0:b0:3bd:1647:160b with SMTP id u22-20020ac858d6000000b003bd1647160bmr19096769qta.2.1677087517965;
        Wed, 22 Feb 2023 09:38:37 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id a184-20020a3798c1000000b007423caef02fsm700845qke.122.2023.02.22.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:38:37 -0800 (PST)
Date:   Wed, 22 Feb 2023 12:38:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        David Stevens <stevensd@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: alloc_charge_hpage() take care of mem
 charge errors
Message-ID: <Y/ZTHEACqwYUYGFP@x1n>
References: <20230221214344.609226-1-peterx@redhat.com>
 <Y/ZLjF9Xe1F6Mu76@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Vmaj7Dywv+8d4uMP"
Content-Disposition: inline
In-Reply-To: <Y/ZLjF9Xe1F6Mu76@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vmaj7Dywv+8d4uMP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Feb 22, 2023 at 12:06:20PM -0500, Johannes Weiner wrote:
> Hello,
> 
> On Tue, Feb 21, 2023 at 04:43:44PM -0500, Peter Xu wrote:
> > If memory charge failed, the caller shouldn't call mem_cgroup_uncharge().
> > Let alloc_charge_hpage() handle the error itself and clear hpage properly
> > if mem charge fails.
> 
> I'm a bit confused by this patch.
> 
> There isn't anything wrong with calling mem_cgroup_uncharge() on an
> uncharged page, functionally. It checks and bails out.

Indeed, I didn't really notice there's zero side effect of calling that,
sorry.  In that case both "Fixes" and "Cc: stable" do not apply.

> 
> It's an unnecessary call of course, but since it's an error path it's
> also not a cost issue, either.
> 
> I could see an argument for improving the code, but this is actually
> more code, and the caller still has the uncharge-and-put branch anyway
> for when the collapse fails later on.
> 
> So I'm not sure I understand the benefit of this change.

Yes, the benefit is having a clear interface for alloc_charge_hpage() with
no prone to leaking huge page.

The patch comes from a review for David's other patch here:

https://lore.kernel.org/all/Y%2FU9fBxVJdhxiZ1v@x1n/

I've attached a new version just to reword and remove the inproper tags.
Do you think that's acceptable?

Thanks,

-- 
Peter Xu

--Vmaj7Dywv+8d4uMP
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-khugepaged-alloc_charge_hpage-take-care-of-mem-ch.patch"

From 0595acbd688b60ff7b2821a073c0fe857a4ae0ee Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 21 Feb 2023 16:43:44 -0500
Subject: [PATCH] mm/khugepaged: alloc_charge_hpage() take care of mem charge
 errors

If memory charge failed, instead of returning the hpage but with an error,
allow the function to cleanup the folio properly, which is normally what a
function should do in this case - either return successfully, or return
with no side effect of partial runs with an indicated error.

This will also avoid the caller calling mem_cgroup_uncharge() unnecessarily
with either anon or shmem path (even if it's safe to do so).

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: David Stevens <stevensd@chromium.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/khugepaged.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8dbc39896811..941d1c7ea910 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1063,12 +1063,19 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE);
 	int node = hpage_collapse_find_target_node(cc);
+	struct folio *folio;
 
 	if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
-	if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
+
+	folio = page_folio(*hpage);
+	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
+		folio_put(folio);
+		*hpage = NULL;
 		return SCAN_CGROUP_CHARGE_FAIL;
+	}
 	count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
+
 	return SCAN_SUCCEED;
 }
 
-- 
2.39.1


--Vmaj7Dywv+8d4uMP--

