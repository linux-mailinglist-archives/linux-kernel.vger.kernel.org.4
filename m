Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4F6D5276
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjDCU07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjDCU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57440FB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680553458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12z27TE6VQBbAogAxz6FeUpqEHMEvWSC888OB+GlE4o=;
        b=Bd4DHy7x/Q+WsUNWf9nQNA3GUnRGmdcDS+4Wf51L6IS6Q2pwo+4x6ADxfT5iCoqyRCndoy
        QfNpP3qyEACa9w06j6x1JTSc38HmUlZYpiZi+9oKBHlXLZQRYw3TiS69F8eG+8b128bH2E
        Fcg0FeMCLiVjDRy9gpzfsABVfPQLvlw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-t0xRB48pOXaQQY8fBYXCkQ-1; Mon, 03 Apr 2023 16:24:15 -0400
X-MC-Unique: t0xRB48pOXaQQY8fBYXCkQ-1
Received: by mail-qt1-f199.google.com with SMTP id s23-20020a05622a1a9700b003e6578904c3so2072216qtc.17
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680553454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12z27TE6VQBbAogAxz6FeUpqEHMEvWSC888OB+GlE4o=;
        b=K8teuS+IiAGJV/K8GEi4MHeqzk2EVmeiOxrWbNdFICfkE9DRgnq2a8sHxP7BNWv1eH
         vE80TRpuFkfVjWOfc/UELafyXb5QhcYv0vUdeBTutNbsbm1eDMT/voEa7TVhiqHDP3Na
         0IbYPirCSB6rCQFrBszbtUTsdQNalaiRsRSWkXrzXi6TqvhM1evneb9LFFhySNnIVi+i
         vkOhFeoMttpf+wxX4csf3AP2zGAYKw6truwn6a1Z1rz+NWUr6JLz+A2oHMySbcF6I004
         JCKHfbqZfTDo3+gUxZw28/pb3yqpthX6O+T8JbIuv/IpA/P2CrX/OU+pwChVZYurDkT+
         S4yQ==
X-Gm-Message-State: AAQBX9fu3EYH/HAs6K9DlV2zp5Xho6Ufksq2dtKWNuOwv0Dp80nqL9TD
        6s1yqaGQROhq7CR7MxwfFIM6UJftx0+ibQLYv3uSy5ywQQ1obDfwIj3a7bDAbn3IvKSQjbxZ0aY
        0kBjmoDj8/U5S7qM96lwS7hdK
X-Received: by 2002:a05:622a:1aa1:b0:3e3:7e6b:50ce with SMTP id s33-20020a05622a1aa100b003e37e6b50cemr28352851qtc.4.1680553454572;
        Mon, 03 Apr 2023 13:24:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350aJ5GZwPuDVCerdCcEtBCco7NVgNWOm1iTIkPAelFtiIg65vx1ypOOl8OxWAinXF8cHOqEMBg==
X-Received: by 2002:a05:622a:1aa1:b0:3e3:7e6b:50ce with SMTP id s33-20020a05622a1aa100b003e37e6b50cemr28352811qtc.4.1680553454251;
        Mon, 03 Apr 2023 13:24:14 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r12-20020ac867cc000000b003e3910db4f1sm2766125qtp.35.2023.04.03.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:24:13 -0700 (PDT)
Date:   Mon, 3 Apr 2023 16:24:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/29] selftests/mm: UFFDIO_API test
Message-ID: <ZCs17E5frPyIoCOs@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160752.3107283-1-peterx@redhat.com>
 <fcf40deb-e731-c257-fb77-7fcfddf623b1@redhat.com>
 <ZCsCRRdnbeNgcSlq@x1n>
 <b282519e-d43d-026c-3f96-4d7fb287d96b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b282519e-d43d-026c-3f96-4d7fb287d96b@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 09:06:26PM +0200, David Hildenbrand wrote:
> On 03.04.23 18:43, Peter Xu wrote:
> > On Mon, Apr 03, 2023 at 09:59:50AM +0200, David Hildenbrand wrote:
> > > There is ksft_print_msg, ksft_test_result, ksft_test_result_fail, ... do we
> > > maybe want to convert properly to ksft while already at it?
> > 
> > Yes, I started with trying to use that but found that there're not a lot of
> > things that I can leverage.
> > 
> > Starting with ksft_set_plan() - I think this is something we call first. I
> > want the current unit test to skip everything if UFFD API test failed here,
> > then I need to feed in a dynamic number of "plan" into ksft_set_plan().
> > But I never know after I ran the 1st test..
> 
> In cow.c I did that. Getting the number of tests right can be challenging
> indeed.

