Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B736F71F377
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFAUNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFAUNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:13:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB16D1;
        Thu,  1 Jun 2023 13:13:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685650409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhqYS2lyDFfuoa88kODGtonbyEtHNG3TXqkVpEvaQl8=;
        b=PGlHMojZjN/9GkSbz2rHDfnwxnlRvrOxaaLVJunjL9LP8LHNGsxTaALStcWxUxIi8sdJX8
        lqvT3ilMtpVyNXbpQeqU81GEIRUGIPEklrKJKr5YEgd7xaLFHSyZz/zdHQWZaBJnzTb4Dd
        I8AEhgdqt2QnVwEIx+HzhdQIjKHNiXWzDTJ2uWIC/vh6X+GcLfc+cOx5jpLsSuuY7AwlXq
        TQKRmBK2E5db9IpX6/1KXh7U0yhsB6Ok2fxS7jdrnS/SM3YhPnKeIl8EqPhZKtBnN9zDvX
        w709Is3z8nO4YgoJ41KJ5VOx+pGJkACicnoqZLXtsfM07ekiRkGNjUeZALfsHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685650409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhqYS2lyDFfuoa88kODGtonbyEtHNG3TXqkVpEvaQl8=;
        b=xleRV+bWpbXMbVWK7dfSAyfJ/A8lvCBKqJk3V6HyfWibUAieNU5VU48PDtqZp09tXaj8ag
        6rd61mxCICbDZ6CQ==
To:     Steven Noonan <steven@uplinklabs.net>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
In-Reply-To: <871qivdjui.ffs@tglx>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <87mt1jeax1.ffs@tglx> <87h6rrdoy0.ffs@tglx>
 <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
 <871qivdjui.ffs@tglx>
Date:   Thu, 01 Jun 2023 22:13:29 +0200
Message-ID: <87y1l3c55i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2023 at 22:10, Thomas Gleixner wrote:
>
> So back to the options:
>
>    1) Kernel
>
>       If at all then this needs to be disabled by default and enabled by
>       a command line option along with a big fat warning that it might
>       disable TSC for timekeeping and bug reports related to this are
>       going to be ignored.
>
>       Honestly I'm not too interested in this. It's yet another piece of
>       art which needs to be maintained and kept alive for a long time.
>
>       The fact that we need to check for synchronized TSCs in the first
>       place is hillarious already. TSC_ADJUST makes the resynchronization
>       attempt at least halfways sensible.
>
>       Without it, it's just a pile of never going to be correct
>       heuristics with a flood of "this fixes it for my machine (and
>       breaks the rest)" patches.
>
>
>    2) Binary patching
>
>       Unfortunately RDTSC is only a two byte instruction, but there are
>       enough advanced binary patching tools to deal with that.
>
>       It might be a completely crazy idea, but I wouldn't dismiss it
>       before trying.

Duh. Hit send too early

     3) Virtualization

        Obviously not trivial either but definitely workable.

Thanks,

        tglx
