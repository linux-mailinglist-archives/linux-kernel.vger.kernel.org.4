Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7E60DEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiJZKiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiJZKiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:38:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC736DD7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:37:59 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 225111EC032C;
        Wed, 26 Oct 2022 12:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666780678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZX9dpgsglCG9/xfyhtzG1Jg1smDACPCZdOVzq6ZSD7A=;
        b=UVRzJi407zgiEMvg1MFExN6jybGK2KCFer+1pIO0GpYRp00V9RjhDuS/yGK9dcymEvQdd7
        YAyadENKE6MHNcoNmVpCHwx9OVNxmK/J52kuoqo1Gv53YCzql2FzxDfP0RyR+1iYmhk7Cj
        VTMNcQsLD1ltMHUsD9Kw5LRxgsjx60M=
Date:   Wed, 26 Oct 2022 12:37:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 07/16] x86/mtrr: split generic_set_all()
Message-ID: <Y1kOAUDYW7HpRvfl@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-8-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-8-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:14AM +0200, Juergen Gross wrote:
> Split generic_set_all() into multiple parts, while moving the main
> function body into cacheinfo.c.
> 
> Prepare the support of PAT without needing MTRR support by
> moving the main function body of generic_set_all() into cacheinfo.c
> while renaming it to cache_cpu_init(). The MTRR specific parts are
> moved into a dedicated small function called by cache_cpu_init() in
> order to make cache_cpu_init() as MTRR agnostic as possible.
> 
> The setting of smp_changes_mask is merged into the (new) function
> mtrr_generic_set_state() used to call set_mtrr_state(). It was
> probably split in ancient times, as atomic operations while running
> uncached might be quite expensive, but OTOH only systems with a
> broken BIOS should ever require to set any bit in smp_changes_mask,
> so just hurting those devices with a penalty of a few microseconds
> during boot shouldn't be a real issue.

This still needs addressing

"So the commit message should not say what you're doing - that should
be visible from the diff itself. It should talk more about the *why*
you're doing it."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
