Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83868F636
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBHR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBHR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:56:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD886A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:56:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m2so20215427plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG/WkXZTAUlwvzHLZNVpvm8mQ39tyKfuQBX/kYBdkgw=;
        b=iiBzhEUvmFJRwoF+qVJzvzPb7b8rRGARPABcPQV9sI4+/QVnESZ4GsLPIO36w7l2wg
         wT1eHSfgxM/KFitaFrhB2cISovXV6b9GKnrJDBM8UkJbgBhS4/GgZ5MZhfkAaY/SLINf
         rTdStWKVdAwm7Xeo4+MdmGhI10NXBzeLoZUKbGaU9owSnrCg3IIyIHWXtwlQj9RKlf2l
         PKF/mhpK5uuqZlzvp810QvLvlglRPeDw6LT/0uyh+PsIOPiLTFSIzpM8qHn09C+72xcm
         ZwGEo0hdy3opgPTtQBn6+zyTSJj2gM3z9r5zm9Smzl+b5MGGVthl9/lHp1C3X03wrYNT
         KLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG/WkXZTAUlwvzHLZNVpvm8mQ39tyKfuQBX/kYBdkgw=;
        b=c1u2cEz/K4lGsQMS6zbLpUv410i/LQSuPgBhY2S8do0gWmoKlxXWBX4FLas2x3dlfC
         SuZNiPpWSrtLpVbG2gKu5616XjLiZuccG7+apxUdQXNi1NA94ZkDLAU/3eGmcKyEYva1
         ra3va6q6pVKA9mc9o3EAK57TzGOWt1syO7a5EQr3cpsImIp/4L39s9EVgYbbmIpl0lM0
         ZyeQOw0TJBJJOlkT9YRr92p2Qc1kKbzbQjldELirzsyfA9NWURPNJa9IeCDcAz00Qdua
         zLRb0Gn5WyBz0tOUSi4XM8MAUDjOI/YIw2N760g1ZZn+bGCJsk/E7/b6I5+/eP2voKdH
         rcPw==
X-Gm-Message-State: AO0yUKUvN9CrYwr5ia0OxTz3pBJKGnwv71B0XtLIs4WXX/TvS1BK1jwR
        QB7GIf3YRN1NqS9kIM16aPRbQg==
X-Google-Smtp-Source: AK7set+IvKf9JG8iTJHj7qXU2eE80ms2QI7mR9bDPaVSOxfo071drYvo75zvCNHaOlO+nG1YOZKYdw==
X-Received: by 2002:a17:902:e545:b0:199:60:b9c8 with SMTP id n5-20020a170902e54500b001990060b9c8mr10269320plf.45.1675878968150;
        Wed, 08 Feb 2023 09:56:08 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902b18c00b001949f21e1d2sm11208714plr.308.2023.02.08.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:56:06 -0800 (PST)
Date:   Wed, 08 Feb 2023 09:56:06 -0800 (PST)
X-Google-Original-Date: Wed, 08 Feb 2023 09:56:04 PST (-0800)
Subject:     Re: [PATCH] riscv: avoid enabling vectorized code generation
In-Reply-To: <20221216185012.2342675-1-abdulras@google.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        abdulras@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     abdulras@google.com
Message-ID: <mhng-4c71ada6-003c-414f-9a74-efa3ccd2856b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 10:50:12 PST (-0800), abdulras@google.com wrote:
> The compiler is free to generate vectorized operations for zero'ing
> memory.  The kernel does not use the vector unit on RISCV, similar to
> architectures such as x86 where we use `-mno-mmx` et al to prevent the
> implicit vectorization.  Perform a similar check for
> `-mno-implicit-float` to avoid this on RISC-V targets.
>
> Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> ---
>  arch/riscv/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0d13b597cb55..68433476a96e 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
>  # architectures.  It's faster to have GCC emit only aligned accesses.
>  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>
> +# Ensure that we do not vectorize the kernel code when the `v` extension is
> +# enabled.  This mirrors the `-mno-mmx` et al on x86.
> +KBUILD_CFLAGS += $(call cc-option,-mno-implicit-float)
> +
>  ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
>  prepare: stack_protector_prepare
>  stack_protector_prepare: prepare0

Sorry to just restart the thread, but there's been discussions on this 
in a bunch of places.  From my understanding, we don't actually need 
this: we have this tricky line in the Makefile

    KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))

that removes the floating-point extenions from what the kernel is built 
with, so adding `-mno-implicit-float` doesn't actually do anything (and 
we'd end up with essentially the same thing for V when it gets added).

So unless I'm missing something, we don't need this.
