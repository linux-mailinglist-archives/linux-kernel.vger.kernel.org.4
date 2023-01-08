Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6510E6614D1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjAHLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 06:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHLdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 06:33:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A9DEB7
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 03:33:13 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 258591EC0373;
        Sun,  8 Jan 2023 12:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673177592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nyJLQA1m4naJ6eJZ+I4n2/ZyMzrOzYUD3Jgta7XbWzs=;
        b=UKfntsFBM55yvZEyV7K5eWZW+Cezz8BxbJXqbmPu5JYW/WEiykOXkvKXJRwVjuUSp6geQc
        c4VHBkinJa7Wx6y5KhIgst3BsW/k5TC7weBVCtWe0Pb+Zy5i9U5SHU9rkCHP9+WvOLTx6d
        szJd3EUrVyXkxfzC1Ke+LVAmPbRLJXw=
Date:   Sun, 8 Jan 2023 12:33:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joan Bruguera <joanbrugueram@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Message-ID: <Y7qp80cK+r247eCU@zn.tnic>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230108030748.158120-1-joanbrugueram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 03:07:48AM +0000, Joan Bruguera wrote:
> Wake-up from suspend to RAM seems broken under `retbleed=stuff`
> (the recently introduced call depth tracking mitigation, see:
> https://lore.kernel.org/lkml/f9fd86acac4f49bc8f90b403978e9df3@AcuMS.aculab.com/t/)
> I can replicate it on both real hardware and QEMU (with and without KVM).
> 
> It can replicate it by booting a fairly standard mainline kernel

Which version exactly?

> on QEMU with `init=/bin/bash` and then suspending to RAM with:
>     echo "deep" > /sys/power/mem_sleep
>     echo "mem" > /sys/power/state
> Then executing `system_wakeup` on the QEMU monitor causes the crash.

You probably need to share .config too because my tailored .config built with
latest tip/master works fine here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
