Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139DC622A66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiKILZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiKILZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:25:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9F1A813
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:25:07 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7e8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E16B1EC03B9;
        Wed,  9 Nov 2022 12:25:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667993106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rNfWtR13plF3k6hKgWHcsrXb6x06XarGBqpNpJ/g01Q=;
        b=Sj+2UHwd5waIkzuXuwjKoBoQd8S+uYzoTS/ztvKWQ6onXw+J+cs1JCEXRinioq3DdBavy8
        w2BMz9I8F/dWbl2rDwqI1JAUsYSJADcFrhy4fJmQn0Caw6ZyL9pxoj4PcXJRTw7qT0qbU/
        pXNmjJyHZI6Cc3NU8D0hJiWHRwjNAcE=
Date:   Wed, 9 Nov 2022 12:25:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [v2 03/13] x86/microcode/intel: Fix a hang if early loading
 microcode fails
Message-ID: <Y2uODnpkSvQs/nbU@zn.tnic>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-4-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103175901.164783-4-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:58:51PM +0000, Ashok Raj wrote:
> When early loading of microcode fails for any reason other than the wrong
> family-model-stepping, Linux can get into an infinite loop retrying the
> same failed load.
> 
> A single retry is needed to handle any mixed stepping case.
> 
> Assume we have a microcode that fails to load for some reason.
> load_ucode_ap() seems to retry if the loading fails. But it searches for

Seems to retry because we were supporting mixed revisions. Which we do
not now.

And if you say "seems" then this sounds like the problem hasn't been
analyzed properly. If this can happen with the current code, then this
needs to be fixed in stable. So, how do you trigger exactly?

I'd like to reproduce it myself.

As to this patch: it should simply be removing the retrying instead of
doing silly crap like

	bool retried = false;

...

In light of how a lot has changed since last time, yes, please redo the
patchset ontop of tip:x86/microcode, keeping in mind now that we don't
support mixed revisions anymore.

Just like dhansen said, you can split it in fixes and new features so
that it is not too many patches at once - your call.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
