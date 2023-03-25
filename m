Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97AD6C8CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 10:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjCYJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCYJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:29:03 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A0F1554D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yRk/ApQWm/ArcYvgFX2+C9zNPXO/rwgU6YDyXi/+Frs=;
  b=c/Mpa9+u7LZgntI+gaA0py9BhDZqeIKC6OzTKuwUb1jM2dV+/MDtkfyZ
   bH+41G7ByuU93uhOEAkAsLtYhOVSli0gX5pZlqWKf/9yN2G4hvwEwNzWW
   orxSIQ1dYgeu34kJ99WFtbXwAIuGZvw/Sb+sJ9Gr1BHkhwnKP7aemBYRK
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51220213"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:28:58 +0100
Date:   Sat, 25 Mar 2023 10:28:58 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Alex Elder <elder@ieee.org>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
In-Reply-To: <ZB61rbl68LfGCosV@kroah.com>
Message-ID: <alpine.DEB.2.22.394.2303251025330.2833@hadrien>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com> <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org> <alpine.DEB.2.22.394.2303212140480.2919@hadrien> <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org> <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
 <48674d8f-9753-780c-f37c-f83ea2855ae6@ieee.org> <eabacc6f-c7fb-ff33-26d1-271537fb4760@inria.fr> <ZBvcWkpMJnxea78L@kroah.com> <alpine.DEB.2.22.394.2303230807130.2866@hadrien> <ZB61rbl68LfGCosV@kroah.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Mar 2023, Greg KH wrote:

