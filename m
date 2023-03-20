Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC4E6C2098
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCTS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCTS6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:58:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159B9900D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:50:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cy23so50592137edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679338213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE7joPFSPo91MljcNLKy5Pq7cC1AKr/PO4y5JXEPEWg=;
        b=gpuYOS0dkscNjwEuIVohmjELrl6r2lSuUu+c67EIEDrhfKQALn3zDjkqEi05IAEDXl
         odTX/o04IXoITLhCzJNrY7ipoPPDe9znicl/qUIs12X9Q4axHEEAB7CVBf3j/0Z3CL40
         Vdde7GDU1MEgjfb6BkAreZytiReYrq7QFtHNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE7joPFSPo91MljcNLKy5Pq7cC1AKr/PO4y5JXEPEWg=;
        b=E2Rvhpv7zoqjvlSsCngihQz9x4sr4DgedsVt7zogkQ7DJPCBt7o+h42NtRlH6CMHdt
         9i0imeoP1Jp8AQrRRpcA4x9G1GLk8LmSxFiNvYY+Jhgg22dpiIAH0JlrKp7sPcYdMrAc
         +vgXtS9KwsbDqMqKEDAdpgSaP+2yCx1HahuMFkJLnrA6AUbsdAm3joRCSo1n84hjmI2q
         fAEhwu+bRYA4L4P2LTzjTTn1irAEfxmZxNQMbSvQ933GipjOYwrhaEQQClN/vgf9ZaEC
         3gXQzASpKXEuACDJuWcedFV4WA9d6sZ+Evno4AG/XhlL32JD5+qAPHr4Z8y+GgSVw2tR
         H0sA==
X-Gm-Message-State: AO0yUKXlNSA69iImStIbfg7+BZdle/BSd05eyhPkAKyebXNe9R7fzH6L
        vZI7L9ke+VYSxaaKvchro8RE1UzO9RE1jcFVYZUs63Ah
X-Google-Smtp-Source: AK7set+Td4Rx8YIUfkU98v9y1J1DSvDQ4v5RMPh1Yd1D8yKKhwslJTG+IAL7UOsnIiaF3aDSiOid1w==
X-Received: by 2002:a17:907:bb8a:b0:931:4896:6674 with SMTP id xo10-20020a170907bb8a00b0093148966674mr109594ejc.23.1679338213098;
        Mon, 20 Mar 2023 11:50:13 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0092b606cb803sm4838152ejp.140.2023.03.20.11.50.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:50:12 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id eg48so50592112edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:50:12 -0700 (PDT)
X-Received: by 2002:a17:906:aac9:b0:927:912:6baf with SMTP id
 kt9-20020a170906aac900b0092709126bafmr17779ejb.15.1679338211916; Mon, 20 Mar
 2023 11:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X> <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 11:49:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXi1qgeDLHbaCyMpZ4XXYqS=fT2daYAmWntEK2rhG25g@mail.gmail.com>
Message-ID: <CAHk-=whXi1qgeDLHbaCyMpZ4XXYqS=fT2daYAmWntEK2rhG25g@mail.gmail.com>
Subject: Re: Linux 6.3-rc3
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:26=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. I do my arm64 allmodconfig builds with gcc, and I'm surprised
> that gcc doesn't warn about this.

Side note: I'm also wondering why that TEGRA_HOST1X config has that
ARM dependency in

        depends on ARCH_TEGRA || (ARM && COMPILE_TEST)

because it seems to build just fine at least on x86-64 if I change it to be=
 just

        depends on ARCH_TEGRA || COMPILE_TEST

ie there seems to be nothing ARM-specific in there.

Limiting it to just the tegra platform by default makes 100% sense,
but that "only do compile-testing on ARM" seems a bit bogus.

That limit goes back to forever (commit 6f44c2b5280f: "gpu: host1x:
Increase compile test coverage" back in Nov 2013), so maybe things
didn't use to work as well back in the dark ages?

None of this explains why gcc didn't catch it, but at least allowing
the build on x86-64 would likely have made it easier for people to see
clang catching this.

                   Linus
