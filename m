Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF19B6B82C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCMUa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCMUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:30:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1A2470D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:30:26 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b16so5522886iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678739425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmmXPOPa9Wwe/zlOVKRso+okJl7ktSqRY5A9TuqIoc0=;
        b=IcH3U9ez457ngRXupyzCHzWYFAuy2JCxyGVLU2ee9eruoYxjtiXRR7DGXqNCctwtFn
         SG3D7wTq0WUIimXQJ7L/o61OqI+MiziliSgrlGjodGikkMB1ngPLvSnjqUs6eZI/aooz
         49STL8ktLhQvAZugW28mAbkYLYMzxouCj5i87LvTspL5QaBpMEOg1EARCyt/BcydzvlM
         8w6lySUI6OjjfmjuDahS+UO1NXTLAX6w44bS+fsSYlbLXRlPYNshj3xocj2Q3qA7qUZw
         H2+O7OaHZ5nfA1Z2MYyIKBYKvbv6GUe4ixDWTEDthGFBMo8L8oDIHSjk8js5fLtuCfyH
         BTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678739425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmmXPOPa9Wwe/zlOVKRso+okJl7ktSqRY5A9TuqIoc0=;
        b=B9dubSP7SMektxdndM/VVW+20DfWACwl9rcqLcEMyrnSV0UDOsQ1CN2BpGhCf5YW1A
         RJUx+NCYTo3gdTY9i2uLukPptJThMCEYOgtC9I++lC/6KKNP+hWD9YTsj6qwZHY66dzy
         ebfRrtN8rHx9QJXuCsso6PKgZ7Ojrze2mXc5QUwggaNpq2JnlDABqaCgc4ZBITEehWAO
         jKg3hkAjrKYvxU73OqwDWthDu019TYFfSQk/vMraAbqKEpomosZkWKTPg8K9W9OFQQ6b
         MKT/6Bg+TsOUGL/7cJDO55oB0Qru4mHs6G3Yb2iAC3Prz7JU1L3B0iB6lSqKXDEpkUDq
         uVgQ==
X-Gm-Message-State: AO0yUKUES9p4MGV3yNaCezWs2L3FVBIffL4Dfp8s3Vsjevg+l6ahYSvn
        LJLc59jaLwnD1RbfGPO0C+o=
X-Google-Smtp-Source: AK7set/x3YR20L5GPFJ6J6uCsrJogXYCs598meWz41KX9O8o/6s085YFmdFa5Qy7eaCChPQJAmdliw==
X-Received: by 2002:a5d:9257:0:b0:73a:6c7f:c476 with SMTP id e23-20020a5d9257000000b0073a6c7fc476mr10655509iol.16.1678739425245;
        Mon, 13 Mar 2023 13:30:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p23-20020a5d9c97000000b0074564031d75sm225457iop.2.2023.03.13.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:30:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Mar 2023 13:30:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc2
Message-ID: <fce02d50-65a7-4aa7-8949-6a82321da292@roeck-us.net>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:21:44AM -0700, Linus Torvalds wrote:
> On Mon, Mar 13, 2023 at 8:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Warning backtraces in calls from ct_nmi_enter(),
> > seen randomly.
> 
> Hmm.
> 
> I suspect this one is a bug in the warning, not in the kernel,
> although I have no idea why it would have started happening now.
> 
> This happens from an irq event, but that check is not *supposed* to
> happen at all from interrupts:
> 
>          * We dont accurately track softirq state in e.g.
>          * hardirq contexts (such as on 4KSTACKS), so only
>          * check if not in hardirq contexts:
> 
> but I think that the ct_nmi_enter() function was called before the
> hardirq count had even been incremented.
> 
> > Sample decoded stack trace:
> 
> Hmm. That WARNING backtrace doesn't actually seem to follow the stack
> chain, so it only shows the irq stack, not where the irq happened.
> 
> > Seen if CONFIG_DEBUG_LOCK_ALLOC=y and CONFIG_CONTEXT_TRACKING_IDLE=y.
> > It seems that rcu_read_lock_sched_held() can be true when entering an interrupt.
> >
> > The problem is not seen in v6.2, but occurs randomly on ToT with various
> > arm emulations.
> 
> Strange. I must be wrong about this being a race on the warning
> itself, because that warning has been there for a long long time.
> 
> Adding in some people who might have more of a clue. I'm thinking
> Frederic and Paul might know what's up with the context tracking, but
> I don't see why this would be arm-related or have started recently.
> But I do note that PeterZ did some rcuidle tracing cleanups that do
> end up affecting arm too.
> 
> So adding PeterZ too.
> 
> Original email with full details at
> 
>    https://lore.kernel.org/lkml/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net/
> 
> for added peeps.
> 
> Anybody?
> 

