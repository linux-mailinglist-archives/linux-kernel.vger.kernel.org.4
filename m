Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7499728C57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjFIAXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFIAXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:23:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A22D72;
        Thu,  8 Jun 2023 17:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686270180; x=1717806180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hfORcgQzuOPbSklLPJdOW8LVCo5d5Go2LF+sADUuhiU=;
  b=KKj2g/8okkDMbg1JK1vlqBo5WO8T2Yg1lw+o3aF091wCdUalOduElHZE
   /Dm25vHxeFMHoGjV6sWSn5Su2YITlWNga4vMxgXE7dDv2kaHbMS3GgBB+
   DCsYj58YJHY0MfAkyw2mT/fLUsyKAEFZ2x91wIwyDoHDjHnn0rfnygqnq
   udMIAAAlFmWvv9fmmv5e32stVYtfwOz2z395WKhNnSwHjmxOv0irJ/KtP
   KzeYl+aU2ZmFXkRyjXDZ/qalA+IdSgFWcYDGP09H4ACBHSCXnlwt9A+rT
   1DmVw/jx3J7LG0OkeF6IfOuLjqXQU3ZbmHyMi3UlFPQ34jSHNAptUCuBJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="421061871"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="421061871"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 17:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884393196"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="884393196"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.144.161.97])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 17:22:57 -0700
Date:   Thu, 8 Jun 2023 17:22:57 -0700
From:   Yunhong Jiang <yunhong.jiang@linux.intel.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch] x86/realmode: Make stack lock work in trampoline_compat()
Message-ID: <20230609002257.GA3661@yjiang5-mobl.amr.corp.intel.com>
References: <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name>
 <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <87h6rujdvl.ffs@tglx>
 <20230608233402.GA3430@yjiang5-mobl.amr.corp.intel.com>
 <a56a06c2-73fd-5295-3f6c-922ccb078488@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a56a06c2-73fd-5295-3f6c-922ccb078488@citrix.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:57:46AM +0100, Andrew Cooper wrote:
> On 09/06/2023 12:34 am, Yunhong Jiang wrote:
> > On Tue, May 30, 2023 at 12:46:22PM +0200, Thomas Gleixner wrote:
> >> The stack locking and stack assignment macro LOAD_REALMODE_ESP fails to
> >> work when invoked from the 64bit trampoline entry point:
> >>
> >> trampoline_start64
> >>   trampoline_compat
> >>     LOAD_REALMODE_ESP <- lock
> > One possibly dumb question and hope get some hints.
> 
> There's a phrase.  "The only dumb question is the one not asked".
> 
> If you have this question, there's an excellent chance that someone else
> reading this thread has the same question.
> 
> >  The LOAD_REALMODE_ESP is
> > defined under .code16 directive and will be used by 32-bit mode caller also. Is
> > it ok because the instructions there will be same for both 16-bit and 32-bit? I
> > checked
> > https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_16.html#SEC205 and
> > don't find much information there.
> 
> The position of the LOAD_REALMODE_ESP .macro itself doesn't matter. 
> It's just some text which gets pasted elsewhere.  Imagine it just the
> same as running the C preprocessor on a file before compiling it.
> 
> As you note, some expansions of the macro are in .code16, and some are
> not.  This does result in different bytes being emitted.  The default
> operands size flips between .code16 and .code32, so there will be some
> 0x66 prefixes in one mode, and not in others.
> 
> The important point is the l suffix on btsl, which forces it to be long
> (32bit) irrespective of the default operand size.
> 
> So yes, it will work, but that's because gas is handling the differing
> encodings automatically based on the default operand size where the
> LOAD_REALMODE_ESP gets expanded.
> 
> Hope this helps,
Thank you for the explaination, it's quite clear now.
> 
> ~Andrew
