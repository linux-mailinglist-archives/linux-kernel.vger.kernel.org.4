Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372468B301
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBFALH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBFALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:11:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3B717157;
        Sun,  5 Feb 2023 16:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rGSaCbdLvJLIXU4diqo8Az/pvlwzPHqyC8mVLdkgmVs=; b=wQwn+cTYGhjeIQzkhRGa2nUWly
        qYw+9p/37SKqb+atz8pOYcdUXhEpdCm4hpif6nv5xWdmZ4IPvrilZjWRNA+Wqtf/vuG9djjBMGX4t
        Daee7IzYAIZh6dMwqOftfSAlIXLk6lFLaaX6VHpRGZ207Xf/lA1BV651u4V5zIA1QLMikOzYRHNmf
        b0usFOi4WDyAPKftj5wTS/OyxHd+7t9ljT2PfT/Upl4noMYHLabBTRNnrOqjV09ETRIliFyCIx1r2
        kmVArxQgmKVg1Htm1C5fQPwobTOoR1LC+GbwKJBLA+qJck/Ede5ly6QoUBmLkL6dKtZlKHj60xTcr
        VUCWbhOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOp5x-00GJrn-6g; Mon, 06 Feb 2023 00:10:53 +0000
Date:   Mon, 6 Feb 2023 00:10:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+BFjQDBIFq5ih+t@casper.infradead.org>
References: <20230205231704.909536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205231704.909536-1-peterx@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 06:17:01PM -0500, Peter Xu wrote:
> I noticed a few collision usage on VM_FAULT_* definition in the page fault
> path on arm/arm64/s390 where the VM_FAULT_* can overlap with the generic
> definition of vm_fault_reason.
> 
> The major overlapped part being VM_FAULT_HINDEX_MASK which is used only by
> the hugetlb hwpoisoning.
> 
> I'm not sure whether any of them can have a real impact, but that does not
> look like to be expected.  I didn't copy stable, if anyone thinks it should
> please shoot.  Nor did I test them in any form - I just changed the
> allocations from top bits and added a comment for each of them.

This seems like a bad way to do it.  Why not just put these VM_FAULT_*
definitions in linux/mm_types.h?  Then we'll see them when adding new
VM_FAULT codes.  Sure, they won't be used by every architecture, but
so what?
