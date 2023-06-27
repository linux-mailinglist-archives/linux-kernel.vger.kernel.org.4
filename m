Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A769274050B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjF0Uiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjF0Uip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:38:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6EC10D8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:38:44 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDA371EC034D;
        Tue, 27 Jun 2023 22:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687898322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BCCbvqZrB4qJ4Y3BRKHICkFgIZFq7ziciNqD3xemilQ=;
        b=dfcFacrZW3fqbUFJ2YRi7UnjCTn+QllgGKZgaOOohIy/8pK1NskXGvZ17ULCPW0D2uXG0f
        DEv1jmGFxsO8zO/mUAh0ZFhyAE7CqGHwZup1PJI9ORAN/lQbyhyZ0OGOl140lC1OjKZONo
        hDakKVNjx/PO+E8/1px8xWKEBrkA6DA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mOnZG54dxc_F; Tue, 27 Jun 2023 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687898319; bh=BCCbvqZrB4qJ4Y3BRKHICkFgIZFq7ziciNqD3xemilQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpEiqFpXow7Ez4ljXOBM0vKp3EDEtd6sfHootkGUWh2ax1Z0K+KfQsquIcgxLHJOp
         AHmTLUmIp77wuGDwaX2t0Dpb9WaM78flxEwyuT4Szk0aYijqV/0U1t4p0pSuWiF0tR
         fKtDUbM1HJucIovKSFlTgKkOigc1pPJoTv2rPWDu2mMY+J3OBm9xh9MUZPVQ/XnMUb
         F+iaweQGDy57vkRJEwPD/6v/WNuECwzlPysSGVVDulRR00t+EUlA+5FFBi59NrkqHM
         UDoxaSo+cADVyLQeFsncJvng5Lf5E1fA/KwqcSwchgd6fwwIUi0FUTEMYkWlFikp4Q
         QmTYLKmjd8E1NvTKZlTQhYLNVfhbozsyyOhDK7gKkwnNEQJx81WlDrobSB1N7JevPU
         oikBI/18G6FolIYIpj0Pb1Vpq9tKHzHlcJMTRCoEiwV5Cc/Lho6s+8V6UWCeV9MDZK
         hPXfbz/V8sGjTLiwFySlmODG9HWx+RtcN6eSzU55R98iofJtmT/sjL3lEu4LMd8+6I
         b88GqEW1rEARvwYbDm0dFTE2kOU72twIwK4VtZSzeAetVXccum5SYe25BsIx8MdXgt
         okC3tOFhnjcQBHqgDXYPO5DFI6wErRG4y/tBPg+MFsO0Bic3pr7N04HAvwAhrS+jmG
         rsfdtp3xBjTCIiDUraa6/fZQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F39840E0033;
        Tue, 27 Jun 2023 20:38:34 +0000 (UTC)
Date:   Tue, 27 Jun 2023 22:38:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/misc for 6.5
Message-ID: <20230627203829.GKZJtIxQhQoC6erNva@fat_crate.local>
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:26:18PM -0700, Linus Torvalds wrote:
> I will now go back to my cave and continue pulling stuff, I just had
> to do something else for a while. Some people relax with a nice drink
> by the pool, I relax by playing around with inline asm.

And there's a third kind who relax by the pool with a nice drink,
*while* playing around with inline asm. ;-P

Btw, I'll send you a new version of this pull request with this patch
dropped to let folks experiment with it more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
