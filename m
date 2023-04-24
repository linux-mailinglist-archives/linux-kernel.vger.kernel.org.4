Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C3B6DAB09
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjDGJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:42:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FFF469B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:42:43 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377cQKX021429;
        Fri, 7 Apr 2023 09:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=qQyhNJNdHFXjk30Z2Yy0V7Voo81BtWkh809AYuBFthk=;
 b=jp+hLqpGwvaIg5fjfaWo0Eo+oAvWMEbjv/KRhUxwdrvAPQaDlUZkk169x0SZSy9LuzwQ
 XaT1hm6+vX2jwYctEbS5TNU/Amc9Y2Ob7lAawybVNK2kQ2XBHUWpctNjSyEC5/c48jtk
 pTKWSwrQk9XSq8Ddg73NE2ilVThqUPTCUpMza3pPox1KIT/3/tGjllgPUja267YXVKXR
 X+xDLfJN2JnCqwMF2RBfQTpbWxSrPyU8aRCaWQXXPKxxieHDAAXZy23/oryjHK5UEzcY
 P7xlBswF7NH8jg/Un0thCTGzT9MaVaOaOVaAURDZPEpWbYRYnXULoXX77f1FcL6g5LM7 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt9bb0drk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:42:37 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3379ga8q004752;
        Fri, 7 Apr 2023 09:42:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt9bb0dqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:42:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336JjpJm026329;
        Fri, 7 Apr 2023 09:42:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc874vq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:42:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379gWQ744040558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:42:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B47E2004B;
        Fri,  7 Apr 2023 09:42:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F15C120043;
        Fri,  7 Apr 2023 09:42:30 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:42:30 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:42:29 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 10/29] selftests/mm: Test UFFDIO_ZEROPAGE only when
 !hugetlb
Message-ID: <ZC/lhZlcDaDCErsz@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160714.3106999-1-peterx@redhat.com>
 <20230331183726.GD12460@monkey>
 <CAJHvVcjOqShPeu3mYk2Xu1ZyMfFLuPCUp8+8nQ+CUyCj4nZVqA@mail.gmail.com>
 <cfc0d7c8-edb5-ae5d-8edf-d4f7ee18b877@redhat.com>
 <ZCr6g3RDwt1pWTkx@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCr6g3RDwt1pWTkx@x1n>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BCe5lz7u0fyPfJFkX7eMe75r4mOsQX7C
