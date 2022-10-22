Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1560608DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJVOlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:41:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056414D1E3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DBUn2IB/WL8hSq2BF6b5f2QkDBxX+FNfBmYGQ4qJjHQ=; b=HiTI4aylcoj8Mlz7LPaOgUiQ2B
        vITwbdVg098srIBUUEZJXYL++GnEg1eJ0+M/0X6WaEBKxrBJX2X8CKBH6tCiWZJNUCtTvdN9W2pFB
        LBWChNzZejJMbXkpHbmdPFgHzs9GnUJh2T/4DnHBnOCQOI0KA6QBfUf8a82HtLPAQy/nX49zkgU0i
        RyS+WAeAKt+YlFl88dtn7JOW/wcYDulZ/zTkMFUtZNUsbbFbxNSc9sPiEianbsImt7axCeOB9jxor
        VEnMaWO3W3LDI2GzTYzL2lBt9+ZYtJDcZqasnm0Ga7kkhBkXB9a6s5XG0SRSl2RWNHwK3V250w112
        7YuP/ykg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omFfj-005ZZa-Ki; Sat, 22 Oct 2022 14:40:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0008230035C;
        Sat, 22 Oct 2022 16:40:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9E742C30ED60; Sat, 22 Oct 2022 16:40:21 +0200 (CEST)
Date:   Sat, 22 Oct 2022 16:40:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Seth Jenkins <sethjenkins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/mm] x86/mm: Randomize per-cpu entry area
Message-ID: <Y1QA1RhqBYMkyEc8@hirez.programming.kicks-ass.net>
References: <20221022000010.1802-1-hdanton@sina.com>
 <dbc0ad82-28dc-a7c5-8973-4ddae671a2ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc0ad82-28dc-a7c5-8973-4ddae671a2ae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:56:02PM -0700, Dave Hansen wrote:
> On 10/21/22 17:00, Hillf Danton wrote:
> >> -#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
> >> +#ifdef CONFIG_X86_32
> >> +#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU +		\
> >> +					 (CPU_ENTRY_AREA_SIZE * NR_CPUS) -	\
> >> +					 CPU_ENTRY_AREA_BASE
> > My vi editor finds un-paired bracket here.
> > Feel free to ignore it if nothing hurt.
> 
> Thanks for finding that!  Looks like Peter and I need to dust off our
> 32-bit .configs!
> 
> I just fixed the issue and pushed a new commit out to tip/x86/mm.

Pff, I've had this commit exposed to 0day for a while, you'd think it
would scream. Then again, maybe it got lost in the email firehose :/
