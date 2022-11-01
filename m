Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B427614E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKAPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKAPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:15:30 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F31CFD2;
        Tue,  1 Nov 2022 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M2ExO0OCc/LPgMfVGJ0dehDqeiUDLMpSbdsjJWkQO9w=; b=iVaiWKqvDXPFcMYqk7ShHnWG9V
        05F2ZgaJh6rZYVtjNBrIEQgutVEb7TmGlwvQpDrG7UdNus6mhoaIet4q+XBp+2nGEE/yLLd2kdksL
        L/Q1p5uHduSw1hBmyVdeitYOqlQXm0GzL4zEO7YqEA8oDIkoIzNkGx6+sTc+5AIqeDimAu3tA4NXS
        oGmFzLmHiA40eYcdXN10EOS4Me3x9/UEwSAAWlVVzLWmqsw6mDJZ4jmAwu+R29DebdwhMY3eRPwbP
        02xDkFFHk7SldT0wjXICghtKwZfq2JeK+h2QifyQmsIUYBDETi10IGJ0rS+kFE077gXA5ERqmNzuR
        s/VoTPKg==;
Received: from [177.102.148.33] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1opsvy-00AMRE-3c; Tue, 01 Nov 2022 16:12:10 +0100
Message-ID: <2ece1ac9-e602-9c65-e5b5-81b4a7fb6676@igalia.com>
Date:   Tue, 1 Nov 2022 12:12:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3] x86/split_lock: Add sysctl to control the misery mode
To:     x86@kernel.org, tglx@linutronix.de, Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, bagasdotme@gmail.com,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Andre Almeida <andrealmeid@igalia.com>
References: <20221024200254.635256-1-gpiccoli@igalia.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221024200254.635256-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 17:02, Guilherme G. Piccoli wrote:
> Commit b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
> changed the way the split lock detector works when in "warn" mode;
> basically, not only it shows the warn message, but also intentionally
> introduces a slowdown (through sleeping plus serialization mechanism)
> on such task. Based on discussions in [0], seems the warning alone
> wasn't enough motivation for userspace developers to fix their
> applications.
> 
> Happens that originally the proposal in [0] was to add a new mode
> which would warns + slowdown the "split locking" task, keeping the
> old warn mode untouched. In the end, that idea was discarded and
> the regular/default "warn" mode now slowdowns the applications. This
> is quite aggressive with regards proprietary/legacy programs that
> basically are unable to properly run in kernel with this change.
> While it is understandable that a malicious application could DoS
> by split locking, it seems unacceptable to regress old/proprietary
> userspace programs through a default configuration that previously
> worked. An example of such breakage was reported in [1].
> 
> So let's add a sysctl to allow controlling the "misery mode" behavior,
> as per Thomas suggestion on [2]. This way, users running legacy and/or
> proprietary software are allowed to still execute them with a decent
> performance while still observe the warning messages on kernel log.
> 
> [0] https://lore.kernel.org/lkml/20220217012721.9694-1-tony.luck@intel.com/
> 
> [1] https://github.com/doitsujin/dxvk/issues/2938
> 
> [2] https://lore.kernel.org/lkml/87pmf4bter.ffs@tglx/
> 
> Fixes: b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Paul Gofman <pgofman@codeweavers.com>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Zebediah Figura <zfigura@codeweavers.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Andre Almeida <andrealmeid@igalia.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Hi Thomas / Tony, is there anything else to improve here? Suggestions /
reviews are greatly appreciated.

In case this version is good enough, I'd like to ask if it's possible to
get it merged during the rc cycle for 6.1 (I'll also backport it to
stable 6.0), so we can have this fix available for a bigger public.

Thanks,


Guilherme
