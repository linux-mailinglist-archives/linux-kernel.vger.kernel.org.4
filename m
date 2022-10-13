Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696DD5FD79F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJMKKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJMKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:09:59 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2332167CB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 03:09:55 -0700 (PDT)
Date:   Thu, 13 Oct 2022 19:09:43 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665655793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z78o+HpYoAcNgcRhH1mKkWfyfDptYAYJiQPW+GbhdF0=;
        b=xwoIQnqclf6LpmSJkDvCWops4flotPrAtjRAXUqIXRAHWLXxItStjoTUbquc7DNyJNtvVZ
        uv7ovwtnf60mSqSgEdKNXGZY8Es0qAa1+hoPPR1L2+r6Z1GoAlEh6obYJTAOSpJyF5/Ugi
        zBWclQ9jxKFDKJ4RLyfpHrMfQXZ9Q2E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
Message-ID: <20221013100943.GA1505152@u2004>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
 <Y0fNaYGvnMdwHkg1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0fNaYGvnMdwHkg1@localhost.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 10:33:45AM +0200, Oscar Salvador wrote:
> On Fri, Oct 07, 2022 at 10:07:06AM +0900, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > Currently PageHWPoison flag does not behave well when experiencing memory
> > hotremove/hotplug.  Any data field in struct page is unreliable when the
> > associated memory is offlined, and the current mechanism can't tell whether
> > a memory block is onlined because a new memory devices is installed or
> > because previous failed offline operations are undone.  Especially if
> > there's a hwpoisoned memory, it's unclear what the best option is.
> > 
> > So introduce a new mechanism to make struct memory_block remember that
> > a memory block has hwpoisoned memory inside it. And make any online event
> > fail if the onlining memory block contains hwpoison.  struct memory_block
> > is freed and reallocated over ACPI-based hotremove/hotplug, but not over
> > sysfs-based hotremove/hotplug.  So the new counter can distinguish these
> > cases.
> > 
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> I glanzed over it and looks good overall.
> Have a small question though:

Thank you for looking.

> 
> > @@ -864,6 +878,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
> >  		mem = find_memory_block_by_id(block_id);
> >  		if (WARN_ON_ONCE(!mem))
> >  			continue;
> > +		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
> 
> Why does num_poisoned_pages_sub() have to make this distinction (!-1 == -1)
> for the hot-remove stage?

The first argument is used to find memory_block including the given pfn.
And in the above context remove_memory_block_devices() already has the
pointer "mem", so recalcurating it looked to me not necessary.  Moreover,
this code is about to free the memory_block so updating the counter inside
it can be avoided.  This is just a tiny optimization, and there can be
better option.

Thanks,
Naoya Horiguchi
