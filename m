Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989C27268B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjFGS3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFGS3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:29:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8560101
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:29:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686162573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vhANbTQxhW5giEgdQGefPD2Te4s/UC7F1qDEdOjzG0=;
        b=Mo7738aD+YotFaAvA5/ObujektbVcCYSas0zkHcEOWfQQrl8ZTc7i/g5UJWB/I7qd3aPpx
        D9IqLWq8iOUr1ZQqXlngl2cfBao8fNu4CGXKcpGjxggXz8HIfzDmo8h9tC//7H4DY4yI/g
        XQag2wldSYYM+/zTYUeIU22/CCMKNnrNQFMAYvEffPwFIY5450/eHdZ1quVfXMtlpfzkfm
        Xjb8T5mR1MBaMavj145MvDt1tuUUtB4EDj0IWGj8080CtI5KuD8T4VSfekn9sXObLqatQY
        /oNfNVpg7nj2VOqs5BMOldxSX1HC+9bjp7eFGMdHPj+7lZayUHPRYuHYvpk5eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686162573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vhANbTQxhW5giEgdQGefPD2Te4s/UC7F1qDEdOjzG0=;
        b=/h0BEeBYLORpbcZp0MX6wq1y2VNw6+Wea4DCG/vpqwQeLOBfgwkSRAUP4ZtqpiT3J0Wu21
        xKOnKuP3naVH45BQ==
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
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
In-Reply-To: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
Date:   Wed, 07 Jun 2023 20:29:32 +0200
Message-ID: <877csfjfcj.ffs@tglx>
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

On Mon, May 15 2023 at 16:19, Hou Wenlong wrote:

> This patchset unifies FIXADDR_TOP as a variable for x86, allowing the
> fixmap area to be movable and relocated with the kernel image in the
> x86/PIE patchset [0]. This enables the kernel image to be relocated in
> the top 512G of the address space.

What for? What's the use case.

Please provide a proper argument why this is generally useful and
important.

Thanks,

        tglx
