Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E15672418
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjARQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjARQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:50:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EEF5587
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bQAktCDQ6e/+wYFLFQt0v+4fjsz4txk9HXgCMtL6FbQ=; b=asK/2f3GS3R5f8TGamIVSQG9h4
        OsikbWR4SWAueNkXv1oKDgL79gJNHYBq0E1YfeFXyrA2XlR1DZyxm3Zw+sfio8MW8N+aOnITlLoiw
        CAfkxsSY85E9/AZaP0RCnYuZpf3u7160C0p109rBR65GFMEqYdJPD4+JvDb8zjpOv/QvaUgt8G9Se
        i9OYX9YGpJPEFHp8njhltVkKAeK+jFYJ321z2BJUDB5+O/a0bMb/Jm62yfC0SCn/Yxm0yJCG8NQKu
        PAZel7QaAFyFJ4ml9dB/Ja0oIr5JLi2+ywnOx8OuZaYv90N3cm41kbJhiID2cX5/c5PVy1QxbpcB6
        93dl5Ggw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIBdO-0009hz-AO; Wed, 18 Jan 2023 16:49:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEF53300094;
        Wed, 18 Jan 2023 17:49:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D01BB20A68C2A; Wed, 18 Jan 2023 17:49:56 +0100 (CET)
Date:   Wed, 18 Jan 2023 17:49:56 +0100
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
Subject: Re: [PATCHv14 00/17] Linear Address Masking enabling
Message-ID: <Y8gjNAxBCYfbwAry@hirez.programming.kicks-ass.net>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 03:37:19PM +0300, Kirill A. Shutemov wrote:

> Kirill A. Shutemov (12):
>   x86/mm: Rework address range check in get_user() and put_user()
>   x86: Allow atomic MM_CONTEXT flags setting
>   x86: CPUID and CR3/CR4 flags for Linear Address Masking
>   x86/mm: Handle LAM on context switch
>   mm: Introduce untagged_addr_remote()
>   x86/uaccess: Provide untagged_addr() and remove tags before address
>     check
>   x86/mm: Provide arch_prctl() interface for LAM
>   x86/mm: Reduce untagged_addr() overhead until the first LAM user
>   mm: Expose untagging mask in /proc/$PID/status
>   iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
>   x86/mm/iommu/sva: Make LAM and SVA mutually exclusive

+- the static_branch() thing,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
