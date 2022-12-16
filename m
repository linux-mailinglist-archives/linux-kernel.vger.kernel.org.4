Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA864F4B9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiLPXKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLPXJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3606F0C4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:09:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F2C8B81DA5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 23:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96989C433D2;
        Fri, 16 Dec 2022 23:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671232152;
        bh=y3Y1ARip08drTXfIeo2kOoxaCl3cE/sJu7Coe2bVKec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RMCI3gRqtUCRSLqE1s9cOrcrcFNQeJxUINER1fOh4TZrDedqk/C5yE7uGW9VmpXeS
         3n1KkJsKazMvmhlp0C/QIvB6kWKXl4saqYo5wbd0WJOENEThDKoa3V9Mffs2eoqcp0
         yFt2aqiKGrpI1HncfJIOVjTTtyth5xxluXqfbZRI=
Date:   Fri, 16 Dec 2022 15:09:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <willy@infradead.org>
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Message-Id: <20221216150911.a99fe2079a6ba5c880989449@linux-foundation.org>
In-Reply-To: <963ba9b4-6ddf-39bc-85cf-2feef542029d@nvidia.com>
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
        <20221216142733.e2a716a4cd7ea55240d98391@linux-foundation.org>
        <963ba9b4-6ddf-39bc-85cf-2feef542029d@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 14:56:47 -0800 John Hubbard <jhubbard@nvidia.com> wrote:

> On 12/16/22 14:27, Andrew Morton wrote:
> > On Tue, 13 Dec 2022 13:20:53 -0800 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> > 
> >> folio_set_compound_order() is moved to an mm-internal location so external
> >> folio users cannot misuse this function. Change the name of the function
> >> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
> >> handle the case if a non-large folio is passed and add clarifying comments
> >> to the function.
> >>
> > 
> > This differs from the version I previously merged:
> > 
> > --- a/mm/internal.h~mm-move-folio_set_compound_order-to-mm-internalh-update
> > +++ a/mm/internal.h
> > @@ -384,8 +384,10 @@ int split_free_page(struct page *free_pa
> >    */
> >   static inline void folio_set_order(struct folio *folio, unsigned int order)
> >   {
> > -	if (WARN_ON_ONCE(!folio_test_large(folio)))
> > +	if (!folio_test_large(folio)) {
> > +		WARN_ON_ONCE(order);
> >   		return;
> > +	}
> 
> I think that's out of date?

Yes thanks, I'm looking at patches in the wrong order.  I'll drop the
above delta.

