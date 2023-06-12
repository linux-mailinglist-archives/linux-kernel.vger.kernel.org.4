Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B672C899
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbjFLOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjFLOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:31:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED5230EC;
        Mon, 12 Jun 2023 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686580234; x=1718116234;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=nu9cHDCGnhrdFWKyoctaWO51j3F00a8wP/G/yi0Zavs=;
  b=E5GfZJ721Bm1TmaoxOpyNjzbK0irk3SBVvtDIobwSdUNHdKutK6KJxPF
   8VmVLiZvhC8Jh2tg5yjrEJk0Qp2DKIu29BcFRPkiXREQOXo9O5zxOnw/k
   hhLgViTeS02iKL3gDsV1VgFMbUkpPIZH3v4YI70losAX0IcBYBggOjjzF
   7OVPoIiYbqfDviEubjgAq7AofteNt64z7JGrB9Wxbz72Y5W3u0kPzkXps
   XHzI0JqoudBJCBReappqPAS3IlV/UxqhRz4QTm1Xbm8LdRSqfTG9c68xv
   V85N6PBchLZ3nwgiMT/IoEgLGZO6NSfr6FfmJH5rHMIW/l+F4QD6kgpRE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444430919"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="444430919"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 07:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041350402"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="1041350402"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2023 07:28:41 -0700
Message-ID: <e153b3e8-6c0a-a142-c357-eb295eecdece@linux.intel.com>
Date:   Mon, 12 Jun 2023 17:30:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
References: <20230531-xhci-deadlock-v1-1-57780bff5124@chromium.org>
 <14d94fa1-1499-de1f-c924-9b823a606580@linux.intel.com>
 <CANiDSCuTYRUfW8tLbPDq3dE+F7Wno5oc4C9qESMmTpaNyW-54Q@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Do not create endpoint debugfs while holding the
 bandwidth mutex
In-Reply-To: <CANiDSCuTYRUfW8tLbPDq3dE+F7Wno5oc4C9qESMmTpaNyW-54Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.6.2023 19.05, Ricardo Ribalda wrote:
> Hi Mathias
> 
> On Thu, 1 Jun 2023 at 16:13, Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> Do you still have the lockdep output showing the deadlock?
> 
> [  459.731142] ======================================================
> [  459.731150] WARNING: possible circular locking dependency detected
> [  459.731161] 5.4.169-lockdep-17434-g505c8a10e6fe #1 Not tainted
> [  459.731168] ------------------------------------------------------
> [  459.731176] syz-executor.3/15308 is trying to acquire lock:
> [  459.731184] ffffff80c63e0ee0 (&queue->mutex){+.+.}, at:
> uvc_queue_mmap+0x30/0xa0 [uvcvideo]
> [  459.731226]
>                 but task is already holding lock:
> [  459.731232] ffffff80a748eea8 (&mm->mmap_sem){++++}, at:
> vm_mmap_pgoff+0x10c/0x1f4
> [  459.731255]
>                 which lock already depends on the new lock.
> 
...
> [  459.732148] Chain exists of:
>                   &queue->mutex --> &sb->s_type->i_mutex_key#4 --> &mm->mmap_sem
> 
> [  459.732165]  Possible unsafe locking scenario:
> 
> [  459.732172]        CPU0                    CPU1
> [  459.732178]        ----                    ----
> [  459.732184]   lock(&mm->mmap_sem);
> [  459.732193]                                lock(&sb->s_type->i_mutex_key#4);
> [  459.732204]                                lock(&mm->mmap_sem);
> [  459.732212]   lock(&queue->mutex);
> [  459.732221]
>                  *** DEADLOCK ***
> 
>>
>> I'm not sure how calling xhci_debugfs_create_endpoint() from
>> xhci_add_endpoint() instead of xhci_check_bandwidth() helps.
>>
>> Both are called with hcd->bandwidth_mutex held:
>>
>> usb_set_interface()
>>          mutex_lock(hcd->bandwidth_mutex);
>>          usb_hcd_alloc_bandwidth()
>>                  hcd->driver->add_endpoint()    -> xhci_add_endpoint()
>>                  hcd->driver->check_bandwidth() -> xhci_check_bandwidth()
>>          mutex_unlock(hcd->bandwidth_mutex);
> 
> Yep, I guess I was lucky not to be able to repro again :)
> 
> The locks involved are:
> 
> hcd->bandwidth_mutex
> mm->mmap_sem
> [uvc] queue->mutex
> 

Ok, took a look at this.
I don't think the bandwidth mutex matters that much.

To my understanding this is caused by the following lock chains:

ucv_queue_mmap()
   mmap_sem --> queue->mutex

uvc_ioctl_streamon() calling usb_set_interface() calling debugfs_create_dir()
   queue->mutex --> i_mutex_key

Some debugfs error case:
   i_mutex_key --> mmap_sem

So we could end up with this deadlock:
CPU0		CPU1		CPU2
mmap_sem	queue->mutex	i_mutex_key
  
waiting for	waiting for	waiting for
queue->mutex	i_mutex_key	mmap_sem	

I have no idea if this can be triggered in real life.

Looks like that requires a some specific debugfs error
to trigger at the same time we are creating a debugfs directory

Thanks
Mathias



  

