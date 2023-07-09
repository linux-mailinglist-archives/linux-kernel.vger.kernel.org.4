Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD61B74C6C9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGIRiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjGIRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:38:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC1106
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:38:50 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F16B1EC095B;
        Sun,  9 Jul 2023 19:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688924329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZIkpstv09ZKhZyWLWFz/FSqHjFx+e70Btrkc+S+Dxe8=;
        b=Ci6D9Pj19ZObwexiIBMy/5H2C0noiQ0j0oLeCK/zh3Co/m39DxPVnmJZxuyKlJxDMqVmXs
        3fm4siYPMPw816FhL2hO5ETpVWJQ7lA+ca76HenRsnph70g0IiVOzGK1nAoeLtHoSefjzl
        0zvbWrxgrohwIOf10giljZfxLjXE0EE=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SwNqaHvRmjj7; Sun,  9 Jul 2023 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688924326; bh=ZIkpstv09ZKhZyWLWFz/FSqHjFx+e70Btrkc+S+Dxe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yq00ATmzBggX7uKqIs0xhzeLLkf2V9pBRbDF6lrf1lgEXQ6cbBTgIblRsszxcArKq
         qCRgGfflzthZ7l3Tgz795oHWWMG/Sw7YedlENyrToaWuSPQCs2cVU1cZuarIHXgKNF
         D8FAN+TeQCV5OLr69IykMqhpSaKiB26uL3oFgs9tfNIPacEPIgSB86UV/EjuusN5yW
         oV1opdJ4OmbzdhUikrx9ohbshKUuQ2t9kb0c7nhUIqHDgJiUbuHOze9uEfMe5zxG39
         58i8qYSHpJMmW2uwjV9qrbswHPMh4SgDh1RHh5v4QBCair2UtgJ5bpPCxKBfEZ1r9a
         MWjnOSmk2GPphlmuldSjTWzF3FYaJnyNz8bljFIGoCN8jY/8lDCT2FUQI7PZ8lEMrd
         a6rqLdqawITNLA1MyBS5IqkdjofEXGG7KP+AyTcNQyr9yozIQBWxPjPot3zYrcgXJd
         RWdqqrmzsRIw0cuWLmJxHB4pN3iqah7SOyyP0WpWHtHk3C9IjpHpIH7uWXPK9zCUtD
         hU2btcTsPTDbaMt4Bdh/B4cJHxTxSB91HSD2RM8vciXVsksQHPChXcF4/T+ACvsUf/
         hoqtNgHJkuMQit/PrRY44w7M3Yc9lAtR1/P/RX2RLhsE96w82M9HbzRhfOnLfTB0lO
         sRtEJOehJu5jxa3dXetyN2cA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18F0C40E01D0;
        Sun,  9 Jul 2023 17:38:43 +0000 (UTC)
Date:   Sun, 9 Jul 2023 19:38:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] objtool/urgent for v6.5-rc1
Message-ID: <20230709173838.GEZKrwnm5LFMIfyosG@fat_crate.local>
References: <20230709081903.GCZKptd16D1sbcDoIy@fat_crate.local>
 <CAHk-=wiY8nehcZfNA6vo_vws7TqvwcDrPNt6_McqkHXs4zbuNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiY8nehcZfNA6vo_vws7TqvwcDrPNt6_McqkHXs4zbuNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 10:20:39AM -0700, Linus Torvalds wrote:
> I had actually applied this directly last week already, since it was I
> who had missed the semantic conflict.
>
> See commit 06697ca69bca ("objtool: Remove btrfs_assertfail() from the
> noreturn exceptions list").

Ah ok, for some reason that branch didn't get zapped in tip, hinting at
it needing to be sent.

> Your pull request would obviously merge cleanly, but I'll just skip it
> as "nothing new".

Right, no need for that.

I've reset the tip branch and thus zapped the commit.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