X-Proofpoint-ORIG-GUID: JnxH7-LKgQJS7qckHiZO_RSmFi6K-Wma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_04,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 12:10:43PM -0400, Peter Xu wrote:
> On Mon, Apr 03, 2023 at 09:55:41AM +0200, David Hildenbrand wrote:
> > On 01.04.23 03:57, Axel Rasmussen wrote:
> > > On Fri, Mar 31, 2023 at 11:37 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > 
> > > > On 03/30/23 12:07, Peter Xu wrote:
> > > > > Make the check as simple as "test_type == TEST_HUGETLB" because that's the
> > > > > only mem that doesn't support ZEROPAGE.
> > > > > 
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >   tools/testing/selftests/mm/userfaultfd.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
> > > > > index 795fbc4d84f8..d724f1c78847 100644
> > > > > --- a/tools/testing/selftests/mm/userfaultfd.c
> > > > > +++ b/tools/testing/selftests/mm/userfaultfd.c
> > > > > @@ -1118,7 +1118,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
> > > > >   {
> > > > >        struct uffdio_zeropage uffdio_zeropage;
> > > > >        int ret;
> > > > > -     bool has_zeropage = get_expected_ioctls(0) & (1 << _UFFDIO_ZEROPAGE);
> > > > > +     bool has_zeropage = !(test_type == TEST_HUGETLB);
> > > > 
> > > > It is true that hugetlb is the only mem type that does not support zeropage.
> > > > So, the change is correct.
> > > > 
> > > > However, I actually prefer the explicit check that is there today.  It seems
> > > > more like a test of the API.  And, is more future proof is code changes.
> > > > 
> > > > Just my opinion/thoughts, not a strong objection.
> > > 
> > > I agree. The existing code is more robust to future changes where we
> > > might support or stop supporting this ioctl in some cases. It also
> > > proves that the ioctl works, any time the API reports that it is
> > > supported / ought to work, independent of when the *test* thinks it
> > > should be supported.
> > > 
> > > Then again, I think this is unlikely to change in the future, so I
> > > also agree with Mike that it's not the biggest deal.
> > 
> > As there were already discussions on eventually supporting UFFDIO_ZEROPAGE
> > that doesn't place the shared zeropage but ... a fresh zeropage, it might
> > make sense to keep it as is.
> 
> Thanks everyone.
> 
> So here the major goal is to drop get_expected_ioctls(), and I think it's
> really unwanted here.  Besides it's a blocker for split the test in a clean
> way, a major reason is get_expected_ioctls() fetches "wheter we support
> zeropage for this mem" from UFFD_API_RANGE_IOCTLS, rather than from the
> UFFDIO_REGISTER anyway:
> 
> uint64_t get_expected_ioctls(uint64_t mode)
> {
>        uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
> 
>        if (test_type == TEST_HUGETLB)
>                ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
> 
>        if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
>                ioctls &= ~(1 << _UFFDIO_WRITEPROTECT);
> 
>        if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
>                ioctls &= ~(1 << _UFFDIO_CONTINUE);
> 
>        return ioctls;
> }
> 
> It means it'll succeed or fail depending on what kernel we run this test
> on, and also on what headers we compile the test against.
> 
> I actually mentioned some of the reasoning in a follow up patch (sorry
> maybe the split here caused some confusion):
> 
>     selftests/mm: uffd_[un]register()
>     
>     Add two helpers to register/unregister to an uffd.  Use them to drop
>     duplicate codes.
>     
>     This patch also drops assert_expected_ioctls_present() and
>     get_expected_ioctls().  Reasons:
>     
>       - It'll need a lot of effort to pass test_type==HUGETLB into it from the
>       upper, so it's the simplest way to get rid of another global var
>     
>       - The ioctls returned in UFFDIO_REGISTER is hardly useful at all, because
>       any app can already detect kernel support on any ioctl via its
>       corresponding UFFD_FEATURE_*.  The check here is for sanity mostly but
>       it's probably destined no user app will even use it.
>     
>       - It's not friendly to one future goal of uffd to run on old kernels, the
>       problem is get_expected_ioctls() compiles against UFFD_API_RANGE_IOCTLS,
>       which is a value that can change depending on where the test is compiled,
>       rather than reflecting what the kernel underneath has.  It means it'll
>       report false negatives on old kernels so it's against our will.
>     
>     So let's make our live easier.
> 
> But I do agree that it's helpful to keep a test against
> uffdio_register.ioctls in this case against _UFFDIO_ZEROPAGE, so it can be
> detected dynamically.  IOW, even if we would like to avoid "test !=
> HUGETLB" here, at least we should like to fix that with the UFFDIO_REGISTER
> results.
> 
> Here's my offer below. :)
> 
> Could I keep this patch as-is (as part of getting rid of
> get_expected_ioctls() effort; I can squash this one into "selftests/mm:
> uffd_[un]register()" if any of you think proper), meanwhile I'll squash a
> fixup to the "move zeropage test into uffd-unit-tests" explicitly check
> uffdio_register.ioctls in the same patchset?  IOW, we'll have a few test
> commits missing this specific ioctl test, but then we'll have a better one
> dynamically detected from the kernel.
> 
> The fixup patch attached.  I think it'll automatically work when someone
> would like to introduce UFFDIO_ZEROPAGE to hugetlb too, another side
> benefit is I merged the zeropage test into one, which does look better too.

I agree that it makes sense. A nit below :)
 
> Thanks,
> 
> -- 
> Peter Xu

> From 5b06f921cf8420600c697a3072a1459a5cb4956b Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 3 Apr 2023 11:57:07 -0400
> Subject: [PATCH] fixup! selftests/mm: Move zeropage test into uffd unit tests
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 62 +++++++++++---------
>  1 file changed, 33 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 793931da5056..247700bb4dd0 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -711,54 +711,58 @@ static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
>  	return false;
>  }
> 
> +/*
> + * Registers a range with MISSING mode only for zeropage test.  Return true
> + * if UFFDIO_ZEROPAGE supported, false otherwise. Can't use uffd_register()
> + * because we want to detect .ioctls along the way.
> + */
> +static bool
> +uffd_register_detect_zp(int uffd, void *addr, uint64_t len)

