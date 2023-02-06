Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB268C945
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBFWWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBFWWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:22:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D935BA7;
        Mon,  6 Feb 2023 14:22:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CECFCB81636;
        Mon,  6 Feb 2023 22:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D76C433D2;
        Mon,  6 Feb 2023 22:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722127;
        bh=g8nY4KWQRGHZ+UEBU3IfsGHHp9POeugLWf+ks7MhlYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ku27bb49TXnifj4vDKUwLt//IhS+AuKgNZHjSBzmgIygXsWngoTvqzjsyI4aaPcuH
         Ne/GMb6QblTp2Jv681blYtCgjkXaPsQUgkrsec8L+xRVWuKD28hd8t9BRChWBzJwZK
         gFEWXSU7jaZZgPnPMEvOqqaXTfNHVDYUbsIUYWKlmuEb7nAEqsRD53T6hGhLZYqx/u
         DQUcYnhTaFCk/Smt9vORx+U2SLIPq7vHqyxTh+SxZ9//C/gkazIzBXyvCtcwtDa+nk
         Ec2/QPURQbIa9r42wgKqNXQHC6PZxrciIKrlgpzWDw6z2c/ntsIbU896+w3wVQ78cR
         a9GpVI+CKZooA==
Date:   Mon, 6 Feb 2023 14:22:02 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: Re: [PATCH 12/22] powerpc/cpu: Mark start_secondary_resume()
 __noreturn
Message-ID: <20230206222202.zreg3pyhynhvyggy@treble>
References: <cover.1675461757.git.jpoimboe@kernel.org>
 <b5d065218265e79daa23f82bb84efc6a7ea120fc.1675461757.git.jpoimboe@kernel.org>
 <87v8kfdp7l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8kfdp7l.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:10:22PM +1100, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@kernel.org> writes:
> > start_secondary_resume() doesn't return.  Annotate it as such.  By
> > extension this also makes arch_cpu_idle_dead() noreturn.
> 
> Can we also mark arch_cpu_idle_dead() (the C function) __noreturn ?
> 
> Seems like it would be good documentation, even if it's not required
> once the generic prototype is __noreturn.

Yeah, agreed.  Maybe I'll do that (for all the implementations) with
patch 22.

> But not a show-stopper.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks!

-- 
Josh
