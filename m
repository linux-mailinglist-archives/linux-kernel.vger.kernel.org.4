Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A244618655
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKCRoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:44:31 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC51B1A813
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:44:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e15so1714416qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mA1Z7Cm83w+Vyx+oBgGwMaOfCfLAZylXYXAtJ1Raiz8=;
        b=dod+VUiBUEq1hk72lAssa/ES6lzBPt/3grGL93+x6xqazqzSesxF5gOoKjy5hsuBii
         dpyo6KG7QmoqhIT3bctyKBZuOrbntQ/3KSRaUa+QlclegAP50WUv80YibEtoQqHjPJB6
         Uu61/FFf2iArbTLONCqSdQPP9r8phlQw2FnrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA1Z7Cm83w+Vyx+oBgGwMaOfCfLAZylXYXAtJ1Raiz8=;
        b=IjOl7b5jwy58qNWA/+++xRwppZ7Jktxq3r2nOIbwJHrFopuHupI7dkxUk4Bx4fs8mC
         SyqI/aBWTwN43jGZbjcN7tzrwDy7Fopn+wwd06AwM6aLswB/esuG/HlNFm55psu60079
         lUOT+TWFmHHvWM/4GhY7Q7w/WPWEi8FvScuiyolJqtZGrLFVB61S0C4yj3BavoOH/+2k
         ZJcpHgHYA5SufGvYKr2eqTrlaHp8rBp1tUI1W/zgcLkrutLbhd6qZNrbcA7e0dBgNM8D
         bJM1s33iw8T7Y0cZYRg8fj5qiQLdont8E2DUyGp/8vGwcIGG1aEQIPNWPf4pa4yYVHH2
         HOPw==
X-Gm-Message-State: ACrzQf0ozMSNBFDghmcnDTHvVW2o1PXYXQdqGxe3OPVlceHK6hmQMuTS
        Qq+TPp6idW43y2AAkEFGd7z7gKFfy2D/9Q==
X-Google-Smtp-Source: AMsMyM5ExIaEf8/OjZnh2cN/CW1niCKANrmSTW9XFQENKWh7voKGb9QRditgHvc78ZWPsfgDKHcGjA==
X-Received: by 2002:ac8:6f08:0:b0:3a5:45a4:ab59 with SMTP id bs8-20020ac86f08000000b003a545a4ab59mr8346448qtb.167.1667497469776;
        Thu, 03 Nov 2022 10:44:29 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id k3-20020a05620a414300b006ce0733caebsm1142713qko.14.2022.11.03.10.44.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:44:28 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3321c2a8d4cso22503337b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:44:28 -0700 (PDT)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr22362989ywf.441.1667497468069; Thu, 03
 Nov 2022 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <87o7tossaa.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o7tossaa.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Nov 2022 10:44:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh87aGtg3eJPkA31V0Pn22hah0DWRc8oWsQ__5P2SXaTw@mail.gmail.com>
Message-ID: <CAHk-=wh87aGtg3eJPkA31V0Pn22hah0DWRc8oWsQ__5P2SXaTw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-4 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        schwab@linux-m68k.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org
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

On Wed, Nov 2, 2022 at 7:09 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>  - Fix an endian thinko in the asm-generic compat_arg_u64() which led to syscall arguments
>    being swapped for some compat syscalls.

Am I mis-reading this, or did this bug (introduced in this merge
window by commit 43d5de2b67d7 "asm-generic: compat: Support BE for
long long args in 32-bit ABIs") break *every* architecture?

And people just didn't scream, because 32-bit code has just become so rare?

Or is it just because those compat macros are effectively not used
elsewhere, and x86 has its own versions? Looks like possibly mainly
RISC-V?

Side note: why is it doing

        #ifndef compat_arg_u64

at all? That macro is not actually defined anywhere else, so that
#ifdef seems to be just confused.

                 Linus
