Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5F725638
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbjFGHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbjFGHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:45:27 -0400
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E81BF5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:44:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---.TNbNmQf_1686123841;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TNbNmQf_1686123841)
          by smtp.aliyun-inc.com;
          Wed, 07 Jun 2023 15:44:02 +0800
Date:   Wed, 07 Jun 2023 15:44:01 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Alexey Makhalov" <amakhalov@vmware.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "=?UTF-8?B?TWlrZSBSYXBvcG9ydCAoSUJNKQ==?=" <rppt@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "=?UTF-8?B?U3JpdmF0c2EgUy4gQmhhdCAoVk13YXJlKQ==?=" 
        <srivatsa@csail.mit.edu>, "Suren Baghdasaryan" <surenb@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Usama Arif" <usama.arif@bytedance.com>,
        <virtualization@lists.linux-foundation.org>,
        "VMware PV-Drivers Reviewers" <pv-drivers@vmware.com>,
        <x86@kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC 0/4] x86/fixmap: Unify FIXADDR_TOP
Message-ID: <20230607074401.GA53666@k08j02272.eu95sqa>
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 04:19:31PM +0800, Hou Wenlong wrote:
> This patchset unifies FIXADDR_TOP as a variable for x86, allowing the
> fixmap area to be movable and relocated with the kernel image in the
> x86/PIE patchset [0]. This enables the kernel image to be relocated in
> the top 512G of the address space.
> 
> [0] https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antgroup.com
> 
> Hou Wenlong (4):
>   x86/vsyscall: Don't use set_fixmap() to map vsyscall page
>   x86/xen: Pin up to VSYSCALL_ADDR when vsyscall page is out of fixmap
>     area
>   x86/fixmap: Move vsyscall page out of fixmap area
>   x86/fixmap: Unify FIXADDR_TOP
> 
>  arch/x86/entry/vsyscall/vsyscall_64.c |  7 +-----
>  arch/x86/include/asm/fixmap.h         | 28 ++++-------------------
>  arch/x86/include/asm/paravirt.h       |  7 ++++++
>  arch/x86/include/asm/paravirt_types.h |  4 ++++
>  arch/x86/include/asm/vsyscall.h       | 13 +++++++++++
>  arch/x86/kernel/head64.c              |  1 -
>  arch/x86/kernel/head_64.S             |  6 ++---
>  arch/x86/kernel/paravirt.c            |  4 ++++
>  arch/x86/mm/dump_pagetables.c         |  3 ++-
>  arch/x86/mm/fault.c                   |  1 -
>  arch/x86/mm/init_64.c                 |  2 +-
>  arch/x86/mm/ioremap.c                 |  5 ++---
>  arch/x86/mm/pgtable.c                 | 13 +++++++++++
>  arch/x86/mm/pgtable_32.c              |  3 ---
>  arch/x86/xen/mmu_pv.c                 | 32 +++++++++++++++++++--------
>  15 files changed, 77 insertions(+), 52 deletions(-)
> 
> 
> base-commit: f585d5177e1aad174fd6da0e3936b682ed58ced0
> --
> 2.31.1
Hi,

Just wanted to send a kind ping on this patchset.

Thanks.
