Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB29867B0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjAYLRq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Jan 2023 06:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAYLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:16:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F78697
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:16:23 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-187-rcURqmcMPseQZXBBvv05JA-1; Wed, 25 Jan 2023 11:16:21 +0000
X-MC-Unique: rcURqmcMPseQZXBBvv05JA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 25 Jan
 2023 11:16:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 25 Jan 2023 11:16:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>,
        Mina Almasry <almasrymina@google.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] arch: Enable function alignment for arm64
Thread-Topic: [PATCH v1] arch: Enable function alignment for arm64
Thread-Index: AQHZL+y0RRcMkmENukGyDrKLrCNKda6u+djA
Date:   Wed, 25 Jan 2023 11:16:19 +0000
Message-ID: <c663ba9da2c14c69a126f01774cf5973@AcuMS.aculab.com>
References: <20221208053649.540891-1-almasrymina@google.com>
 <20230124120913.GA26449@willie-the-truck>
In-Reply-To: <20230124120913.GA26449@willie-the-truck>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>
> Sent: 24 January 2023 12:09
> 
> On Wed, Dec 07, 2022 at 09:36:48PM -0800, Mina Almasry wrote:
> > We recently ran into a double-digit percentage hackbench regression
> > when backporting commit 12df140f0bdf ("mm,hugetlb: take hugetlb_lock
> > before decrementing h->resv_huge_pages") to an older kernel. This was
> > surprising since hackbench does use hugetlb pages at all and the
> > modified code is not invoked. After some debugging we found that the
> > regression can be fixed by back-porting commit d49a0626216b ("arch:
> > Introduce CONFIG_FUNCTION_ALIGNMENT") and enabling function alignment
> > for arm64. I suggest enabling it by default for arm64 if possible.
> >
...
> 
> This increases the size of .text for a defconfig build by ~2%, so I think it
> would be nice to have some real numbers for the performance uplift. Are you
> able to elaborate beyond "double-digit percentage hackbench regression"?
> 
> In general, however, I'm supportive of the patch (and it seems that x86
> does the same thing) so:

I bet it just changes the alignment of the code so that more
functions are using different cache lines.

All sorts of other random changes are likely to have a similar effect.

Cache-line aligning the start of a function probably reduces the
number of cache lines the functions needs - but that isn't guaranteed.
It also slightly reduces the delay on a cache miss - but they are so
slow it probably makes almost no difference.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