It gets weird. Bisect log below. Reverting the identified patch does
indeed seem to fix the problem, only I have no clue why this might
be the case. The patch looks completely innocent to me. Yet, I can
reliably reproduce the problem with v6.3-rc2, but at least so far I
have not been able to reproduce it with commit f3dd0c53370 reverted
(and I am trying on five different servers in parallel).

Guenter

---
# bad: [a5c95ca18a98d742d0a4a04063c32556b5b66378] Merge tag 'drm-next-2023-02-23' of git://anongit.freedesktop.org/drm/drm
# good: [c9c3395d5e3dcc6daee66c6908354d47bf98cb0c] Linux 6.2
git bisect start 'a5c95ca18a98' 'v6.2'
# good: [36289a03bcd3aabdf66de75cb6d1b4ee15726438] Merge tag 'v6.3-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good 36289a03bcd3aabdf66de75cb6d1b4ee15726438
# bad: [0175ec3a28c695562a08fdccf73f2ec5ed744e2f] Merge tag 'regulator-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
git bisect bad 0175ec3a28c695562a08fdccf73f2ec5ed744e2f
# good: [cb6b2e11a42decea2afc77df73ec7326db1ac25f] devlink: Fix memleak in health diagnose callback
git bisect good cb6b2e11a42decea2afc77df73ec7326db1ac25f
# good: [3365777a6a2243f1cca5a441f2c89002d16fc580] net: phy: marvell: Use the unlocked genphy_c45_ethtool_get_eee()
git bisect good 3365777a6a2243f1cca5a441f2c89002d16fc580
# good: [700ed3bbb7a0bd5eeb805a2c2ba47a6d7b286745] ASoC: SOF: core/ipc4/mtl: Add support for PCM delay
git bisect good 700ed3bbb7a0bd5eeb805a2c2ba47a6d7b286745
# good: [4d4266e3fd321fadb628ce02de641b129522c39c] page_pool: add a comment explaining the fragment counter usage
git bisect good 4d4266e3fd321fadb628ce02de641b129522c39c
# good: [76f5aaabce492aa6991c28c96bb78b00b05d06c5] ASoC: soc-ac97: Return correct error codes
git bisect good 76f5aaabce492aa6991c28c96bb78b00b05d06c5
# good: [5661706efa200252d0e9fea02421b0a5857808c3] Merge branch 'topic/apple-gmux' into for-next
git bisect good 5661706efa200252d0e9fea02421b0a5857808c3
# bad: [603ac530f13506e6ce5db4ab953ede4d292c5327] Merge tag 'regmap-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect bad 603ac530f13506e6ce5db4ab953ede4d292c5327
# good: [b60417a9f2b890a8094477b2204d4f73c535725e] selftest: fib_tests: Always cleanup before exit
git bisect good b60417a9f2b890a8094477b2204d4f73c535725e
# bad: [064d7dcf51a82b480e953a15cca47e5df0426502] Merge tag 'sound-6.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad 064d7dcf51a82b480e953a15cca47e5df0426502
# good: [5b7c4cabbb65f5c469464da6c5f614cbd7f730f2] Merge tag 'net-next-6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good 5b7c4cabbb65f5c469464da6c5f614cbd7f730f2
# good: [7933b90b42896f5b6596e6a829bb31c5121fc2a9] Merge branch 'for-linus' into for-next
git bisect good 7933b90b42896f5b6596e6a829bb31c5121fc2a9
# bad: [f3dd0c53370e70c0f9b7e931bbec12916f3bb8cc] bpf: add missing header file include
git bisect bad f3dd0c53370e70c0f9b7e931bbec12916f3bb8cc
# first bad commit: [f3dd0c53370e70c0f9b7e931bbec12916f3bb8cc] bpf: add missing header file include
