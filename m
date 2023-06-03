Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA67721144
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjFCQiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 12:38:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB88D8;
        Sat,  3 Jun 2023 09:37:58 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61F651EC082E;
        Sat,  3 Jun 2023 18:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685810276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rbkCqWi/u09WZD2lALO4ak891/hbb8sjW1bney7b+Oo=;
        b=Ehh+j4q2YvIvSGngwWAHLsSEFhGfqSXCf0q80heRZaURCpA5Oj4X3CtJiCzESrkoJAEzOr
        mXX2YktOIr11rmng7n45HH5YI6TxEWdpxxRZNnhZrvcanX2wOzn0LO6pnquUAFllp1uVN2
        fqdq7yss6LgVPWLkSC3ys3czUtDrlak=
Date:   Sat, 3 Jun 2023 18:37:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, ebiggers@kernel.org, elliott@hpe.com,
        gmazyland@gmail.com, luto@kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 09/12] x86/cpu: Add a configuration and command line
 option for Key Locker
Message-ID: <20230603163751.GBZHtsXwW5UUnsSbKX@fat_crate.local>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-10-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603152227.12335-10-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 08:22:24AM -0700, Chang S. Bae wrote:
> +static __init int x86_nokeylocker_setup(char *arg)
> +{
> +	/* Expect an exact match without trailing characters. */
> +	if (strlen(arg))
> +		return 0;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
> +		return 1;
> +
> +	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
> +	pr_info("x86/keylocker: Disabled by kernel command line.\n");
> +	return 1;
> +}
> +__setup("nokeylocker", x86_nokeylocker_setup);

Can we stop adding those just to remove them at some point later but
simply do:

clearcpuid=keylocker

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
