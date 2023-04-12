Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835736DF545
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDLMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDLMbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:31:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBF6195
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:30:50 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A81891EC068E;
        Wed, 12 Apr 2023 14:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681302648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bhnDXdy2VF1lKr1UjNg1V7wUWRoWDZfKo0FUcl+Dhe4=;
        b=pxUbpJ5HSjTrB6f3InyEeJxgNsUJMlH0muOeR8LJnsYU3+TLI9vowfPDWhStcXcgnl5iQ2
        rAwuXytWwbxmHzo0bKLfDC5+4+4DI8YLKj+OMx1Cy/0Lund9WD5oinjlMRLgb8p5xYDQGx
        Pd3IUk6lDmUlWSsj6GhQvFIzy/bfDWw=
Date:   Wed, 12 Apr 2023 14:30:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 08/15] x86/mtrr: have only one set_mtrr() variant
Message-ID: <20230412123044.GJZDakdLatRW26J+1k@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-9-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230401063652.23522-9-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:36:45AM +0200, Juergen Gross wrote:
> Today there are two variants of set_mtrr(): one calling stop_machine()

"... two variants which set MTRRs: set_mtrr() and set_mtrr_cpuslocked(),
first calling ..."

> and one calling stop_machine_cpuslocked().
> 
> The first one (set_mtrr()) has only one caller, and this caller is
> always running with only one CPU online and interrupts being off.

Wait, whaaat?

It's only caller is mtrr_restore() and that is part of syscorse ops
which is registered for

"The CPU has no MTRR and seems to not support SMP."

Do you mean that, per chance?

If you do, please explain that properly in the commit message - this is
not a guessing game.

By the looks of that syscore thing, it is needed for the very old MTRR
implementations which weren't SMP (K6, Centaur, Cyrix etc).

Please explain that in the commit message too. It needs to say *why* the
transformation you're doing is ok.

"this caller is always running with only one CPU online" is not nearly
beginning to explain what the situation is.

> Remove the first variant completely and replace the call of it with
> a call of mtrr_if->set().
> 
> Rename the second variant set_mtrr_cpuslocked() to set_mtrr() now that
> there is only one variant left.

Those are visible from the diff itself - you don't need to explain what
the patch does but why.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
