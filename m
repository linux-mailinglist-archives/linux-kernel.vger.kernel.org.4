Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766F964C27B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiLNDAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiLNDAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:00:42 -0500
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DC13F7F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:00:40 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670986838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0RmDmYwpbIyE85XfYoMhQZGsS4z4RgrTyeIW41Vt/Y=;
        b=o/iSUFNFyCfQp4W4+GNKbDJJbAHyg0307cIwXvhUOsYnOU+DzurDKmS+my1sPCsuJWNMsT
        Uw++bFVXpt5y90UqNzmhiU2lyOielX9QLYDQHTJFNbJCJd0O88v/wZDALo6LfLL/SOqiv5
        N9Cpk2WmnWN1f/CqIVRdm1Qkh42n+IA=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <23fa4ffa-965a-da80-e8b5-73ae92dc5767@nvidia.com>
Date:   Wed, 14 Dec 2022 11:00:02 +0800
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, tsahu@linux.ibm.com,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00CBD2D1-EEDD-4171-94F4-8DCC0446F26E@linux.dev>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
 <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
 <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
 <20cc2088-b66e-28d1-a529-414e82146336@nvidia.com>
 <434a111c-7f1a-0018-6bd2-561cb382deea@oracle.com>
 <7d72778e-7305-18e9-edf4-ed55a98aa7e2@nvidia.com>
 <00222280-DBDD-49A3-92A5-05112359AE30@linux.dev>
 <f4909342-eaca-8c55-ad95-359ab7a5e6db@nvidia.com>
 <23fa4ffa-965a-da80-e8b5-73ae92dc5767@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 10, 2022, at 05:20, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> On 12/9/22 13:10, John Hubbard wrote:
>> On 12/9/22 06:27, Muchun Song wrote:
>>>  =46rom you advise, I think we can remove VM_BUG_ON and handle =
non-zero
>>> order page, something like:
>> Yes, and thanks for summarizing all the individual feedback into a
>> proposed solution.
>> If we go this route, then I'd suggest a little note above the =
function,
>> such as:
>> /*
>>  * For non-large folios, this will have no effect, other than =
possibly
>>  * generating a warning, if the caller attempts to set a non-zero =
folio order
>>  * for a non-large folio.
>>  */
>>> static inline void folio_set_order(struct folio *folio,
>>>                            unsigned int order)
>>> {
>>>     if (!folio_test_large(folio)) {
>>>         WARN_ON(order);
>=20
> Although, on second thought...I'm still a little confused about why
> keeping the same name is so important?

Just my personal preference. I like its simplicity. I'm not against
large_folio_set_order, but suggest folio_set_order.

Thanks.

>=20
> A very direct approach that has more accurate naming (and therefore no
> need for a strange comment explaining the behavior) would be:
>=20
>=20
> static inline void large_folio_set_order(struct folio *folio,
> unsigned int order)
> {
> 	if (WARN_ON_ONCE(!folio_test_large(folio)))
> 		return;
>=20
> 	folio->_folio_order =3D order;
> #ifdef CONFIG_64BIT
> 	folio->_folio_nr_pages =3D order ? 1U << order : 0;
> #endif
> }
>=20
>=20
> thanks,
> --=20
> John Hubbard
> NVIDIA

