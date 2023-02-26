Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466716A2E40
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBZEzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZEzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:55:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DDF10A98
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A45B7B80B7C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC4DC433D2;
        Sun, 26 Feb 2023 04:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677387345;
        bh=rjBnCv2ULxEz7oJV432ZaM8iYHq42FRu53Pj0zGrV9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zs96Isk7BUDkozaK8NVXBH8wpXf+B/3rxNacG3e2KJ/ICcJ4eE1nxsieBaCKjgUML
         Y1dTApNqBhpNN/PZOLM/fPeU/20Ejpve2zmzemg8+je873WcrwrJQ25yNlGBjUDTfF
         zeM38a4vfl9ja8eUzf2FWQm7oVeU42BOLKkErqsI=
Date:   Sat, 25 Feb 2023 20:55:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 0/3] migrate_pages: fix deadlock in batched synchronous
 migration
Message-Id: <20230225205543.5d56714d2145ac45da25369e@linux-foundation.org>
In-Reply-To: <20230224141145.96814-1-ying.huang@intel.com>
References: <20230224141145.96814-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 22:11:42 +0800 Huang Ying <ying.huang@intel.com> wrote:

> Two deadlock bugs were reported for the migrate_pages() batching
> series.

"migrate_pages(): batch TLB flushing"

>  Thanks Hugh and Pengfei.  Analysis shows that if we have
> locked some other folios except the one we are migrating, it's not
> safe in general to wait synchronously, for example, to wait the
> writeback to complete or wait to lock the buffer head.
> 
> So 1/3 fixes the deadlock in a simple way, where the batching support
> for the synchronous migration is disabled.  The change is
> straightforward and easy to be understood.  While 3/3 re-introduce the
> batching for synchronous migration via trying to migrate
> asynchronously in batch optimistically, then fall back to migrate
> synchronously one by one for fail-to-migrate folios.  Test shows that
> this can restore the TLB flushing batching performance for synchronous
> migration effectively.

If anyone backports the "migrate_pages(): batch TLB flushing" series
into their kernels, they will want to know about such fixes.  So we can
help them by providing suitable Link: tags.

Such a Link: may also be helpful to people who are performing git
bisection searches for some issue but who keep stumbling over the
issues which this series addresses.

Being lazy, I slapped

Fixes: 6f7d760e86fa ("migrate_pages: move THP/hugetlb migration support check to simplify code")

on all three, as this was the final patch in that series.  Inaccurate,
but it means that these fixes will land in a suitable place if anyone
needs them.
