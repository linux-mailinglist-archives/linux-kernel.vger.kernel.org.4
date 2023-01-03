Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E665C248
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbjACOv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbjACOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:51:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBC3EE29;
        Tue,  3 Jan 2023 06:51:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA354B80F98;
        Tue,  3 Jan 2023 14:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AC1C433EF;
        Tue,  3 Jan 2023 14:51:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EqnD+Mhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672757473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+RLDe/8vohQzP3TtQehHcZpEOOCmmguq+K5+MMOxGoY=;
        b=EqnD+MhecEi8D9Zl9NkxthSAqw0o5RwggsXq4P4l0H/DwihZEWFHT2HX0nGFf+Gk76LKxz
        rfHwwmvDjdE/dt8X8mMRnEQi3TOcLL5HL6oRCCxCojAwnAOcZDxKNmBGDw5fOQHMAhUu3X
        KhMLfBvCKlwMsrjlZqz1Bxa6sthkZjA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cc3c3e28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 14:51:13 +0000 (UTC)
Date:   Tue, 3 Jan 2023 15:51:09 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ingo Molnar <mingo@kernel.org>
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
Message-ID: <Y7RA3bmko0AjO8hQ@zx2c4.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7QELo9etPM8Tpx5@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:32:14AM +0100, Ingo Molnar wrote:
> 
> * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
> > Rename the insn ones to have a INSN_ prefix, so that the headers can be
> > used from the same source file.
> > 
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c          | 26 +++++++++++++-------------
> >  arch/x86/include/asm/insn-eval.h | 18 +++++++++---------
> >  arch/x86/kernel/sev.c            | 18 +++++++++---------
> >  arch/x86/lib/insn-eval.c         | 20 ++++++++++----------
> >  4 files changed, 41 insertions(+), 41 deletions(-)
> 
> FYI, I've applied this fix to tip:x86/asm, as the fix for the namespace 
> clash makes sense independently of the vDSO getrandom feature.

I guess you missed the conversation with Borislav yesterday about that.
He mentioned that I'd just take it through random.git when this whole
series goes in.

(Unless of course you wanted to put this into 6.2? That'd be easiest for
me.)

Jason
