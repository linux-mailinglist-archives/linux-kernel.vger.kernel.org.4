Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B2616D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiKBSs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiKBSs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:48:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F22FFFE;
        Wed,  2 Nov 2022 11:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F4F1B82416;
        Wed,  2 Nov 2022 18:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FB3C433D6;
        Wed,  2 Nov 2022 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667414876;
        bh=yxrsFviIF1KsIOZJXHx2mBYrnCUXLsJNgyiy7V57cCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eysR7HGt9c35uNnTz3pb75plWA9WEs3r1E8ZKbHuRg1bRFicmFLLe+HOD+EFqCxF8
         n3kCHgccDxxx9lm7u+qZbm3da1Tt1zK0S/pzXVE9OUuyQ2WFehjxV7ogo4abk/T2Tp
         gZ0l/HzpFNbFKiX/nfaX8yYwpH86lnuMcCJqTbhc=
Date:   Wed, 2 Nov 2022 11:47:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        David Miller <davem@davemloft.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd)
Message-Id: <20221102114755.f7135b9c1ac2668e98cabdbd@linux-foundation.org>
In-Reply-To: <Y2K4Kd8JRWa1noLB@x1n>
References: <20220811161331.37055-1-peterx@redhat.com>
        <20220811161331.37055-5-peterx@redhat.com>
        <20221021160603.GA23307@u164.east.ru>
        <Y1Wbi4yyVvDtg4zN@x1n>
        <CADxRZqy+cMHN4FjtDr7-LOyVf0y+G8MPiBoGiTEsSj48jBfVnw@mail.gmail.com>
        <Y1f2IR+h4i2+/swj@x1n>
        <CADxRZqz+Sk=yxrJQ8B7UVkrcct9w6nUeiaaVn7QTFL59isFLDA@mail.gmail.com>
        <Y2K4Kd8JRWa1noLB@x1n>
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

On Wed, 2 Nov 2022 14:34:17 -0400 Peter Xu <peterx@redhat.com> wrote:

> > Tested again with 6.1.0-rc3, segfaults dpkg... applied patch - no dpkg
> > segfaults.
> 
> Andrew, shall we apply the minimum revert for this patch for now?  The
> one-liner was attached in this email I replied to Anatoly:
> 
> https://lore.kernel.org/all/Y1Wbi4yyVvDtg4zN@x1n/

Oh.  I missed that in the email flood.

I added the Fixes: and queued it, thanks.
