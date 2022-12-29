Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA8658FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiL2RcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiL2Rb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:31:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FC815813
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O6Ikrs1CIxHfi8Ue6kwk76aDhiVwW97NYJ5AhQiikWY=; b=fZJ91ZHH4wjOdmJFKpknmM2JjI
        ls0n0/1hxa4PVs+RaxBEjxjrk4pI42FWPiAnjtNaKauJuvjhv3Xa7M+buiGTIYLkoF9QItIdP+N3R
        +Qqb3MWEu6NwN5QK8kLvrU0VRZd+T4/Yzu5S1NaHPEYCmplvs7+Vc4wuiLTGrtmTJy5SXLINYPOBt
        muE8v74cPqxViZwA0t/J9AL3MJk11Kqp06oNSbfHirv8WqJKupT2QEZ6SSx7hFJuEm825pwiZKVtF
        rnzyceNMthtUK9ir1LVYqnvCak6NLRNGKOLk5tRutpVoWpmWsvprSRQoFafG66UwygxMa/CBlq8Ny
        h/Wo9xSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAwkN-00A11E-Ng; Thu, 29 Dec 2022 17:31:15 +0000
Date:   Thu, 29 Dec 2022 17:31:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        liam.howlett@oracle.com, surenb@google.com, ldufour@linux.ibm.com,
        michel@lespinasse.org, vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y63O4zYhhi3/zkF0@casper.infradead.org>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org>
 <Y63KBNzdOkf3qmBX@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y63KBNzdOkf3qmBX@murray>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 05:10:28PM +0000, Lorenzo Stoakes wrote:
> On Thu, Dec 29, 2022 at 04:51:37PM +0000, Matthew Wilcox wrote:
> > The mmap_lock is taken for many, many things.  [snip]
> 
> I am currently describing the use of this lock (for 6.0) in the book and it is
> striking just how broadly it's used. I'm diagramming it out for 'core' users,
> i.e. non-driver and non-some other things, but even constraining that leaves a
> HUGE number of users.

I fear this would be overwhelming.  I don't think anybody would disagree
that the mmap_lock needs to be split up like the BKL was, but we didn't
do that by diagramming it out.  Instead, we introduced new smaller locks
that protected much better-defined things until eventually we were able
to kill the BKL entirely.

That's what I'm trying to do here -- there is one well-defined thing
that the maple tree lock will protect, and that's the structure of the
maple tree.  It doesn't protect the data pointed to by the pointers
stored in the tree, just the maple tree itself.

> I've also documented the 'unexpected' uses of the
> page_table_lock, which seems to have been significantly improved over time but
> still a few cases remain!

Now, I think this is useful.  There's probably few enough abuses of the
PTL that my brain can wrap itself around which ones are legitimate and
then deal with the inappropriate ones.

> Am happy to give you (+ anybody else on MAINTAINERS list) an early copy of the
> relevant bit (once I've finished the diagrams anyway) if that'd be helpful!

I'm definitely interested in the PTL.  Thank you for the offer!

> Now if you guys could stop obsoleting my work that'd be great ;)

Never!  How else will you get interest in the Second Edition Covering
Linux 7.0?  ;-)
