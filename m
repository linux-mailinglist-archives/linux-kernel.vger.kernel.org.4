Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D306F6D20FE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjCaM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjCaM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:57:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A4199
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:57:41 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78BCB1EC063A;
        Fri, 31 Mar 2023 14:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680267460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0UXT4MFiQibJvCWEZtWIVSsUyziWhEKfbqs3c25IHX0=;
        b=M9PGowwPxn9LhkuqikrEp7ORU7Gmqo36JNzhvH7+YnTPO08qs72h6IIImwx53GEEjgkgfQ
        yVGNrzlTfDnBhS76Mqj/AIzj5KqzdOUExHq22FYMGPCcV0XysiKskkY9uSGmehOxdguy/P
        deMeWrMF7nfU/RlLMk8KMmQqGJurVJE=
Date:   Fri, 31 Mar 2023 14:57:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230331125740.GCZCbYxFkJOg8hIl6C@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163425.8324-10-jgross@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:34:22PM +0100, Juergen Gross wrote:
> +/* Build the cache_map containing the cache modes per memory range. */
> +void mtrr_build_map(void)
> +{
> +	unsigned int i;
> +	u64 start, end, size;
> +	u8 type;
> +
> +	if (!mtrr_state.enabled)
	     ^^^^^^^^^^^^^^^^^^^

> +		return;
> +
> +	/* Add fixed MTRRs, optimize for adjacent entries with same type. */
> +	if (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED) {
	    ^^^^^^^^^^^^^^^^^^

First check can go.

> +		start = 0;
> +		end = size = 0x10000;
> +		type = mtrr_state.fixed_ranges[0];
> +
> +		for (i = 1; i < MTRR_NUM_FIXED_RANGES; i++) {

Loops starts at 1. Comment explaining why pls.

> +			if (i == 8 || i == 24)

Magic numbers.

Ok, I'll stop here.

Please send a new version with the review comments incorporated. I need
to look more at that map thing more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
