Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C655B4AC2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 01:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIJXK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIJXKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 19:10:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D31D326
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662851411; x=1694387411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WS0o8bhIq6oaepJ1nP7UHx7w6oJVp+AOQkUe5JwimsY=;
  b=IKCxiaxAAEJthlsP0lBzmtU+Cro/2hJQsdKuwQABfdO5qKYyKvkdCQwl
   hSgZyvyiiafLGF9E96fhz5Xg98c9eqNKFY9wEMH6ca6EkkbAbrv3zPt4K
   DA1m23VR4A/Ne4oaA4rsfASwn3tUUD2HBZuu7QDnY7lzaI6JDBzNDWoHM
   t+M2T+mcJcn03rG316cu9Jf+gbyzz/vA05EpMbAhi+/zQ//s/NHrRIodZ
   4vrqcvhyg9rgLcGSmFlYhv7UFAtPWlp1zDdvjuJQx2JtoPruvf7uONX84
   AOTzl79KaV+eyxHcrz3AC4B3CWLRQ6FPUKeow8JFEHggJrL4pTzEzcBDF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="298477402"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="298477402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 16:10:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="645986151"
Received: from yguo-mobl1.amr.corp.intel.com (HELO [10.212.57.31]) ([10.212.57.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 16:10:04 -0700
Message-ID: <ca8d4f94-a106-dc56-893d-d32d43beed85@intel.com>
Date:   Sat, 10 Sep 2022 16:09:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] x86/mm/dump_pagetables: Allow dumping pagetables by pid
Content-Language: en-US
To:     lizhe.67@bytedance.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        yuanzhu@bytedance.com
References: <20220804070401.86524-1-lizhe.67@bytedance.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220804070401.86524-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 00:04, lizhe.67@bytedance.com wrote:
> In current kernel we can only dump a user task's pagetable
> by task itself. Sometimes we need to inspect the page table
> attributes of different memory maps to user space to meet
> the relevant development and debugging requirements. This
> patch helps us to make our works easier. It add two file
> named 'pid' and 'pid_pgtable_show'. We can use 'pid' to
> input the task we want to inspect and get pagetable info
> from 'pid_pgtable_show'.
> 
> User space can use file 'pid' and 'pid_pgtable_show' as follows.
> ====
> $ echo $pid > /sys/kernel/debug/page_tables/pid
> $ cat /sys/kernel/debug/page_tables/pid_pgtable_show

This seems a wee bit silly considering that we have /proc.  It's also
impossible to have an ABI like this work if multiple processes are
trying to dump different pids.

Are there any other per-process things in debugfs where folks have done
something similar?
