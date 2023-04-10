Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD306DCBA3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDJTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDJTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:34:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A61BE4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681155252; x=1712691252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1v+fkw5hKVXUIsw8os7nktMH4AZSQ0oQAFoWW69TZ4g=;
  b=BQYzk7brDrJJDj4OCHVriY65qp8/RliklgMSRMWNnocW73oPoYcBvN/z
   gA0rF+K9Q7AmRD8GPJF/VApyhreXHb+E+QfYmYPvpk8SXh6SfnVtNNTSB
   E4+DWCjqrKphGzaxhfKeKayPzdAIwFx0UON0GU87OWxVvNqiwaF+63s5I
   Xjl5Dp4X/gt96qiDL2lP5MZBO6jW8lYiIDPE+WH1bh+VB8kMK+C/n69M9
   XZXUKZozzbJp14Fev0i4kKFVqvLcsCEJLyYMB4PVtDi2fk51xK4YVOlDy
   4TJKDuQj8Eqit6V/fRRPVwgJatGXC98WTVC0vSpTpKzpCJOC9QOuHsMjL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="371281073"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="371281073"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 12:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688364595"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="688364595"
Received: from arsetion-mobl.amr.corp.intel.com (HELO [10.209.122.228]) ([10.209.122.228])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 12:34:11 -0700
Message-ID: <d416428f-c846-b6b9-74da-f3571d92d38a@intel.com>
Date:   Mon, 10 Apr 2023 12:34:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] x86: profiling: remove lock functions hack for
 !FRAME_POINTER
Content-Language: en-US
To:     Chen Zhongjin <chenzhongjin@huawei.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foudation.org, ben-linux@fluff.org, wuchi.zero@gmail.com
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
 <20230410022226.181812-2-chenzhongjin@huawei.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230410022226.181812-2-chenzhongjin@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/23 19:22, Chen Zhongjin wrote:
> Syzbot has been reporting the problem of stack-out-of-bounds in
> profile_pc for a long time:
> https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
> 
> profile_pc tries to get pc if current regs is inside lock function. For
> !CONFIG_FRAME_POINTER it used a hack way to get the pc from stack, which
> is not work with ORC. It makes profile_pc read illeagal address, return
> wrong result, and frequently triggers KASAN.
> 
> Since lock profiling can be handled with much better other tools, It's
> reasonable to remove lock functions hack for !FRAME_POINTER kernel.

OK, so let me make sure I understand what's going on:

1. This whole issue is limited to kernel/profile.c which is what drives
   readprofile(8) and /proc/profile
2. This is removing code that got added in 2006:
	0cb91a229364 ("[PATCH] i386: Account spinlocks to the caller during
profiling for !FP kernels")
3. This was an OK hack back in the day, but it outright breaks today
   in some situations.  KASAN also didn't exist in 2006.
4. !CONFIG_FRAME_POINTER is probably even more rare today than it was in
   2006
5. Lock function caller information is available at _least_ from perf,
   maybe other places too??  (What "much better other tools" are there?)

Given all that, this patch suggests that we can remove the stack peeking
hack.  The downside is that /proc/profile users will see their profiles
pointing to the spinlock functions like they did in 2005.  The upside is
that we won't get any more KASAN reports.

If anyone complains, I assume we're just going to tell them to run 'perf
--call-graph' and to go away (which also probably didn't exist in 2006).

If I got all that right, the end result seems sane to me.  It would be
_nice_ if you could make a more coherent changelog out of that and
resend.  Also, considering that your two "profile" issues are quite
independent, you can probably just resend the two patches separately.
