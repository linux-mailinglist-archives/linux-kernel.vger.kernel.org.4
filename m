Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437DF6194C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKDKp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81BA2654F;
        Fri,  4 Nov 2022 03:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69A47B82CE3;
        Fri,  4 Nov 2022 10:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94640C433D6;
        Fri,  4 Nov 2022 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667558752;
        bh=YG5QT5BrT2Dix6/bR0a1msXZLUcIJS7O9PLridmy2gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKqyFHkYIrPG98emsiHE+lF6OzSSvMIH3EaSFQnHU6R6A/ouXNGcvI/t55q7AkG/c
         /3htPAi2U8zyHrzEcwpiXlXVppoxkeB6PDZQk7BnWumf58QM6xA3stORTsJrhpGALZ
         dHSZOYJsvZZZkYUe+AYu6/1dRWzmSqvvFw+Cs5F8=
Date:   Fri, 4 Nov 2022 11:45:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kunbo Zhang <absoler@smail.nju.edu.cn>
Cc:     dmitry.torokhov@gmail.com, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] input: i8042 - fix a double-fetch vulnerability
 introduced by GCC
Message-ID: <Y2TtXAW1LhOwlE64@kroah.com>
References: <20221104072347.74314-1-absoler@smail.nju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104072347.74314-1-absoler@smail.nju.edu.cn>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:23:47PM +0800, Kunbo Zhang wrote:
> We found GCC (at least 9.4.0 and 12.1) introduces a double-fetch of `i8042_ports[I8042_AUX_PORT_NO].serio` at drivers/input/serio/i8042.c:408.
> 
> One comparison of the global variable `i8042_ports[I8042_AUX_PORT_NO].serio` has been compiled to three ones,
> and thus two extra fetches are introduced.

And what problem does this cause?

> As in the source code, the global variable is tested (at line 408) before three assignments of irq_bit, disable_bit and port_name.
> However, as shown in the following disassembly of i8042_port_close(), 
> the variable (0x0(%rip)) is fetched and tested three times for each 
> assignment of irq_bit, disable_bit and port_name.

There should not be any problem with this as that value does not ever
change except in rare cases (shutdown or init).

> 
> 0000000000000e50 <i8042_port_close>:
> i8042_port_close():
> ./drivers/input/serio/i8042.c:408
>      e50:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # first load
> ./drivers/input/serio/i8042.c:403
>      e57:	41 54                   push   %r12
> ./drivers/input/serio/i8042.c:408
>      e59:	b8 ef ff ff ff          mov    $0xffffffef,%eax
>      e5e:	49 c7 c4 00 00 00 00    mov    $0x0,%r12
> ./drivers/input/serio/i8042.c:403
>      e65:	55                      push   %rbp
> ./drivers/input/serio/i8042.c:408
>      e66:	48 c7 c2 00 00 00 00    mov    $0x0,%rdx
> ./drivers/input/serio/i8042.c:419
>      e6d:	be 60 10 00 00          mov    $0x1060,%esi
> ./drivers/input/serio/i8042.c:403
>      e72:	53                      push   %rbx
> ./drivers/input/serio/i8042.c:408
>      e73:	bb df ff ff ff          mov    $0xffffffdf,%ebx
>      e78:	0f 45 d8                cmovne %eax,%ebx
>      e7b:	0f 95 c0                setne  %al
>      e7e:	83 e8 03                sub    $0x3,%eax
>      e81:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # second load
>      e88:	40 0f 94 c5             sete   %bpl
>      e8c:	83 c5 01                add    $0x1,%ebp
>      e8f:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # third load
> ./drivers/input/serio/i8042.c:419
>      e96:	48 c7 c7 00 00 00 00    mov    $0x0,%rdi
> ./drivers/input/serio/i8042.c:408
>      e9d:	4c 0f 45 e2             cmovne %rdx,%r12
> 
> We have not found any lock protection for the three fetches of `i8042_ports[I8042_AUX_PORT_NO].serio` yet.
> If the value of this global variable is modified concurrently among the three fetches, the corresponding assignment of 
> disable_bit or port_name will possibly be incorrect.

When can that modification happen?

And if you really want to protect it, use the existing lock in the
structure, don't manually attempt to place calls to barrier(), that will
not work, sorry.

thanks,

greg k-h
