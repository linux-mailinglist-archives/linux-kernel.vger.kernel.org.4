Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42857365F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjFTIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFTIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:20:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421D9DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:20:44 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 792DA1EC03C0;
        Tue, 20 Jun 2023 10:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687249242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=243YMiY6WMANT6FnKYqgk0/aopO032r6tgzL/JXDFho=;
        b=MEpyTNDN0PD0p+NckLOU6rEPoYFdXUwP4/uU7lGcXUQJxRQKbBWI3vvR13AqnByWL+TFDK
        1WFKYRrUUK6dRMF5Rj4rbHifVtyTDn5suGmsMFV9mINxgQOgwKkqAjxXYRFpCjvZ0KYdf7
        Jhb9725fUTc+wR6/eaSqkfVqBIg/NOo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eibnpNZE3AMT; Tue, 20 Jun 2023 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687249238; bh=243YMiY6WMANT6FnKYqgk0/aopO032r6tgzL/JXDFho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9LG/pDbFb7ZTnYP8MVaJr82pl71YiSlPp956xhBVfE3jvgsrj+PU1eZMIKRAJBC+
         XPKBpvOwbcKkAr9Y9PnA+fYqKBMPb2ShYL5/KeIkUbsxbmAEB3wFC5Zx8RZnn2BY3I
         1TPG/TEpg88ofvw3cOSWW5STwhqpIjOvyADY5wzAjApoZs9Xz4hlx8k72VTNJjjhbE
         4HCi3qGiwNq0krs0uBQSbP2oGcmNrIy18LfGpAds7iCaLgyExwtu5H1BsLOs9KMLRZ
         4fPJ163Isno0YXcYQ+3QNkGARxHVnx1+eiJPQP9iUuG05eGBBcipIcPiSxvPCGfbzm
         zLEZj0HDiSAE7joaL0xrVe5bdVUvvxrhMjcmnH5vhGqn4SVcEk8E36Bti8azxM9xUV
         mABTjBlR6dPZPhAbDN6TYVRqXpM2uxWxM/KBvVjs/ThehAsKHF8huA5FVFJnXtAA2g
         B/lwIlFBKu06R7WXvOsSN6beGx5e2U0F5rZkwrwopsOecg+1hNoQL7xMKlwxwsb7SL
         f0QM8q+msVe/QUlJ5MI2CXu+1hbkzqBcw2hikxM23GeXRgIkdmwLzQzNIE47oPNlLg
         CxdQgZ9CoiQ1DOakhhcTG6/s4LLZebl72hspzkkmGqBEHU00T5+UCsNd7jS3Dce0lq
         upW0Q3L7sjqXpFZf+SneZOzg=
Received: from zn.tnic (p200300EA971Dc5B2329C23FfFea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7826040E0034;
        Tue, 20 Jun 2023 08:20:28 +0000 (UTC)
Date:   Tue, 20 Jun 2023 10:20:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch v3 2/7] x86/smp: Dont access non-existing CPUID leaf
Message-ID: <20230620082023.GTZJFhRxji7SHvvmdk@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.322186388@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615193330.322186388@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:33:52PM +0200, Thomas Gleixner wrote:

> Subject: Re: [patch v3 2/7] x86/smp: Dont access non-existing CPUID leaf

"Do not access a non-existing... "

> From: Tony Battersby <tonyb@cybernetics.com>
> 
> stop_this_cpu() tests CPUID leaf 0x8000001f::EAX unconditionally. CPUs
> return the content of the highest supported leaf when a non-existing leaf
> is read.

This should be:

"On Intel, querying an invalid extended CPUID leaf returns the values of the
maximum basic CPUID leaf. On AMD, invalid CPUID leafs return zeros."

Other than that:

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
