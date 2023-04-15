Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637D16EF879
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjDZQbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjDZQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:31:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45A6D7A9D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:31:30 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 37EB521C2B3E;
        Wed, 26 Apr 2023 09:31:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37EB521C2B3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682526689;
        bh=HCy1R5MnFh5/przdIOjVbXj0o/kcMiTwBlBpNSBNctU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQdlf1mGc1Ah3oR3oaQPf7GXYkyWuhtf7WCx3yBb19Q098yf2bVGhD28Edrz/D7SJ
         ZZwCuUg2/yxqsZ+wzVz9+I4BLZs5uLa7mcaAi7uNjxs42qnXKPEUbQ7nCRMuLUWZ4T
         kPe9q67Lsrwx3zT8hpZ4u5AD1rU6U4Hf2mVWSYX8=
Date:   Fri, 14 Apr 2023 20:23:39 -0700
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Down <chris@chrisdown.name>,
        Helge Deller <deller@gmx.de>, Omar Sandoval <osandov@fb.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: asm/io.h: Harden virt_to_phys/isa_virt_to_bus
 prototypes
Message-ID: <20230415032339.GA8240@skinsburskii.localdomain>
References: <168146523405.6279.3632248068235163346.stgit@skinsburskii.localdomain>
 <7d0389aa-4fc0-499b-8f2e-5a96102efa24@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d0389aa-4fc0-499b-8f2e-5a96102efa24@app.fastmail.com>
X-Spam-Status: No, score=-16.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 11:02:33AM +0200, Arnd Bergmann wrote:
> On Fri, Apr 14, 2023, at 11:40, Stanislav Kinsburskii wrote:
> > From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> >
> > These two helper functions - virt_to_phys and isa_virt_to_bus - don't need the
> > address pointer to be mutable.
> >
> > In the same time expecting it to be mutable leads to the following build
> > warning for constant pointers:
> >
> >   warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ 
> > qualifier from pointer target type
> >
> 
> The change looks fine, and this is clearly useful for spreading
> more 'const' annotations, but I have two concerns:
> 
> - I'd really like this to be done consistently across architectures,
>   so at least the asm-generic/io.h version should get the same
>   annotation, or ideally all of them in one patch.
> 

Sure, let me come up with the a series to cover other architectures.

> - I would not describe this change itself as "hardening", as it
>   also does the opposite, when you have a pointer that is actually
>   "const" but converting it through virt_to_phys() and back
>   through phys_to_virt() ends up losing the annotation.
>

Indeen, I didn't think about this way.
Let me then just state what the change does (i.e. "Make virt_to_phys to
allow unmutable pointers"), unless you have a better option to advice.

Thanks,
Stanislav

>      Arnd
