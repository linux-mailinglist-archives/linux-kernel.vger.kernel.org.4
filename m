Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4567222B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjARPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjARPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:53:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63653B1D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jP8Fr6MlbMMjd8lIYq+Vp79w4vg/s3Wf0pcdTIx4qDE=; b=MoQkuL37B2+b7WYJ1xAEOmL8rN
        WqVWIVHp/L8/FMWDkPRjcSWDEdbS6e6Pl0Fa9Q33tvk/VZNoO0C1/FSauVwgI5A7cK/xa6id0Sxqf
        5Ps78va3nbGyMVH0ppiMGsk2R+emHHe9AE3wFoyXqF1FQxDKikJc25fgwxgaxl28ANaVv6nkdnlvc
        QkSWyjFuNwg2Blc4d2sAXdWf0bJ4Sp7dbtnFH7KN8Ek5Y/a8WfxxUoi+Xq6G/+COIeLvINHZwjcDa
        wCF0HEWJ6W1Edxh/bxwUDq9XLv5jYtMqoxnq65RW/lCMuPvlArz4nqfgkHfhbUyID+Yssn5c/TAFL
        3HtHax+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pIAgu-0002C7-0E;
        Wed, 18 Jan 2023 15:49:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B864C30006D;
        Wed, 18 Jan 2023 16:49:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CBAC20F42661; Wed, 18 Jan 2023 16:49:57 +0100 (CET)
Date:   Wed, 18 Jan 2023 16:49:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
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
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 01/17] x86/mm: Rework address range check in
 get_user() and put_user()
Message-ID: <Y8gVJUDEFE5U7xAq@hirez.programming.kicks-ass.net>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111123736.20025-2-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 03:37:20PM +0300, Kirill A. Shutemov wrote:
> The functions get_user() and put_user() check that the target address
> range resides in the user space portion of the virtual address space.
> In order to perform this check, the functions compare the end of the
> range against TASK_SIZE_MAX.
> 
> For kernels compiled with CONFIG_X86_5LEVEL, this process requires some
> additional trickery using ALTERNATIVE, as TASK_SIZE_MAX depends on the
> paging mode in use.
> 
> Linus suggested that this check could be simplified for 64-bit kernels.
> It is sufficient to check bit 63 of the address to ensure that the range
> belongs to user space. Additionally, the use of branches can be avoided
> by setting the target address to all ones if bit 63 is set.
> 
> There's no need to check the end of the access range as there's huge
> gap between end of userspace range and start of the kernel range. The
> gap consists of canonical hole and unused ranges on both kernel and
> userspace sides.

So far I can follow, however

> If an address with bit 63 set is passed down, it will trigger a #GP
> exception. _ASM_EXTABLE_UA() complains about this. Replace it with
> plain _ASM_EXTABLE() as it is expected behaviour now.

here I don't. The new logic basically squishes every kernel address to
-1L -- a known unmapped address, but getting that address in
{get,put}_user() is still a fail, right?

We used to manually branch to bad_get_user when outside TASK_SIZE_MAX,
now we rely on #GP.

So why silence it?

