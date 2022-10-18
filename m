Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0155602D32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJRNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJRNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:41:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E842A723
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:41:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B2901F979;
        Tue, 18 Oct 2022 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666100472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4dDktYe9CWTuDjVFyx2lG5Orw7IVVi7YQYZYlzAxtE=;
        b=kKf7ZGOaFs/KIm0RKTGud/5VpSOKQAXeBF7PnID19n3RsbwKGDdueBX/lDmae3Q5L7U9y3
        PzZFMapQzo/RjjZSAGcFQ0tGgEnoHoRKRx91+kwuMZK7ufIXPpF9T58YwmiTlS9TToueCY
        HveMR6U2RWq+7v0eGu0p/zLkTfxCU3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666100472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4dDktYe9CWTuDjVFyx2lG5Orw7IVVi7YQYZYlzAxtE=;
        b=dKe7OWEZYUOHmGUThCL+gCUv70X2KBzV/e5p5X1a8o642CgogF12GN5dYgyli4S+eMd8RV
        f44YOmD4OVImbnBQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id CC5772C141;
        Tue, 18 Oct 2022 13:41:10 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 51DE34401F8; Tue, 18 Oct 2022 15:41:10 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
References: <20220905230820.3295223-1-yury.norov@gmail.com>
        <20220905230820.3295223-6-yury.norov@gmail.com>
        <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
        <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
X-Yow:  I Know A Joke
Date:   Tue, 18 Oct 2022 15:41:10 +0200
In-Reply-To: <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 18 Oct 2022 15:15:32 +0200")
Message-ID: <mvmlepdb66h.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 18 2022, Geert Uytterhoeven wrote:

> Moreover, this cannot be used on all systems.  E.g. on Icicle Kit with
> Microchip PolarFire SoC, CONFIG_NR_CPUS needs to be larger than 4,
> as the system has actually 5 CPU cores (1xE51 and 4xU54), but Linux
> runs only on 4 of them.  So you cannot use FORCE_NR_CPUS=y.

But does Linux acually see the E51 core?  On the Hifive boards it is
disabled in the device tree, and the cpu probing just skips it,
effectively resulting in only four cpus.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
