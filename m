Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE07632EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKUVdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKUVd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:33:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF91C41E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:33:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB607CE186C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9486FC433C1;
        Mon, 21 Nov 2022 21:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669066401;
        bh=Dl1R9b0AHghTRfXyys1XgEZQ5J33PnAzaYPtOIHH+zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dwGiAgsGwInbdHDjuP9L+CDahcr5Nn6x2oKNpsogkF0A+fZ06kwUY+t2PFN53uC3n
         Y3dv4ajua98tlVlDTMUVDpA4w8xZ2vAclcKisv5Px1E/CctRrOTNBxxUybF55iYRjC
         8/kiCJOHBIRWIcp9tINmI7Gbyo02sYAX664KKRNA=
Date:   Mon, 21 Nov 2022 13:33:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Message-Id: <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
In-Reply-To: <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
References: <20221031152524.173644-1-david@redhat.com>
        <Y1/0e12ZJT6+N0kI@nvidia.com>
        <Y2BIbyxT0Bh6bCUr@monkey>
        <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
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

On Mon, 21 Nov 2022 09:05:43 +0100 David Hildenbrand <david@redhat.com> wrote:

> >> MikeK do you have test cases?
> > 
> > Sorry, I do not have any test cases.
> > 
> > I can ask one of our product groups about their usage.  But, that would
> > certainly not be a comprehensive view.
> 
> With
> 
> https://lkml.kernel.org/r/20221116102659.70287-1-david@redhat.com
> 
> on it's way, the RDMA concern should be gone, hopefully.
> 
> @Andrew, can you queue this one? Thanks.

This is all a little tricky.

It's not good that 6.0 and earlier permit unprivileged userspace to
trigger a WARN.  But we cannot backport this fix into earlier kernels
because it requires the series "mm/gup: remove FOLL_FORCE usage from
drivers (reliable R/O long-term pinning)".

Is it possible to come up with a fix for 6.1 and earlier which won't
break RDMA?

