Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2D6DFF78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDLUNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3C6359E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B80E36323B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5692C4339B;
        Wed, 12 Apr 2023 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681330383;
        bh=fcOdDZPfT6Pc+nyQt0Z104yoPIvfvFyUOVPGZ/Hl6J8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J9dJXUx6JHtF3q5BB/WjISGMW5lPxnuFk0nEH2B49wVFYoeqEsS680fHiCOaqZdFW
         zZWMwAv6ACW5iTqH/WE86QUZlNQAQoVnWfntjdrbJTH/FT3KsrdDahe2uQB0889HRT
         N9vb15DRYNM2G8WVocMbJd3XN4Z22S+vPrTPr3IY=
Date:   Wed, 12 Apr 2023 13:13:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, mhocko@suse.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
Message-Id: <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
In-Reply-To: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of questions (ie, missing information!)

On Wed, 12 Apr 2023 19:59:39 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> HugeTLB pages have a struct page optimizations where struct pages for tail
> pages are freed. However, when HugeTLB pages are destroyed, the memory for
> struct pages (vmemmap) need to be allocated again.
> 
> Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
> but given that this flag makes very little effort to actually reclaim
> memory the returning of huge pages back to the system can be problem.

Are there any reports of this happening in the real world?

> Lets
> use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> reclaim without causing ooms, but at least it may perform a few retries,
> and will fail only when there is genuinely little amount of unused memory
> in the system.

If so, does this change help?

If the allocation attempt fails, what are the consequences?

What are the potential downsides to this change?  Why did we choose
__GFP_NORETRY in the first place?

What happens if we try harder (eg, GFP_KERNEL)?
