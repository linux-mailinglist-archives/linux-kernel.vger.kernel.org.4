Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5069E9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBUVrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBUVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:47:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319C32516;
        Tue, 21 Feb 2023 13:47:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677016020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cP88n+Q0Efs6fNs0zhSu0osDsFH+tYMLLvPbqm6DPTs=;
        b=eWBOmMrgb5OWr8fqdcszqqAq++ZQeEJSp+355MsgnJ4PQ3bksoebZn8Rb5shK1dYL2VHoN
        SgkEzuIHr6aDsc3wviMWOrC44VDsAmwHeJHAuvjYqkYIPuV/b0pT4XkyhIG1vGflKKRxYS
        MiXC/izWpRd3otRc4F4YDn6UWcbk+OyWYEWJMh9N9xxOHSvAmTzMY8jmcdSgtkdc/EFmDW
        T+SwlAZMJxBP8XWGATNJV8Gz8nDda9RKkjxZtzvnAqGmJG/bs96+s+VqCIzlpxmSPRTZOq
        NzRAOaWtW9YkIrHQUu7mpL9YeSB6ImFUSx6wbET44wwYurJzWAiT5EqyALOT7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677016020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cP88n+Q0Efs6fNs0zhSu0osDsFH+tYMLLvPbqm6DPTs=;
        b=y+ALlCYrk0pS5oLd1YLS4Vl23zODfwkKurP52vdPMNWoLuyOXDgx/Sqd6ysFnflZAi1TFe
        +RPottWZb8dKHkAg==
To:     Josh Stone <jistone@redhat.com>, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
In-Reply-To: <65ab5cb1-2dbe-e853-48ea-d1df87706cf0@redhat.com>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <65ab5cb1-2dbe-e853-48ea-d1df87706cf0@redhat.com>
Date:   Tue, 21 Feb 2023 22:46:59 +0100
Message-ID: <87zg96n12k.ffs@tglx>
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

On Tue, Feb 21 2023 at 09:13, Josh Stone wrote:

> On 2/21/23 4:32 AM, Thomas Gleixner wrote:
>> Now the problem is that 'Instant' in it's specification is bound to
>> CLOCK_MONOTONIC and there is no way to express CLOCK_BOOTTIME, but
>> that's a shortcoming of the spec which ignores CLOCK_BOOTTIME
>> completely. IOW, that's also a problem for user space.
>
> That's not exactly *specified* -- it's meant to be opaque time. It is
> documented that this currently uses clock_gettime monotonic on unix
> targets, but "Disclaimer: These system calls might change over time."
> CLOCK_MONOTONIC isn't even consistent across unix targets whether that
> counts suspended time. It's been debated if we should switch to
> CLOCK_BOOTTIME on Linux, but for now we're sticking to monotonic:

You'll need both when you want to implement substantial parts of the low
level user space stack in Rust. Same for CLOCK_TAI.

Thanks,

        tglx
