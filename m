Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D8965C47F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbjACRDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjACRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:02:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2710A5;
        Tue,  3 Jan 2023 09:00:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z11so28861470ede.1;
        Tue, 03 Jan 2023 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XGF/oHYkE2lnb+e6AM2YoeOvVTcCohPHHsm6JMBYZU=;
        b=JDnCpKyYZH9ch/oXO9ePdMr6nXo6+0cW9i508hhjlh5zT44nCdfAggvBsb9VuWsgF3
         pm7qz9lvpzvNIDdnZ9rJHOeOwiYK7PcIkFW1Gwa8q/fwah8DGmsKuPGGCxvJgNGMF+3I
         wkfn1AF+Oj0zsjmJnnjuFUlHdu5RDBopb6hQLhxL+uRnDZEmL8VvCEWWFhzSt6G94Kua
         SLN8u2wr98j/CzArKxSPgzhT0xP9cKSG/qRfu0SVKiD/TyBjqjM/zB/Hz/0McDHCH1WS
         Qpwo72f4apurBO+drAOl1SEAm40lNuCIXq2wji+g4uWYU4Lp3iAhY1y0KseaA7OzfDc2
         SeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XGF/oHYkE2lnb+e6AM2YoeOvVTcCohPHHsm6JMBYZU=;
        b=hHdo7pO7CV4fKLdCkoVqV6R7ir5h1qPiyj7sEDK1s/2QOnEfqJ5SkoHzlln7Ry+q66
         GbRSAZ3zFaDmIXVifZ7QRX8HmA05FAi54z04bvDLbLX62KeYggGrVhwa+BZaUJmfl+Vn
         o+EacIqU8/NBI21jaulGAC0TrK3QOTISIdDCychtLWsw+gV3pcV19ig3nGX8VZr3U+SM
         5xKBA2PdbsKvrSN6KjWgQk7HZm0Yt9ez7FCw5veG5pTFiLeNaXEvyjmpFNzFcdehPcpb
         iXIvGjXinvfvKh7WHswY2u8LtT2kkdKBwgHS++vTiJkvmzqsj9rZrI5c3Rl2xPTJ8h1H
         iGJw==
X-Gm-Message-State: AFqh2ko1q8gzobAmVq7VnukQBE/kmOO5oposgrLgS8MUUOMMmAuxeBDz
        OzzWBJ0N4c0BG/O8tFb3qrQ=
X-Google-Smtp-Source: AMrXdXtSYbu5hBJ16foCqcNUSZci2xbRQgMPpDknr2ME3NpvEQ7R5l7mS/T8utPIRP3G+YPQUXMw6Q==
X-Received: by 2002:a05:6402:1f89:b0:47b:16c7:492c with SMTP id c9-20020a0564021f8900b0047b16c7492cmr43128963edc.25.1672765252973;
        Tue, 03 Jan 2023 09:00:52 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id da14-20020a056402176e00b0048b4e2aaba0sm5018870edb.34.2023.01.03.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:00:52 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Jan 2023 18:00:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v14 1/7] x86: lib: Separate instruction decoder MMIO type
 from MMIO trace
Message-ID: <Y7RfPnyK/25pxpKs@gmail.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com>
 <Y7RA3bmko0AjO8hQ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7RA3bmko0AjO8hQ@zx2c4.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> On Tue, Jan 03, 2023 at 11:32:14AM +0100, Ingo Molnar wrote:
> > 
> > * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > 
> > > Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
> > > Rename the insn ones to have a INSN_ prefix, so that the headers can be
> > > used from the same source file.
> > > 
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > ---
> > >  arch/x86/coco/tdx/tdx.c          | 26 +++++++++++++-------------
> > >  arch/x86/include/asm/insn-eval.h | 18 +++++++++---------
> > >  arch/x86/kernel/sev.c            | 18 +++++++++---------
> > >  arch/x86/lib/insn-eval.c         | 20 ++++++++++----------
> > >  4 files changed, 41 insertions(+), 41 deletions(-)
> > 
> > FYI, I've applied this fix to tip:x86/asm, as the fix for the namespace 
> > clash makes sense independently of the vDSO getrandom feature.
> 
> I guess you missed the conversation with Borislav yesterday about that.
> He mentioned that I'd just take it through random.git when this whole
> series goes in.

Please base your tree off on tip:x86/asm then (or pull it in) - it only 
includes this patch and another trivial patch at:

   a0e3aa8fe6cb ("x86/insn: Avoid namespace clash by separating instruction decoder MMIO type from MMIO trace type")

We often modify these files - roughly ~4 commits to arch/x86/kernel/sev.c 
alone per cycle on average - and it would be better to avoid conflicts 
here.

Thanks,

	Ingo
