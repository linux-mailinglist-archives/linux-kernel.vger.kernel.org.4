Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B555614409
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKAFGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKAFGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:06:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C927C13D3F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667279193; x=1698815193;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=IvSOtGrzZN2pV+uWfoyYt5wv9j9DhXJ+Scyj4+toEww=;
  b=fZTtjZJ6i7hRSfEE5uqNjR76f4BVCQfTPUM+r9VIxrF9vHumJStihIDO
   mrYwvKHYB2HBEplUdd4UOcC/XpcKqfCvRgSHnSN0HaaSQOGCnD9wRXB58
   uMANcGOJF2LpPmPediC3FylCFqKZ07WXZUsZlyEB3qG1L2VMurNXzF5kw
   QsC/d/pO50fS9skWLsH0XGKtajhcb9SZbdJM96gFsxnZfn9tL745tMSRL
   JE9zN0E7GrEi4y5anExd0Zm9uEPFOvD6CbF8rVQ/w9SCpGDxUK5WM9zyc
   8HhJgpunJEd8SYbqlB0SO4NHSS67u5SJncJv6Z0kjFMmrOir7ij0sI855
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="306683278"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="306683278"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 22:06:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="628474616"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="628474616"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 22:06:31 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 0/2] mm: Use pte marker for swapin errors
References: <20221030214151.402274-1-peterx@redhat.com>
        <87h6zkepog.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1/YT9/PcF6kx/gq@x1n>
Date:   Tue, 01 Nov 2022 13:05:51 +0800
In-Reply-To: <Y1/YT9/PcF6kx/gq@x1n> (Peter Xu's message of "Mon, 31 Oct 2022
        10:14:39 -0400")
Message-ID: <87mt9bclhs.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Mon, Oct 31, 2022 at 09:40:15AM +0800, Huang, Ying wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > rfc->v1:
>> > - Rename SWAP_ERROR -> SWAPIN_ERROR [David, Miaohe]
>> > - Added r-bs for Ying and Miaohe
>> >
>> > Hi,
>> >
>> > This series uses the pte marker to replace the swapin error swap entry,
>> > then we save one more swap entry slot for swap devices.  A new pte marker
>> > bit is defined.
>> 
>> Per my understanding, "swap entry" describes one swap page (4KB on x86)
>> in one swap device.  So, the original swapin error implementation uses
>> one swap file (or swap device) instead of one swap entry.  So your patch
>> saves one swap file (or swap device).
>
> Yeah I was definitely not accurate enough, I wanted to use "slot" to mean
> "type" here but obviously I didn't make it, sorry.  Hopefully the whole
> patchset is still clear enough anyway so no reader will get confused by it.

The terminology used in swap code is a little complex.  The swap slot is
used to describe swap entry (swap page) too in swap slots cache
(swap_slots.c/h).

Best Regards,
Huang, Ying