IMHO the major thing is not about not easy to set, it's about there's
merely no benefit I can see of having that calculated at the start of a
test.

There's one thing it can do, that is when calling ksft_finished() it can be
used to know whether all tests are run, but sadly here we're calculating
everything just to make it match.. so it loses its last purpose.. IMHO.

> 
> Basic "feature availability" checks would go first (is uffd even around?),
> and depending on that you can set the plan.
> 
> For everything else, you can skip instead of test, so it will still be
> accounted towards the plan.
> 
> > 
> > I can call ksft_set_plan() later than this, but it misses a few tests which
> > also looks weird.
> 
> Yeah, it would be nice to simply make ksft_set_plan() optional. For example,
> make ksft_print_cnts() skip the comparison if ksft_plan == 0. At least
> ksft_exit_skip() handles that already in a descend way (below).
> 
> > 
> > It also seems to not really help anything at all and not obvious to use.
> > E.g. ksft_finished() will reference ksft_plan then it'll trigger
> > ksft_exit_fail() but here I want to make it SKIP if the 1st test failed
> > simply because the kernel probably doesn't have CONFIG_USERFAULTFD.
> 
> You'd simply do that availability check first and then use ksft_exit_skip()
> in case not available I guess.
> 
> > 
> > Another example: I never figured what does x{fail|pass|skip} meant in the
> > header..  e.g. ksft_inc_xfail_cnt() is used nowhere so I cannot reference
> > either.  Then I don't know when I should increase them.
> 
> In cow.c I have the following flow:
> 
> ksft_print_header();
> ksft_set_plan();
> ... tests ...
> err = ksft_get_fail_cnt();
> if (err)
> 	ksft_exit_fail_msg();
> return ksft_exit_pass();
> 
> That gives me:
> 
> # [INFO] detected THP size: 2048 KiB
> # [INFO] detected hugetlb size: 2048 KiB
> # [INFO] detected hugetlb size: 1048576 KiB
> # [INFO] huge zeropage is enabled
> TAP version 13
> 1..190
> ...
> # Totals: pass:87 fail:0 xfail:0 xpass:0 skip:103 error:0
> 
> 
> I didn't use xfail or xpass so far, but what I understood is that these are
> "expected failures" and "expected passes". fail/pass/skip are straight

Yes, xfail can be expressed that way, but maybe not xpass?  Otherwise it's
hard to identify what's the difference between xpass and pass, because IIUC
pass also means "expected to pass".

> forward.
> ksft_test_result_fail()/ksft_test_result_pass()/ksft_test_result_skip() are
> used to set them.
> 
> You'd do availability checks before ksft_set_plan() and fail with a
> ksft_exit_skip() if the kernel doesn't support it. Then, you'd just use
> ksft_test_result_fail()/ksft_test_result_pass()/ksft_test_result_skip().
> 
> > 
> > In short, to make the unit test behave as expected, I figured I'll just
> > write these few helpers and that's good enough for this unit test.  That
> > takes perhaps 5 min anyway and isn't hugely bad for an unit test.
> > 
> > Then I keep the exit code matching kselftests (KSFT_SKIP, etc.).
> > 
> > What I can do here, though, is at least reuse the counters, e.g:
> > 
> >   ksft_inc_pass_cnt() / ksft_inc_fail_cnt()
> > 
> > There's no ksft_inc_skip_cnt() so, maybe, I can just reuse
> > ksft_inc_xskip_cnt() assuming that counts "skip"s?
> > 
> > Let me know if you have better ideas, I'll be happy to switch in that case.
> 
> I guess once you start manually increasing/decreasing the cnt, you might be
> abusing the ksft framework indeed and are better off handling it differently
> :D

I'm serious considering that to address your comment here, to show that I'm
trying my best to use whatever can help in this test case. :) Here reusing
it would avoid a few bytes in the bss, which is still beneficial so I can
do.  At least I'm sure xskip is for skipping now, so I know what to use.

PS: one other reason I didn't use the header is also because I prefer the
current output of uffd-self-tests.c.  I didn't say anything because I think
it's stingy..  So let's keep this in a trivial small PS.  After all, the
print format is half of what the header provides functional-wise.

I'll see what I can come up with at last in the next version, thanks David.

-- 
Peter Xu

