Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893306033CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJRUJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJRUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:09:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF33B6364
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lnPn1mTO9DAs3/JRBAGmlox/yW19ieXwL+1OwP5OX3g=; b=C2tZ/hbLN8QbQp2Z2BzOsz220s
        aofzLcS5AMJPFQusf0lQdZJUhRZ2YivmKAGuOfNK+eMb2/j49CkoSjc5q6ZxVZIWs406AHFgsmU2x
        QX1TUy0Icuysvc4qwrAMBn5KFemB+JCnMvU9MQMC5z8y3cwAVUEDt6HjPT72Pdh5HNVjmWctG495Q
        4ZJXU7QO6Hv0GCZYePcVlgxA23bi+k9TQhyJhzAl5ToGF8buE8fojdddRE/6KNpm1Ut7bADyu8Mtr
        IK6jzxX8mm3Cf9bA2XWtn0wJ9OCA/Ij29SEtOI6451rYYqS8KvCHtNIYeeU58zMHo3HXPkGb5EkWu
        V55qLXDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okstx-004ZAS-6N; Tue, 18 Oct 2022 20:09:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24D4830008D;
        Tue, 18 Oct 2022 22:09:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09CB82C0A0313; Tue, 18 Oct 2022 22:09:24 +0200 (CEST)
Date:   Tue, 18 Oct 2022 22:09:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210181020.79AF7F7@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:

> > +#ifdef CONFIG_FINEIBT
> > +/*
> > + * kCFI						FineIBT
> > + *
> > + * __cfi_\func:					__cfi_\func:
> > + *	movl   $0x12345678,%eax			     endbr64			// 4
> 
> kCFI emits endbr64 here first too ...
> 
> > + *	nop					     subl   $0x12345678,%r10d   // 7
> > + *	nop					     jz     1f			// 2
> > + *	nop					     ud2			// 2
> > + *	nop					1:   nop			// 1
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop

It does not; it does emit ENDBR at the start of the regular symbol
though:

0000000000001040 <__cfi_yield>:
1040:       b8 0c 67 40 a5          mov    $0xa540670c,%eax
1045:       90                      nop
1046:       90                      nop
1047:       90                      nop
1048:       90                      nop
1049:       90                      nop
104a:       90                      nop
104b:       90                      nop
104c:       90                      nop
104d:       90                      nop
104e:       90                      nop
104f:       90                      nop

0000000000001050 <yield>:
1050:       f3 0f 1e fa             endbr64
1054:       e8 00 00 00 00          call   1059 <yield+0x9> 1055: R_X86_64_PLT32    __fentry__-0x4
1059:       65 48 8b 05 00 00 00 00         mov    %gs:0x0(%rip),%rax        # 1061 <yield+0x11>    105d: R_X86_64_PC32     pcpu_hot-0x4
1061:       31 c9                   xor    %ecx,%ecx
1063:       87 48 18                xchg   %ecx,0x18(%rax)
1066:       e9 00 00 00 00          jmp    106b <yield+0x1b>        1067: R_X86_64_PLT32    .text+0xc08c
106b:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

Not doing that is an option...


> Tangent: why are these nop instead of 0xcc? These bytes aren't executed
> ever are they?

Because that's what the compiler gets us through -fpatchable-function-entry.


