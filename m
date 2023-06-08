Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB24727B7D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjFHJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjFHJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:33:27 -0400
Received: from out0-219.mail.aliyun.com (out0-219.mail.aliyun.com [140.205.0.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDEE2D63
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:33:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---.TOc6qlT_1686216783;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TOc6qlT_1686216783)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 17:33:04 +0800
Date:   Thu, 08 Jun 2023 17:33:03 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     <linux-kernel@vger.kernel.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
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
Message-ID: <20230608093303.GA16983@k08j02272.eu95sqa>
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
 <1f633e99-d294-6932-31e9-0eb158d030ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f633e99-d294-6932-31e9-0eb158d030ea@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:49:15PM +0800, Dave Hansen wrote:
> On 5/15/23 01:19, Hou Wenlong wrote:
> > This patchset unifies FIXADDR_TOP as a variable for x86, allowing the
> > fixmap area to be movable and relocated with the kernel image in the
> > x86/PIE patchset [0]. This enables the kernel image to be relocated in
> > the top 512G of the address space.
> 
> What problems does this patch set solve?  How might that solution be
> visible to end users?  Why is this problem important to you?
> 
> Also, while you're waiting for someone to review _your_ code, have you
> considered reviewing anyone else's code?  I don't think I've seen any
> review activity from you lately.

Hello,

Sorry for bothering you. This patch is not important; it is just a part
of our PIE patchset. I should be more patient.

We want to build the kernel as PIE and allow the kernel image area,
including the fixmap area, to be placed at any virtual address. We have
also implemented a PV Linux guest based on PIE, which can be used in
software virtualization similar to Lguest. PIE makes the guest kernel
share the host kernel space similar to a normal userspace process.
Additionally, we are considering whether it is possible to use PIE and
PVOPS to implement a user-mode kernel.

Thank you for your advice. I will participate more actively in community
review activities. Sorry again for bothering you.

Thanks.
