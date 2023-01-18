Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35592672406
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjARQtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjARQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:49:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6099E37F0D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NoQkT4bAeFUtKhReQlXOayJmOIx8fi/SsB/fWlbrzXQ=; b=BZ1vl+eV0aBW85PIlSsd4uGqBn
        zc9sXI+JywLhi61h/6zxZmH5YXB+YjyJLjy3kJTCpZNv532AZv6O2seW9haxn5H3yUNdUB2sIi6xG
        wq8Eagx4eb7hsFFspIYUDGUr4WFEKICOhoh0mT2z053/9tXaMK+loxX5CKFrp/yu4PUP0OIAWccdZ
        RMYK9XXU7qBH4U17RS7XBBcFTPHqwkXxyAyTZeU6qOELe6Kc+dMD4k8qpgKqfVDgyHwQfXdIUmHcu
        rwhKR24bbsLqb2sUksVytStpMylNzI82SIls6q2BU/8Fk6Z3v0VwMDvEj+ncmvC8Oaal+hHaPbUAb
        1MMovObA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pIBc3-0002uG-0r;
        Wed, 18 Jan 2023 16:48:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE30230030F;
        Wed, 18 Jan 2023 17:48:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E7B720A68C2A; Wed, 18 Jan 2023 17:48:59 +0100 (CET)
Date:   Wed, 18 Jan 2023 17:48:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 01/17] x86/mm: Rework address range check in
 get_user() and put_user()
Message-ID: <Y8gi+/Y0qcjtRf6m@hirez.programming.kicks-ass.net>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-2-kirill.shutemov@linux.intel.com>
 <Y8gVJUDEFE5U7xAq@hirez.programming.kicks-ass.net>
 <CAHk-=wj4PDt_73n5rG9obkXrRQFcxN8vUhG6T9DipxozybH9_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4PDt_73n5rG9obkXrRQFcxN8vUhG6T9DipxozybH9_w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 07:59:21AM -0800, Linus Torvalds wrote:

> We don't silence it - for a kernel address that turns into an all-ones
> address, the the _ASM_EXTABLE() will still cause the -EFAULT due to
> the page fault.

> But it's not the high bit set case that is the problem here.

Yes, and the explicit bad_get_user jump would not print the message and
now with _UA removed it won't either (I seem to have my wires crossed
just now).

> The problem is a "positive" address that is non-canonical.
> 
> Testing against TASK_SIZE_MAX would catch non-canonical addresses
> before the access, and we'd return -EFAULT.
> 
> But now that we don't test against TASK_SIZE_MAX any more,
> non-canonical accesses will cause a GP fault, and *that* message is
> what we want to silence.

Right, but I was thinking that we'd explicitly allowed those because
with LAM enabled we'd actually accept those addresses.

> We'll still return -EFAULT, of course, we're just getting rid of the
> 
>         WARN_ONCE(trapnr == X86_TRAP_GP,
>                 "General protection fault in user access.
> Non-canonical address?");
> 
> issue that comes from not being so exact about the address limit any more.

Ah indeed, so for !LAM we'd now print the message were we would not
before (the whole TASK_SIZE_MAX+ range).

OK, agreed.
