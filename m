Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3272AE21
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjFJShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFJShX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:37:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC030E8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 11:37:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686422239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7WjIOv23GkoARnLqItYOF1clW2sOuIKmsM3GXO5Xpg=;
        b=YCL2WcdNIO0s3K7UdC06CzI1RNfJDkJe7HEF4v5qdxN8RrO3sAaq8xX62f444BjcyFpI8P
        dvsdlA/V4XzVxCD0n8uz5bQYGAgwsvDqWJ8rNLJDHj8k8iQwRRGGrRVWI0YDNiCXV818Ht
        GruRrk0/QYF97Rhj5uVOQfTLlEitAY6Rs+rjvdpG7tob605G0Kvr/fVugOur6hufdowyf4
        Ax62Ig7bPHia5hggr2KaWqBtF0qOBpkmhrvFk02kMofvAv6EhF1xBRXZSKW4DrYvu52o5K
        D3W+c9UFX4owv7UrRYBLocORMja3sAJWQxRmRkowpokWoNy9GULDK6NIlr681w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686422239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7WjIOv23GkoARnLqItYOF1clW2sOuIKmsM3GXO5Xpg=;
        b=S7g5PoBvQUVBSn498XvK9vJHSGy+5G3W0vpFYxeTng6YEJJyB4cAG/EGEkYC18Ui7RMwlG
        7oqYWL4zDKXltfCg==
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Usama Arif <usama.arif@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC 0/4] x86/fixmap: Unify FIXADDR_TOP
In-Reply-To: <20230608093303.GA16983@k08j02272.eu95sqa>
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
 <1f633e99-d294-6932-31e9-0eb158d030ea@intel.com>
 <20230608093303.GA16983@k08j02272.eu95sqa>
Date:   Sat, 10 Jun 2023 20:37:18 +0200
Message-ID: <87y1kr88pt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08 2023 at 17:33, Hou Wenlong wrote:
> On Wed, Jun 07, 2023 at 08:49:15PM +0800, Dave Hansen wrote:
>> What problems does this patch set solve?  How might that solution be
>> visible to end users?  Why is this problem important to you?
>
> We want to build the kernel as PIE and allow the kernel image area,
> including the fixmap area, to be placed at any virtual address.

You are still failing to tell us why you want that and which problem
this solves. Just that fact that you want to something is not an
argument.

> We have also implemented a PV Linux guest based on PIE, which can be
> used in software virtualization similar to Lguest. PIE makes the guest
> kernel share the host kernel space similar to a normal userspace
> process.  Additionally, we are considering whether it is possible to
> use PIE and PVOPS to implement a user-mode kernel.

That solves what?

Thanks,

        tglx
