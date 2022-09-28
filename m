Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74565EE1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiI1Q2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI1Q1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:27:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF879F74B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:27:52 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D88D51EC058B;
        Wed, 28 Sep 2022 18:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664382466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sytnbl35VVJrEFtsYCPcAI3F0fkm5QLxwoHOh+qS/6o=;
        b=oPRUwEbsQBJAw/QNmZlyueST0ikXwOZdM/fhn1T0XbAuktoPiiOJAHBZf0irJvDQTW3oIU
        PEfWVaLUm/OC7T67NoTKiWJFE6psOwXHBWmxvey0Re0mt3PEkEMMXM83z6Sv3g20k4OhQd
        ftFRdJDC2NHyEghMQ1qjG8HafbZnayI=
Date:   Wed, 28 Sep 2022 18:27:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH] x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit relevant
 diagnostics
Message-ID: <YzR1/nWoQtdRQ3Uv@zn.tnic>
References: <20220810221909.12768-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220810221909.12768-1-andrew.cooper3@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:19:09PM +0100, Andrew Cooper wrote:
> "XSAVE consistency problem" has been reported under Xen, but that's the extent
> of my divination skills.
> 
> Modify XSTATE_WARN_ON() to force the caller to provide relevant diagnostic
> information, and modify each caller suitably.
> 
> For check_xstate_against_struct(), this removes a double WARN() where one will
> do perfectly fine.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: x86@kernel.org
> CC: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> 
> RFC: CC stable?  This has been wonky debugging for 7 years.
> 
> Apparently "size 832 != kernel_size 0" so let the debugging continue...

I've got a similar bug report from people running Linux guest on some
other prop. HV. And I wanted to give them a debugging patch which dumps
*all* the relevant data along the path of paranoid_xstate_size_valid(),
the loop in there and xstate_calculate_size().

Looking how you might need something like that too, how about you extend
your patch to do that and have it being toggled on by a xstate=debug
cmdline?

It feels like this would be a useful thing to have with the gazillion of
XSTATE features and dynamic buffer allocation...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
