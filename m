Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DF660F0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiJ0G5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiJ0G5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:57:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445855F7F7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bmGOTRQNqXiAnfYXVViubqg9EMcrf2AS5/y7ywnYk5g=; b=hX+Mya3PW77AK07QPItzJOONTQ
        eYl0D4zV8UzohuM5l1b3d+CjQNi6AbxRRBmeAcx0275MGoiRjCIxPYdvq8IQAycNX4fESpy78/7kJ
        ZNx0tPXAhe6eSwFtd2jQt5UVTnAL2MIHDYbwBhWPf59/rrfVk7YC6P/SWXpEuRhDz6x8dxgVlHvGi
        ZCez/E4myt0QX45d9uNfWOL+0uB1v5TsciADfFOZ8GYsLRvOxUdNwheLOubiN8qScVjltIW0gSh1D
        QnGN/WJzrdogFKNlj4hqtc1kgnT731YU3UVOLc7SmrYyZwa87rROOEVwOdX5lGfUQiEPHudYlJVcd
        IzYDY0qg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onwnY-00Haur-2U; Thu, 27 Oct 2022 06:55:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4922930010B;
        Thu, 27 Oct 2022 08:55:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2325929D8226C; Thu, 27 Oct 2022 08:55:22 +0200 (CEST)
Date:   Thu, 27 Oct 2022 08:55:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julian Pidancet <julian.pidancet@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/alternative: Consistently patch SMP locks in vmlinux
 and modules
Message-ID: <Y1orWktSbZy+wxtP@hirez.programming.kicks-ass.net>
References: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:42:37AM +0200, Julian Pidancet wrote:
> The alternatives_smp_module_add() function restricts patching of SMP
> lock prefixes to the text address range passed as an argument.
> 
> For vmlinux, patching all the instructions located between the _text and
> _etext symbols is allowed. That includes the .text section but also
> other sections such as .text.hot and .text.unlikely.
> 
> As per the comment inside the 'struct smp_alt_module' definition, the
> original purpose of this restriction is to avoid patching the init code
> which may have been deallocated when the alternatives code run.

It is not; init code is still around when we run alternatives.
