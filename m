Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9880B6BA788
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCOGKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCOGK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:10:28 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B55B41B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:10:27 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 644683F201
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678860626;
        bh=qMeoUKhYzDgnizP/GQ28Ev1EYvBAg9BQEuvFR6NeagM=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=AUzD4Vp5hZW8ip2KmLv9lnb5oSuEQzkWdh+LK3/sM9t3K2cmE2MFiDXMk650PtSvl
         mElF6GaSOVVOg12BCJaXzYfOFEkb66WMxAdY5aEi5v3wfdXFP5fa9c5Wyc3s6lG+Ci
         tGks7751+axvGgqKC/Dakt8Z6seq6MCaibt9ZtYLQFpV1Q3CDvjopgLuXmOiplFo0z
         99/TgYnoQmf4Djb4EfIWTBTxm1sRuCF0oDV0GCt19Z6ACnxtqNv51sP4IdaeGqeqPX
         1yXGUXj89BA7uDyVGC6UVQkB6t6qy/4Yvx/e5wGuVv8Q2hzBe/Ws6QXtID3qlJCDvC
         N3VuBsNmr4Uqg==
Received: by mail-ed1-f69.google.com with SMTP id en6-20020a056402528600b004fa01232e6aso16800045edb.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678860626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMeoUKhYzDgnizP/GQ28Ev1EYvBAg9BQEuvFR6NeagM=;
        b=cRDoGIKGczacWB7X5N9vGM75ocMERMDgizril6XQ1yAYW/b8c3Voswk0MgaclY9NrW
         O7xy60MICe/dCsCDmglrLGhS1NYmw7LpkqmCiLmwQ+DQmv2NbaWQSIb7rtefhffYTRXh
         /9FKGfGrfjBjoIZllNB/28xano98tgTEZGhdFP7G4hUImVv/XfhCMJWcytNVkZJ0w/hU
         3lS1ypQSYVkNH+pt7LodDCjKBDrQjIvrc3A1kwbiHRty7deB85RE2y55SznBaxXwjFeY
         R+0I6dWp/bzu9THuJM9semwzSFg54k8SakEZNORAuY6SQJe3bPNvMUVeDpDBISph5/bT
         Fy2w==
X-Gm-Message-State: AO0yUKUas+At2Y+SylAenyS9tGEVh3Df5qnB12MMk83Avvu9F3Obv7Vv
        HXKkkjjv3i9BlrkXiIy69WqQrew7G9dEYk3FFEkfmd4mf2LdSfOI7rb035CYsbZIEqwTWSjbsBp
        ZNjMSyI24M/c97MaLBz5yEFW+tjKh1ulDVB22QLKTug==
X-Received: by 2002:a17:906:5d16:b0:87b:d2b3:67ca with SMTP id g22-20020a1709065d1600b0087bd2b367camr5884288ejt.75.1678860626031;
        Tue, 14 Mar 2023 23:10:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Lssfla0yupVlH322DngUHEvV18c7m/g5JbvnjN5WZYfVNUjJiiQxIZIPUM0DZytL7yheCaw==
X-Received: by 2002:a17:906:5d16:b0:87b:d2b3:67ca with SMTP id g22-20020a1709065d1600b0087bd2b367camr5884268ejt.75.1678860625751;
        Tue, 14 Mar 2023 23:10:25 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id y4-20020a170906558400b008bfe95c46c3sm2003469ejp.220.2023.03.14.23.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:10:25 -0700 (PDT)
Date:   Wed, 15 Mar 2023 07:10:24 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: boot regression on ppc64 with linux 6.2
Message-ID: <ZBFhUAlL+1ZVKcwQ@righiandr-XPS-13-7390>
References: <ZA7oJr1/Z4vzWy4N@righiandr-XPS-13-7390>
 <878rfyofma.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rfyofma.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 02:30:53PM +1100, Michael Ellerman wrote:
> Andrea Righi <andrea.righi@canonical.com> writes:
> > I'm triggering the following bug when booting my qemu powerpc VM:
> 
> I'm not seeing that here :/
> 
> Can you give a bit more detail?
>  - qemu version
>  - qemu command line
>  - what userspace are you using?
>  - full dmesg of the failing case

Yeah, ignore this for now, it could be related to another custom patch
that I had applied (and forgot about it sorry), this one:
https://lore.kernel.org/lkml/20230119155709.20d87e35.gary@garyguo.net/T/

That is causing other issues on ppc64, so I think it might be related to
that, I'll do more tests making sure I use a vanilla kernel.

Sorry for the noise.

-Andrea

> 
> > event-sources: Unable to request interrupt 23 for /event-sources/hot-plug-events
> > WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/pseries/event_sources.c:26 request_event_sources_irqs+0xbc/0xf0
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.2.2-kc #1
> > Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1200 0xf000005 of:SLOF,HEAD pSeries
> > NIP:  c000000002022eec LR: c000000002022ee8 CTR: 0000000000000000
> > REGS: c000000003483910 TRAP: 0700   Tainted: G        W           (6.2.2-kc)
> > MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24483200  XER: 00000000
> > CFAR: c000000000180838 IRQMASK: 0 
> > GPR00: c000000002022ee8 c000000003483bb0 c000000001a5ce00 0000000000000050 
> > GPR04: c000000002437d78 c000000002437e28 0000000000000001 0000000000000001 
> > GPR08: c000000002437d00 0000000000000001 0000000000000000 0000000044483200 
> > GPR12: 0000000000000000 c000000002720000 c000000000012758 0000000000000000 
> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > GPR24: 0000000000000000 c0000000020033fc cccccccccccccccd c0000000000e07f0 
> > GPR28: c000000000db0520 0000000000000000 c0000000fff92ac0 0000000000000017 
> > NIP [c000000002022eec] request_event_sources_irqs+0xbc/0xf0
> > LR [c000000002022ee8] request_event_sources_irqs+0xb8/0xf0
> > Call Trace:
> > [c000000003483bb0] [c000000002022ee8] request_event_sources_irqs+0xb8/0xf0 (unreliable)
> > [c000000003483c40] [c000000002022fa0] __machine_initcall_pseries_init_ras_hotplug_IRQ+0x80/0xb0
> > [c000000003483c70] [c0000000000121b8] do_one_initcall+0x98/0x300
> > [c000000003483d50] [c000000002004b28] kernel_init_freeable+0x2ec/0x370
> > [c000000003483df0] [c000000000012780] kernel_init+0x30/0x190
> > [c000000003483e50] [c00000000000cf5c] ret_from_kernel_thread+0x5c/0x64
> > --- interrupt: 0 at 0x0
> >
> > I did a bisect it and it seems that the offending commit is:
> > baa49d81a94b ("powerpc/pseries: hvcall stack frame overhead")
> >
> > Reverting that and also dfecd06bc552 ("powerpc: remove
> > STACK_FRAME_OVERHEAD"), because we need to re-introduce
> > STACK_FRAME_OVERHEAD, seems to fix everything.
> 
> That function doesn't make a hcall, so presumably there was some earlier
> problem which we only detect here.
> 
> cheers
