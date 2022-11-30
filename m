Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B9863D970
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiK3PaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiK3P36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:29:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E544537E0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:29:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669822193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hawNiGlCtzlPbrpiS85xbPkk5wst6Kv4FnQMrTfD5Oo=;
        b=t1oQij+RMdPhxm5R/tOuxXVA1Qn9l6vSpLsGNjxHaWs0VmBU6soaboEv54cr5eqnXvuyw/
        qqwKWmgygTbCv+8TlhISSEwzVP6R9gRRH1oUPDzbLSvvGQMnJF/Mc0RiI3/inSQkjU6EEl
        UuXN87yFyLWAghpoR+8u3P/Ol92urMA9NwaHhX69GLQzbyKLH9JO/bK75Yo8iLtyxlFHfr
        f/Fq/u+jLDO3jqHyXPLJbn5uNOkLzvOm8ttQjA+qm2lG5VYUmB78RVVDGxLoCuUZFDkcPS
        sdZT6hf3Xj9jm2LiGHDKncSRZbxET3bykorZHJUOi1aqXWNy7Jo6ocSXz/8HGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669822193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hawNiGlCtzlPbrpiS85xbPkk5wst6Kv4FnQMrTfD5Oo=;
        b=aR2w1zintC6AmJ45sscxSsf+n7s9tReVK44wAKqS6gNTvk/bQgVBjeH3vx1Fswl9Ws+TOI
        6/yGn/F0O2a32rCw==
To:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] genirq: Simplify cond_unmask_eoi_irq()
In-Reply-To: <87edtkts5p.ffs@tglx>
References: <20221126234134.32660-1-samuel@sholland.org>
 <20221126234134.32660-2-samuel@sholland.org> <87edtkts5p.ffs@tglx>
Date:   Wed, 30 Nov 2022 16:29:52 +0100
Message-ID: <87a648tq8f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30 2022 at 15:48, Thomas Gleixner wrote:
> On Sat, Nov 26 2022 at 17:41, Samuel Holland wrote:
>> +	    (desc->istate & IRQS_ONESHOT) && !desc->threads_oneshot)
>>  		unmask_irq(desc);
>
> This breaks the mask logic of handle_fasteoi_mask_irq() for an interrupt
> which does not have IRQS_ONESHOT set.

Ignore this one. That handler is broken by design.
