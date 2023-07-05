Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C97491BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGEXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGEXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:22:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4064171A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HEv54oJyQWRkD06KFJ0WpEF5DAyvKakyxHIfyAHYI9M=; b=jzKiWcS0bnZpCkyhSlrsSSlBWW
        FJVjLjsazn5sdp9pn+h/mkwBHqT80/O0zDVZ6/pa4ajExYTBOxF3jxMJi64RsW9WAReZSCnvZz4R1
        3ePgCD6VqN8A4NkBtMCGslLGaudcssW8V9IlYU3sF0h/jE5qwRwl6ENYXfeb5HX2QlvrF9l1BsuSq
        nk8gFgHMmJJg71cSxY7pyhTS9Q0EPBQII/rYQbYCUaqhs5nmIJVnQg08/q946PWVXrePKCUZliGRZ
        OiQLAN7L7w4l4OQW02lTeOpOh9nzvD8/3ZdaWUB3itxGOOd8WOZ4zAxYcer1ift2EBFwqgh/TPPcC
        Z1RrmQkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHBpV-00AWp6-DD; Wed, 05 Jul 2023 23:22:37 +0000
Date:   Thu, 6 Jul 2023 00:22:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: mprotect and hugetlb mappings
Message-ID: <ZKX7PerFpnoMT5Pc@casper.infradead.org>
References: <20230705230808.GA41006@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705230808.GA41006@monkey>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 04:08:08PM -0700, Mike Kravetz wrote:
> I was recently asked about the behavior of mprotect on a hugetlb
> mapping where addr or addr+len is not hugetlb page size aligned.  As
> one might expect, EINVAL is returned in such cases.  However, the man
> page makes no mention of alignment requirements for hugetlb mappings.
> 
> I am happy to submit man page updates if people agree this is the correct
> behavior.  We might even want to check alignment earlier in the code
> path as we fail when trying to split the vma today.
> 
> An alternative behavior would be to operate on whole hugetlb pages within
> the range addr - addr+len.

After a careful re-reading of the mprotect() man page, I suggest the
following behaviour ...

addr must be a multiple of the hpage size.  Otherwise -EINVAL.
len should be rounded up to hpage size.

I wonder how likely this change would be to break userspace code.
Maybe some test cases.
