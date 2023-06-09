Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505507299F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbjFIM3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFIM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:29:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981F35B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:28:51 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D7511EC02F2;
        Fri,  9 Jun 2023 14:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686313712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XGeGq5u0I7nlT2+Nk15j13YTNrhGHxxYvdudMYCDfzU=;
        b=GS0rAJNQaGRzKqlcqwE08LquusefK3ay91ri5KZXzEWkFdgrlaaCxU5/tSbPmVIbKFoVoY
        BA3lOrQjtri1SjxJ8XOgnJQXJwuEKBKkD4rTKsdH1NNbXFZAMjY0PWPQtFgRAHqHG331e4
        h1JdISbTLnAt2f3vbd/mzLJjJvevHUQ=
Date:   Fri, 9 Jun 2023 14:28:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Message-ID: <20230609122828.GBZIMa7OtCIpSkYGxV@fat_crate.local>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
 <ZIE1G9UBAT36kPhJ@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIE1G9UBAT36kPhJ@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 06:55:39PM -0700, Ashok Raj wrote:
> When end user changes the behavior, isn't it against the design
> specification? And if so, should that result in kernel being tainted
> after a reload?

That's a chicken bit and should not be used usually. I'm adding it just
in case.

> Is this reload on all threads required by all models, or only certain
> models? I was wondering if the forced reload could be limited to only
> affected CPUs instead of doing it on all unconditionally.

Unconditionally.

> Shouldn't the "control" be under LATE_LOADING? Since this only controls
> late-loading behavior?

No, that's a bitfield and is going to be used for other flags, if
needed and which are not necessarily late-loading related.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
