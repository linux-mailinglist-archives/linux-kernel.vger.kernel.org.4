Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22264D268
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLNWg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:36:24 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255F303DC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:36:23 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id r3so3869902vkq.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MY3UvV8qfuLmW0mh3ybluVgZmmXLT9RgvRtqrNrsplM=;
        b=D8RE0ezI/Lyj8q5qGGcq3x0sUWunzNzjb66SVYEcT/P+p9Ue1GROhZrW23y28kjnuD
         TZhbgfsULXArFtBuvJdve4LNtsWToqAoDF6+2rJb1d6Dh6qk6VO0hTlXlomhrggptvrd
         /wligCEbFkAan+tADLhFsapmTxxu77phHhzTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MY3UvV8qfuLmW0mh3ybluVgZmmXLT9RgvRtqrNrsplM=;
        b=UVsO75/ahnFrsUjfqI0foHWwonYtKSdJTetOMiz5FTa44oJ3h/HBE7o1gkYMwdvUzL
         je2Pc/1Hh2pmA8qwuKHchdpBat4WH/aosfenJY0dFpCmJ2yf9Ulwhb7ejYKhQJ7ixg44
         BwGdV1A4pH9mNzgnXo53IZed31XNcfQYZgeJY1Z6ufiDNcX+iU6XGxhEnI6zBbC1emTr
         OwQZLjBAu93oWDfn8C0H0l0UUD/YZJV93sB/NgrT01yCxDjCEZbaKlEjVh5Ff9CoALgy
         88dMYd/WtaC/V6nl+lAkOrbtuxPucrxnwfZg23ZEzKHr73AS/pkiRmgvXFcTdqJuhuw9
         elrw==
X-Gm-Message-State: ANoB5pmzKCiRVUaqAOleXMDszBug3wVk8NX8j3tdLTbW+j0Gloyo+83V
        fqDFtww390LBJ1B0fHVXUJG4RKjH8Rw4jKrf
X-Google-Smtp-Source: AA0mqf7n0w1rzdsLlUlSNHBQfnMkxKpq6R74a0L+lUvDn8uCLpBK6gBehSvTf3w4xOBJzeVuELPEEg==
X-Received: by 2002:ac5:cb73:0:b0:3c0:f9ab:4821 with SMTP id l19-20020ac5cb73000000b003c0f9ab4821mr10331436vkn.5.1671057382134;
        Wed, 14 Dec 2022 14:36:22 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id d125-20020ae9ef83000000b006ee8874f5fasm10369848qkg.53.2022.12.14.14.36.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 14:36:21 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id z17so1902777qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:36:21 -0800 (PST)
X-Received: by 2002:a05:620a:4890:b0:6ff:a7de:ce22 with SMTP id
 ea16-20020a05620a489000b006ffa7dece22mr547175qkb.72.1671057380778; Wed, 14
 Dec 2022 14:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
In-Reply-To: <20221213174234.688534-1-dave.hansen@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Dec 2022 14:36:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
Message-ID: <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.2
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 9:43 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> This also contains a new hardware feature: Linear Address Masking
> (LAM).  It is similar conceptually to the ARM Top-Byte-Ignore (TBI)
> feature and should allow userspace memory sanitizers to be used
> with less overhead on x86.

Christ.

Is it too late to ask Intel to call this "Top-Bits-Ignore", and
instead of adding another crazy TLA, we'd just all agree to call this
"TBI"?

I  know, I know, NIH and all that, but at least as long as we are
limiting ourselves to regular US-ASCII, we really only have 17576
TLA's to go around, and at some point it gets not only confusing, but
really quite wasteful, to have everybody make up their own
architecture-specific TLA.

And while I'm on the subject: I really think that the changes to
"untagged_addr()" are fundamentally broken.

Why? That whole LAM (or BTI) is not necessarily per-mm. It can easily
be per-*thread*.

Imagine, if you will, a setup where you have some threads that use
tagged pointers, and some threads that don't.

For example, maybe the upper bits of the address contains a tag that
is used only used within a virtual machine? You could even have the
"native" mode use the full address space, and put itself and its
private data in the upper bits virtually.

IOW, imagine using the virtual address masking as not just memory
sanitizers, but as an actual honest-to-goodness separation feature (eg
JITed code might fundamentally have access only to the lower bits,
while the JITter itself sees the whole address space).

Maybe that's not how LAM works on x86, but your changes to
untagged_addr() are *not* x86-specific.

So I really think this is completely wrong, quite aside from the
naming. It just makes assumptions that aren't valid.

The fact that you made this mm-specific actually ends up being an
active bug in the code, even on x86-64. You use the mmap lock to
serialize this all in prctl_enable_tagged_addr(), but then the read
side (ie just untagged_addr()) isn't actually serialized at all - and
*shouldn't* be serialized.

So I really think this is a fundamental design mistake, and while I
pulled it and sorted out the trivial conflicts, I've unpulled it again
as being actively mis-designed.

                Linus
