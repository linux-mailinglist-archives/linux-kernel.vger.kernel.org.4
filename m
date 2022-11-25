Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A33638B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKYNop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKYNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:44:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB228E08
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:44:40 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CFBEE3F202
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669383878;
        bh=H7WgkO/jthnfYyqghB3+uZ02vDcS06QazZEvHsZ2tPA=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=K0frvN0ZRrrvJqtj2AVKiz7nrBpU0JlJBZyTZa++n4lRZBwJUvfJYHFqSm/iM8BqU
         iAN2ME+9noYvWs/l95IOFjMFgYxXycTdyJuS+/qJiBKa3yCYCmzIUpacoTvmKE5ppq
         aUBk/5lEgFvzHp/146lbwJpYmAsjE1ADrMUsDJf0ApA4JAuiTboyDpX5+HYldmpt3F
         R3j4JiZ+4OirHVIIKVU7r8uFeEOmbJqGz0Q/i7glV3yKMQVbtsNa20zMNmpAz0UYyN
         Bj9hiK716YfMrLvRTKpU+ZAQ+YPS9I9U0/WtU2ZVDsG7oqOCPErdBKPSxWU6Fql6vF
         LBC1tjrpzZAoQ==
Received: by mail-ed1-f72.google.com with SMTP id t4-20020a056402524400b004620845ba7bso2641539edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7WgkO/jthnfYyqghB3+uZ02vDcS06QazZEvHsZ2tPA=;
        b=qwlHQh3Tt7344oIZDvRg8M6zS2g3xb/XB/pab5mtW0VZdpIGwEz+ruGdshwh/9LNgC
         WImVU2DI7Wr3VhtWZ3/JRzwF49puCDW9SouUW3J8hmk0B2ugMMuACln81vdRQIH3MtdC
         f2fSJVbrWQSBIB2aDCjFa/0EH0qpVzXJvgfuxItps4tovdvg1ZEnHHxG7t4FYaMfmtSY
         F9HbvsHytf381ISAwwlvTdztD1GECxoi4ClfLZGwQXHBv7quxL4AwguABPe4Ws53RVZr
         fjmjHLOCGGKVHtsil0cPm6Sma5gA1lWGbiqmLvWlaeU0KXzGZJBvP48TEoarhul9E+vx
         a6qw==
X-Gm-Message-State: ANoB5pnZsmVd7FqiCuoHXgcnE44XQXjkXp9bqXjrN5MAPvGnzADgMEIu
        JNZ2hzVdyd2kfZ/p17J49mEsd98LnHV6+p1ma2vyQzI8Uy0tyEXaCUnDomq0T6KJxS5FmQsFDg1
        630L1nDNLcUZHhpLzS9jNhe4/nlQ58GGgTxMp/Bm0nw==
X-Received: by 2002:a17:906:5a9a:b0:7bc:26e:a259 with SMTP id l26-20020a1709065a9a00b007bc026ea259mr4681498ejq.445.1669383878543;
        Fri, 25 Nov 2022 05:44:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5C9lKruuxJCkUDFDDG9/Rf6eznqrgnehqdS7LMq93QVRBj4Qh1HwPA0xlZ3myltBwGs9wZMw==
X-Received: by 2002:a17:906:5a9a:b0:7bc:26e:a259 with SMTP id l26-20020a1709065a9a00b007bc026ea259mr4681482ejq.445.1669383878284;
        Fri, 25 Nov 2022 05:44:38 -0800 (PST)
Received: from localhost ([95.236.177.174])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090632da00b0073022b796a7sm1581335ejk.93.2022.11.25.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:44:37 -0800 (PST)
Date:   Fri, 25 Nov 2022 14:44:37 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: increase boot command line size to 1K
Message-ID: <Y4DGxWLIVx9p9TS+@righiandr-XPS-13-7390>
References: <20221125133713.314796-1-andrea.righi@canonical.com>
 <6fee29f8-8150-e6ec-e2ec-210610a7e27d@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fee29f8-8150-e6ec-e2ec-210610a7e27d@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 02:41:11PM +0100, Alexandre Ghiti wrote:
> Hi Andrea,
> 
> On 11/25/22 14:37, Andrea Righi wrote:
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
> > 
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >   arch/riscv/include/asm/setup.h      | 7 +++++++
> >   arch/riscv/include/uapi/asm/setup.h | 7 +++++++
> >   2 files changed, 14 insertions(+)
> >   create mode 100644 arch/riscv/include/asm/setup.h
> >   create mode 100644 arch/riscv/include/uapi/asm/setup.h
> > 
> > diff --git a/arch/riscv/include/asm/setup.h b/arch/riscv/include/asm/setup.h
> > new file mode 100644
> > index 000000000000..f4fe549aab40
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/setup.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __ASMRISCV_SETUP_H
> > +#define __ASMRISCV_SETUP_H
> > +
> > +#include <uapi/asm/setup.h>
> > +
> > +#endif /* __ASMRISCV_SETUP_H */
> > diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
> > new file mode 100644
> > index 000000000000..5738f93ae437
> > --- /dev/null
> > +++ b/arch/riscv/include/uapi/asm/setup.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _UAPI__ASMRISCV_SETUP_H
> > +#define _UAPI__ASMRISCV_SETUP_H
> > +
> > +#define COMMAND_LINE_SIZE 1024
> > +
> > +#endif /* _UAPI__ASMRISCV_SETUP_H */
> 
> 
> Just for reference to previous discussions regarding this: https://lore.kernel.org/lkml/CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com/T/
> 
> Thanks,
> 
> Alex

Ah! It has been address/discussed already, great! Thanks for pointing
that out and sorry for the unnecessary patch. :)

-Andrea
