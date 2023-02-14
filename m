Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C122696CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjBNS2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBNS2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28282E0DF;
        Tue, 14 Feb 2023 10:28:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95ABC617B3;
        Tue, 14 Feb 2023 18:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5279BC433D2;
        Tue, 14 Feb 2023 18:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676399315;
        bh=FbF6sDzVu8IYeXRzBwpTRcd2V9cyuwcFeFjq0Ymm7Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHhn4MxW4jaWFJ2rWLLTx3PrN1UgQYhr8rIIi09a5nKp9q1ESDXYN6B61WfPK+RCk
         kGOo0Ttnppg2I0ImN2NZWVnYn5Hj3XaN0LDcyDf/bwqXXcmVPP3k8vhBjHFmJR2Bwl
         59QsKYYCyuVJKOZH8QhykBvzswD6lxU5Dm7UQEUn/f61z0n0wk0iCLguGpDT9BQtko
         BMamtHKjb0Kw6J2wXAyHy1UIJAIQSjMfecn63l73DrJUySuInHCUTNK20Fu4b0MRwy
         oFsYNMAp0xS4VwbLeGrloRppo8ZqhdA7joLLtCUVdDhIWqqYlEK1n6Wnc+Yaj98vfY
         KvhcfOKc0ivxg==
Date:   Tue, 14 Feb 2023 10:28:31 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
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
Subject: Re: [PATCH v2 13/24] sh/cpu: Make sure play_dead() doesn't return
Message-ID: <20230214182831.7l73rzoeqjowbyly@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <d0c3ff5349adfe8fd227acc236ae2c278a05eb4c.1676358308.git.jpoimboe@kernel.org>
 <2575e5f7-b11a-020f-06ef-ba42301d7415@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2575e5f7-b11a-020f-06ef-ba42301d7415@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:57:39AM +0100, Philippe Mathieu-Daudé wrote:
> On 14/2/23 08:05, Josh Poimboeuf wrote:
> > play_dead() doesn't return.  Make that more explicit with a BUG().
> > 
> > BUG() is preferable to unreachable() because BUG() is a more explicit
> > failure mode and avoids undefined behavior like falling off the edge of
> > the function into whatever code happens to be next.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >   arch/sh/include/asm/smp-ops.h | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/sh/include/asm/smp-ops.h b/arch/sh/include/asm/smp-ops.h
> > index e27702130eb6..63866b1595a0 100644
> > --- a/arch/sh/include/asm/smp-ops.h
> > +++ b/arch/sh/include/asm/smp-ops.h
> > @@ -27,6 +27,7 @@ static inline void plat_smp_setup(void)
> >   static inline void play_dead(void)
> >   {
> >   	mp_ops->play_dead();
> > +	BUG();
> >   }
> 
> Shouldn't we decorate plat_smp_ops::play_dead() as noreturn first?

I guess it really depends on how far we want to go down the __noreturn
rabbit hole.  To keep the patch set constrained yet still useful I
stopped when I got to a function pointer, as I think it still needs a
BUG() afterwards either way.

That said, there would still be benefits of adding __noreturn to
function pointers, I just wanted to keep the patch set down to a
manageable size ;-)

-- 
Josh
