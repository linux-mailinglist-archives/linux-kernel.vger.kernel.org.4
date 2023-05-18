Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF33707B66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjERHwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:52:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864026AB;
        Thu, 18 May 2023 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684396354; x=1715932354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SuT79ZRDYHe0si+5PoHM6aIaHEfx1rR2SpAoApuh0tg=;
  b=YDUrfK87fVUUDyAQFJFTzdBn8jYmtXM3fJ94f9NE5cKjBGCSqeh+C0Ex
   mK2Bt6l4L52LLKF72+A71n7lKBsTfkAhW7XBskVo32n2yQNgT+sz/bw7/
   T8t2isqEXBwSnYA4cnbB6x1u+pNV+1CTsXl3m2fTiOHqo7c2OsM7GJM+m
   c0nci8gHSw7JdK1rk6XQBto/qBGCPd+xI7Zeoi1UfYZ8OOTy7nR0AZ02Z
   b7eSW0NgM21HCbbCf72Y8kex7DpdfgKF+LfLCyJYu/ifcVJVCdGHbrhGE
   Llf8ek+3sR2usTnEA+JjlrjPwpZgLCFqMyNv/CttQLZmeoHP8SrTblIyo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380207678"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380207678"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 00:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="1032066864"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="1032066864"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.52])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 00:52:32 -0700
Message-ID: <a8127cb3-7693-22e9-7ace-547f7eb4403b@intel.com>
Date:   Thu, 18 May 2023 10:52:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: Problem running perf using Intel-PT with snapshots
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <6325A777-706E-462A-8931-59E16D4E37A5@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6325A777-706E-462A-8931-59E16D4E37A5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/23 07:26, Nadav Amit wrote:
> Hello perf masters,
> 
> I am running perf with Intel PT with snapshot mode and the result makes no
> sense. I tried to figure it out myself but failed.
> 
> Excluding the first data file, the rest seem messed up in various ways. The
> only thing that repeatedly shows are calls to __fentry__+0x0. I would note
> that ftrace is not enabled, and I turned off mitigations as I thought it
> might somehow be related, but it did not help.
> 
> Here is an example for execution and output. In between I ran
> `kill -SIGUSR2 [perf-pid]`. To dump some traces.
> 
> Any ideas what it might be?
> 
> Thanks,
> Nadav
> 
> --
> 
> $ perf record -e intel_pt/noretcomp=1/k --kcore --timestamp -a --snapshot=e262144 --switch-output -m,64

--switch-output does not work well with Intel PT.  Intel PT needs all of the sideband event information from all files, so decoding errors result from splitting files.

If you need separate files, consider stopping and restarting 'perf record' instead.  If you do that, you may want to look at options like -B and -N and --no-bpf-event which can affect how long it takes to stop perf record.

If you don't need separate files, you can use --time to look at time ranges within the resulting perf.data file.

> [ perf record: dump data: Woken up 2 times ]
> [ perf record: Dump perf.data.2023051804132358 ]
> [ perf record: dump data: Woken up 1 times ]
> [ perf record: Dump perf.data.2023051804132537 ]
> [ perf record: dump data: Woken up 1 times ]
> [ perf record: Dump perf.data.2023051804132689 ]
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Dump perf.data.2023051804132829 ]
> [ perf record: Captured and wrote 14.330 MB perf.data.<timestamp> ]
> 
> 
> $ sudo perf script -i  perf.data.2023051804004293
> 
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff81096125 ept_page_fault+0x3f5 ([kernel.kallsyms]) => ffffffff8108f1d0 kvm_mmu_get_child_sp+0x0 ([kernel.kallsyms])
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff8108f1d0 kvm_mmu_get_child_sp+0x0 ([kernel.kallsyms]) => ffffffff81131190 __fentry__+0x0 ([kernel.kallsyms])
>  instruction trace error type 1 time 78.287624064 cpu 6 pid -1 tid -1 ip 0xffffffff8101c4fd code 6: Trace doesn't match instruction
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff81296e14 futex_unlock_pi+0x184 ([kernel.kallsyms]) => ffffffff81294120 futex_cmpxchg_value_locked+0x0 ([kernel.kallsyms])
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff81294124 futex_cmpxchg_value_locked+0x4 ([kernel.kallsyms]) => ffffffff81131190 __fentry__+0x0 ([kernel.kallsyms])
>  instruction trace error type 1 time 78.287624104 cpu 6 pid -1 tid -1 ip 0xffffffff824c7a44 code 6: Trace doesn't match instruction
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff812909c4 __tick_broadcast_oneshot_control+0x1d4 ([kernel.kallsyms]) => ffffffff8128f720 tick_broadcast_set_event+0x0 ([kernel.kallsyms])
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff8128f720 tick_broadcast_set_event+0x0 ([kernel.kallsyms]) => ffffffff81131190 __fentry__+0x0 ([kernel.kallsyms])
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff81296e8e futex_unlock_pi+0x1fe ([kernel.kallsyms]) => ffffffff812961d0 put_pi_state+0x0 ([kernel.kallsyms])
>              :-1    -1 [006]    78.287624:          1             branches:k:  ffffffff812961d4 put_pi_state+0x4 ([kernel.kallsyms]) => ffffffff81131190 __fentry__+0x0 ([kernel.kallsyms])
>  instruction trace error type 1 time 78.287624208 cpu 6 pid -1 tid -1 ip 0xffffffff824c7a44 code 6: Trace doesn't match instruction
> 

