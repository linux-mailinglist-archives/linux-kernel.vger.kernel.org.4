Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176996D4D44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjDCQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjDCQLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FF410C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680538263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRUf4mF4hTo23LsJoejT2omq992QGUjosmoknsLXmlQ=;
        b=D8o0Gh4Q2j7omR+kasRSAWILi4fTcGFig3owfLcgj/22EOG2FR3+08VxnnIK/GkiOe5voB
        KoK5wpPL2Ly54++CnIj22yuup0xSaiIXTpCWk3BQ9Wk2N8OU5S0rP8P/hPji5S8ksDxy67
        NOUR5FxIDKO+B5DcUZWJ3sbiXSCOPLA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-swGqHhzBMn-snQ31xjKNYw-1; Mon, 03 Apr 2023 12:10:46 -0400
X-MC-Unique: swGqHhzBMn-snQ31xjKNYw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e2daffa0d4so9290101cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRUf4mF4hTo23LsJoejT2omq992QGUjosmoknsLXmlQ=;
        b=i88PbexqO9iPjvhQ6siqxfwyerBvkRrlraU86wCvn5xt9//BqJ0EpLJt9PrOQ6pR9A
         H1+cWVjKWKWXQWE6pbNw2xOWlusENrcNgYXIJAH8ABtmQL0Af9G497XhThdIxsYZJ70f
         1qM84UmIY8XreHIKlP1B/4erZhy5k+wZI1eFjUCOumP55c0s9MQVfJEA+pMua8dI+cN8
         E1Gg33NyU29NXUbUG7fXWwom7A+41rwX7LLje9Kphvuw2ZvCyr9IbLeeqMi+wnIGkUtk
         /kBLowRdOQs4Ni4Bzuh4cvuNGnj9enmihwkTkGsboYN3+UgbbucZrkQEgp7Xr27+PrOn
         LO9Q==
X-Gm-Message-State: AAQBX9cEx9yhALEjGWipaX0SgPg5bJOuwl78zWqmNBtgj863ODZTnM2v
        Nx/JCoBkFdl7s7MmwjbLVUBfC0bp9le22M5IisGNUqP4+sgykq5UeU//jDf08MKsFWWS/Rytsd4
        PEJAPDYHEV0ePodPd7GS3KDxt
X-Received: by 2002:a05:622a:1802:b0:3e2:4280:bc58 with SMTP id t2-20020a05622a180200b003e24280bc58mr25368989qtc.3.1680538246205;
        Mon, 03 Apr 2023 09:10:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZrAEJ2CRWprD2fD+HlTJnehDWaAzKnA4S0xNyGtrumwgreRZFynUIy7Ewy6y8KrmqQFx/cYA==
X-Received: by 2002:a05:622a:1802:b0:3e2:4280:bc58 with SMTP id t2-20020a05622a180200b003e24280bc58mr25368944qtc.3.1680538245759;
        Mon, 03 Apr 2023 09:10:45 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id v4-20020ac873c4000000b003e29583cf22sm2588994qtp.91.2023.04.03.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:10:44 -0700 (PDT)
Date:   Mon, 3 Apr 2023 12:10:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 10/29] selftests/mm: Test UFFDIO_ZEROPAGE only when
 !hugetlb
Message-ID: <ZCr6g3RDwt1pWTkx@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160714.3106999-1-peterx@redhat.com>
 <20230331183726.GD12460@monkey>
 <CAJHvVcjOqShPeu3mYk2Xu1ZyMfFLuPCUp8+8nQ+CUyCj4nZVqA@mail.gmail.com>
 <cfc0d7c8-edb5-ae5d-8edf-d4f7ee18b877@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/4lLZ6sttUXyfTXJ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfc0d7c8-edb5-ae5d-8edf-d4f7ee18b877@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/4lLZ6sttUXyfTXJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 03, 2023 at 09:55:41AM +0200, David Hildenbrand wrote:
