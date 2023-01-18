Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A05671975
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjARKoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjARKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:42:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B1676EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vngt/LhqRClTSAwIT1d/lHxWy/3LcgFLtLzBhiC6+H4=; b=qN7sbrX2eZZR6fSOcS9SM2m8SL
        KggCGNxcd+u+9YxQownogqA0p2VZtU3Hko3Q0wGr2v56chdBuZQbt8ha8wwKycbmdGHoPwXPOcYWO
        npR4HyZ8Pg0qVt0FBNFD5xObAQSnYEMLBZwFFAcIp5+pvT+t6v0Ch6b71BT3vg+al7pt2SxISAwxm
        uOirgCK3BC7rZc0jC+dlSUlqxx3jQf+icqo7pPFEwKBnFFcIvrAtGbI1eSTV3BIX9HWNH1/ObOAXK
        8KY0Sz1JX97KdQvz3fvjCu3Vhs0q3pkB/tddNlhJehJbePTPSxMYlR0vdP/9hbvLbtZoxrnsCdgDx
        n6eQ3Bsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI518-00AXu0-OJ; Wed, 18 Jan 2023 09:46:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4BAA30012F;
        Wed, 18 Jan 2023 10:45:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACDDF201C94B7; Wed, 18 Jan 2023 10:45:44 +0100 (CET)
Date:   Wed, 18 Jan 2023 10:45:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, jroedel@suse.de,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com
Subject: Re: [PATCH v2 1/7] x86/boot: Remove verify_cpu() from
 secondary_startup_64()
Message-ID: <Y8e/yKgVZgbqgvAG@hirez.programming.kicks-ass.net>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.589522290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116143645.589522290@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:25:34PM +0100, Peter Zijlstra wrote:
> The boot trampolines from trampoline_64.S have code flow like:
> 
>   16bit BIOS			SEV-ES				64bit EFI
> 
>   trampoline_start()		sev_es_trampoline_start()	trampoline_start_64()
>     verify_cpu()			  |				|
>   switch_to_protected:    <---------------'				v
>        |							pa_trampoline_compat()
>        v								|
>   startup_32()		<-----------------------------------------------'
>        |
>        v
>   startup_64()
>        |
>        v
>   tr_start() := head_64.S:secondary_startup_64()
> 
> Since AP bringup always goes through the 16bit BIOS path (EFI doesn't
> touch the APs), there is already a verify_cpu() invocation.

So supposedly TDX/ACPI-6.4 comes in on trampoline_startup64() for APs --
can any of the TDX capable folks tell me if we need verify_cpu() on
these?

Aside from checking for LM, it seems to clear XD_DISABLE on Intel and
force enable SSE on AMD/K7. Surely none of that is needed for these
shiny new chips?

I mean, I can hack up a patch that adds verify_cpu() to the 64bit entry
point, but it seems really sad to need that on modern systems.
