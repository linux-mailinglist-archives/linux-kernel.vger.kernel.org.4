Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76AE65B2B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjABNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjABNg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:36:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52630F2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:36:58 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D33F81EC050D;
        Mon,  2 Jan 2023 14:36:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672666616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pN93SdFoWRjgufplLvovHBgkU18si3SSvteu6HEOv7w=;
        b=SQPDA0DLFhtzjyX2dAb8R034c9ZqeVlusKHWUArsNmWBQtJqJnx9PDXVPtNpMJa1fad3+L
        x6BaxUaPpN1MHbzF015TN3izC0amQRNJFXD39W8zKd86Anp3WRftYxvrnbdkCSBPwFNdBV
        3RhZajVD6cZbp5VPzAsQWwgnd+TpQ38=
Date:   Mon, 2 Jan 2023 14:36:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, kraxel@redhat.com, philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7Ld9MVZC3/fsj9Y@zn.tnic>
References: <Y7A9nBud6UeH+wYd@zn.tnic>
 <Y7A+YELM7m5E2PUQ@zx2c4.com>
 <Y7BGIAL4z6o6FEI5@zn.tnic>
 <Y7B993P1+jYB/etX@zx2c4.com>
 <Y7CGzde+qPB7YJP4@zn.tnic>
 <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
 <8f072588-7d66-0932-7486-ed9159ae93ae@zytor.com>
 <Y7JzTh8JnMXM6ZPS@zn.tnic>
 <Y7J3B50kn1kWrxlk@zn.tnic>
 <CAMj1kXHDw5p5yX25TnKiQ7sgqVbhEjB+=fu=7Oz67shQD-fL6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHDw5p5yX25TnKiQ7sgqVbhEjB+=fu=7Oz67shQD-fL6Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 10:32:03AM +0100, Ard Biesheuvel wrote:
> So instead of appending data to the compressed image and assuming that
> it will stay in place, create or extend a memory reservation
> elsewhere, and refer to its absolute address in setup_data.

From my limited experience with all those boot protocols, I'd say hardcoding
stuff is always a bad idea. But, we already more or less hardcode, or rather
codify through the setup header contract how stuff needs to get accessed.

And yeah, maybe specifying an absolute address and size for a blob of data and
putting that address and size in the setup header so that all the parties
involved are where what is, is probably better.

But WTH do I know...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
