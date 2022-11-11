Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C216261DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiKKT1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKT1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:27:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224FE67F4F;
        Fri, 11 Nov 2022 11:27:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADBD9620BC;
        Fri, 11 Nov 2022 19:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC96DC433D6;
        Fri, 11 Nov 2022 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668194853;
        bh=LO+ntQc0E3uXo6MFAX4vcf+t4RJhM/5JL5OOiHCwBxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=COWKm3vj6cl9npbNuKbPrUnx5UMrRBXertuDg30dZNEbSJvJekEWKopjU0lQQXRkQ
         QD56X1LMulYF1qm3Z7TpP3nE3uTKnP4JX5G/t95lYuhn6gbETrMSzJsTBSnldT+V+f
         sT/afxaYJj1RDuzQ0lCIiXEOsNetsGWc2AgcPbkI=
Date:   Fri, 11 Nov 2022 11:27:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] mm: add new syscall pidfd_set_mempolicy().
Message-Id: <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
In-Reply-To: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
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

On Fri, 11 Nov 2022 16:40:51 +0800 Zhongkun He <hezhongkun.hzk@bytedance.com> wrote:

> Page allocation usage of task or vma policy occurs in the fault
> path where we hold the mmap_lock for read. because replacing the
> task or vma policy requires that the mmap_lock be held for write,
> the policy can't be freed out from under us while we're using
> it for page allocation. But there are some corner cases(e.g.
> alloc_pages()) which not acquire any lock for read during the
> page allocation. For this reason, task_work is used in
> mpol_put_async() to free mempolicy in  pidfd_set_mempolicy().
> Thuse, it avoids into race conditions.

This sounds a bit suspicious.  Please share much more detail about
these races.  If we proced with this design then mpol_put_async()
shouild have comments which fully describe the need for the async free.

How do we *know* that these races are fully prevented with this
approach?  How do we know that mpol_put_async() won't free the data
until the race window has fully passed?

Also, in some situations mpol_put_async() will free the data
synchronously anyway, so aren't these races still present?


Secondly, why was the `flags' argument added?  We might use it one day?
For what purpose?  I mean, every syscall could have a does-nothing
`flags' arg, but we don't do that.  What's the plan here?

