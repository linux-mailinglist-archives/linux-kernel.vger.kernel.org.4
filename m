Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A1675868
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjATPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjATPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:21:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38502DA127
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tWhqBqeds6M5kvB9paMMJ8Ql2m2pownIzTjbJavhOlc=; b=f7Fu/nIjdc8hxAhFw2solrt8I4
        cxb2BlesCm92jZX8/skmtcYPAJgKRS7qV9Fq4J9ox2jmXXsHvmlh7fHvBkScs9JdxLHxIgCDpnvyp
        doTZIkfLt5VyQ8gIIg/ccb+96ilZaVzjy1ENd7+KcN9px1YdPfd9GGRN7hmgbDX+wTj6sp7Iv1PPb
        vJ96ZJ1mZDfSAZyUsvN3Ly39bNAK1JM6KVCN5WwRAuhmMkeab0DjmC1gHTuLpm2bgC88xvjVkgNRD
        TZtYtGnzrp8y6Jw3PrdvktW/FfUlvtZbc6LAMjujpsbPZmDkIF59f7LEMjLWc2kymzMruB8k7k9tC
        7CjWPHfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pItCT-002446-OT; Fri, 20 Jan 2023 15:21:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11C28300033;
        Fri, 20 Jan 2023 16:21:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35C962016471C; Fri, 20 Jan 2023 16:21:03 +0100 (CET)
Date:   Fri, 20 Jan 2023 16:21:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] exit: Detect and fix irq disabled state in oops
Message-ID: <Y8qxX4iZUZYOaCD0@hirez.programming.kicks-ass.net>
References: <20230120011820.2664120-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120011820.2664120-1-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:18:20AM +1000, Nicholas Piggin wrote:
> If a task oopses with irqs disabled, this can cause various cascading
> problems in the oops path such as sleep-from-invalid warnings, and
> potentially worse.
> 
> Since commit 0258b5fd7c712 ("coredump: Limit coredumps to a single
> thread group"), the unconditional irq enable in coredump_task_exit()
> will "fix" the irq state to be enabled early in do_exit(), so currently
> this may not be triggerable, but that is coincidental and fragile.
> 
> Detect and fix the irqs_disabled() condition in the oops path before
> calling do_exit(), similarly to the way in_atomic() is handled.
> 
> Link: https://lore.kernel.org/lkml/20221004094401.708299-1-npiggin@gmail.com/
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Hi Peter,
> 
> Would you consider taking this through the sched tree?

Yep, can do, let me go queue it.
