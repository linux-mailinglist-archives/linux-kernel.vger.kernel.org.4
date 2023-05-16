Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C52705075
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjEPOU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjEPOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:20:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBA7ED9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:20:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684246809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=FkXFAZYIh0haPSOcnt1eOZKRDhLeWlVCTunLq/bj9vc=;
        b=B5v0P+HYuHs8awq1DZLsQ4kqlnyl0mhVnxUEkFVi9MqzUnYnNGkeqTxrNIotxSalBFC10+
        Hlw0xFA09mL3+td7bpsJferpf2xy8sfE9T26w7EHciXWaxM8cOR8rXGVJSR/BMgG9PUft9
        zdg1qqcpkMU6y1JYIuIRfudoedFcUqPqKt8WmYGPNM/NBZxO03Aky7h5dKqoVjTXiJ+QCg
        85jYUfWlWtAFrILeTDLw1N7e+G+aOt7CNIINPu9PO3ADmJxmHSykCBeixdH7HKJMuRcxO6
        aK0Vz4KlXz8wTPGFQsGU/c+hg/247pS2TaHn82bALtxNpRF3fyU6pe5/Khlz2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684246809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=FkXFAZYIh0haPSOcnt1eOZKRDhLeWlVCTunLq/bj9vc=;
        b=KVIg+5re+0nftM7WOpVd6795CiyX2EXG8Zw4zyBUZ1n/PoatUkzTue/l2YJ8qfmzO+OGGR
        ssOKcZ4Nhad2cABA==
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rtoax@foxmail.com, Rong Tao <rongtao@cestc.cn>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/vdso: Use non-serializing instruction rdtsc
In-Reply-To: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
Date:   Tue, 16 May 2023 16:20:09 +0200
Message-ID: <87ttwc73za.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rong!

On Tue, May 16 2023 at 14:52, Rong Tao wrote:
> Replacing rdtscp or 'lfence;rdtsc' with the non-serializable instruction
> rdtsc can achieve a 40% performance improvement with only a small loss of
> precision.

That rdtsc_ordered() is not there to achieve precision. It's there to
guarantee correctness. The correctness requirement is that reading clock
MONOTONIC is strictly monotonic, i.e. there is no way that you can
observe time going backwards. Neither locally nor accross CPUs.

As you explained:

> The RDTSC instruction is not a serializing instruction.  It does not
> necessarily wait until all previous instructions have been executed
> before reading the counter.

Q: What guarantees that this does not speculate deep enough to actually
   make time go backwards?

A: Nothing

Conclusion: The fence stays, unless you can prove the contrary under all
circumstances and microarchitecture generations.

Thanks,

        tglx

