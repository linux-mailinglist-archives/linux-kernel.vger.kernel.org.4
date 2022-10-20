Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC52605487
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJTAjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJTAjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:39:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A7193EE7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:39:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m6so11883228qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tWFty6dFQpYyrkEdAH1uJ4wkhdCD5dnU4AL+htgFXmY=;
        b=GyjTTjrEberaB84XqhfJGUe6Z01GsAcKjAHnBqgJULvR918dxSuZNti9tMFPxpuGlE
         MYZAPh1ARSVn2/jBiolCEQ3kg9ZQ9llE8CPAlIrRJxj2yWaHhmOhxJ9mpdfddf98hnfa
         Es3WUJRJ1Fv9UyZKqqXCbXXO+DHe7Ajo9i65c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWFty6dFQpYyrkEdAH1uJ4wkhdCD5dnU4AL+htgFXmY=;
        b=EjZrairSZXXpUONxtZ4oWexqwkYZmuMaSeIsXoGmUgqJMiMrLXYIfcSrK5USbgBLwg
         H45J++tjcKWWfNPiDiOxR+qt4PlEqwf4TQcWJueH5IgqbT3t4sppkKmbxYiKEHEsXp57
         wXszeUxu4Y7BXqRsh3buk4KNPfutQ00B8J1d3LkBFmu1zMfcFX2dhFONGcCiT3Uk6xKL
         L6lnDkCfcvlYDpcdpKX4R1R2byHih54PLYZibWQG0jVBxnTyRuvkI/kj1onb3+Rj2b6n
         MUWWXcDfNsmGcvy1X45bsuigQesdrAoSf8RE0VD5OH2uRNI5Xq4f17CqepSJDrLcoL7t
         ETGg==
X-Gm-Message-State: ACrzQf32Ay+J3G7n/HsnOAYYCMwWzdmESVHKKLxyuxWfv1hERZVH6Xlg
        eJo7NjgPvGzHT9qqdqMCXQllkk6sAnBfww==
X-Google-Smtp-Source: AMsMyM6Yr53WRbQ07CfcsYGxrgmiy9D04SjYYdinGSUWO5LrqhlX7KzRS30Bf8Tg6T1uW4xyzQf2Ww==
X-Received: by 2002:a05:620a:2495:b0:6ee:b318:32f with SMTP id i21-20020a05620a249500b006eeb318032fmr7723569qkn.605.1666226355181;
        Wed, 19 Oct 2022 17:39:15 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id x7-20020ac85387000000b0039cc944ebdasm5077979qtp.54.2022.10.19.17.39.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 17:39:13 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id z8so12821226qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:39:13 -0700 (PDT)
X-Received: by 2002:a05:622a:420d:b0:38d:961c:a57c with SMTP id
 cp13-20020a05622a420d00b0038d961ca57cmr8975604qtb.678.1666226353131; Wed, 19
 Oct 2022 17:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <CAHk-=wit-67VU=kt-8Ojtx04m6wxfqypKLzW7CuSeEH_9MYZvw@mail.gmail.com> <Y1CP/uJb1SQjyS0n@zx2c4.com>
In-Reply-To: <Y1CP/uJb1SQjyS0n@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 17:38:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
Message-ID: <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Given I've started with cleaning up one driver already, I'll keep my eye
> on further breakage.

I wonder if we could just check for code generation differences some way.

I tested a couple of files, and was able to find differences, eg

  # kernel/sched/core.c:8861: pr_info("task:%-15.15s state:%c",
p->comm, task_state_to_char(p));
 - movzbl state_char.149(%rax), %edx # state_char[_60], state_char[_60]
 + movsbl state_char.149(%rax), %edx # state_char[_60], state_char[_60]
   call _printk #

because the 'char' for the '%c' is passed as an integer. And the
tracing code has the

        .is_signed = is_signed_type(_type)

initializers, which obviously change when the type is 'char'.

But I also checked a number of other files that didn't have that
pattern at all, and there was zero code generation difference, even
when the "readable asm" output itself had some changes in some of the
internal label names.

That was what my old 'sparse' trial thing was actually *hoping* (but
failed) to do, ie notice when the signedness of a char actually
affects code generation. And it does in fact seem fairly rare.

Having some scripting automation that just notices "this changes code
generation in function X" might actually be interesting, and judging
by my quick tests might not be *too* verbose.

             Linus