> On 01.04.23 03:57, Axel Rasmussen wrote:
> > On Fri, Mar 31, 2023 at 11:37 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > 
> > > On 03/30/23 12:07, Peter Xu wrote:
> > > > Make the check as simple as "test_type == TEST_HUGETLB" because that's the
> > > > only mem that doesn't support ZEROPAGE.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >   tools/testing/selftests/mm/userfaultfd.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
> > > > index 795fbc4d84f8..d724f1c78847 100644
> > > > --- a/tools/testing/selftests/mm/userfaultfd.c
> > > > +++ b/tools/testing/selftests/mm/userfaultfd.c
> > > > @@ -1118,7 +1118,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
> > > >   {
> > > >        struct uffdio_zeropage uffdio_zeropage;
> > > >        int ret;
> > > > -     bool has_zeropage = get_expected_ioctls(0) & (1 << _UFFDIO_ZEROPAGE);
> > > > +     bool has_zeropage = !(test_type == TEST_HUGETLB);
> > > 
> > > It is true that hugetlb is the only mem type that does not support zeropage.
> > > So, the change is correct.
> > > 
> > > However, I actually prefer the explicit check that is there today.  It seems
> > > more like a test of the API.  And, is more future proof is code changes.
> > > 
> > > Just my opinion/thoughts, not a strong objection.
> > 
> > I agree. The existing code is more robust to future changes where we
> > might support or stop supporting this ioctl in some cases. It also
> > proves that the ioctl works, any time the API reports that it is
> > supported / ought to work, independent of when the *test* thinks it
> > should be supported.
> > 
> > Then again, I think this is unlikely to change in the future, so I
> > also agree with Mike that it's not the biggest deal.
> 
> As there were already discussions on eventually supporting UFFDIO_ZEROPAGE
> that doesn't place the shared zeropage but ... a fresh zeropage, it might
> make sense to keep it as is.

Thanks everyone.

So here the major goal is to drop get_expected_ioctls(), and I think it's
really unwanted here.  Besides it's a blocker for split the test in a clean
way, a major reason is get_expected_ioctls() fetches "wheter we support
zeropage for this mem" from UFFD_API_RANGE_IOCTLS, rather than from the
UFFDIO_REGISTER anyway:

uint64_t get_expected_ioctls(uint64_t mode)
{
       uint64_t ioctls = UFFD_API_RANGE_IOCTLS;

       if (test_type == TEST_HUGETLB)
               ioctls &= ~(1 << _UFFDIO_ZEROPAGE);

       if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
               ioctls &= ~(1 << _UFFDIO_WRITEPROTECT);

       if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
               ioctls &= ~(1 << _UFFDIO_CONTINUE);

       return ioctls;
}

It means it'll succeed or fail depending on what kernel we run this test
on, and also on what headers we compile the test against.

I actually mentioned some of the reasoning in a follow up patch (sorry
maybe the split here caused some confusion):

    selftests/mm: uffd_[un]register()
    
    Add two helpers to register/unregister to an uffd.  Use them to drop
    duplicate codes.
    
    This patch also drops assert_expected_ioctls_present() and
    get_expected_ioctls().  Reasons:
    
      - It'll need a lot of effort to pass test_type==HUGETLB into it from the
      upper, so it's the simplest way to get rid of another global var
    
      - The ioctls returned in UFFDIO_REGISTER is hardly useful at all, because
      any app can already detect kernel support on any ioctl via its
      corresponding UFFD_FEATURE_*.  The check here is for sanity mostly but
      it's probably destined no user app will even use it.
    
      - It's not friendly to one future goal of uffd to run on old kernels, the
      problem is get_expected_ioctls() compiles against UFFD_API_RANGE_IOCTLS,
      which is a value that can change depending on where the test is compiled,
      rather than reflecting what the kernel underneath has.  It means it'll
      report false negatives on old kernels so it's against our will.
    
    So let's make our live easier.

But I do agree that it's helpful to keep a test against
uffdio_register.ioctls in this case against _UFFDIO_ZEROPAGE, so it can be
detected dynamically.  IOW, even if we would like to avoid "test !=
HUGETLB" here, at least we should like to fix that with the UFFDIO_REGISTER
results.

Here's my offer below. :)

Could I keep this patch as-is (as part of getting rid of
get_expected_ioctls() effort; I can squash this one into "selftests/mm:
uffd_[un]register()" if any of you think proper), meanwhile I'll squash a
fixup to the "move zeropage test into uffd-unit-tests" explicitly check
uffdio_register.ioctls in the same patchset?  IOW, we'll have a few test
commits missing this specific ioctl test, but then we'll have a better one
dynamically detected from the kernel.

The fixup patch attached.  I think it'll automatically work when someone
would like to introduce UFFDIO_ZEROPAGE to hugetlb too, another side
benefit is I merged the zeropage test into one, which does look better too.

Thanks,

-- 
Peter Xu

--/4lLZ6sttUXyfTXJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-selftests-mm-Move-zeropage-test-into-uffd-unit.patch"

From 5b06f921cf8420600c697a3072a1459a5cb4956b Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 3 Apr 2023 11:57:07 -0400
Subject: [PATCH] fixup! selftests/mm: Move zeropage test into uffd unit tests

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 62 +++++++++++---------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 793931da5056..247700bb4dd0 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -711,54 +711,58 @@ static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
 	return false;
 }
 
+/*
+ * Registers a range with MISSING mode only for zeropage test.  Return true
+ * if UFFDIO_ZEROPAGE supported, false otherwise. Can't use uffd_register()
+ * because we want to detect .ioctls along the way.
+ */
+static bool
+uffd_register_detect_zp(int uffd, void *addr, uint64_t len)
+{
+	struct uffdio_register uffdio_register = { 0 };
+	uint64_t mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	uffdio_register.range.start = (unsigned long)addr;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = mode;
+
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
+		err("zeropage test register fail");
+
+	return uffdio_register.ioctls & (1 << _UFFDIO_ZEROPAGE);
+}
+
+
 /* exercise UFFDIO_ZEROPAGE */
-static void uffd_zeropage_test_common(bool has_zeropage)
+static void uffd_zeropage_test(void)
 {
-	if (uffd_register(uffd, area_dst, page_size,
-			  true, false, false))
-		err("register");
+	bool has_zeropage;
+	int i;
 
+	has_zeropage = uffd_register_detect_zp(uffd, area_dst, page_size);
 	if (area_dst_alias)
-		if (uffd_register(uffd, area_dst_alias, page_size,
-				  true, false, false))
-			err("register");
-
-	if (do_uffdio_zeropage(uffd, has_zeropage)) {
-		int i;
+		/* Ignore the retval; we already have it */
+		uffd_register_detect_zp(uffd, area_dst_alias, page_size);
 
+	if (do_uffdio_zeropage(uffd, has_zeropage))
 		for (i = 0; i < page_size; i++)
 			if (area_dst[i] != 0)
 				err("data non-zero at offset %d\n", i);
-	}
 
+	if (uffd_unregister(uffd, area_dst, page_size))
+		err("unregister");
 
-	if (uffd_unregister(uffd, area_dst, page_size * nr_pages))
+	if (area_dst_alias && uffd_unregister(uffd, area_dst_alias, page_size))
 		err("unregister");
 
 	uffd_test_pass();
 }
 
-static void uffd_zeropage_test(void)
-{
-	uffd_zeropage_test_common(true);
-}
-
-static void uffd_zeropage_hugetlb_test(void)
-{
-	uffd_zeropage_test_common(false);
-}
-
 uffd_test_case_t uffd_tests[] = {
 	{
 		.name = "zeropage",
 		.uffd_fn = uffd_zeropage_test,
-		.mem_targets = MEM_ANON | MEM_SHMEM | MEM_SHMEM_PRIVATE,
-		.uffd_feature_required = 0,
-	},
-	{
-		.name = "zeropage-hugetlb",
-		.uffd_fn = uffd_zeropage_hugetlb_test,
-		.mem_targets = MEM_HUGETLB | MEM_HUGETLB_PRIVATE,
+		.mem_targets = MEM_ALL,
 		.uffd_feature_required = 0,
 	},
 	{
-- 
2.39.1


--/4lLZ6sttUXyfTXJ--

