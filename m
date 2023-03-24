Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA26C8105
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCXPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:19:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65663AF11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:19:39 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB2BC1EC070A;
        Fri, 24 Mar 2023 16:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679671177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qAdQYxd+GG+dS9UCrKh+ebCQF6NKtlTg93yGBBAgkq0=;
        b=Vl4uNk/SClwM0P/GR/nuKm5MoaG1DCVlDyDDYhS3bavumn6Q5sQYaEGRbMYmrCd3kteldD
        DFAc4f/dth/XhDDnj9lLpBCpsg7ynJCixLDOnyUCpa9aS88TkCr5k2luTKWwY6p5gf3lqh
        LEJ62n6IhZjAQkRWjIE041tXTwsYtr4=
Date:   Fri, 24 Mar 2023 16:19:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: move @microcode_mutex definition near
 usage
Message-ID: <20230324151933.GCZB2/hUOFuECIF1AG@fat_crate.local>
References: <20230324114720.1756466-1-john.ogness@linutronix.de>
 <20230324120019.GAZB2Q09ODVq0iYz5l@fat_crate.local>
 <87edpenvkh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edpenvkh.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:17:10PM +0106, John Ogness wrote:
> I was doing some tests with CONFIG_PREEMPT_RT. I did not think that
> mattered, since the mutex is obviously defined but not used for
> !CONFIG_MICROCODE_LATE_LOADING.

Oh sure, I see that. I'd still like to have in the commit message why
exactly it happens.

> Digging deeper I see that initializing @wait_list in
> __MUTEX_INITIALIZER() is what is allowing unused global mutexes to go
> unnoticed. Since with CONFIG_PREEMPT_RT the mutex is different and
> initialized differently, it is (correctly) detected as unused.
> 
> CONFIG_PREEMPT_RT cannot be enabled yet, so this patch is not urgent for
> mainline. But at some point it will need fixing.

Sure, send it to me when it can be triggered with a .config with the
upstream tree, along with exact explanation how it happens and I'll
queue it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