Let's spell out 'zp' as zeropage, what do you say?

> +{
> +	struct uffdio_register uffdio_register = { 0 };
> +	uint64_t mode = UFFDIO_REGISTER_MODE_MISSING;
> +
> +	uffdio_register.range.start = (unsigned long)addr;
> +	uffdio_register.range.len = len;
> +	uffdio_register.mode = mode;
> +
> +	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
> +		err("zeropage test register fail");
> +
> +	return uffdio_register.ioctls & (1 << _UFFDIO_ZEROPAGE);
> +}
> +
> +
>  /* exercise UFFDIO_ZEROPAGE */
> -static void uffd_zeropage_test_common(bool has_zeropage)
> +static void uffd_zeropage_test(void)
>  {
> -	if (uffd_register(uffd, area_dst, page_size,
> -			  true, false, false))
> -		err("register");
> +	bool has_zeropage;
> +	int i;
> 
> +	has_zeropage = uffd_register_detect_zp(uffd, area_dst, page_size);
>  	if (area_dst_alias)
> -		if (uffd_register(uffd, area_dst_alias, page_size,
> -				  true, false, false))
> -			err("register");
> -
> -	if (do_uffdio_zeropage(uffd, has_zeropage)) {
> -		int i;
> +		/* Ignore the retval; we already have it */
> +		uffd_register_detect_zp(uffd, area_dst_alias, page_size);
> 
> +	if (do_uffdio_zeropage(uffd, has_zeropage))
>  		for (i = 0; i < page_size; i++)
>  			if (area_dst[i] != 0)
>  				err("data non-zero at offset %d\n", i);
> -	}
> 
> +	if (uffd_unregister(uffd, area_dst, page_size))
> +		err("unregister");
> 
> -	if (uffd_unregister(uffd, area_dst, page_size * nr_pages))
> +	if (area_dst_alias && uffd_unregister(uffd, area_dst_alias, page_size))
>  		err("unregister");
> 
>  	uffd_test_pass();
>  }
> 
> -static void uffd_zeropage_test(void)
> -{
> -	uffd_zeropage_test_common(true);
> -}
> -
> -static void uffd_zeropage_hugetlb_test(void)
> -{
> -	uffd_zeropage_test_common(false);
> -}
> -
>  uffd_test_case_t uffd_tests[] = {
>  	{
>  		.name = "zeropage",
>  		.uffd_fn = uffd_zeropage_test,
> -		.mem_targets = MEM_ANON | MEM_SHMEM | MEM_SHMEM_PRIVATE,
> -		.uffd_feature_required = 0,
> -	},
> -	{
> -		.name = "zeropage-hugetlb",
> -		.uffd_fn = uffd_zeropage_hugetlb_test,
> -		.mem_targets = MEM_HUGETLB | MEM_HUGETLB_PRIVATE,
> +		.mem_targets = MEM_ALL,
>  		.uffd_feature_required = 0,
>  	},
>  	{
> -- 
> 2.39.1
> 


-- 
Sincerely yours,
Mike.
