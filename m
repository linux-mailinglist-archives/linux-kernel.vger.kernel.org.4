Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5469072A628
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjFIWLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFIWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E530F8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 15:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9825465C8C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 22:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B0EC433EF;
        Fri,  9 Jun 2023 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686348673;
        bh=lffJYaMQAt9WPAdTp1t2dEqqXehvGeWl0jgqeQiZLsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=veolEzIkoNAhgbTjDkz+B4HaCTlVkq0cOqTDiKJoT3tbi2byP08KumyaxKPbusMxn
         zaq9ENZkZOEQ15ayq670UoLBmJBtHeAAgxt6J3b/dRk+TDT+r14OKJV91mfPXEFwEV
         dHDceG0/cT+PDUwfxP4UymV3WPb8PpdO8x7N34JY=
Date:   Fri, 9 Jun 2023 15:11:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        ying.huang@intel.com, mgorman@techsingularity.net,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid@kernel.org>
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Message-Id: <20230609151111.bb7908254853a0879db07746@linux-foundation.org>
In-Reply-To: <3c2ac70b-31a2-4e85-0ade-cb9f701525b3@oracle.com>
References: <ZG/I7tYY4uV/32hP@casper.infradead.org>
        <ZG/To8Z3StoVoenU@casper.infradead.org>
        <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
        <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
        <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
        <ZHD+eOMpZpWXNAig@casper.infradead.org>
        <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
        <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
        <ZHF2byaRlaX3W6Md@casper.infradead.org>
        <9821bd9c-7c30-8f0c-68e4-6b1d312bc032@nvidia.com>
        <ZHPydXSAfRq8sh0u@casper.infradead.org>
        <4d035744-271d-1ca3-a440-f8b1573eec96@redhat.com>
        <3c2ac70b-31a2-4e85-0ade-cb9f701525b3@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 09:42:33 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> > I completely agree that we should be careful with such mapcount vs. pagecount checks, and if we can use something 
> > better, let's use something *better*.
> 
> When we have a reliable folio_maybe_dma_longterm_pinned() function, it will be better to call that instead of doing 
> refcount vs mapcount check. Until that better function to check for pinned pages is in place, may I propose that the 
> current patch fixes a customer problem though not optimally and is a good enough working solution. When a better 
> function is in place, page_has_extra_refs() function can be updated to rely on this other function instead of refcount 
> vs mapcount.

We seem rather stuck with this patch.  I think I'll drop it while we
ponder a way forward.
