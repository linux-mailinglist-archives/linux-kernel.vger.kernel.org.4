Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7BD6A03CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjBWI1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjBWI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:27:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71584AFD5;
        Thu, 23 Feb 2023 00:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R1GIMlyP5PmQ6SSQoioYTffHvrdpX2DoA1X1TWCwifQ=; b=jS9dsEsb5Fd/0eEkO0zUtow29J
        o5wgECtpniTBjdA+Vb0yrmQPVKc2v8KOZHZTyVVbtgyaibYrMJU9ZBpGg+TMVh/IkLkWabfplx+Br
        tmO+FrxbsBNroteuBOZUTbZjhfgxSlWczot+KzJ8kZnWY43ZtNv0Ky68OTsKb2/X19u8lNwemqdeF
        Qi/AsX8fwFYr1FQOZCQgKZb6AE2hl1rNf86uTdhXvbKb4/OVH47bpyQQYIgZoiQj1H7vm/tTzl+tb
        mU0rS+kkPKl6pIQBaFJHMsj2q3uf2YsceGb70dXOQw62BFBSp+goy/3u4Go25kRBviu5U49H+kC1o
        2X2QkhFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV6wW-00ECNn-Jw; Thu, 23 Feb 2023 08:27:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 942BF30013F;
        Thu, 23 Feb 2023 09:27:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3025620831B67; Thu, 23 Feb 2023 09:27:07 +0100 (CET)
Date:   Thu, 23 Feb 2023 09:27:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Beeman Strong <beeman@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: Perf event to counter mapping question
Message-ID: <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
References: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 04:28:36PM -0800, Atish Patra wrote:

> AFAIK, ARM64 allows all-to-all mapping in pmuv3[1]. That makes life
> much easier. It just needs to pick the next available counter.
> On the other hand, x86 allows selective counter mapping which is
> discovered from the json file and maintained in per event
> constraints[4].

All the contraint management is done in kernel, and yes, it's a giant
pain in the rear side.

From what I understand the reason for these contraints is complexity of
implementation, less constraints is more 'wires' in the hardware.

With PMU use being ever more popular, we're seeing the x86 PMU move
towards less constraints -- although I don't think we'll ever get rid of
them :/

> 2. Mandate all-to-all mapping similar to ARM64.

If at all possible, I would strongly recommend taking this route. Yes,
the hardware people will complain, but newer x86 hardware having less,
or simpler, constraints might be sufficient to convince them.

(and if you do have to do contraints, please take a lesson from x86 and
 *never* allow overlapping contraints as AMD had, solving those
 constraints is not fun)

As you note, this is *much* simpler to program and virtualize.

> Note: This is only for programmable counters. If the platform supports
> any fixed counters (i.e. can monitor
> only a specific event), that needs to be provisioned via some other
> method. IIRC the fixed counters(apart from cycle) in ARM64 are part of
> AMU not PMU.

So free running counters are ideal and fairly simple to multiplex/use.

The moment you start adding overflow interrupts / filters and any other
complexities to fixed function counters it becomes a mess (look at the
x86 PMU again).
