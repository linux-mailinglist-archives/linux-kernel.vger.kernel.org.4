Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A069B50E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBQVrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBQVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:47:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47163B20F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:47:29 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0BC91EC01E0;
        Fri, 17 Feb 2023 22:47:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676670446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cjE3oxFI8ycKU8s9Z7/bplvRY1Fi3Qg1ejyG5JOZTW8=;
        b=ixxcCM4ZjeZm/NS262zMm1hHEWcI7oPYLYDGN5v2YhrP+SpsyrRGUuU8EFLGX8pOW7eT2L
        1otzeD6Wha2m+ClGJikmPWAPlOnO0UALd5D1TG+5o7cRhUbKNB1ZHpm0D8qgIcRb/5lBGY
        qHFrK1kwuVJBfxeyqWk5zDccDnN7n7s=
Date:   Fri, 17 Feb 2023 22:47:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] x86/mm: Fix use of uninitialized buffer in sme_enable()
Message-ID: <Y+/16MlEBb53ficg@zn.tnic>
References: <20230202182538.29352-1-n.zhandarovich@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202182538.29352-1-n.zhandarovich@fintech.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:25:38AM -0800, Nikita Zhandarovich wrote:
> cmdline_find_option() may fail before doing any initialization of
> buffer array. This may lead to unpredictable results when the same
> buffer is used later in calls to strncmp() function.
> Fix the issue by initializing the buffer to an empty string.

I'd prefer if you test cmdline_find_option()'s return value instead and
return early if -1.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.

SVACE is?

> Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")

The proper Fixes commit should be:

aca20d546214 ("x86/mm: Add support to make use of Secure Memory Encryption")

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
