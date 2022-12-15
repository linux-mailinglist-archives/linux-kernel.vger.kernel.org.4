Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B964DE97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiLOQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLOQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:26:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D32F029;
        Thu, 15 Dec 2022 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671121585; x=1702657585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WdPUTgd9zWkCfq183zLUbTzeE291Z9BB8LrxG86yBVg=;
  b=MpyOElCfD1J+vgY6IS3nNruNDgrwBQ9E3dKqfYcnqinl3Mr37TjzSHWv
   PqcPbd5VpZPgxGJyU14HsKlAcTNd7UL+CaCT81/GrBUbqGrr80Kql5jDW
   SiEBmQkNmwlgQceazubFqJcwfinToxmcgNh/l4iKvSGRBjCOcv1dBNljf
   /8DDzBzPJwgFKuaLEMpMMbTvI9kDfwc6ZQOlEhsLXfTNeL8cFckkqFiFL
   fEdCZPuBWxrsq9H8oR2PVZx0NZTEM4WYyOIpSbd3uAJ7Y80/VwHk7YpWK
   IAOw32uJN6VQXNm3kYWkwKOwVOzvO7+SoGWKtDuHSmw7zHo8yBZ6ltDYe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320603924"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="320603924"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 08:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="773780459"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="773780459"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2022 08:26:05 -0800
Date:   Thu, 15 Dec 2022 08:34:20 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zilstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20221215163420.GA19321@ranerica-svr.sc.intel.com>
References: <20221213124023.40476af0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213124023.40476af0@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:40:23PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> In file included from include/linux/uaccess.h:11,
>                  from include/linux/sched/task.h:11,
>                  from include/linux/sched/signal.h:9,
>                  from include/linux/rcuwait.h:6,
>                  from include/linux/percpu-rwsem.h:7,
>                  from include/linux/fs.h:33,
>                  from include/linux/highmem.h:5,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from drivers/scsi/scsi_ioctl.c:9:
> drivers/scsi/scsi_ioctl.c: In function 'sg_scsi_ioctl':
> arch/x86/include/asm/uaccess.h:46:9: error: cast specifies array type
>    46 |         (__force __typeof__(ptr))__ptrval;                              \
>       |         ^
> arch/x86/include/asm/uaccess.h:107:38: note: in definition of macro '__typefits'
>   107 |         __builtin_choose_expr(sizeof(x)<=sizeof(type),(unsigned type)0,not)
>       |                                      ^
> arch/x86/include/asm/uaccess.h:130:18: note: in expansion of macro '__inttype'
>   130 |         register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);            \
>       |                  ^~~~~~~~~
> arch/x86/include/asm/uaccess.h:162:9: note: in expansion of macro 'do_get_user_call'
>   162 |         do_get_user_call(get_user,x,untagged_ptr(current->mm, ptr));    \
>       |         ^~~~~~~~~~~~~~~~
> arch/x86/include/asm/uaccess.h:162:37: note: in expansion of macro 'untagged_ptr'
>   162 |         do_get_user_call(get_user,x,untagged_ptr(current->mm, ptr));    \
>       |                                     ^~~~~~~~~~~~
> drivers/scsi/scsi_ioctl.c:522:13: note: in expansion of macro 'get_user'
>   522 |         if (get_user(opcode, sic->data))
>       |             ^~~~~~~~
> 
> Caused by commit
> 
>   ce66a02538f3 ("x86/mm: Fix sparse warnings in untagged_ptr()")
> 
> (the scsi code above has not changed since at least February ...)
> 
> I have reverted that commit for today.

There is a patch from Kirill that fixes this issue. It seems that its on
it's way to be merged [1].

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/166986602299.2101055.4152803267481265665.b4-ty@oracle.com/
