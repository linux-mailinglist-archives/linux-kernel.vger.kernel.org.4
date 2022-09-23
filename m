Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B75E80A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIWRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIWRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:25:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA966C9974
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:25:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sb3so2078465ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Crb3s25Omqu1NAMWxHZm/yf1S27deYG0G+HS3v28Yio=;
        b=FF14L68tVamaIMQiJeZWQgYZw39kd7bWTZap3dDOtHw7ZoVSg0M0OAN6/Ob/dPeGRu
         dAxapGSehv7iiwWcUPMvvF2aGZkvKEbGCjUxb81biAjzgP5n09odR+kq4YL1JTGXbA9D
         4bAKDv3dbZ8SU4aVH4qs6Dlm+LMiW+EglP4vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Crb3s25Omqu1NAMWxHZm/yf1S27deYG0G+HS3v28Yio=;
        b=icDwSdTh7WBy6oH3SVc8sCNWDR8jf0777we3RHjyc3gbhaigODJdEaTzmyeUcHo0Fw
         S8vNNtW6UdOnmkJZQHwpGrQBCdG9Z62jcvLpg50JWl+5gbR8BYAKryiNdN4c2/Q/kGpq
         4AYeLUzuq//Y0Gjtp3os4jjrVaDhb6Qs58HaqE/jwfpmY7DFWby+TOQ4LjaPV4KxnuWs
         dhnWKJqrDaBCfvqj5zEpxLN9bqN6bXVXDgIdCREv/qSI41PvPNL5srbIRpT+qvA7jF3A
         WZl5YutB5VERxvThqoZysYoBoILmFlI6KSOwLMUq7SEpQAmOXFyPI0PTKczVX2Zp9DBC
         bXgQ==
X-Gm-Message-State: ACrzQf2zPMFy4ifRDWNzZr2cu6rZPUiCtCazUxRxQ7Z3J69R58Oo4jEO
        Wqo3NlTq4NSfser0mT+of++O9XGtllBHfA==
X-Google-Smtp-Source: AMsMyM5oABKuwJoDQmSXwfcNQVVNwG/y69aBNpQh2FOj7Adv6IskggXUXIoPQ8bkkpap29D4TMCB+g==
X-Received: by 2002:a17:907:1c12:b0:782:a8d6:3f00 with SMTP id nc18-20020a1709071c1200b00782a8d63f00mr3130601ejc.187.1663953933076;
        Fri, 23 Sep 2022 10:25:33 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id r3-20020a1709067fc300b00780b1979adesm4222533ejs.218.2022.09.23.10.25.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:25:32 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id hy2so2089329ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:25:32 -0700 (PDT)
X-Received: by 2002:a17:907:75c5:b0:77a:fd9f:12d1 with SMTP id
 jl5-20020a17090775c500b0077afd9f12d1mr7985087ejc.82.1663953931699; Fri, 23
 Sep 2022 10:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220923005827.1533380-1-dverkamp@chromium.org> <Yy2U2BW6Tx0imGpK@zn.tnic>
In-Reply-To: <Yy2U2BW6Tx0imGpK@zn.tnic>
From:   Daniel Verkamp <dverkamp@chromium.org>
Date:   Fri, 23 Sep 2022 10:25:05 -0700
X-Gmail-Original-Message-ID: <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
Message-ID: <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 4:13 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Sep 22, 2022 at 05:58:27PM -0700, Daniel Verkamp wrote:
> > In the "Fast Short REP MOVSB" path of memmove, if we take the path where
> > the FSRM flag is enabled but the ERMS flag is not, there is no longer a
> > check for length >= 0x20 (both alternatives will be replaced with NOPs).
> > If a memmove() requiring a forward copy of less than 0x20 bytes happens
> > in this case, the `sub $0x20, %rdx` will cause the length to roll around
> > to a huge value and the copy will eventually hit a page fault.
> >
> > This is not intended to happen, as the comment above the alternatives
> > mentions "FSRM implies ERMS".
> >
> > However, there is a check in early_init_intel() that can disable ERMS,
> > so we should also be disabling FSRM in this path to maintain correctness
> > of the memmove() optimization.
>
> Is this something you hit in a real-world scenario? If so, how exactly?
>
> Thx.

Yes, we hit this in crosvm when booting the guest kernel with either
OVMF or u-boot on an Intel 12th Gen CPU. The guest kernel boots fine
when loaded directly (using the crosvm kernel loader and not running
any firmware setup in the guest), but it crashes when booting with
firmware inside the first forward memmove() after alternatives are set
up (which happens to be in printk). I haven't gotten to the bottom of
why exactly using firmware is causing this to be set up in an
inconsistent way, but this is a real-world situation, not just a
hypothetical.

Now that I look at it with fresh eyes again, maybe we should instead
directly patch the memmove FSRM alternative so that the flag-set
version just does the same jmp as the ERMS one. I can prepare a patch
for that instead of (or in addition to) this one if that sounds
better.

Thanks,
-- Daniel
