Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC76629EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbjAIPaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjAIP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:29:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C881FB8D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:29:34 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673278172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoiFHa3OYaUadlpj4XIDCoE4VEmQuSerBU1ZGv9DnLo=;
        b=OnNlXVI4ddvfBx/m5OTKEBQuyVb7cjlADg637Gsgi1H1U3SOck00FIi0KuikWfCERHPPcc
        av1tt9E7/NWqr4e7brvvf1Ih5WwTrky4geNfDi2Ud8ErV+Qgfxen1WWMtmYWas9NvBpMAC
        RK+7k9N8rLGgwA31d9LySbDfOlcD7n/LUBoKpRTVh8MaRh+JBYQJyDlzAM2Z7WhbGg/Kq9
        xLRq5Y8n2M+eksNGgyhFSd6gKj7eqXkyqhxFTiFxQlXGpRK/C6xY7Wm57PYsaV1nppLP0G
        OANzM0RPvvPwPGH1X8eu39HeKOQFKW+7WGoYP8NdX+WRyAaNm/4iFRLA9s3crw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673278172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoiFHa3OYaUadlpj4XIDCoE4VEmQuSerBU1ZGv9DnLo=;
        b=CZHFPtJPuGRR5JMiSzNZNLLnEk+jcaDXQ22Ea1ihyEmk0PJ70MkfiUR2S29JqVzSa5vTKO
        PXwi4NtnSYnptuBg==
To:     Guo Hui <guohui@uniontech.com>, sboyd@kernel.org
Cc:     jstultz@google.com, wangxiaohua@uniontech.com,
        linux-kernel@vger.kernel.org, Guo Hui <guohui@uniontech.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] timekeeping:add padding in timekeeper for Unixbench pipe
In-Reply-To: <20230106062946.19983-1-guohui@uniontech.com>
References: <20230106062946.19983-1-guohui@uniontech.com>
Date:   Mon, 09 Jan 2023 16:29:32 +0100
Message-ID: <874jszlo9v.ffs@tglx>
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

Guo!

On Fri, Jan 06 2023 at 14:29, Guo Hui wrote:
> When the LLC cache line size is 128 bytes, such as Kunpeng 920,
> the seq attribute and xtime attribute in the structure tk_core
> are completely in the same LLC cache line,
> and xtime_sec is the data protected by the seq lock
> in the function ktime_get_coarse_real_ts64,
> so seq and xtime_sec are in the same LLC cache line
> causing the false sharing problem.

What exactly causes the alleged false sharing problem?

> Adding padding before xtime_sec in the structure timekeeper
> is based on the comment of the structure tk_read_base: "This
> struct has size 56 byte on 64 bit. Together with a seqcount
> it occupies a single 64byte cache line." Therefore,
> seq and the structure tk_read_base
> should be placed in the same 64-byte cacheline.

How is that relevant? They _are_ in the same cacheline independent of
your padding, no?
                                           Offset  Size
  seqcount_raw_spinlock_t seq;          /*     0     4 */
  struct timekeeper       timekeeper;   /*     8   280 */
    struct tk_read_base     tkr_mono;   /*     8    56 */

8 + 56 = 64 which is also the case with your padding.

If your false sharing thing exists then all other timekeeper read
functions which only use

     tk_core.seq and tk_core.timekeeper.tkr_mono

have the very same false sharing problem because seq and data are in the
same cache line, no?

Aside of that, for architectures with 64 byte cache line size, your
change is fundamentally bad. Why?

It moves xtime_sec to offset 128 which means seq and xtime_sec are not
longer in consecutive cache lines.

If you change core data structures for the benefit of your platform,
then you have to provide proof that it does not cause any issues on
other architectures and platforms.

Thanks,

        tglx
