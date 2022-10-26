Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8BB60E06A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiJZMMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiJZMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:11:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFB45F9AB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:10:49 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C2B61EC032C;
        Wed, 26 Oct 2022 14:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666786248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Cu8ioNEqSiqhiCaYGiXDuC/BH2QD8B4nky0VFZpJswM=;
        b=WhH8kR9GyGFP4c+EueuhPQDDWsPhv5B4P2a1YJPWzlVQwD44iI0qeRuEnr3cz3pwTEsXB9
        cw9Konv1wvgoDFzYADQWAwE9ms5z2QnQVuXOmQQSxGDDqnQfyEMelQoHR+rF1ysIi6dFr8
        S3PQfSO2pqmAF+J1KwWMxwo1Wbwqqlw=
Date:   Wed, 26 Oct 2022 14:10:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 07/16] x86/mtrr: split generic_set_all()
Message-ID: <Y1kjxPJEKdhknYU0@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-8-jgross@suse.com>
 <Y1kOAUDYW7HpRvfl@zn.tnic>
 <52410187-f277-a4a0-f369-9390d25a70f6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52410187-f277-a4a0-f369-9390d25a70f6@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:43:52PM +0200, Juergen Gross wrote:
> The reason is "Prepare the support of PAT without needing MTRR support".
> 
> DYM I should just remove the rest of the commit message?

I mean something like this:

"Disentangle MTRR init from PAT init.

Add a main cache_cpu_init() init routine which initializes MTRR and/or
PAT support depending on what has been detected on the system.

Leave the MTRR-specific initialization in a MTRR-specific init function
where the smp_changes_mask setting happens now with caches disabled.

This global mask update was done with caches enabled before probably
because atomic operations while running uncached might have been quite
expensive.

But since only systems with a broken BIOS should ever require to set any
bit in smp_changes_mask, hurting those devices with a penalty of a few
microseconds during boot shouldn't be a real issue."

A commit message should talk about why the change is done - not, what is
being done. The what is clear from the diff.

It is way more important to state why and the direction this is
taking and what the author's concerns were while doing it. Like the
bit about the smp_changes_mask - that is important.

 The fact that generic_set_all() is gutted out and renamed to
mtrr_generic_set_state() - not so much and also visible.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
