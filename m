Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3474D815
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjGJNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjGJNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D68C1B3;
        Mon, 10 Jul 2023 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MttSIBFDzxo+w4PFW3J7ZDj+Lub8j7ffKGXirDBsatA=; b=UYobBqUdV751cNMlhoG7PQe8Wf
        VgghfAe2GDPkENOs6/OBmeZwI3a1JHQPudBFW849/wJh2Str9PC0rEoAtKf93kqmaX/PZ96ZcwFKf
        x3iHKezvRBU1GeZsJfqyESrNX0kMji3hMiXVi2x9lrHybRAwdvcpsecOt3ULqPw71EFpUYOz/SaR/
        xvus7ag9nr7PhkAIHjbmZeV4bWQg/qBbnq7b87sU/qy9clQZjRo7NnV3kbUhUcxj2wY15StSHutJc
        dkV0utIhHfvpI2F4IqcLO/zA0JrGfFXWXFUJLMreck7WuzJIVLHfBdNtmeu0TisAkpH6Lh6rVXrDO
        bOIXHE3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIrDa-00EeDT-QW; Mon, 10 Jul 2023 13:46:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C67630017D;
        Mon, 10 Jul 2023 15:46:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 664DE29984D3B; Mon, 10 Jul 2023 15:46:21 +0200 (CEST)
Date:   Mon, 10 Jul 2023 15:46:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] x86: kprobes: Fix CFI_CLANG related issues
Message-ID: <20230710134621.GC3034907@hirez.programming.kicks-ass.net>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168899125356.80889.17967397360941194229.stgit@devnote2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 09:14:13PM +0900, Masami Hiramatsu (Google) wrote:

> I just build tested, since I could not boot the kernel with CFI_CLANG=y.
> Would anyone know something about this error?
> 
> [    0.141030] MMIO Stale Data: Unknown: No mitigations
> [    0.153511] SMP alternatives: Using kCFI
> [    0.164593] Freeing SMP alternatives memory: 36K
> [    0.165053] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b
> [    0.166028] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.2-00002-g12b1b2fca8ef #126
> [    0.166028] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [    0.166028] Call Trace:
> [    0.166028]  <TASK>
> [    0.166028]  dump_stack_lvl+0x6e/0xb0
> [    0.166028]  panic+0x146/0x2f0
> [    0.166028]  ? start_kernel+0x472/0x48b
> [    0.166028]  __stack_chk_fail+0x14/0x20
> [    0.166028]  start_kernel+0x472/0x48b
> [    0.166028]  x86_64_start_reservations+0x24/0x30
> [    0.166028]  x86_64_start_kernel+0xa6/0xbb
> [    0.166028]  secondary_startup_64_no_verify+0x106/0x11b
> [    0.166028]  </TASK>
> [    0.166028] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b ]---
> 
> 

Hmm, I just build v6.4 using defconfig+kvm_guest.config+CFI_CLANG using
clang-16 and that boots using kvm... (on my IVB, and the thing also
boots natively on my ADL).

I'll go have a look at your patches shortly.
