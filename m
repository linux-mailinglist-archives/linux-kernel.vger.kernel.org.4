Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A1C64E3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLOWhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:37:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EBC4A065
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F09A61F74
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E210C433D2;
        Thu, 15 Dec 2022 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671143821;
        bh=sORse0IGcAma0YoG8+CcwCQtsnysD6EbRJIA+wtE9w8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=niC/oyILOGo3MMNQvkGHvvoqVsyhtdU1p11c2bskUgZjejn1o90RAZ0Xi6vMU7ij8
         qqheuoYvO55WC1r3mF3EvMltIcxQ30KoeVgY5yKSrMxU+rcKL8WKbUBI45CoW4/GTJ
         RS8/kwoEjrlusZ8clwbrQAC6JQjkgZbpr6/nheGE=
Date:   Thu, 15 Dec 2022 14:37:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH 1/2] hugetlb: really allocate vma lock for all sharable
 vmas
Message-Id: <20221215143700.232f7ef0084167269f7068df@linux-foundation.org>
In-Reply-To: <20221212235042.178355-1-mike.kravetz@oracle.com>
References: <20221212235042.178355-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 12 Dec 2022 15:50:41 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Commit bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")
> removed the pmd sharable checks in the vma lock helper routines.
> However, it left the functional version of helper routines behind #ifdef
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE.  Therefore, the vma lock is not being
> used for sharable vmas on architectures that do not support pmd sharing.
> On these architectures, a potential fault/truncation race is exposed
> that could leave pages in a hugetlb file past i_size until the file is
> removed.
> 
> Move the functional vma lock helpers outside the ifdef, and remove the
> non-functional stubs.  Since the vma lock is not just for pmd sharing,
> rename the routine __vma_shareable_flags_pmd.
> 
> Fixes: bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")

So I assume we want this backported to 6.1?  I added a cc:stable.

The [2/2] patch is, I think, 6.3-rc1 material?
