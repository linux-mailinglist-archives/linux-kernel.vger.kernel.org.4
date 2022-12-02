Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB22640E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiLBS6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiLBS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:58:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1A9A4D2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:58:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670007522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTAaq0K2yMj7q/wt8hfIaZP0HJYKKi1+zXlY0Z5SIEE=;
        b=TgdxiseKmR3QZUPIkisqSBFbY2qjrS4do1CEQXae/CPfZi/pMY94N5Iza9+0Dw23J0R4Ga
        vowu2Vp2W/FXUYoEBuuHwim1pQ4DrO83ueF/g7AVRdlgrtVifSqEZlfKePJ6zpFomV8z+5
        XVRg1pRDCEOG+zc27vNzunSk7/so/KTU23AQ0q9NYRfAn36GWeTR0eRg6dQ36MO0CgVwTg
        Ohzn8KFNQszWsYGYVROV9EIzHxZBedHy3MtJvPJMr2W1VatkLbrlEfT/IPQ+4LnsMcOkFH
        KSbO7pyatDfSJDfXpswAL03eUwy/9wl6rbueMwAFP9+eMkaa8flwksnmetbVSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670007522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTAaq0K2yMj7q/wt8hfIaZP0HJYKKi1+zXlY0Z5SIEE=;
        b=7j6+Gers8GCK8kklGUF/xqNmB6OIiRTTnAjOaAZQEdlTg+esPXHR7JCt6/28UbBc/74M8J
        6rF/s+ELdXjw72BQ==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 1/7] x86/microcode/intel: Remove redundant microcode
 rev pr_info()s
In-Reply-To: <20221129210832.107850-2-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-2-ashok.raj@intel.com>
Date:   Fri, 02 Dec 2022 19:58:42 +0100
Message-ID: <87cz91pr8d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok!

On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:
> There is a pr_info() to dump information about newly loaded microcode.

There... Somewhere, right?

> The code intends this pr_info() to be just once, but the check to ensure
> is racy. Unfortunately this happens quite often in with this new change
> resulting in multiple redundant prints on the console.

-ENOPARSE. Can you try to express that in coherent sentences please?

> microcode_init()->schedule_on_each_cpu(setup_online_cpu)->collect_cpu_info
>
> [   33.688639] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
> [   33.688659] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
> [   33.688660] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
>
> There is already a pr_info() in microcode/core.c as shown below:
>
> microcode: Reload completed, microcode revision: 0x2b000041 -> 0x2b000070

There are quite some pr_info()'s in microcode/core.c...

$function_name() prints the new and the previous microcode revision once
when the load has completed:

  microcode: Reload completed, microcode revision: 0x2b000041 -> 0x2b000070

Hmm?

> The sig and pf aren't that useful to end user, they are available via

The sig and pf ?!? Come on, you really can do better.

> /proc/cpuinfo and this never changes between microcode loads.
>
> Remove the redundant pr_info() and the racy single print checks. This
> removes the race entirely, zap the duplicated pr_info() spam and
> simplify the code.

The last sentence does not qualify as coherent either.

Other than that. Nice cleanup.

Thanks,

        tglx
