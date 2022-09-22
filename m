Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754BA5E5E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIVI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:57:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDAF985A5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:57:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hy2so15794368ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ySxqqKhws4ONu2ayKLM0wO+32ova08aOybDjohhuKpM=;
        b=n/X04St3Ih3vbknhOY99Wefvq5k6RR+8/hDJVG84XKsz4BNKUJRgmOXAKoGU6HTEb+
         CApZC+VKGqabPIj9tTgGCdUOpenaUlKWiTe+eR90Kq9SraMvKwS+OH1KKuM3tt30+RKU
         mqO+kjAPawICp/JNsMpDko/PgjZzF6ACFmQDdVWe4u3CBMFqEyZeQ25hot+9Tob2Y9gs
         Hu3q+5b3GhR244rnJxzJwpoiw/BzE1ghuo9zX5fntaYPEC5pSJD7DkchIiB/7y3FJm37
         nMTtlxrx5/130YzqVG3MGzTqvol+N8V5OPJHCiegM4WbiK1gw/CM+fuP/Rb9VX2C700T
         LjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ySxqqKhws4ONu2ayKLM0wO+32ova08aOybDjohhuKpM=;
        b=4JqZq54AjJZEM3V8TJkkiQCQmWkN9yyPE00LjxoO5lXmwqlZIJxyzK88fEAUzkX5qQ
         /nXL/Kvb/zrkWUiwlJlFi7JxMPHTYXDawZScy+AwqFJh63iPUkYcNysD00SxgBK4KFR0
         0gZxwHZQk/gIExWI7RTqN0wfTX2vOZo8QWE6Dylu66R13n22qlczLID81KwEcuoXS5/S
         p89GdfmwQauVBCT+RcOQq+60QobLipWaTMorFGcC/ryQCaOoTyCQ53o3r38xMkX72l7w
         FGsWkuDn0kb84IUZ6XJ5wCGAXCiWuRGbEAVpDGyAlxGamWGuVYm0uC2cncmfeWYI1Rij
         WSxw==
X-Gm-Message-State: ACrzQf3sOogz5RphlqHRVlIWc2ZC8lZffDtfdboB8R/15oxl4t2jWPeR
        9bw0jWo08e0oVDIQn+mq42LF60ShjDiU3UKgZafHejUjnckjeGop
X-Google-Smtp-Source: AMsMyM75lUMCv6SvHR3fDEPSjVUl4rWAzZpcVivx2jukKD70NS4IfkbJOJ2wxUI8FaYjYT5y8aKbV39PVkgfeWVQoQc=
X-Received: by 2002:a17:906:5d04:b0:77f:ca9f:33d1 with SMTP id
 g4-20020a1709065d0400b0077fca9f33d1mr1914266ejt.526.1663837042822; Thu, 22
 Sep 2022 01:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220920230728.2617421-1-tnovak@fb.com>
In-Reply-To: <20220920230728.2617421-1-tnovak@fb.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Sep 2022 10:57:11 +0200
Message-ID: <CACRpkdZZFx3W3EHZh30FnQ+xH9ub_S7DZdGLJFQ_wBVN5EBVwA@mail.gmail.com>
Subject: Re: [PATCH] ARM: perf: Fix stacktraces for tracepoint events in
 THUMB2 kernels
To:     Tomislav Novak <tnovak@fb.com>
Cc:     Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 1:19 AM Tomislav Novak <tnovak@fb.com> wrote:

> Store the frame address where arm_get_current_stackframe() looks for it
> (ARM_r7 instead of ARM_fp if CONFIG_THUMB2_KERNEL=y). Otherwise frame->fp
> gets set to 0, causing unwind_frame() to fail.
>
>   # bpftrace -e 't:sched:sched_switch { @[kstack] = count(); exit(); }'
>   Attaching 1 probe...
>   @[
>       __schedule+1059
>   ]: 1
>
> A typical first unwind instruction is 0x97 (SP = R7), so after executing
> it SP ends up being 0 and -URC_FAILURE is returned.
>
>   unwind_frame(pc = ac9da7d7 lr = 00000000 sp = c69bdda0 fp = 00000000)
>   unwind_find_idx(ac9da7d7)
>   unwind_exec_insn: insn = 00000097
>   unwind_exec_insn: fp = 00000000 sp = 00000000 lr = 00000000 pc = 00000000
>
> With this patch:
>
>   # bpftrace -e 't:sched:sched_switch { @[kstack] = count(); exit(); }'
>   Attaching 1 probe...
>   @[
>       __schedule+1059
>       __schedule+1059
>       schedule+79
>       schedule_hrtimeout_range_clock+163
>       schedule_hrtimeout_range+17
>       ep_poll+471
>       SyS_epoll_wait+111
>       sys_epoll_pwait+231
>       __ret_fast_syscall+1
>   ]: 1
>
> Signed-off-by: Tomislav Novak <tnovak@fb.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you put this patch into Russell's patch tracker please?
https://www.armlinux.org.uk/developer/patches/

BTW: what is this interesting CONFIG_THUMB2_KERNEL target
that Facebook/Meta is working on? (It's OK if you can't tell, just
curious.)

Yours,
Linus Walleij
