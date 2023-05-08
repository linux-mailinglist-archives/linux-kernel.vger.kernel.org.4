Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097366F9D2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjEHBA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHBA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE92100C1
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A8160F57
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86611C433D2;
        Mon,  8 May 2023 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683507654;
        bh=bmMy0QzRm7e6GBM3N6g+m3auRaR95vIAs0QzdR7RIWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WOjAd4a7qAn5tN5OSyPxS7u+ClEN+iweK+3Cjf8gPUZa4nuoawaIKqvc8sc8em/S8
         nR1IbaB5n5xQQ7DGaetoap4ZmjLmGajSHTeCtw1lxPm6Ffdvb66v/EoWss/w+WBbRl
         kMYJvAL+GMHl1tEPkM4AuVHEH5tGP2H9Ip38Ka5k=
Date:   Sun, 7 May 2023 18:00:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup: add missing gup_must_unshare() check to
 gup_huge_pgd()
Message-Id: <20230507180053.7d47cd3b58c73f3b6fc567e0@linux-foundation.org>
In-Reply-To: <2dbc82e9-30dc-5187-cdd6-166fa53213c4@redhat.com>
References: <cb971ac8dd315df97058ea69442ecc007b9a364a.1683381545.git.lstoakes@gmail.com>
        <20230507173022.96c9d24cb1aa6f57ed50f5fa@linux-foundation.org>
        <2dbc82e9-30dc-5187-cdd6-166fa53213c4@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 02:45:12 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 08.05.23 02:30, Andrew Morton wrote:
> > On Sat,  6 May 2023 15:05:25 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> > 
> >> All other instances of gup_huge_pXd() perform the unshare check, so update
> >> the PGD-specific function to do so as well.
> >>
> >> While checking pgd_write() might seem unusual, this function already
> >> performs such a check via pgd_access_permitted() so this is in line with
> >> the existing implementation.
> > 
> > Rationale seems strange.  "Other sites do it so this should also".  Why
> > is this a desirable change?  Maybe the "other instances" shouldn't be
> > performing this check either?
> 
> This change makes unshare handling across all GUP-fast variants consistent,
> which is desirable as GUP-fast is complicated enough already even when
> consistent :)

Thanks, I added the below to the changelog:

David said:

: This change makes unshare handling across all GUP-fast variants
: consistent, which is desirable as GUP-fast is complicated enough
: already even when consistent.
: 
: This function was the only one I seemed to have missed (or left out and
: forgot why -- maybe because it's really dead code for now).  The COW
: selftest would identify the problem, so far there was no report. 
: Either the selftest wasn't run on corresponding architectures with that
: hugetlb size, or that code is still dead code and unused by
: architectures.
: 
: the original commit(s) that added unsharing explain why we care about
: these checks:
: 
: a7f226604170acd6 ("mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page")
: 84209e87c6963f92 ("mm/gup: reliable R/O long-term pinning in COW mappings")

