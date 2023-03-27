Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012246C9FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjC0JkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjC0JkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:40:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CB469E;
        Mon, 27 Mar 2023 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679910016; x=1711446016;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=IW3zsAq16i6wCn3thgfU7ml+pZV5tKxghHNUo4jwRwY=;
  b=FDGyH6pqgr3wqJqZRpqfUFCwVne2Ith+F7VJLYJGtkYy7H6VcHZ1twlh
   nShmxVqHwWmUb3TCeynTm4/9Hq4ACJqCvtMdlfZszh+wXcz3qh56mbA5S
   QHxiNhG8xX6BYlXMEPJjF7zS0Pe6+4A00ioadMDkGDggH7RPE3HufB0fl
   MKTFWJ94tvKzf0HC3nJSpHkbfMVqBROKEPS9zjAstWFcouECoMJLKITQh
   16QVwRQTono1u9rhzXl2UJ+Y0EcfY8Ru5nh6cnYYBE4YOoTBWnO0cq20j
   vZm6fhqFOCRNyXzL2OpPlft3nLQ9A3ztyYNCTws/wXYwvycghTTYgVV7u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="402818920"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="402818920"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 02:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="857596828"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="857596828"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2023 02:40:13 -0700
Message-ID: <b86fcdbd-f1c6-846f-838f-b7679ec4e2b4@linux.intel.com>
Date:   Mon, 27 Mar 2023 12:41:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>
References: <24263902-c9b3-ce29-237b-1c3d6918f4fe@alu.unizg.hr>
 <651c0500-2b84-d938-fdc2-45e92b322b38@alu.unizg.hr>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: BUG: drivers/usb/host/xhci: memleak in alloc from
 xhci_disable_usb3_lpm_timeout()
In-Reply-To: <651c0500-2b84-d938-fdc2-45e92b322b38@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.3.2023 13.33, Mirsad Goran Todorovac wrote:
> On 25. 03. 2023. 12:27, Mirsad Goran Todorovac wrote:
>> Hi all!
>>
>> Here are again the good news and the bad news:
>>
>> BAD:  another kernel memory leak detected (one more to hunt down and fix)
>> GOOD: another kernel memory leak detected (one less unaccounted for)
>>
>> I tried to make some fun, but maintainers are busy folks, so let's get down
>> to business:
>>
>> ---
>> Nine (9) new systemd-udevd kernel memory leaks occurred (unable to reproduce).
>>
>> The platform is Ubuntu 22.10 with (relatively recent) systemd 251.4-1ubuntu7.1
>> on LENOVO_MT_82H8_BU_idea_FM_IdeaPad 3 15ITL6 with BIOS GGCN51WW from 11/16/2022.
>>
>> The symptom (/sys/kernel/debug/kmemleak output):
>>
>> unreferenced object 0xffff909698ff9280 (size 64):
>>    comm "systemd-udevd", pid 436, jiffies 4294893239 (age 6287.088s)
>>    hex dump (first 32 bytes):
>>      e0 51 bb 99 96 90 ff ff 00 00 00 00 00 00 00 00  .Q..............
>>      40 5b bb 99 96 90 ff ff 00 00 00 00 00 00 00 00  @[..............
>>    backtrace:
>>      [<ffffffffb29de94c>] slab_post_alloc_hook+0x8c/0x320
>>      [<ffffffffb29e5107>] __kmem_cache_alloc_node+0x1c7/0x2b0
>>      [<ffffffffb2962f3b>] kmalloc_node_trace+0x2b/0xa0
>>      [<ffffffffb31af2ec>] xhci_alloc_command+0x7c/0x1b0
>>      [<ffffffffb31af451>] xhci_alloc_command_with_ctx+0x21/0x70
>>      [<ffffffffb31a8a3e>] xhci_change_max_exit_latency+0x2e/0x1c0>>      [<ffffffffb31a8c5b>] xhci_disable_usb3_lpm_timeout+0x7b/0xb0
>>      [<ffffffffb31457a7>] usb_disable_link_state+0x57/0xe0

Thanks for the report.

I think I found the leak, and wrote a patch for it.
Any chance you could test it with the same setup?

https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-linus&id=8bacee588602ed74cc22aaf4c56b796300e5a943

Thanks
-Mathias

