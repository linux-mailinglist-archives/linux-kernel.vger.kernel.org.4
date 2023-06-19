Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1F734D86
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFSIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjFSIXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:23:46 -0400
Received: from out-42.mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB79E6E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:23:43 -0700 (PDT)
Date:   Mon, 19 Jun 2023 17:23:30 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687163019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1f+pZURW+w1RCPnnZXu1sVV0QTjxA8H8mKJ4xL39JA=;
        b=CFy7fZtOVlnjuX11edB8SC+1mfUuiV37ttTYe0TfaE5rdfh09ywb23mSOR1z+lfR/cdZ8N
        7oirQpd7N8PwmNxLTYrEuo4Xlps07Mi7eoLn3bDwrCJsjLzeAJwZGGffwmso6bZ+u4Srhs
        zQ64v4AHL/TbjQ/4JsjRHlG1oX93mhk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230619082330.GA1612447@ik1-406-35019.vs.sakura.ne.jp>
References: <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey>
 <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
 <20230617225927.GA3540@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230617225927.GA3540@monkey>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 03:59:27PM -0700, Mike Kravetz wrote:
> On 06/16/23 19:18, Jiaqi Yan wrote:
> > On Fri, Jun 16, 2023 at 4:35 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > On 06/16/23 14:19, Jiaqi Yan wrote:
> > > >
> > > > Now looking again this, I think concurrent adding and deleting are
> > > > fine with each other and with themselves, because raw_hwp_list is
> > > > lock-less llist.
> > >
> > > Correct.
> > >
> > > > As for synchronizing traversal with adding and deleting, I wonder is
> > > > it a good idea to make __update_and_free_hugetlb_folio hold
> > > > hugetlb_lock before it folio_clear_hugetlb_hwpoison(which traverse +
> > > > delete raw_hwp_list)? In hugetlb, get_huge_page_for_hwpoison already
> > > > takes hugetlb_lock; it seems to me __update_and_free_hugetlb_folio is
> > > > missing the lock.
> > >
> > > I do not think the lock is needed.  However, while looking more closely
> > > at this I think I discovered another issue.
> > > This is VERY subtle.
> > > Perhaps Naoya can help verify if my reasoning below is correct.
> > >
> > > In __update_and_free_hugetlb_folio we are not operating on a hugetlb page.
> > > Why is this?
> > > Before calling update_and_free_hugetlb_folio we call remove_hugetlb_folio.
> > > The purpose of remove_hugetlb_folio is to remove the huge page from the
> > > list AND compound page destructor indicating this is a hugetlb page is changed.
> > > This is all done while holding the hugetlb lock.  So, the test for
> > > folio_test_hugetlb(folio) is false.
> > >
> > > We have technically a compound non-hugetlb page with a non-null raw_hwp_list.
> > >
> > > Important note: at this time we have not reallocated vmemmap pages if
> > > hugetlb page was vmemmap optimized.  That is done later in
> > > __update_and_free_hugetlb_folio.
> > 
> > 
> > >
> > > The 'good news' is that after this point get_huge_page_for_hwpoison will
> > > not recognize this as a hugetlb page, so nothing will be added to the
> > > list.  There is no need to worry about entries being added to the list
> > > during traversal.
> > >
> > > The 'bad news' is that if we get a memory error at this time we will
> > > treat it as a memory error on a regular compound page.  So,
> > > TestSetPageHWPoison(p) in memory_failure() may try to write a read only
> > > struct page. :(
> > 
> > At least I think this is an issue.
> > 
> > Would it help if dissolve_free_huge_page doesn't unlock hugetlb_lock
> > until update_and_free_hugetlb_folio is done, or basically until
> > dissolve_free_huge_page is done?
> 
> Unfortunately, update_and_free_hugetlb_folio is designed to be called
> without locks held.  This is because we can not hold any locks while
> allocating vmemmap pages.
> 
> I'll try to think of some way to restructure the code.  IIUC, this is a
> potential general issue, not just isolated to memory error handling.

Considering this issue as one specific to memory error handling, checking
HPG_vmemmap_optimized in __get_huge_page_for_hwpoison() might be helpful to
detect the race.  Then, an idea like the below diff (not tested) can make
try_memory_failure_hugetlb() retry (with retaking hugetlb_lock) to wait
for complete the allocation of vmemmap pages.

@@ -1938,8 +1938,11 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
        int ret = 2;    /* fallback to normal page handling */
        bool count_increased = false;

-       if (!folio_test_hugetlb(folio))
+       if (!folio_test_hugetlb(folio)) {
+               if (folio_test_hugetlb_vmemmap_optimized(folio))
+                       ret = -EBUSY;
                goto out;
+       }

        if (flags & MF_COUNT_INCREASED) {
                ret = 1;


Thanks,
Naoya Horiguchi

> -- 
> Mike Kravetz
> 
> > 
> > TestSetPageHWPoison in memory_failure is called after
> > try_memory_failure_hugetlb, and folio_test_hugetlb is tested within
> > __get_huge_page_for_hwpoison, which is wrapped by the hugetlb_lock. So
> > by the time dissolve_free_huge_page returns, subpages already go
> > through hugetlb_vmemmap_restore and __destroy_compound_gigantic_folio
> > and become non-compound raw pages (folios). Now
> > folio_test_hugetlb(p)=false will be correct for memory_failure, and it
> > can recover p as a dissolved non-hugetlb page.
