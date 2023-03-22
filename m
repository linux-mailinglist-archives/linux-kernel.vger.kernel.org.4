Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0C56C471D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCVKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCVKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:00:46 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC66A4E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sHYBsf4pz/+39iaVsZ7mpbeyKqvZZpry99CXK++F6wk=;
  b=sbPCOMmnZWv1F6u85uIPJZ9XQoYo8Gi1FS6WySkiwd1sIOOlaCYnODpo
   9J+hQ+a/d0sHHqMMKxYYtY6GiVz6zCssT02RsVgN7uaSCU+Yu7Q85gr8J
   mAl3eLVQrHqgwTIz4d0wE0t95FPskP/XDYhkS7EgHpLGFqZU1IoIwfVca
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,281,1673910000"; 
   d="scan'208";a="98464634"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 11:00:41 +0100
Date:   Wed, 22 Mar 2023 11:00:41 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Alex Elder <elder@ieee.org>
cc:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
In-Reply-To: <48674d8f-9753-780c-f37c-f83ea2855ae6@ieee.org>
Message-ID: <eabacc6f-c7fb-ff33-26d1-271537fb4760@inria.fr>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com> <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org> <alpine.DEB.2.22.394.2303212140480.2919@hadrien> <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org> <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
 <48674d8f-9753-780c-f37c-f83ea2855ae6@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg raised the question of whether the inline function is really as
efficient as a macro.

I tried the following definitions:

#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)

static inline struct gbphy_device *extra_to_gbphy_dev(const struct device *_dev)
{
       return container_of(_dev, struct gbphy_device, dev);
}

And the following uses:

ssize_t macro_protocol_id_show(struct device *dev,
                                struct device_attribute *attr, char *buf)
{
        struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);

        return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
}
ssize_t extra_protocol_id_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
        struct gbphy_device *gbphy_dev = extra_to_gbphy_dev(dev);

        return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
}

They are a little bit different to avoid too much compiler optimization.

After doing make drivers/staging/greybus/gbphy.s, I get similar looking
code in both cases:

Macro version:

        .type   macro_protocol_id_show, @function
macro_protocol_id_show:
        endbr64
1:      call    __fentry__
        .section __mcount_loc, "a",@progbits
        .quad 1b
        .previous
        pushq   %rbp    #
        movq    %rdx, %rbp      # tmp96, buf
        pushq   %rbx    #
# drivers/staging/greybus/gbphy.c:40: {
        movq    %rdi, %rbx      # tmp95, dev
# drivers/staging/greybus/gbphy.c:43:   return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
        call    __sanitizer_cov_trace_pc        #
# drivers/staging/greybus/gbphy.c:43:   return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
        movq    -32(%rbx), %rax # MEM[(struct gbphy_device *)dev_7(D) + -40B].cport_desc, MEM[(struct gbphy_device *)dev_7(D) + -40B].cport_desc
# drivers/staging/greybus/gbphy.c:43:   return sprintf(buf, "%c macro 0x%02x\n", *buf, gbphy_dev->cport_desc->protocol_id);
        movzbl  0(%rbp), %edx   # *buf_9(D), *buf_9(D)
        movq    %rbp, %rdi      # buf,
        movq    $.LC18, %rsi    #,
        movzbl  3(%rax), %ecx   # _1->protocol_id, _1->protocol_id
        call    sprintf #
# drivers/staging/greybus/gbphy.c:44: }
        movl    $13, %eax       #,
        popq    %rbx    #
        popq    %rbp    #
        jmp     __x86_return_thunk
        .size   macro_protocol_id_show, .-macro_protocol_id_show

Function version:

        .type   extra_protocol_id_show, @function
extra_protocol_id_show:
        endbr64
1:      call    __fentry__
        .section __mcount_loc, "a",@progbits
        .quad 1b
        .previous
        pushq   %rbp    #
        movq    %rdx, %rbp      # tmp96, buf
        pushq   %rbx    #
# drivers/staging/greybus/gbphy.c:47: {
        movq    %rdi, %rbx      # tmp95, dev
# drivers/staging/greybus/gbphy.c:50:   return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
        call    __sanitizer_cov_trace_pc        #
# drivers/staging/greybus/gbphy.c:50:   return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
        movq    -32(%rbx), %rax # MEM[(struct gbphy_device *)dev_8(D) + -40B].cport_desc, MEM[(struct gbphy_device *)dev_8(D) + -40B].cport_desc
# drivers/staging/greybus/gbphy.c:50:   return sprintf(buf, "extra 0x%02x %c\n", gbphy_dev->cport_desc->protocol_id, *buf);
        movzbl  0(%rbp), %ecx   # *buf_9(D), *buf_9(D)
        movq    %rbp, %rdi      # buf,
        movq    $.LC19, %rsi    #,
        movzbl  3(%rax), %edx   # _3->protocol_id, _3->protocol_id
        call    sprintf #
# drivers/staging/greybus/gbphy.c:51: }
        movl    $13, %eax       #,
        popq    %rbx    #
        popq    %rbp    #
        jmp     __x86_return_thunk
        .size   extra_protocol_id_show, .-extra_protocol_id_show

Both seem to access the memory directly.  Maybe the example is too simple,
and the compiler is more likely to optimize aggressively?

julia
