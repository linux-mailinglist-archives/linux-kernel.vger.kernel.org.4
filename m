Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE162BA19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiKPKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKPKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:50:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234E54E43D;
        Wed, 16 Nov 2022 02:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jsN0Nhr1vnvrb51t6eKNZY0+CFnpdn/XZ7+QR7DX9s8=; b=EBCdiiAnOXF07kYoDrH66f//Ij
        2uIWTl0SJZ9G9lybvILij454RhzCO1pdTBQu06PCCF+h3JxE0DlTOUrmGJxdBTAzSJZjR30QwDDXH
        N4HTfKs/rX4HXWl+Si5Uxsik6awEdetJQFP7oDr2UJf7PD6lv1GpC5JqW6SuioZ1+/gnqVMJQf+Sp
        x4bY8BlUPmNrsZwsc4CnFCqV1LpHUX1+9y5TBCaAGmsAxwUVxj1AVOB4Ks04mr3l/yv+I6z0yRhE1
        weWL9Vl8Z8ufAICDubbtmrjlyf63VRbXhrlWTVQ0EdpZVqIJQnMQiHZ29FDgDd9AWmDcNehBIsssn
        ziROuI/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovFpR-001H3H-Vx; Wed, 16 Nov 2022 10:39:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CC5E3008ED;
        Wed, 16 Nov 2022 11:39:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 492C3200E4A18; Wed, 16 Nov 2022 11:39:37 +0100 (CET)
Date:   Wed, 16 Nov 2022 11:39:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Guo Jin <guoj17@chinatelecom.cn>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking: Fix qspinlock/x86 inline asm error
Message-ID: <Y3S96d8vrEEQe1XH@hirez.programming.kicks-ass.net>
References: <20221108060126.2505-1-guoj17@chinatelecom.cn>
 <166859051534.4906.7078966677789928700.tip-bot2@tip-bot2>
 <64372250-a413-076e-3b6d-2d263ee9c7f2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64372250-a413-076e-3b6d-2d263ee9c7f2@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:40:10AM +0100, Juergen Gross wrote:
> On 16.11.22 10:21, tip-bot2 for Guo Jin wrote:
> > The following commit has been merged into the locking/urgent branch of tip:
> > 
> > Commit-ID:     23df39fc6a36183af5e6e4f47523f1ad2cdc1d30
> > Gitweb:        https://git.kernel.org/tip/23df39fc6a36183af5e6e4f47523f1ad2cdc1d30
> > Author:        Guo Jin <guoj17@chinatelecom.cn>
> > AuthorDate:    Tue, 08 Nov 2022 14:01:26 +08:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Wed, 16 Nov 2022 10:18:09 +01:00
> > 
> > locking: Fix qspinlock/x86 inline asm error
> > 
> > When compiling linux 6.1.0-rc3 configured with CONFIG_64BIT=y and
> > CONFIG_PARAVIRT_SPINLOCKS=y on x86_64 using LLVM 11.0, an error:
> > "<inline asm> error: changed section flags for .spinlock.text,
> > expected:: 0x6" occurred.
> > 
> > The reason is the .spinlock.text in kernel/locking/qspinlock.o
> > is used many times, but its flags are omitted in subsequent use.
> > 
> > LLVM 11.0 assembler didn't permit to
> > leave out flags in subsequent uses of the same sections.
> > 
> > So this patch adds the corresponding flags to avoid above error.
> > 
> > Fixes: 501f7f69bca1 ("locking: Add __lockfunc to slow path functions")
> > Signed-off-by: Guo Jin <guoj17@chinatelecom.cn>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/r/20221108060126.2505-1-guoj17@chinatelecom.cn
> 
> Wouldn't it be better to take my more generic patch [1] instead?
> 
> [1]: https://lore.kernel.org/lkml/20221109134418.6516-1-jgross@suse.com/

Durr, I missed that, lemme go stare at it.
