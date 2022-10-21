Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5A607D15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJUQ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJUQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:57:06 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D72290699;
        Fri, 21 Oct 2022 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pzedf8xUwKOln81ZTWxbSMHMJwx3UBJjVHtdKN+dquE=; b=PSqL5obtPZNUSphXW+bDu7qUsv
        aFRhXzW0sAuFpn241dUXZav8iCQY1kuqC7gNN+x/vLxS0XKJKogjE+KxjG1SITNzvVYyssgYoTmXK
        hZn4gcQTk5ZsebJ41dJIwEns1LclHialE6zySbWO7fZ6BplVG5u3SVuqtS3jvLSBACygjl1XR1ZQX
        xh4ommYHirqoUgdwzQB8t1mrc3cSJgnmupZRuxYQV4oZH2WWwZkqxgPJ+zNjlUQc6XDwW8S2SYPp+
        slsVeMvrWzE0H1Oa7PobRn0Dg2q/msokW55028EfB2NI1aai1feHINwR2NlOh+T1sa872LPZ6fiml
        GbTk/uiQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1olvJz-002xu8-Ac; Fri, 21 Oct 2022 18:56:35 +0200
Message-ID: <04954335-ff3f-d418-3e23-c463a9e47f0c@igalia.com>
Date:   Fri, 21 Oct 2022 13:56:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221014180506.211592-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 15:05, Guilherme G. Piccoli wrote:
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
> While is understandable that a malicious application could try a DoS
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
> Cc: Andre Almeida <andrealmeid@igalia.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Paul Gofman <pgofman@codeweavers.com>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Zebediah Figura <zfigura@codeweavers.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---

Hi Dave / Thomas, do you think this version is good enough?

If so, would be possible to pick it still in the v6.1-rc cycle, since it
is a fix?

What about the documentation improvements from Bagas, should I re-send
(V3) with that, or would you pick them when merging?

Thanks in advance,


Guilherme
