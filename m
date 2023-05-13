Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888E701AC2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEMXFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AAC1703
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 16:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9EE6148A
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 23:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D38C433D2;
        Sat, 13 May 2023 23:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684019135;
        bh=NC/4k6idYM8q5OXvy5ko2aM3jnNAcvzlrnr9hZdq2vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCnekFwZHAPy4yc+M7eRwfX/4LFgCA2N6JPAH/eFQ+E9jo37+d6elhM580FWxeSpK
         WqDEkq1jJNh5pPzB0pcJbF0EQiBYh4m3uKx29ezHJR4kAPjJioLETHe7bJAYHnA3u5
         MvCwTnlVkO2pllUe90JWjQF263Bgev4ypwNUNx2TnBlH3sHCOvlJCV+ns8tLzTYjb4
         J6fyAmjcx0WADvr57oulthmatNgV5uhKbribjbYcKjh1F8lG2yski1vm2azMQKrIVD
         iSiv92UJkIyP5kiMzUoUUsXyK/1pYPRwNrM/+2hadRJVE7I//Lqf49t9VHDO1dlu7d
         BrKikUsbpvNPQ==
Received: by pali.im (Postfix)
        id 864537F9; Sun, 14 May 2023 01:05:32 +0200 (CEST)
Date:   Sun, 14 May 2023 01:05:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] powerpc: udbg: export udbg_putc
Message-ID: <20230513230532.ojjf2xkmkx4v4zdo@pali>
References: <20230513055804.23775-1-rdunlap@infradead.org>
 <20230513091358.pzlexqnff5ydhlzf@pali>
 <af2ca59b-b5ba-a154-991f-536d9170cc05@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af2ca59b-b5ba-a154-991f-536d9170cc05@infradead.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 May 2023 15:53:19 Randy Dunlap wrote:
> Hi Pali,
> 
> On 5/13/23 02:13, Pali Rohár wrote:
> > On Friday 12 May 2023 22:58:04 Randy Dunlap wrote:
> >> In a randconfig with CONFIG_SERIAL_CPM=m and
> >> CONFIG_PPC_EARLY_DEBUG_CPM=y, there is a build error:
> >> ERROR: modpost: "udbg_putc" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
> >>
> >> The build can be fixed by exporting "udbg_putc" in udbg.c.
> >>
> >> OTOH, maybe something like this is more appropriate in
> >> arch/powerpc/Kconfig.debug?
> >>
> >> config PPC_EARLY_DEBUG_CPM
> >> 	bool "Early serial debugging for Freescale CPM-based serial ports"
> >> -	depends on SERIAL_CPM
> >> +	depends on SERIAL_CPM=y
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: Nicholas Piggin <npiggin@gmail.com>
> >> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: "Pali Rohár" <pali@kernel.org>
> >> ---
> >>  arch/powerpc/kernel/udbg.c |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff -- a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
> >> --- a/arch/powerpc/kernel/udbg.c
> >> +++ b/arch/powerpc/kernel/udbg.c
> >> @@ -14,6 +14,7 @@
> >>  #include <asm/udbg.h>
> >>  
> >>  void (*udbg_putc)(char c);
> >> +EXPORT_SYMBOL(udbg_putc);
> >>  void (*udbg_flush)(void);
> >>  int (*udbg_getc)(void);
> >>  int (*udbg_getc_poll)(void);
> > 
> > Hello! I do not think that it is a good idea to export udbg functions
> > for kernel modules. I have quickly looked at the cpm_uart driver file
> 
> Sure, that was just a conversation starter.
> 
> > drivers/tty/serial/cpm_uart/cpm_uart_core.c and it looks like that once
> > udbg from it is registered then there is no code for unregistering it.
> > So I have feeling that compiling cpm_uart driver as module should not be
> > allowed when CONFIG_SERIAL_CPM_CONSOLE is enabled, and early debug
> > should depend on CONFIG_CONSOLE_POLL || CONFIG_SERIAL_CPM_CONSOLE.
> 
> The other change above also fixes the build error: (Option 2)
> 
> >> config PPC_EARLY_DEBUG_CPM
> >> 	bool "Early serial debugging for Freescale CPM-based serial ports"
> >> -	depends on SERIAL_CPM
> >> +	depends on SERIAL_CPM=y
> 
> 
> Also, making SERIAL_CPM (cpm_uart driver) be restricted to not allow it
> as a module when SERIAL_CPM_CONSOLE is enabled [how does one express that
> in Kconfig language?] will cause a circular dependency since SERIAL_CPM_CONSOLE
> depends on SERIAL_CPM=y. It looks like you are suggesting reversing the
> dependencies.

I see that SERIAL_CPM_CONSOLE has already "depends on SERIAL_CPM=y".
Am I right that this already disallow compiling cpm_uart driver as
module when SERIAL_CPM_CONSOLE is enabled?

> > Any other opinion?
> 
> Yes, please. Otherwise I prefer my option 2.
> 
> -- 
> ~Randy

Option 2 looks like a better solution.
