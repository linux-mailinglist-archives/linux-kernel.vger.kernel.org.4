Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AFE6CD369
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjC2HiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjC2Hhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:37:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563874ED3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:35:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o32so8294329wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680075338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tb//YDVUmszU3HNKDs7zRNHGdvp2WswWGNo1xYLl49k=;
        b=btxz4X7mi144ytdCdyjcDvmeXuljdwVW3fU5zn5YfnfuTrHFrI+p6APnH4mRMnN7SC
         8gctq+qrbaNiJ0PhVwg+SGjTLLeZ1tZDUUAso30YkbYvhEJO8GDJdQdf/Y3Z0fO947vX
         6UXc9gLGoAeiF556Aiom0/yK5s+mW6aL1mfOqzrhart9Qbk+Ku/0lQUBviTA7uDz6P5C
         nkgd0KYXSGFDea2fvcqaL9yReEXgZ5xLBzawZeejqbD0FRITVhrUcRFym+V5CSjteEtU
         Ycom5LOgeyf1toe6pAEVEgbI0JvJOUgvwkjZFzBkIhMcA7JqYHaAIl2bg/OtG2hsf/Fu
         fRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tb//YDVUmszU3HNKDs7zRNHGdvp2WswWGNo1xYLl49k=;
        b=vd8HJBTJCQ5TdKhNpRAxUhY3qntRLbGd9muvQ45VHP+uZNX/5rb/ncwdoRQu+6L/2i
         Z5FxVtX9MSa1lS4wLmMZwRKhL0q8dARvnn8ol4qNDzwpRg7UdCkY9GebX+g78cC3gkiD
         qQB4NIPGRe2C3kZa2YVGfb1w75WpFn6veCm+7RakI+aGR92YZyd3LPPvnOWYTju7yB0+
         D5oFWao0S6kJK+6T+ZdH8qDzYoPZCKA5aLLRWMys2FAmO0FEQyAx+jk5za2YOjSLk8fe
         56bdQ3X4C9ZvUrDrsQPaPz46x/qRQIQjsFH6HB00EwVq8L52Lf2w8PPi/5b7i9Jf1/Z7
         6ABw==
X-Gm-Message-State: AAQBX9e2adslIBnWY9OUs1rFSEkRG1cOfZyJan3ysL0fwG+6Y/OAEM+m
        5CCxpzHUjfwpbRG58AUd5gkS239zLjfUhTfs4quIdw==
X-Google-Smtp-Source: AKy350a+DVwXzR1171GYdtWnoFYic/UYA525fZ5ISoocG8RHpGIl1lm1Y4OfeO/xsnQVh7981UqLgddYWPJ3fUDjdJQ=
X-Received: by 2002:a7b:cb8c:0:b0:3ef:6dfc:916d with SMTP id
 m12-20020a7bcb8c000000b003ef6dfc916dmr2410999wmi.7.1680075337829; Wed, 29 Mar
 2023 00:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230327115642.1610-1-cuiyunhui@bytedance.com>
 <d7111158-7e17-4c88-a8c1-a568db5891fa@spud> <CAEEQ3wkKr9NhKwo0O3D=pfi80j7-cup3VgaWuk8vdk87=ryy6g@mail.gmail.com>
 <747a3382-17e7-4167-a1bb-30a9482be4d1@spud>
In-Reply-To: <747a3382-17e7-4167-a1bb-30a9482be4d1@spud>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Wed, 29 Mar 2023 15:35:26 +0800
Message-ID: <CAEEQ3wm4Ax4v63QVb7NtQp=-HxbKZNAUsQwevBzDs3sX4+pu9w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv/fault: Dump user opcode bytes on
 fatal faults
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Mar 29, 2023 at 2:25=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:

>
> Right, I'm trying to figure out of this is another bug in the kernel -
> if you don't have "fd" in riscv,isa in your devicetree then, even if
> CONFIG_FPU is set, none of the FPU code is meant to run, right?

yeah, CONFIG_FPU is set.
In the problem I encountered, the init to be executed in user mode
contained floating-point instructions, which caused an exception.


> What would be nice to have is what the new show_opcodes() function will
> look like ;)

After printing the contents of __show_regs(), this line will continue
to be printed:
Opcode: 53 80 02 f0

It is not just the problem I encountered. When the process exits
unexpected, we all want to know what the instruction that caused the
process exception is.

Thanks,
Yunhui
