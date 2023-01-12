Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AF466682A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjALA5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjALA5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:57:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D01BC94;
        Wed, 11 Jan 2023 16:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673485053; x=1705021053;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gXSztU5rbk3B7Y8rjXqRhgkpb7HVOhhRvitKJq8kch8=;
  b=H6hBPhSr2JxLU9lOaFUollJPSBAFiI4iVxxhZY7QptZeaRPiw8cEhyn1
   US6LAHkpk3r+HZoD9WFnxNw8eidb24AZxMB6jiItqbn7/rOjlFGQNuXau
   fR2lC2u3Y2IsL01erFCcmCjYZ6xpm/wAHC2MCgeEsA8rDJsxgKEB5NL3Q
   jCIobKNQGT34rah3y9xhKMEAbd4Kr2S3GhGmtJSTh8jn9z+ew5yHZQ12s
   xBbceKsOx9DPSxeaGUf6zJzY/zfbkvdVJtHkjnTMqLOlcGxZVGYCSwVCR
   sYrd4TEpj6Bi/FIdMrP7pXl0u5SbbFzb7q4Qobn5zvCTF4fLMP0kYdeuC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303954055"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303954055"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:57:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="746357534"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="746357534"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:57:28 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "Gao, Chao" <chao.gao@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Shahar, Sagi" <sagis@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v8 07/16] x86/virt/tdx: Use all system memory when
 initializing TDX module as TDX memory
References: <cover.1670566861.git.kai.huang@intel.com>
        <8aab33a7db7a408beb403950e21f693b0b0f1f2b.1670566861.git.kai.huang@intel.com>
        <e7b682a1-abdf-ce73-f262-8b7ce946e78e@intel.com>
        <bc11552572428c3b29b67852b062c387ecd7be45.camel@intel.com>
        <e02fd75d-e9d4-15f1-eb9c-31cf3cc9ddc1@intel.com>
        <a5d4de8b074b6d1a34bd3d424c5c4f0d677ec15f.camel@intel.com>
        <16f23950-2a27-29de-c0b4-e5f2d927c8b4@intel.com>
        <13096e4e39801806270c3a6a641102a8151aa5fc.camel@intel.com>
Date:   Thu, 12 Jan 2023 08:56:36 +0800
In-Reply-To: <13096e4e39801806270c3a6a641102a8151aa5fc.camel@intel.com> (Kai
        Huang's message of "Wed, 11 Jan 2023 18:00:07 +0800")
Message-ID: <871qo0y3i3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Kai" <kai.huang@intel.com> writes:

> On Tue, 2023-01-10 at 08:18 -0800, Hansen, Dave wrote:
>> On 1/10/23 04:09, Huang, Kai wrote:
>> > On Mon, 2023-01-09 at 08:51 -0800, Dave Hansen wrote:
>> > > On 1/9/23 03:48, Huang, Kai wrote:
>> > > > > > > > This can also be enhanced in the future, i.e. by allowing adding non-TDX
>> > > > > > > > memory to a separate NUMA node.  In this case, the "TDX-capable" nodes
>> > > > > > > > and the "non-TDX-capable" nodes can co-exist, but the kernel/userspace
>> > > > > > > > needs to guarantee memory pages for TDX guests are always allocated from
>> > > > > > > > the "TDX-capable" nodes.
>> > > > > >
>> > > > > > Why does it need to be enhanced?  What's the problem?
>> > > >
>> > > > The problem is after TDX module initialization, no more memory can be hot-added
>> > > > to the page allocator.
>> > > >
>> > > > Kirill suggested this may not be ideal. With the existing NUMA ABIs we can
>> > > > actually have both TDX-capable and non-TDX-capable NUMA nodes online. We can
>> > > > bind TDX workloads to TDX-capable nodes while other non-TDX workloads can
>> > > > utilize all memory.
>> > > >
>> > > > But probably it is not necessarily to call out in the changelog?
>> > >
>> > > Let's say that we add this TDX-compatible-node ABI in the future.  What
>> > > will old code do that doesn't know about this ABI?
>> >
>> > Right.  The old app will break w/o knowing the new ABI.  One resolution, I
>> > think, is we don't introduce new userspace ABI, but hide "TDX-capable" and "non-
>> > TDX-capable" nodes in the kernel, and let kernel to enforce always allocating
>> > TDX guest memory from those "TDX-capable" nodes.
>>
>> That doesn't actually hide all of the behavior from users.  Let's say
>> they do:
>>
>>       numactl --membind=6 qemu-kvm ...
>>
>> In other words, take all of this guest's memory and put it on node 6.
>> There lots of free memory on node 6 which is TDX-*IN*compatible.  Then,
>> they make it a TDX guest:
>>
>>       numactl --membind=6 qemu-kvm -tdx ...
>>
>> What happens?  Does the kernel silently ignore the --membind=6?  Or does
>> it return -ENOMEM somewhere and confuse the user who has *LOTS* of free
>> memory on node 6.
>>
>> In other words, I don't think the kernel can just enforce this
>> internally and hide it from userspace.
>
> IIUC, the kernel, for instance KVM who has knowledge the 'task_struct' is a TDX
> guest, can manually AND "TDX-capable" node masks to task's mempolicy, so that
> the memory will always be allocated from those "TDX-capable" nodes.  KVM can
> refuse to create the TDX guest if it found task's mempolicy doesn't have any
> "TDX-capable" node, and print out a clear message to the userspace.
>
> But I am new to the core-mm, so I might have some misunderstanding.

KVM here means in-kernel KVM module?  If so, KVM can only output some
message in dmesg.  Which isn't very good for users to digest.  It's
better for the user space QEMU to detect whether current configuration
is usable and respond to users, via GUI, or syslog, etc.

Best Regards,
Huang, Ying
