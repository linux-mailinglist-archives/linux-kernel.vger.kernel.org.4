Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965FF634AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiKVXEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:03:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB508E083
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:03:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A93F0B81DFA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A83DC433D6;
        Tue, 22 Nov 2022 23:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669158236;
        bh=Mo+orukc3bevWxHrUrHQcfom3WcnVlNM1E+v3+jDJgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vEzAYP6FIhN1e2rFg5KylUlwXnqabL/VvLoNfdCYLdlq7jXrNQn/EsIS4gb57DHXn
         iQKWQ2+ru5Ns2vjEZi1Y1rHDxS/+r7A8C8Ex4HqTB3S/G2nyZSc+/8/iWYe/840Bo0
         Wg4RrH6ds3TE269DjBDjaXpV0Qitxik7CBgOC75Q=
Date:   Tue, 22 Nov 2022 15:03:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Message-Id: <20221122150355.41805b9013855cf0433b6612@linux-foundation.org>
In-Reply-To: <Y30N/YCg9MOVnhLk@nvidia.com>
References: <20221031152524.173644-1-david@redhat.com>
        <Y1/0e12ZJT6+N0kI@nvidia.com>
        <Y2BIbyxT0Bh6bCUr@monkey>
        <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
        <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
        <4b926dc7-b8ec-e363-b9d8-35c0f2c897f6@redhat.com>
        <Y30Js24EqCncvqO/@monkey>
        <Y30N/YCg9MOVnhLk@nvidia.com>
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

On Tue, 22 Nov 2022 13:59:25 -0400 Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > 
> > >     While that's certainly valid, it's not the common use case with
> > >     hugetlb pages.
> > 
> > FWIW, I did check with our product teams and they do not knowingly make use
> > of private mappings without write.  Of course, that is only a small and
> > limited sample size.
> 
> Yeah, if it is only this case I'm comfortable as well
> 

So.... I am to slap a cc:stable on this patch and we're all good?
