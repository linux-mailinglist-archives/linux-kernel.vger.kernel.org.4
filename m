Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C753A696DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjBNT3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBNT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:29:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE62B2B3;
        Tue, 14 Feb 2023 11:29:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F5C2618A2;
        Tue, 14 Feb 2023 19:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE92C433EF;
        Tue, 14 Feb 2023 19:29:45 +0000 (UTC)
Date:   Tue, 14 Feb 2023 14:29:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org
Subject: Re: [PATCH v2 19/24] xtensa/cpu: Make sure cpu_die() doesn't return
Message-ID: <20230214142944.100214fe@rorschach.local.home>
In-Reply-To: <20230214182322.r5tyeowxzloiuh72@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
        <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
        <1b4afd82-83cb-0060-7cab-8e16d2e69ff9@linaro.org>
        <20230214182322.r5tyeowxzloiuh72@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 10:23:22 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:


> void __ref cpu_die(void)
> {
> 	idle_task_exit();
> 	local_irq_disable();
> 	__asm__ __volatile__(
> 			"	movi	a2, cpu_restart\n"
> 			"	jx	a2\n");
> 
> 	BUG();
> }
> 
> Hm, not only is the comment wrong, but it seems to be branching to
> cpu_restart?  That doesn't seem right at all.

Agreed, that does not look right at all.

-- Steve

> 
> Max/Chris?
> 

