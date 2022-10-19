Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE0604F27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJSRwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:52:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCB643318
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:52:42 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E85761EC06F6;
        Wed, 19 Oct 2022 19:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666201957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2lP+tZyH1u1ggn7MuSBPUtEusUvih2SqFcDVSJqYRYg=;
        b=WvYF7pzzqQs9VpY/G9v8LQmNqnwq8MKVPhxgvuszAmwlK0LpyEVY+sG/50Sgzg38BHh6EY
        4NJoqK/Ot2ej17/2paH9wNCkf109RNbpISFjfWYI/DyoEkyuUVtTayn0tXA5et7kXiOAED
        OtdmBrGTpv6Qa1orbg2R8EyWNZcXKK8=
Date:   Wed, 19 Oct 2022 19:52:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH 02/13] x86/microcode: Do not load from filesystem for CPU
 hot add
Message-ID: <Y1A5YHzmzab8LrYD@zn.tnic>
References: <20221014200913.14644-1-ashok.raj@intel.com>
 <20221014200913.14644-3-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014200913.14644-3-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:09:02PM -0700, Ashok Raj wrote:
> When request_microcode_fw() is called, refresh_fw parameter must be set
> only when late loading. Currently during CPU hotplug, the path is as
> follows.
> 
> mc_device_add() -> microcode_init_cpu() ->
> 				request_microcode_fw(refresh_hw=true)

So that ugly refresh_fw thing was getting on my nerves for a while
now so I took a long stern look today. And ended up axing off a lot
of ancient crud which was simply getting in the way and is completely
useless.

The diffstat says it all:

 arch/x86/include/asm/microcode.h      |   4 +-
 arch/x86/kernel/cpu/intel.c           |   1 -
 arch/x86/kernel/cpu/microcode/amd.c   |   5 +-
 arch/x86/kernel/cpu/microcode/core.c  | 214 ++++++++++++++++++-------------------------------------------------------------
 arch/x86/kernel/cpu/microcode/intel.c |   3 +-
 5 files changed, 52 insertions(+), 175 deletions(-)

and initial smoke-testing with CPU hotplug and suspend looks good.

I'll hammer on it some more in the coming days.

Patches as a reply to this message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
