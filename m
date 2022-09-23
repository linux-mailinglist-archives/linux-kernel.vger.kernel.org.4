Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628ED5E792D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIWLNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiIWLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:13:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB931332E3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:13:38 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07EBA1EC0662;
        Fri, 23 Sep 2022 13:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663931613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rkoW5rNGCmjILWb9Cp3VEqx+TOEJ4yVNiPQzxqW+QPg=;
        b=g9GPbvgEItVi5Ebt+PaUSUyS/XMQb+bSsBr3p3sUMEv4ftxrqMoSFwnHpYZfbVJDg9uGw3
        dAs0TESb0ohzNOMwAw/Okv2kLbEn9PPnjFzjq5x/YSpX2ZEb0SpIOVFE/GhUGCka/UUhZu
        GQyn+4UNYyPpi9Su8XQXbcclTutE+JE=
Date:   Fri, 23 Sep 2022 13:13:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Yy2U2BW6Tx0imGpK@zn.tnic>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923005827.1533380-1-dverkamp@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:58:27PM -0700, Daniel Verkamp wrote:
> In the "Fast Short REP MOVSB" path of memmove, if we take the path where
> the FSRM flag is enabled but the ERMS flag is not, there is no longer a
> check for length >= 0x20 (both alternatives will be replaced with NOPs).
> If a memmove() requiring a forward copy of less than 0x20 bytes happens
> in this case, the `sub $0x20, %rdx` will cause the length to roll around
> to a huge value and the copy will eventually hit a page fault.
> 
> This is not intended to happen, as the comment above the alternatives
> mentions "FSRM implies ERMS".
> 
> However, there is a check in early_init_intel() that can disable ERMS,
> so we should also be disabling FSRM in this path to maintain correctness
> of the memmove() optimization.

Is this something you hit in a real-world scenario? If so, how exactly?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
