Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2C5FF384
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJNSRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJNSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:17:33 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608734992;
        Fri, 14 Oct 2022 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6A038VSbKgmTtC6l33tUHYMBKCU/5aJDmU19ObnJLSY=; b=cjYasjN28i1cTTCJtybL9zFEc7
        Wriomm9zRnXqkwdRp1vC+xhpjqBtaN5Fogw44iUuRZ0GtOCFonuSki8LLL1YgEtr885NUbACYj1Kw
        uV55cQyh93cBOW4M7fmy28ISlhJQpR/4ekkV/wZoTvune4g8yExAZI283YFmY/9tQhdOv1XEDGPRS
        4/GwmKWO2yQOEr1hc2FM0PKJ9XKv5I5+zx7F44yU8RZ09Jp1e0pVP2AlfINsbHL+XkTEWoq0B1wal
        MGJTWxWHCpKVPsLWGNS7/cVqD8JkmnkQlzgLo8io8egobsMoNFN1uDYjIom7LjsbbZm68GiKOsWMw
        JvIdyKEA==;
Received: from [187.57.106.242] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ojPFO-001YhH-86; Fri, 14 Oct 2022 20:17:26 +0200
Message-ID: <9a606366-6ac7-3802-5c25-91057ad833cb@igalia.com>
Date:   Fri, 14 Oct 2022 15:17:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20221014180506.211592-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme,

On 10/14/22 15:05, Guilherme G. Piccoli wrote:
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

Tested-by: André Almeida <andrealmeid@igalia.com>

Tested on an Intel i7-1165G7 using a small benchmarking script, the 
behavior is effectively reverted when using the sysctl option.

Also, you might want to document this option somewhere? Maybe at 
Documentation/admin-guide/sysctl/kernel.rst
