Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6119164D633
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLOFcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 00:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLOFcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 00:32:15 -0500
Received: from out-141.mta0.migadu.com (out-141.mta0.migadu.com [IPv6:2001:41d0:1004:224b::8d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811B2A958
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 21:32:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671082320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjbPhz8ewubibdERpfEGMrVXZxEqEE0Jc+V7K14QaLQ=;
        b=WBWxdfAX4rclU2dt3iRBCB04Buz5Q3psnYuCHy9Wr0GRiqnGG+Nj+sykniihuaqJkyFGnA
        D7RuAFud+IEha1codAQd42KZwav+bcPpmpIGJYCJg7BoplcEmc0ytrNX18Bfoy4AyKCGeg
        9Nzqvwsr38ZIog/H1nC+jf6OLotzq+I=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <cda1b5ca-a03e-e545-d206-30d74ed33a3d@oracle.com>
Date:   Thu, 15 Dec 2022 13:31:24 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E39CAB80-2745-498C-8CDF-A469430F0276@linux.dev>
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
 <0B650D64-1F64-4695-9365-CF695029C50C@linux.dev>
 <cda1b5ca-a03e-e545-d206-30d74ed33a3d@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 15, 2022, at 13:09, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>=20
> On 12/14/22 7:44 PM, Muchun Song wrote:
>>> On Dec 14, 2022, at 05:20, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>>>=20
>>> folio_set_compound_order() is moved to an mm-internal location so =
external
>>> folio users cannot misuse this function. Change the name of the =
function
>>> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. =
Also,
>>> handle the case if a non-large folio is passed and add clarifying =
comments
>>> to the function.
>>>=20
>>> Link: =
https://lore.kernel.org/lkml/20221207223731.32784-1-sidhartha.kumar@oracle=
.com/T/
>>> Fixes: 9fd330582b2f ("mm: add folio dtor and order setter =
functions")
>>>=20
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>> Suggested-by: John Hubbard <jhubbard@nvidia.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Hi Muchun,
>=20
> Does this review include the change from

Yes.

Thanks.

>=20
> + if (!folio_test_large(folio)) {
> + 	WARN_ON_ONCE(order);
> + 	return;
> + }
>=20
> to
>=20
> if (WARN_ON_ONCE(!folio_test_large(folio)))
> 	return;
>=20
> discussed in in this thread?
>=20
> Thanks,
> Sidhartha Kumar
>> Thanks.