> On Thu, Mar 23, 2023 at 10:52:35AM +0100, Julia Lawall wrote:
> >
> >
> > On Thu, 23 Mar 2023, Greg KH wrote:
> >
> > > On Wed, Mar 22, 2023 at 11:00:41AM +0100, Julia Lawall wrote:
> > > > Greg raised the question of whether the inline function is really as
> > > > efficient as a macro.
> > > >
> > > > I tried the following definitions:
> > > >
> > > > #define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > >
> > > > static inline struct gbphy_device *extra_to_gbphy_dev(const struct device *_dev)
> > > > {
> > > >        return container_of(_dev, struct gbphy_device, dev);
> > > > }
> > > >
> > > > And the following uses:
> > > >
> > > > ssize_t macro_protocol_id_show(struct device *dev,
> > > >                                 struct device_attribute *attr, char *buf)
> > > > {
> > > >         struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
> > > >
> > > >         return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
> > > > }
> > > > ssize_t extra_protocol_id_show(struct device *dev,
> > > > 				struct device_attribute *attr, char *buf)
> > > > {
> > > >         struct gbphy_device *gbphy_dev = extra_to_gbphy_dev(dev);
> > > >
> > > >         return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
> > > > }
> > > >
> > > > They are a little bit different to avoid too much compiler optimization.
> > > >
> > > > After doing make drivers/staging/greybus/gbphy.s, I get similar looking
> > > > code in both cases:
> > > >
> > > > Macro version:
> > > >
> > > >         .type   macro_protocol_id_show, @function
> > > > macro_protocol_id_show:
> > > >         endbr64
> > > > 1:      call    __fentry__
> > > >         .section __mcount_loc, "a",@progbits
> > > >         .quad 1b
> > > >         .previous
> > > >         pushq   %rbp    #
> > > >         movq    %rdx, %rbp      # tmp96, buf
> > > >         pushq   %rbx    #
> > > > # drivers/staging/greybus/gbphy.c:40: {
> > > >         movq    %rdi, %rbx      # tmp95, dev
> > > > # drivers/staging/greybus/gbphy.c:43:   return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
> > > >         call    __sanitizer_cov_trace_pc        #
> > > > # drivers/staging/greybus/gbphy.c:43:   return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
> > > >         movq    -32(%rbx), %rax # MEM[(struct gbphy_device *)dev_7(D) + -40B].cport_desc, MEM[(struct gbphy_device *)dev_7(D) + -40B].cport_desc
> > > > # drivers/staging/greybus/gbphy.c:43:   return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
> > > >         movzbl  0(%rbp), %edx   # *buf_9(D), *buf_9(D)
> > > >         movq    %rbp, %rdi      # buf,
> > > >         movq    $.LC18, %rsi    #,
> > > >         movzbl  3(%rax), %ecx   # _1->protocol_id, _1->protocol_id
> > > >         call    sprintf #
> > > > # drivers/staging/greybus/gbphy.c:44: }
> > > >         movl    $13, %eax       #,
> > > >         popq    %rbx    #
> > > >         popq    %rbp    #
> > > >         jmp     __x86_return_thunk
> > > >         .size   macro_protocol_id_show, .-macro_protocol_id_show
> > > >
> > > > Function version:
> > > >
> > > >         .type   extra_protocol_id_show, @function
> > > > extra_protocol_id_show:
> > > >         endbr64
> > > > 1:      call    __fentry__
> > > >         .section __mcount_loc, "a",@progbits
> > > >         .quad 1b
> > > >         .previous
> > > >         pushq   %rbp    #
> > > >         movq    %rdx, %rbp      # tmp96, buf
> > > >         pushq   %rbx    #
> > > > # drivers/staging/greybus/gbphy.c:47: {
> > > >         movq    %rdi, %rbx      # tmp95, dev
> > > > # drivers/staging/greybus/gbphy.c:50:   return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
> > > >         call    __sanitizer_cov_trace_pc        #
> > > > # drivers/staging/greybus/gbphy.c:50:   return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
> > > >         movq    -32(%rbx), %rax # MEM[(struct gbphy_device *)dev_8(D) + -40B].cport_desc, MEM[(struct gbphy_device *)dev_8(D) + -40B].cport_desc
> > > > # drivers/staging/greybus/gbphy.c:50:   return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
> > > >         movzbl  0(%rbp), %ecx   # *buf_9(D), *buf_9(D)
> > > >         movq    %rbp, %rdi      # buf,
> > > >         movq    $.LC19, %rsi    #,
> > > >         movzbl  3(%rax), %edx   # _3->protocol_id, _3->protocol_id
> > > >         call    sprintf #
> > > > # drivers/staging/greybus/gbphy.c:51: }
> > > >         movl    $13, %eax       #,
> > > >         popq    %rbx    #
> > > >         popq    %rbp    #
> > > >         jmp     __x86_return_thunk
> > > >         .size   extra_protocol_id_show, .-extra_protocol_id_show
> > > >
> > > > Both seem to access the memory directly.  Maybe the example is too simple,
> > > > and the compiler is more likely to optimize aggressively?
> > >
> > > Nice, that shows that it is the same both ways as the compiler version
> > > you are using is smart enough
> > >
> > > Which compiler and version is this?  Does it work the same for all of
> > > the supported versions we have to support (i.e. really old gcc?)
> >
> > gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> >
> > I got a similar result for gcc-5:
> >
> > macro_protocol_id_show:
> > 1:      call    __fentry__
> >         .section __mcount_loc, "a",@progbits
> >         .quad 1b
> >         .previous
> >         movq    %rdx, %rax      # buf, buf
> >         movq    -32(%rdi), %rdx # MEM[(struct gbphy_device *)dev_1(D) + -40B].cport_desc, MEM[(struct gbphy_device *)dev_1(D) + -40B].cport_desc
> >         movq    $.LC19, %rsi    #,
> >         movq    %rax, %rdi      # buf,
> >         movzbl  3(%rdx), %ecx   # _3->protocol_id, D.44996
> >         movzbl  (%rax), %edx    # *buf_6(D), D.44996
> >         call    sprintf #
> >         cltq
> >         jmp     __x86_return_thunk
> >         .size   macro_protocol_id_show, .-macro_protocol_id_show
> >         .section        .text.unlikely
> > .LCOLDE20:
> >         .text
> > .LHOTE20:
> >         .section        .rodata.str1.1
> > .LC21:
> >         .string "extra 0x%02x %c\n"
> >         .section        .text.unlikely
> > .LCOLDB22:
> >         .text
> > .LHOTB22:
> >         .p2align 6,,63
> >         .globl  extra_protocol_id_show
> >         .type   extra_protocol_id_show, @function
> > extra_protocol_id_show:
> > 1:      call    __fentry__
> >         .section __mcount_loc, "a",@progbits
> >         .quad 1b
> >         .previous
> >         movq    %rdx, %rax      # buf, buf
> >         movzbl  (%rdx), %ecx    # *buf_3(D), D.45003
> >         movq    -32(%rdi), %rdx # MEM[(struct gbphy_device *)dev_2(D) + -40B].cport_desc, MEM[(struct gbphy_device *)dev_2(D) + -40B].cport_desc
> >         movq    $.LC21, %rsi    #,
> >         movq    %rax, %rdi      # buf,
> >         movzbl  3(%rdx), %edx   # _6->protocol_id, D.45003
> >         call    sprintf #
> >         cltq
> >         jmp     __x86_return_thunk
> >         .size   extra_protocol_id_show, .-extra_protocol_id_show
> >         .section        .text.unlikely
>
> Ah nice!  Thanks for checking.
>
> Ok, so it's not a performance issue at all either way, compilers are
> smarter than we think :)

I would imagine that the inline would happen first, and then all of the
normal optimizations would apply.  Given that the function has an inline
keyword and is very simple, there is no reason for the inlining not to
happen.  Naive inlining might introduce new variables for the parameters,
but though should be easy for the compiler to get rid of in such a simple
case.

So intuitively it should be ok.

julia



>
> > > For the most part, sysfs files are not on any sort of "fast path" so a
> > > function call is fine, but as I mentioned before, sometimes we are
> > > forced to move calls to container_of() to container_of_const() and that
> > > can not be an inline function, but must remain a macro :(
> >
> > It seems that this is because there is not a unique return type, but not a
> > performance issue?
>
> Yes, container_of_const() will return a different type (const or not)
> depending on what is passed into it.  This allows the "const-ness" of a
> pointer to be kept across the call, while as container_of() will always
> cast away the const which can be dangerous if you don't know what you
> are doing.
>
> thanks,
>
> greg k-h
>
