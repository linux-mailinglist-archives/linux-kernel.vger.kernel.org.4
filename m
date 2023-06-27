Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E72740578
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjF0VLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0VLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:11:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71158199B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:11:29 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0545F1EC0178;
        Tue, 27 Jun 2023 23:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687900288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UfRVw6XHCHepKGIY3+aHuEUC+en1TYBSByjLOvV8eeI=;
        b=bQ7boCuj7tiu8Dqvb/UXGH2i/T8GQ2tlPKRZpXbJa3JPhy7IJJ4h/6uCmMuzR8zFeSoJPX
        uZRsWu7z4s6gRYot+DfSRYlj9fJxLinMcw1wExXbr96rZ5HrE4N7aL5iT4AY5HO0L0E5WE
        nYJiyVkd69R5zeRXuGhBKshplMhmRlo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eUWxhy1zrAQn; Tue, 27 Jun 2023 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687900284; bh=UfRVw6XHCHepKGIY3+aHuEUC+en1TYBSByjLOvV8eeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3hK6ql21L6eOrPRbU9yB7uSgHyKdoQj0F1aKphlfqAMXexxlBijh6vmB6LPcFk0i
         pvPFoTPyZNw7ql0ngBg9uKEOdkVAj0b9LTNkk6g3aiXyQZxtzuwcx5H+xbZm8ONW/1
         9ASJZWPCFlm6JlV0ed6yn3c0BglKZEy7kjNMEUEamghJrz05+ziDBSmTd8yHE+fnYj
         QubwB7zMrWDycj4gYo1WZODoE9M7F3uOwofBStnyND17rq+eJGRuKFPeH87ayHE6cJ
         8ujfhagTWG98yUgstfjBNSW2hvxat4r77sv1cOj8qpb+7OQtVpNhQ8bjT17EbQJTtI
         KZ2OJalzEjRczuZCeTzEIECr4QuW+ZcueXqPYigpfsVVTt7c1s9K8Ac1N6Xh73vgAx
         X+ERxqfaRTwa0aK9VPnde1Fj8KXmTKGAl6StaIg091jeFeOOq+7hx1fXgB7kiKpuoW
         P6rGt7V47iNXC2fBDSre0X2gPdZbWBRhITJJnUE7rBww8e1Xa2TSCugaq04vB27j4i
         kOU47QhSY2gyHGJ7rNwE0jH3KzFcq0KyrdlatBSAFRrlQuvIhStt3g7xE/Cr4SkAlA
         hNxDC8HONxUSuTWLefyIAG6M0u3tzacHj+SnGyOLWhYoL+hucWKzLHqgSK3UYzeTkk
         cPXxV6ihRfhCckWSqDIWWtPs=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5543240E01CB;
        Tue, 27 Jun 2023 21:11:19 +0000 (UTC)
Date:   Tue, 27 Jun 2023 23:11:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/misc for 6.5
Message-ID: <20230627211114.GLZJtQcr0MaEqcPwI/@fat_crate.local>
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com>
 <20230627203829.GKZJtIxQhQoC6erNva@fat_crate.local>
 <CAHk-=whR90bEKrOKmk0O8KtX77bTFQGu3ykDDRhTGwmAw8HzYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whR90bEKrOKmk0O8KtX77bTFQGu3ykDDRhTGwmAw8HzYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:49:12PM -0700, Linus Torvalds wrote:
> That explains a lot.

LOL!

That activity has one rule: don't send the code on the same day as the
pool visit. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
