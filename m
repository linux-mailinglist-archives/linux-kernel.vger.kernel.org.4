Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5369E517
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjBUQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjBUQsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:48:14 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A32BF3E;
        Tue, 21 Feb 2023 08:48:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4B918419B4;
        Tue, 21 Feb 2023 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1676997469;
        bh=q6BVFwfAIWk2OOLv8SyurVmk8P7KEbhEcGD+6P4fo20=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=w0kjcj7XYcDPhignP+eQ2qVh5HGJmQQ5Rx8/rTVI+M3XKsWAVsJgXHLtFC6yA7tdh
         1mIlDwj1XY5GuRUas5orrfa/hBoUc0ADGq41U82jJOlxSw8vTBpQRjsqjTBq8jyQ5E
         /vBGrRmen+YGGa5UjbgtXO91BRGyQYlx8DW01OuJgHxVPTTOvnknbJUvH6Je39VRVW
         cmgoUfjK/Mc7kcdUZcltbB2VzQ43KtxNNhOUmqPv7ztXJhMD/8h0Jd6QG9Us0HYhva
         4GUPYxJXK3f/KF9DcuZmb9kAJh4m6UI/dPxGruORvMh9yk6x/wvYF3ncnGJCXKMBnL
         dJ+sO2KR8E6Pw==
Message-ID: <25f16677-8633-8c06-cf67-8024fae7854f@asahilina.net>
Date:   Wed, 22 Feb 2023 01:37:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Content-Language: en-US
From:   Asahi Lina <lina@asahilina.net>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
 <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net>
In-Reply-To: <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 01.27, Asahi Lina wrote:
> I think that's the better approach, but I was hoping to leave that for a
> future patch, especially since right now I'm the only user of this API
> in the upcoming Apple GPU driver and it only uses it to implement some
> really simple timeouts for polled operations, which isn't much API
> coverage... I figured we might get a better idea for what to do once a
> second user comes along. For example, do we want straight methods like
> that or std::ops trait impls? And do we make everything fallible or
> panic on overflow or just wrap?

Also, it's probably worth mentioning that this kind of refactor can be
done without rewriting all the user code. For example, here is how I use
the APIs:

    let timeout = time::ktime_get() + Duration::from_millis(...);
    while time::ktime_get() < timeout {
        [...]
    }

Even if ktime_get() starts returning another type, as long as it can
interoperate with core::time::Duration the same way, it will continue to
compile (and if it only interoperates with a new kernel-specific
Duration, you'd only have to change the `use` statement at the top).

~~ Lina
