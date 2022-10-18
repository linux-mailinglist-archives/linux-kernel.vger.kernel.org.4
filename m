Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B06033A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJRT6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJRT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:58:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977468C475
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HP274ajX/YSD61RLLeUZGfhgXsGfDEm1d9mPkitVp+k=; b=PNOFcouPCbX/LxUMKNmdVOpXyo
        NQFCrDVuwF++hr9EDL2AXdDf1CmKyI+MtomwifRsj+8xr9zf4z5IlHK3MtFw7R6vpChlPRYg7M+Lw
        6k/Q2YWYVrGxJjZb2pROplMuZDnMX2S62yf+9kKhXTb6Vr1JfEXq+HWAI0Mjk5Jtv+TG/z26+xRJM
        zbJdhGwOJw1UiJN8j1h57vkXQq/WMY0jP3bYYSCGwX0VRxseP7APRwTF/AZle74fZP+eFU+67D0ak
        w7Eq/+rWKPFOb2YyuZW347guGk3eYN4eBiJNoUf29E8XB7RlL/XwxWifbdnSy/io5pGNvUo8fPPaV
        zfGb+8Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oksjM-00Ayvg-5Q; Tue, 18 Oct 2022 19:58:28 +0000
Date:   Tue, 18 Oct 2022 20:58:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liu Zixian <liuzixian4@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] mm/mmap: Fix MAP_FIXED address return on VMA merge
Message-ID: <Y08FZMg1Kgr++o5D@casper.infradead.org>
References: <20221018191613.4133459-1-Liam.Howlett@oracle.com>
 <3da4244a-5a1b-cf34-bf5c-22c199b15cb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3da4244a-5a1b-cf34-bf5c-22c199b15cb6@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:27:11PM +0200, David Hildenbrand wrote:
> > +		if (WARN_ON((addr != vma->vm_start))) {
> > +			error = -EINVAL;
> > +			goto close_and_free_vma;
> > +		}
> 
> If this is something that user space can trigger, WARN_* is the wrong
> choice. But what I understand from the comment change is that this must not
> happen at that point unless there is a real issue.

It's something that a device driver can trigger.  So if userspace calls
mmap(MAP_FIXED) and the driver decides to overwrite the vma->vm_start,
it'll trigger.  I think WARN_ON() is the right choice.

> Why not "if (WARN_ON_ONCE)" ?

Because by it's nature it's not going to trigger a bajillion times in
quick succession.
