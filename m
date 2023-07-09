Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4708C74C034
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 02:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGIAqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 20:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIAqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 20:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EB71B1
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 17:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACEED60B5E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 00:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0865C433C8;
        Sun,  9 Jul 2023 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688863581;
        bh=fY53z6Onsmv3GKKfwc+3hC5M+1dggPKtLgeptAzv1fI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RmiaA/VzS9j6yirmr9X0dZ8m2E6vZJLjygrcSPtL6md5k6YOEhR3LNj0bB/mLCx4W
         vkswlziN5+2UT6w0rShS84zGu0pXfzKXW1DEB8AxCJ8bQ3Oj9KbEfHjmYjSMIyzYru
         JhbRKhNYLqdL7Xq9yXFCnvz83LBjcMbn/wplaNwQ=
Date:   Sat, 8 Jul 2023 17:46:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix a race between vmemmap pmd
 split
Message-Id: <20230708174620.8ef2109908f9606f3e4c090e@linux-foundation.org>
In-Reply-To: <63EDE3B6-B0AD-4D67-8EC6-FC8AE627E352@linux.dev>
References: <20230707033859.16148-1-songmuchun@bytedance.com>
        <20230707123844.adf56ba3e0d000f6da431494@linux-foundation.org>
        <63EDE3B6-B0AD-4D67-8EC6-FC8AE627E352@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 09:42:57 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> 
> 
> > On Jul 8, 2023, at 03:38, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > On Fri,  7 Jul 2023 11:38:59 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > 
> >> The local variable @page in __split_vmemmap_huge_pmd() to obtain a pmd
> >> page without holding page_table_lock may possiblely get the page table
> >> page instead of a huge pmd page.  The effect may be in set_pte_at()
> >> since we may pass an invalid page struct, if set_pte_at() wants to
> >> access the page struct (e.g. CONFIG_PAGE_TABLE_CHECK is enabled), it
> >> may crash the kernel.  So fix it. And inline __split_vmemmap_huge_pmd()
> >> since it only has one user.
> > 
> > Is this likely enough to justify a backport?
> > 
> > I'm thinking "add cc:stable and merge into 6.6-rc1", so it hits -stable
> > after a couple of months of testing.
> > 
> 
> Hi Andrew,
> 
> It is better to backport it to stable. Could you help me add it?
> 

I have added cc:stable to this and I have staged it for 6.6-rc1.
