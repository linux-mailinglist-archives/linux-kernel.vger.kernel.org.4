Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058FD662C90
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjAIRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjAIRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:23:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6EB3FA35
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:23:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t5so4526335wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jJSw0zXn2XrwWEafrZ3cCToSJfCdJ33DUCzeP7fqZM=;
        b=h7vLNcRAyYdMU5oOvZjHe38NLJByqkX/wxmqaW45oUBRWUOXnVdP+f+651CvVQnM3N
         kogByu3Y+X2NNoX0O5Kh/dnELxBrVw+8OXAVyXL1XHv5KHIXQL31LUPxOgeddd2O2erT
         kjRO+8Kivt9bdDKK3q2w4i/vJqezrbmOrqp7ITy7/EvsM2Azw4G2a/GTXDhfbHk/ll/u
         kXPP7SZsQGzQ1mF7sdcUPyc+U/tmsLCyFLetlUhImnGHgLgiZjSXLtif5UJbywcWzZ2c
         Hvc/1HMbEE4K7PZ0aQGF+CHvkpl1pF+mkTMhS4SgMEnVXEaoAoZwGJsv0wieEFU8mz+d
         6yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jJSw0zXn2XrwWEafrZ3cCToSJfCdJ33DUCzeP7fqZM=;
        b=kQeezHy3PwbxUZpa1ah4/FQEYmdg9Ofk4+qkLXTl8a8cRexclGHzYxkc9He2un5mcn
         447kdPD1VRHvQoB3sIIVhghc6/TET/5jdOnNUJgEng8Abo6mT7UmlGMHnB4Aw2ti4sBQ
         ABRUS3UbFZYmdtE7m7R9uwQq0is7mZ916gBMlZ7uPZSR7xY8cKwza1A8WkLohOW+gKA0
         o0WdYNp0FsjXo5JGdl0BeW92KucQ/VA/ZSK83dvtGLRkM1VeTrtVl30LFgcNni+OD0BM
         T8JOezy2+J6OP3tMK4OghghOtLB4es3ivSUXhk29b8pyVvo15jeIa3qVjNg9s9m0QE/x
         JIzw==
X-Gm-Message-State: AFqh2kphZ2BO0uuOiuFiD7u/GTE0owSuFk+gSirtyW1D+Z0GGfFdzZzr
        wF37A3zYuGno/rmH80WI8VE31i3k8G0=
X-Google-Smtp-Source: AMrXdXuooADhAsS+Btn4Jip+2zFFO1VZGCzbDojsYwJEjT3mQCBYeh6MU1Gm13O5GOmorWEqBL8/KA==
X-Received: by 2002:a05:6000:11cd:b0:27b:5c94:d52c with SMTP id i13-20020a05600011cd00b0027b5c94d52cmr38471481wrx.12.1673285027518;
        Mon, 09 Jan 2023 09:23:47 -0800 (PST)
Received: from gmail.com (1F2EF719.nat.pool.telekom.hu. [31.46.247.25])
        by smtp.gmail.com with ESMTPSA id j11-20020adfd20b000000b0024207478de3sm9015257wrh.93.2023.01.09.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:23:46 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Jan 2023 18:23:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] x86/boot: fix relying on link order
Message-ID: <Y7xNoPT9aC/nIbnM@gmail.com>
References: <20230109170403.4117105-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109170403.4117105-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexander Lobakin <alexandr.lobakin@intel.com> wrote:

> Currently, the x86 decompressor code expects the kernel entry point to be
> exactly at the beginning of the kernel image. It's always been true, but
> is hacky in multiple ways: special .head.text section and linking certain
> object files first to have them at the beginning.
> Make the code independent from the link order and then kill the latter.
> The former is to be resolved a bit later.
> 
> I didn't put any "Fixes:" tag since it's not linear. The lines changed
> with 0001 came from the initial x86 KASLR series, but that unconditional
> jump to the kernel beginning already was there. It goes at least from the
> set that brought relocatable kernel support to x86, but this is quite
> prehistoric already and might not look really relatable.
> 
> Alexander Lobakin (2):
>   x86/boot: robustify calling startup_{32,64}() from the decompressor
>     code
>   scripts/head-object-list: remove x86 from the list
> 
>  arch/x86/boot/compressed/head_32.S |  2 +-
>  arch/x86/boot/compressed/head_64.S |  2 +-
>  arch/x86/boot/compressed/misc.c    | 18 +++++++++++-------
>  scripts/head-object-list.txt       |  6 ------
>  4 files changed, 13 insertions(+), 15 deletions(-)

That's a really nice fix/robustification improvement - I've applied your 
series to tip:x86/boot and will push it out after some testing.

Thanks,

	Ingo
