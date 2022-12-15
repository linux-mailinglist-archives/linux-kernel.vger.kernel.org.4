Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12A64DB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLOMad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLOMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:30:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8131112AD3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671107412; x=1702643412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tiv0pMcY74u4ARmOwchsghqG6J2gMtVd1zcIb3AUcdM=;
  b=SxInT7SQmwi61NTexv6igjFDDyjDA+Jy44ysTvJrYv4MJIWOVwKIkaC5
   SryUFsOUIPZVhW6s9LBZ5sCYX4yMElpe9pG4WWhh5XO79eg1jcoHQouQT
   WTe879NRX9xeTLIy1GBmJhUIFLtmd9sYHJseE0fy6e7r7CA7hZcJvyUlf
   KWd/Mnrnon8cLc8y2cu+eqIxQUdbRiHLjCtnUfP3SmcPzumNfVQNLWxp9
   Godv2mMtw5BVIrSl1PIEYqX4ddcjJ0k/m1oadB6TqaejqosLj+TpkH6jc
   8cdO8LdhdpSlvoPJEzpuJ8B98PQKAQSXUnXBUzNuO8MZYvtWPftkBniNA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="317374979"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; 
   d="scan'208";a="317374979"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 04:30:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="712892294"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; 
   d="scan'208";a="712892294"
Received: from milawils-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.217.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 04:30:09 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1A571109448; Thu, 15 Dec 2022 15:30:07 +0300 (+03)
Date:   Thu, 15 Dec 2022 15:30:07 +0300
From:   kirill.shutemov@linux.intel.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: Re: [GIT PULL] x86/mm for 6.2
Message-ID: <20221215123007.cagd7qiidehqd77k@box.shutemov.name>
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 02:36:04PM -0800, Linus Torvalds wrote:
> On Tue, Dec 13, 2022 at 9:43 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> >
> > This also contains a new hardware feature: Linear Address Masking
> > (LAM).  It is similar conceptually to the ARM Top-Byte-Ignore (TBI)
> > feature and should allow userspace memory sanitizers to be used
> > with less overhead on x86.
> 
> Christ.
> 
> Is it too late to ask Intel to call this "Top-Bits-Ignore", and
> instead of adding another crazy TLA, we'd just all agree to call this
> "TBI"?

The very top bit 63 is not ignored in LAM case. And in ARM case, TBI is Top
Byte Ignore, not Bits implies number of ignored bits and their placement.
The same TLA that means different thing does not help situation IMO.

I'm not sure if we can change how Intel calls the feature at this point,
but we can change kernel nomenclature if needed.

BTW, we already have somewhat related feature on Sparc that called ADI
which also hooks up into untagged_addr() machinery.

Maybe it is okay to have architecture-specific terminology as long as it
stays in arch code? Per-arch TLA namespace :P

> I  know, I know, NIH and all that, but at least as long as we are
> limiting ourselves to regular US-ASCII, we really only have 17576
> TLA's to go around, and at some point it gets not only confusing, but
> really quite wasteful, to have everybody make up their own
> architecture-specific TLA.
> 
> And while I'm on the subject: I really think that the changes to
> "untagged_addr()" are fundamentally broken.
> 
> Why? That whole LAM (or BTI) is not necessarily per-mm. It can easily
> be per-*thread*.
> 
> Imagine, if you will, a setup where you have some threads that use
> tagged pointers, and some threads that don't.
> 
> For example, maybe the upper bits of the address contains a tag that
> is used only used within a virtual machine? You could even have the
> "native" mode use the full address space, and put itself and its
> private data in the upper bits virtually.
> 
> IOW, imagine using the virtual address masking as not just memory
> sanitizers, but as an actual honest-to-goodness separation feature (eg
> JITed code might fundamentally have access only to the lower bits,
> while the JITter itself sees the whole address space).
> 
> Maybe that's not how LAM works on x86, but your changes to
> untagged_addr() are *not* x86-specific.

My initial enabling allowed userspace to enable the feature per-thread.
I pointed out the same potential use -- JIT -- case as you did[1].
But it made harder to handle corner cases. Like, it is not obvious what
LAM setup kernel thread has to use when acts on behalf of the process
(io_uring for instance). I ended up with using the most permissive LAM
mode (that allowed the most tag bits), but it is clearly a hack.

Thomas pointed[2] that out and following versions used per-process
approach. It simplified the patchset substantially.

Speaking about, untagged_addr(), how do you see the interface should look
like? It has to work correctly when called from a kernel thread. I can
only think of a hack that makes it branch on task->flags & PF_KTHREAD.

Hm?

[1] https://lore.kernel.org/all/20220513225936.qo4cy6sijqpzmvpt@black.fi.intel.com
[2] https://lore.kernel.org/all/878rr6x4iu.ffs@tglx

> So I really think this is completely wrong, quite aside from the
> naming. It just makes assumptions that aren't valid.
> 
> The fact that you made this mm-specific actually ends up being an
> active bug in the code, even on x86-64. You use the mmap lock to
> serialize this all in prctl_enable_tagged_addr(), but then the read
> side (ie just untagged_addr()) isn't actually serialized at all - and
> *shouldn't* be serialized.

mmap lock in prctl_enable_tagged_addr() serializes LAM enabling against
PASID allocation for the process as SVA and LAM is not currently
compatible.

I re-used the locking for KVM serialization where it wants to make sure
the userspace_addr has no tag bits set. But I just realized that replacing
access_ok() with __access_ok() should work too, no need for unagged_addr()
dance. I will rewrite the patch.

Normal untagged_addr() usage doesn't require serialization: IPI in
prctl_enable_tagged_addr() makes mm->context.untag_mask visible to all
CPUs that runs the mm before it returns. And we only allow one-shot LAM
enabling. It cannot be disabled later on.

Could you elaborate, what active bug do you see?

> So I really think this is a fundamental design mistake, and while I
> pulled it and sorted out the trivial conflicts, I've unpulled it again
> as being actively mis-designed.
> 
>                 Linus

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
