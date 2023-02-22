Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2407F69EB96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBVACB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVAB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:01:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F062ED58;
        Tue, 21 Feb 2023 16:01:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677024117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xMGpa08Mw3PGW7iuLitm7PdtQJcfT87dyawJM52k+dU=;
        b=MLRi3hb8X5D/TpPJf1xZH6FufcfF1nogAzow0RQ4qibu3fHoWq8BUChC+xpokPf1UwbI19
        uDIqwXHlL3WiQyR5OlFSOl8Ua4hbtrFXhd6LxIgOI2J3cBb7alyaR2+8RTvKAycjEYoFAo
        apHv9u54r5LoPjaK2GNiA8GBe0beGgbzn7QMPW8c4K5F9zOrcqmZTfl09BdyfS4vMxDypu
        wivxsYkl7X34CsTHgOUjBFN9UElRum0bDPmn0JwYFztaoMsouko6M7QxCYYc9urW/ZHNTU
        EmtOngioXVeuJwXSPS6xserCcE28HxGsqWLANZ4LyzAm5wCCRdpkMV9Kt+KgqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677024117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xMGpa08Mw3PGW7iuLitm7PdtQJcfT87dyawJM52k+dU=;
        b=HTJMzuLacM9f1T894foCtmTb5LoD1SKgQ/AGK1UWgN7Vt4zfuKK+4V1gA5yWSrVVOMh792
        NEOgjOiqYk+8+ZCQ==
To:     Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
In-Reply-To: <p7e4M5-kxxScH56bBMtlzht2_m33oSfMPHtExSVbDn0WIPYBEbiJjr2NvNhqCJotFhmYqH5h27EWPDhfSmmST0D-dSU1Alq4_BzDQUR48FA=@protonmail.com>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
 <87h6vfnh0f.ffs@tglx> <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net>
 <87edqioo1e.ffs@tglx>
 <p7e4M5-kxxScH56bBMtlzht2_m33oSfMPHtExSVbDn0WIPYBEbiJjr2NvNhqCJotFhmYqH5h27EWPDhfSmmST0D-dSU1Alq4_BzDQUR48FA=@protonmail.com>
Date:   Wed, 22 Feb 2023 01:01:56 +0100
Message-ID: <87r0uimutn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21 2023 at 21:33, Heghedus Razvan wrote:
> On Tuesday, February 21st, 2023 at 8:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> That's the same the Rust std time semantics:
>> 
>> Duration = Instance - Instance valid
>> Duration = Systemtime - SystemTime valid
>> Duration = Systemtime - Instance invalid
>> 
>> No?
>> 
> I agree with Thomas on this one. The Rust type system is really
> powerful and we should take advantage of it. Time deltas can be
> enforced to be from the same clock at compile time.  Just for the sake
> of it, I wrote a small example on how this can be achieve:
> https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=1d0f70bb5329b181f203ce7270e2957a

Cute. This code makes even sense to Rustagnostics like me.

Thanks,

        tglx
