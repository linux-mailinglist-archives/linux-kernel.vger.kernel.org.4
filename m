Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14616EF6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbjDZOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbjDZOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:46:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAAD72B4;
        Wed, 26 Apr 2023 07:45:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q61rS6PL0z4x1H;
        Thu, 27 Apr 2023 00:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682520345;
        bh=oMuxe+KJMbGNCZWYXnNWaQGhxAfiAj2LaZcWFR8JHYs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gfBLEMyoAxGwCpEE9bWsDlEcneRdSa0i0L6TuE6lyTRckWh6EI1FJRxaEncFnWpfK
         0Peh1/OXF1fV1pBhOz+0HtoMCHT1fFL61BFpfQfg4uNJz1vjovVqgEqTmxF/Yc1ewb
         Bbu3/As/Va0rAKRt7gk/DR9DmCONJsnTe+UJYjFWDpRWn5N8iFqMd3f6iXLSlJ0aVe
         wv287yiW4xC7eR0l+gk6WOXzSMBBiUkh4DSKFd1AiA918pHeQhfXCrvtCJbqsgZcP/
         bOTA7gvTUewq4M2lROswBt/qcBhb+o2qi36AQgicpEIIT1I9w+XdX0HAGS51dNnAop
         GXZlkHivnu+fQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
In-Reply-To: <20230426142054.GA1381951@hirez.programming.kicks-ass.net>
References: <ZEXOMC2casTlobE1@boqun-archlinux>
 <87fs8pzalj.fsf@mail.concordia> <20230424151351.GP19790@gate.crashing.org>
 <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
 <877ctyzv08.fsf@mail.concordia>
 <CAEXW_YR4rmNY5JF-077EUpriF=PP9uML+_WMDSVi-L3G6_FOdw@mail.gmail.com>
 <20230426142054.GA1381951@hirez.programming.kicks-ass.net>
Date:   Thu, 27 Apr 2023 00:45:44 +1000
Message-ID: <874jp2zopz.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Wed, Apr 26, 2023 at 09:44:22AM -0400, Joel Fernandes wrote:
>
>> How could you control which code paths don't have the stack protector?
>> Just curious.
>
> https://lkml.kernel.org/r/20230412-no_stackp-v2-0-116f9fe4bbe7@google.com

We also have some entire files disabled, eg:

$ git grep no-stack-protector arch/powerpc/
arch/powerpc/kernel/Makefile:CFLAGS_prom_init.o += -fno-stack-protector
arch/powerpc/kernel/Makefile:CFLAGS_syscall.o += -fno-stack-protector
arch/powerpc/kernel/Makefile:CFLAGS_setup_64.o                += -fno-stack-protector
arch/powerpc/kernel/Makefile:CFLAGS_paca.o                        += -fno-stack-protector

cheers
