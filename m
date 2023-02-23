Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836446A019C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjBWDva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjBWDv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:51:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4592F78A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:51:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMfG55sTQz4x7j;
        Thu, 23 Feb 2023 14:51:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677124286;
        bh=Jk12t1d/8CCUAhLuiUFLJlrM8fox37bxK3nSPYln3Jg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fHTt5AnV5s70i67q52BaKCDK25ED4ijqU7oaFL/XqxqbXHrW7SC0u37PocupIQjBQ
         t/bWkmDSsHBxZK9/KqXMw45i4aRRSkZkL7Nzn0THlIiSa1zr7DlRzy/fiAEVap2EF3
         J1yYnD+o3bP3ufaGayNeGo6YaEKLR9cOaLuKO0rqeXCuNR9d7HvFhWYUVwElkGY+y4
         n9XGjnGRLax8YgipEm3ZwJNHgoSxuYBpJNSV0m+5bm162sjTsbsLYe/dqrfeX/eJzN
         aimYhlDQivOf8/DrRo5YPhQWdOiezwV9Vc1/fUwEvDXv+gSbM1nvlGM5vYVxX8kAEg
         BCNqSGuV6WTMQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     paulmck@kernel.org, Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/powerpc/include/asm/barrier.h: redefine rmb and
 wmb to  lwsync
In-Reply-To: <20230222174719.GA1400185@paulmck-ThinkPad-P17-Gen-1>
References: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
 <20230222174719.GA1400185@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 23 Feb 2023 14:51:25 +1100
Message-ID: <87fsaxavk2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Wed, Feb 22, 2023 at 02:33:44PM +0530, Kautuk Consul wrote:
>> A link from ibm.com states:
>> "Ensures that all instructions preceding the call to __lwsync
>>  complete before any subsequent store instructions can be executed
>>  on the processor that executed the function. Also, it ensures that
>>  all load instructions preceding the call to __lwsync complete before
>>  any subsequent load instructions can be executed on the processor
>>  that executed the function. This allows you to synchronize between
>>  multiple processors with minimal performance impact, as __lwsync
>>  does not wait for confirmation from each processor."
>> 
>> Thats why smp_rmb() and smp_wmb() are defined to lwsync.
>> But this same understanding applies to parallel pipeline
>> execution on each PowerPC processor.
>> So, use the lwsync instruction for rmb() and wmb() on the PPC
>> architectures that support it.
>> 
>> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/barrier.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
>> index b95b666f0374..e088dacc0ee8 100644
>> --- a/arch/powerpc/include/asm/barrier.h
>> +++ b/arch/powerpc/include/asm/barrier.h
>> @@ -36,8 +36,15 @@
>>   * heavy-weight sync, so smp_wmb() can be a lighter-weight eieio.
>>   */
>>  #define __mb()   __asm__ __volatile__ ("sync" : : : "memory")
>> +
>> +/* The sub-arch has lwsync. */
>> +#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
>> +#define __rmb() __asm__ __volatile__ ("lwsync" : : : "memory")
>> +#define __wmb() __asm__ __volatile__ ("lwsync" : : : "memory")
>
> Hmmm...
>
> Does the lwsync instruction now order both cached and uncached accesses?

No.

> Or have there been changes so that smp_rmb() and smp_wmb() get this
> definition, while rmb() and wmb() still get the sync instruction?

No.

They come from:

include/asm-generic/barrier.h:#define rmb()        do { kcsan_rmb(); __rmb(); } while (0)
include/asm-generic/barrier.h:#define wmb()        do { kcsan_wmb(); __wmb(); } while (0)

> (Not seeing this, but I could easily be missing something.)

You are correct, the patch is wrong because it fails to account for IO
accesses.

Kautuk, I'm not sure what motivated you to look at these barriers, was
it just the documentation you linked to?

Maybe we need some better documentation in the kernel explaining why we
use the barriers we do?

Although there's already a pretty decent comment above the definitions,
but maybe it needs further clarification:

  /*
   * Memory barrier.
   * The sync instruction guarantees that all memory accesses initiated
   * by this processor have been performed (with respect to all other
   * mechanisms that access memory).  The eieio instruction is a barrier
   * providing an ordering (separately) for (a) cacheable stores and (b)
   * loads and stores to non-cacheable memory (e.g. I/O devices).
   *
   * mb() prevents loads and stores being reordered across this point.
   * rmb() prevents loads being reordered across this point.
   * wmb() prevents stores being reordered across this point.
   *
   * *mb() variants without smp_ prefix must order all types of memory
   * operations with one another. sync is the only instruction sufficient
   * to do this.
   *
   * For the smp_ barriers, ordering is for cacheable memory operations
   * only. We have to use the sync instruction for smp_mb(), since lwsync
   * doesn't order loads with respect to previous stores.  Lwsync can be
   * used for smp_rmb() and smp_wmb().


cheers
