Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E25FF938
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJOIwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJOIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 04:51:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41F554676
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 01:51:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665823914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vHvN68Hs+83uKVxPKQyBhce7aEycK7M1UbIuAC9XP8=;
        b=sCf5T6EeZ0LrsM3G2PsA8IPJ3PX9di5bdbTNS7x1axdaRfkZO9BWASK6QCRwfjZ23RL6IM
        5vw4RqNFVydImSlJG1NCagT64qMONJocCs4QciWKLG/PD5LIU9IXIWAyDrZofLhVVGVBoW
        WMPiuTkNz+lwJwuasMGQJefGKuSghVYG5xaUEeaGqpcxCfXIaVg2IWGL+IzrvwbtO1M77y
        c3KQx7Ux1tdjaCq6urAUhsojlXIOjUwOTV5+G9VG56BeG2F1hXM+5dZjA63eqgcLcDq5DB
        9LbFFuis/hSWuz90mCpv7TfEFsBI385L+SVW05GECqvuAj3upCcfDNd+ekKA7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665823914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vHvN68Hs+83uKVxPKQyBhce7aEycK7M1UbIuAC9XP8=;
        b=wNv8qqj3U0GJIRJe0zxQcdZNz9P9zNVKcAlWiJ8x4qpNIIpZC1guCMhx8VdhS9gcMge4Fi
        E78hATLzTWRL79BA==
To:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, brgerst@gmail.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v3 4/6] x86/gsseg: move local_irq_save/restore() into
 asm_load_gs_index()
In-Reply-To: <20221013200134.1487-5-xin3.li@intel.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
 <20221013200134.1487-5-xin3.li@intel.com>
Date:   Sat, 15 Oct 2022 10:51:54 +0200
Message-ID: <8735bpbhat.ffs@tglx>
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

On Thu, Oct 13 2022 at 13:01, Xin Li wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>
> The need to disable/enable interrupts around asm_load_gs_index() is a
> consequence of the implementation. Prepare for using the LKGS
> instruction, which is locally atomic and therefore doesn't need
> interrupts disabled.

*Shudder*. We want less ASM not more.

>  static inline void native_load_gs_index(unsigned int selector)
>  {
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
>  	asm_load_gs_index(selector);
> -	local_irq_restore(flags);
>  }

static inline void native_load_gs_index(unsigned int selector)
{
	unsigned long flags;

        if (cpu_feature_enabled(LKGS)) {
              native_lkgs(selector);
        } else {
	      local_irq_save(flags);
              asm_load_gs_index(selector);
	      local_irq_restore(flags);
       }
}

For paravirt enabled kernels we want during feature detection:

        if (cpu_feature_enabled(LKGS)))
        	pv_ops.cpu.load_gs_index = native_lkgs;

No?

Thanks,

        tglx
