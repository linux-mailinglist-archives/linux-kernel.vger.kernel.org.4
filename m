Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5058D638ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKYNGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKYNGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:06:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8022A721
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cT9CmU4G/iTklh8gvbyY9gc4Hlspi/IDJIjKcXZ6R4Y=; b=p3l051gzlJ/KQMesewvZYX+WTV
        9wjihaqT4mnunOatI6i7VlQMGP9dyrPU8BewBFGDYDyezGEUVGEoxWn0YkNNWS07zpRDwZ1h3coYn
        l/rnfYWPSkS5L5x4lgqN4SAVeCXB+QtJTsb2n0uPcOAlZnL1jjjO8EMscGwMu4S/F2W7CqIbQXwbh
        NrEdPserHUx6jblOTkF4dGUsciZo1Z+PH0USg4bJ5TQf5WlKIPOg5rGyLQkOh3o+EdSFT0hmg43uF
        V5576KOtXnMsMC6dK4VCn6JryCaIafssugqPwM8n7TnY0ioVF/BwJAOAiSpe680se9Gatr8bgfysK
        uL6Dc07w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oyYPo-009b6I-66; Fri, 25 Nov 2022 13:06:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04AA6300110;
        Fri, 25 Nov 2022 14:06:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD8C62024B86B; Fri, 25 Nov 2022 14:06:40 +0100 (CET)
Date:   Fri, 25 Nov 2022 14:06:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     jpoimboe@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] About UNWIND_HINT_ENTRY on entry_SYSCALL_64.
Message-ID: <Y4C94LluYLGcf1Wt@hirez.programming.kicks-ass.net>
References: <CAM7-yPTWs8J6sGjcyDrRsXu5APDHm5Kr19G500y=72=FwYCq3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPTWs8J6sGjcyDrRsXu5APDHm5Kr19G500y=72=FwYCq3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:41:46PM +0900, Yun Levi wrote:
> Hello.
> 
> While I try to see the information related to ORC in vmlinux,
> I'm trying to find out ORC information related to entry_SYSCALL_64's address.
> 
> For this, I've tried to take the following step:
>     1. booting the kernel with the "nokaslr" option.
>     2. Getting ORC information by "objdump orc dump vmlinux"
>     3. cat /proc/kallsyms and check the address of "entry_SYSCALL_64"
>           - In my kernel, It's address .text + a00000
>     4. Find out related ORC entry gotten in step 2.
> 
> But, I couldn't find the reason why entry_SYSCALL_64's orc info isn't
> encoded with end =1.
> Instead, It was encoded as INVALID ORC entry like:
> 
>   .text+a00000: sp:(und) bp:(und) type:call end:0
> 
> IIUC, Some of the code is started with UNWIND_HINT_ENTRY or UNWIND_HINT_EMPTY,
> it should be encoded with end = 1. But it doesn't.
> 
> Am I wrong?

$ readelf -Ws defconfig-build/vmlinux.o | grep entry_SYSCALL_64
178466: 0000000000000029     0 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64_safe_stack
188596: 0000000000000000   422 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64
210374: 0000000000000038     0 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64_after_hwframe

$ readelf -WS defconfig-build/vmlinux.o | grep "\[18\]"
[18] .entry.text       PROGBITS        0000000000000000 e59f00 001838 00  AX  0   0 64

$ tools/objtool/objtool --dump=orc defconfig-build/vmlinux.o | grep ".entry.text+0"
.entry.text+0: sp:(und) bp:(und) type:call end:1


