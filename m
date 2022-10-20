Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA46066D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJTRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJTRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:15:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96CA11CB6E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:15:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bb5so14117646qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjCIvltI0ARLYzme57GBWPzsPtp5yIBno5BxRybpBv4=;
        b=Mlaw76yVOCJBJ1ofH8MPx8eyepdOSsu+famkgGAMJrc95zrEp6DmfTCo0zuyLDWSiE
         iFlMT4mxm9bQY+JL+GZWhgnHt5O77Bzgu3q2a+cy6zyfJQZ3FbJWoKpdOg+X4kQ2No2C
         J1g+GUToVB+LNJXErAbrKYJGoEhsy/OrFwJKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjCIvltI0ARLYzme57GBWPzsPtp5yIBno5BxRybpBv4=;
        b=cNAtJlepCC2HWA+AA/lyJu78NF59H9nWzX07JcL7ViTRKuuYEhQmTlvK7VsJWmew1x
         aGCDF1o6C+Y/09Qy+bRkZ1vKUpdSqLYjbDt5TiQLSgwsggTWxd08Km7DBHnpBVYog4Ge
         1zN2WQqTX8QjjXhEn2uVHgbkLxVpJU+Dn1wZhxOoXEUpkLRWAFzYmG9AlbbyQhN75VR0
         cSLi2lEfCCFgsZz2XLZaNfbibhfAp0PJzMYB9WEp0GOTUrRlsLPbtdChiYpMNhLkLa1j
         mGTVgw3/CQp2GBr+Mx/MFDXn94aOnW8dvJ6x/DU8rxr+qN1PLN4xPvH79eELCPB2zjAz
         2cwA==
X-Gm-Message-State: ACrzQf0YTjE4B8AJSWI2DekZHu/TWZQJs/+FAHha/qfVy2VyzcuR4km4
        frLx/q9eksJZCjWvAbX3/aMRhnajtzZySg==
X-Google-Smtp-Source: AMsMyM40NwVSP2YuVFeBxF3jO6y7puCVkyFY2RFvQQw8+QXE5s4PtmZxUybpJaataOS2H8KOqw2gbw==
X-Received: by 2002:a05:622a:449:b0:39c:d73a:e7d5 with SMTP id o9-20020a05622a044900b0039cd73ae7d5mr12165400qtx.276.1666286113439;
        Thu, 20 Oct 2022 10:15:13 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b006eec09eed39sm7432165qkg.40.2022.10.20.10.15.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:15:11 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id r3so365358yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:15:11 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr11908187ybk.501.1666286110963; Thu, 20
 Oct 2022 10:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
In-Reply-To: <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Oct 2022 10:14:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
Message-ID: <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com
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

On Thu, Oct 20, 2022 at 9:28 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Nice catch.
>
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Can we please try to collect these all in one place?

I see that Andrew picked up the original one for -mm, but I think it
would be better if we had one specific place for all of this (one
branch) to collect it all.

I'm actually trying to do a "make allyesconfig" build on x86-64 with
both signed and unsigned char, and trying to see if I can script
something sane to show differences.

Doing the build is easy, but the differences end up being huge just
due to silly constants (ie the whole "one small difference ends up
changing layout, which then causes hundreds of megs of diff just due
to hex constants in the disassembly changing".

I think the problem is that I tried to do the vmlinux file after
linking to make it easier. Doing the individual object files
separately would probably have been a better idea, just to avoid this
kind of relocation offset issues.

There's not a huge amount of pull requests (the week after -rc1 tends
to be quiet for me), so I'll continue to waste my time on this.

                 Linus
