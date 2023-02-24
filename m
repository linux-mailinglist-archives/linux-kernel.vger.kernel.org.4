Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A079E6A1F64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBXQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBXQNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:13:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6FED;
        Fri, 24 Feb 2023 08:13:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C8F2B81CA4;
        Fri, 24 Feb 2023 16:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4D1C433EF;
        Fri, 24 Feb 2023 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677255191;
        bh=CX7DTo+TTEsmnSfQAL6fYr2TZeiQ34sL6XZbkuYAgnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KVwA4z7SDaJT7aawcz7U1U8s44GL3XnQalcq51XdHmsMeBxj4BcNwZGmF+ce9QOkk
         mvRE1Gb+0jsSZNRh/WA/LTM86YXKeG4iolEHiNP2ljJ5AAqK10O9E/x1AZwBfxdidR
         BWxLQm0fVhlnYEO4NI8QAX+PH1+jnPMYh02KPMaIotWbqMcdFxZboQ3JPrGcqQ3P8A
         x9Ai4560Pt+LyozrCr79DgJICgCV0Av+P+c+6k/bvvhTKbytMznBw9uqQeUkn30OWO
         enmRwVrITQBPJ2VojqCMFMAw5VcoLs5mnldX0U2scai0ANx7JURsxNHMrF3AAOogVC
         tp1MW1kZ0o0IQ==
Date:   Sat, 25 Feb 2023 01:13:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     paulmck@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, akpm@linux-foundation.org, ndesaulniers@google.com,
        vbabka@suse.cz, hannes@cmpxchg.org, joel@joelfernandes.org,
        quic_neeraju@quicinc.com, urezki@gmail.com
Subject: Re: [PATCH RFC bootconfig] Allow forcing unconditional bootconfig
 processing
Message-Id: <20230225011306.0dd47e760f502b6787096bf7@kernel.org>
In-Reply-To: <CAMuHMdV9jJvE2y8gY5V_CxidUikCf5515QMZHzTA3rRGEOj6=w@mail.gmail.com>
References: <20230105005838.GA1772817@paulmck-ThinkPad-P17-Gen-1>
        <20230108002215.c18df95b19acdd3207b379fa@kernel.org>
        <20230107162202.GA4028633@paulmck-ThinkPad-P17-Gen-1>
        <CAMuHMdV9jJvE2y8gY5V_CxidUikCf5515QMZHzTA3rRGEOj6=w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, 24 Feb 2023 09:31:50 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Paul,
> 
> On Sat, Jan 7, 2023 at 5:33 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Sun, Jan 08, 2023 at 12:22:15AM +0900, Masami Hiramatsu wrote:
> > > BTW, maybe CONFIG_BOOT_CONFIG_EMBED is better to select this.
> > > (or at least recommend to enable this)
> >
> > Like this?
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit d09a1505c51a70da38b34ac38062977299aef742
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Sat Jan 7 08:09:22 2023 -0800
> >
> >     bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED
> >
> >     When a kernel is built with CONFIG_BOOT_CONFIG_EMBED=y, the intention
> >     will normally be to unconditionally provide the specified kernel-boot
> >     arguments to the kernel, as opposed to requiring a separately provided
> >     bootconfig parameter.  Therefore, make the BOOT_CONFIG_FORCE Kconfig
> >     option default to y in kernels built with CONFIG_BOOT_CONFIG_EMBED=y.
> >
> >     The old semantics may be obtained by manually overriding this default.
> >
> >     Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 0fb19fa0edba9..97a0f14d9020d 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1379,6 +1379,7 @@ config BOOT_CONFIG
> >  config BOOT_CONFIG_FORCE
> >         bool "Force unconditional bootconfig processing"
> >         depends on BOOT_CONFIG
> > +       default y if BOOT_CONFIG_EMBED
> >         help
> >           With this Kconfig option set, BOOT_CONFIG processing is carried
> >           out even when the "bootconfig" kernel-boot parameter is omitted.
> 
> Thanks for your patch, which is now commit 6ded8a28ed80e4cc
> ("bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED").
> 
> After this change, an all{mod,yes}config kernel has:
> 
>     CONFIG_BOOT_CONFIG_FORCE=y
>     CONFIG_BOOT_CONFIG_EMBED=y
>     CONFIG_BOOT_CONFIG_EMBED_FILE=""
> 
> Will this actually work? I haven't tried booting such a kernel yet.

Yeah, good question. It is same as when you boot the kernel with 'bootconfig'
but do not add the bootconfig file to initrd. You may see below message
on boot log, but kernel boots normally. :)

 'bootconfig' found on command line, but no bootconfig found

(Maybe it is better to fix the message, because if BOOT_CONFIG_FORCE=y, this
will be shown without 'bootconfig' on command line.)

Thank you!

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
