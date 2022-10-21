Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE984608033
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJUUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJUUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C623103277
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1C9561F0B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 20:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326A3C433C1;
        Fri, 21 Oct 2022 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666385317;
        bh=BmGPpt6ZZmS6tEKeRWOGR6TymKZu3px6XDlXoOZvO54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NLkzSlyPq+qlpzvyyt31uOBvLLNUIb7e79iWRR07Td0MCWazlH4tj+gL9ryGgMhnR
         QD+VJXjR9P7dhlnDE3uch/jDCamvlp+sosNWsc3v6sdfS8ciwz87zSqWyGGAH0JvBq
         i2VvfVrBK5AxyroSqECfQRmMXkBblqz8a04EtdJE=
Date:   Fri, 21 Oct 2022 13:48:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,madvise,hugetlb: fix unexpected data loss with 
 MADV_DONTNEED on hugetlbfs
Message-Id: <20221021134836.1fe0e8c8310eb247ce7acafb@linux-foundation.org>
In-Reply-To: <20221021154546.57df96db@imladris.surriel.com>
References: <20221021154546.57df96db@imladris.surriel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 15:45:46 -0400 Rik van Riel <riel@surriel.com> wrote:

> A common use case for hugetlbfs is for the application to create
> memory pools backed by huge pages, which then get handed over to
> some malloc library (eg. jemalloc) for further management.
> 
> That malloc library may be doing MADV_DONTNEED calls on memory
> that is no longer needed, expecting those calls to happen on
> PAGE_SIZE boundaries.
> 
> However, currently the MADV_DONTNEED code rounds up any such
> requests to HPAGE_PMD_SIZE boundaries.

Well that's obnoxious.

> This leads to undesired
> outcomes when jemalloc expects a 4kB MADV_DONTNEED, but 2MB of
> memory get zeroed out, instead.
> 
> Use of pre-built shared libraries means that user code does not
> always know the page size of every memory arena in use.
> 
> Avoid unexpected data loss with MADV_DONTNEED by rounding up
> only to PAGE_SIZE (in do_madvise), and rounding down to huge
> page granularity.
> 
> That way programs will only get as much memory zeroed out as
> they requested.

If we merge this, we're inviting people to develop and test code on the 6.2
kernel only to ship it and then find that it misbehaves on 6.1 and
earlier.

So I think we should backport this.

> While we're here, refactor madvise_dontneed_free_valid_vma
> a little so mlocked hugetlb VMAs need MADV_DONTNEED_LOCKED.

And if we do backport it, "while we're here" changes are unwelcome!


