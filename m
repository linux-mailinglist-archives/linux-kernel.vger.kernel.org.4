Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC5639821
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKZTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKZTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:18:48 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF7F584
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:18:47 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E66E93F1C2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 19:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669490324;
        bh=3jItt0ash3hJiki2QJADtgoIkp7l1vksCPuWqsHPOEA=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=FN4gjz8e8sQLVUrWbPu86i4T03ksrdFdV91C+9eF8Rt/40VOJJwRe+qOYGul2wYpn
         hA7Erk3CUzN12/xZB4SLlxWO4PPKMfBSlJajCZEiip2zBaVGvfvn9Llv+16YJNbm0s
         0qN5FwbtJqeguhm/ZNk0ozNYu+JoR8h0rrgkoOUtj1vGcxxGtouGKY0uper0omtTH3
         gNYdcRgj35z8Mrb0QcpsOLFzumXNRDVe4k/8Dv7escHJcfitq6IGa8/HhDeakT9v0Q
         yWsEeNPcYj1yg3MqsOZsURmQ7vDNPykHJrPXWmE6o3gz++SqHBmMu0k+i5NIulbcD1
         CsSTXWfhS4VPw==
Received: by mail-ed1-f72.google.com with SMTP id m13-20020a056402510d00b0046913fa9291so4378128edd.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jItt0ash3hJiki2QJADtgoIkp7l1vksCPuWqsHPOEA=;
        b=kTJmVS6zbwbGi2S0hZGZKvX+Rs2ZiubwnbTdOKZaZWjhc9CjdAKLp9dflHblhuq71Z
         /u/C0q6zHTjFkmEXcRwZrGUG588VfB4g4oSqOf04dEktSvY+8jM2Vwaghs19a8qienBS
         PqVd12rmyyb4lsobo6ViR1pwYpaZJwgnUMHbcvoR0CvIguZlmnjTwZAeZitw6TJK0ABA
         DCSEGC51RSKap+TQQILXz3oSgcvxsn/MEe9oMz6qK+h9Ymd6I2G4aLFgXSI2NXJ5QdMs
         Jcj7BUEQLqxsnk93sx7wDMMlGExLASEdeExXldUpwMf9JxhiaiwGnmsK+nxamHJ8SNp6
         SI2A==
X-Gm-Message-State: ANoB5pnhHsgGfFJl664fwM3pqLHSigMUHh3tnFwawUMaiwEgFyYFCHuf
        vyCJW7kHXPH/BRRp26FwukK4N0wSlt+zZp5Be2m/uFfap+tTd4T+ONa5qTlekerNx1/IcILlSR/
        sV16/4F/JL2ICG8juvFGt8Xf0AbuqHTZRNl42ojB8dw==
X-Received: by 2002:a05:6402:5010:b0:467:60bd:41a1 with SMTP id p16-20020a056402501000b0046760bd41a1mr41669394eda.97.1669490324457;
        Sat, 26 Nov 2022 11:18:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4eQn2h60P7KFREvb4hY60Hz7Uxi+cxQKbGlNYDp2XAebbhV4E/WIex/WNPH9L1Kw7thsUSOA==
X-Received: by 2002:a05:6402:5010:b0:467:60bd:41a1 with SMTP id p16-20020a056402501000b0046760bd41a1mr41669384eda.97.1669490324251;
        Sat, 26 Nov 2022 11:18:44 -0800 (PST)
Received: from localhost ([95.236.177.174])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906385500b0077a201f6d1esm2971541ejc.87.2022.11.26.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 11:18:43 -0800 (PST)
Date:   Sat, 26 Nov 2022 20:18:43 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: increase boot command line size to 1K
Message-ID: <Y4Jmk74enBTwkNcR@righiandr-XPS-13-7390>
References: <20221125133713.314796-1-andrea.righi@canonical.com>
 <Y4Je7chN+fQM3NpP@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Je7chN+fQM3NpP@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 06:46:05PM +0000, Conor Dooley wrote:
> Hey Andrea,
> 
> On Fri, Nov 25, 2022 at 02:37:13PM +0100, Andrea Righi wrote:
> > Kernel parameters string is limited to 512 characters on riscv (using
> > the default from include/uapi/asm-generic/setup.h).
> > 
> > In some testing environments (e.g., qemu with long kernel parameters
> > string) we may exceed this limit, triggering errors like the following:
> > 
> > [    3.331893] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> > [    3.332625] CPU: 2 PID: 1 Comm: sh Not tainted 6.1.0-rc6-kc #1
> > [    3.333233] Hardware name: riscv-virtio,qemu (DT)
> > [    3.333550] Call Trace:
> > [    3.333736] [<ffffffff800062b6>] dump_backtrace+0x1c/0x24
> > [    3.334053] [<ffffffff806e8f54>] show_stack+0x2c/0x38
> > [    3.334260] [<ffffffff806f2d06>] dump_stack_lvl+0x5a/0x7c
> > [    3.334483] [<ffffffff806f2d3c>] dump_stack+0x14/0x1c
> > [    3.334687] [<ffffffff806e92fa>] panic+0x116/0x2d0
> > [    3.334878] [<ffffffff8001b0aa>] do_exit+0x80a/0x810
> > [    3.335079] [<ffffffff8001b1d0>] do_group_exit+0x24/0x70
> > [    3.335287] [<ffffffff8001b234>] __wake_up_parent+0x0/0x20
> > [    3.335502] [<ffffffff80003cee>] ret_from_syscall+0x0/0x2
> > [    3.335857] SMP: stopping secondary CPUs
> > [    3.337561] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000 ]---
> > 
> > It seems reasonable enough to increase the default command line size to
> > 1024, like arm, to prevent issues like the one reported above.
> 
> error: arch/riscv/include/uapi/asm/setup.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
> 
> Unfortunately this does not build :/
> 
> Thanks,
> Conor.

Oh I see, because it's uapi it needs "WITH Linux-syscall-note",
wondering why I can't reproduce this failure...

Anyway, as pointed out by Alexandre, there was already a previous
discussion about this topic:
https://lore.kernel.org/lkml/CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com/T/

Hopefully this change will be addressed there (and the patch land in
-next at least), otherwise I'll post a v2.

Thanks,
-Andrea
