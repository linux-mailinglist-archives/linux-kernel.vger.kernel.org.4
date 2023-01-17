Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28B66E698
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjAQTJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjAQTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:06:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E88031E11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:21:08 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AF5B1EC0646;
        Tue, 17 Jan 2023 19:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673979667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+T1m25y4fv/I7wmutJr3X2Xf96TTvoaLQHG3Ee2Hbd8=;
        b=eQTHj+t56cfBRckrQuH0F+smzlVLvLx1PSA70Iqjnl9qUXjl+byKI4sFB/RoUijbrucROf
        FsSwsOhuWYXSf7xArt3Iv0Gn3apk1RyLxP4pZMolzMjbTLFNlPkWNoR6GyKeLAn/+ecaco
        micpkV05juwzgVOy919+dJzmst1Aego=
Date:   Tue, 17 Jan 2023 19:21:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8bnEgP6iXCL+QmX@zn.tnic>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:29:28AM -0800, Dave Hansen wrote:
> This ensures that a message of some kind is printed on all early loads:
> successes *and* failures.  This should make it easier for our hapless
> users to figure out when a failure occurred.

I'm still not convinced. When something doesn't happen in the kernel, we don't
always say "It didn't happen". We don't say anything.

So I don't like all those talkative drivers for no good reason. If there wasn't
an update message, then no update happened. That's it.

And the current microcode revision is in /proc/cpuinfo.

If you wanna know why the update didn't happen, then you start adding debug
printks and trying things but then you're clearly not a user so you know what
you're doing.

And the log buffer can get overwritten sooner or later depending on its size so
any message can disappear.

So what's the point of this pointless exercise in verbosity?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
