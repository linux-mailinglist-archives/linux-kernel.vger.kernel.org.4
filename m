Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A862D013
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiKQArC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiKQAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:46:29 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA26F348
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:45:24 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g127so128699ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2JYR5BkunF7jpGC9+e1gHhFjfq2CaWsh+JNLeA4cSow=;
        b=VP6VReT7Ga2T8TkmdBXePIZp2IMDUoNlaF+CCECrl6DaKXkfgdOHApNymuj286JAmX
         FF5OamIO5F26h84ltHBlsHynkyTvU3GiIl6z9x+tk7CSMCHkMkdDoe0gMKWlGwOHcjEt
         CsE9r8zFoKzQT7cE12Gvqp9JTJ5thyGDXjtBqK52CERFLlo6giGIfjM8zwe8JzYI9/7t
         YiRlNf22tSRkGfXHAe4thK6/CTx9ZYaAofQeO1HUnrTuu5NpyThUbqOFJSqz0SklL87D
         2mPCoCAPj4ISUYAZzMyHWETvKcvb56p5njBEq7xecXke+GatbzepTA403ePN6qUwmtvW
         onbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JYR5BkunF7jpGC9+e1gHhFjfq2CaWsh+JNLeA4cSow=;
        b=g9QcpJKCamdhUxDS0eo+3A5ODjQcYS9rHh+UpMNg4/1Uwx5gg6grDdPBqUeG5FyD6/
         9rD0rzIcZ6S/WjR5MoKkSaGkQMRhSxzoBf+reFn0yMXwiCRABLtQZ92giMymIb5nq14v
         p1wpp5hrGEwgjGjp91bgTjx75OBxdlMHf87YZib7snEh2aQ46qZDO4xPEqMctEfSCWHS
         P3rsjxSgaRV10zRW0saA27yJpD2O29/ai2B7jHDMcLPvjSL3Urb5SWGLCc57Pa8dDHU9
         GKtAfJ6UhDYE7VkrT4ghtMFGtPAbK7TMocXuQ5RNyEh8bcbrrY/3IPRqaPsUQ82ryBV2
         I19Q==
X-Gm-Message-State: ANoB5pl7JHkvSVHCh5Gh3hxFgmA+PHSCh2GgCOaeW5jc6Jt+qkZTDuia
        ohj0rnKuD8N8gtrjGNwTkKydRIS/7t/p2548B28rh9mQ2LgF0w==
X-Google-Smtp-Source: AA0mqf7BrP7X5qSPJf/drCclU/BXyNzvk2HB+KXaxPpnHS8wgJrAT3kxcJhlabI/OGYuuUGolXEGU///p9v0hEDsSWM=
X-Received: by 2002:a25:40c4:0:b0:6cc:1a02:c338 with SMTP id
 n187-20020a2540c4000000b006cc1a02c338mr181599yba.413.1668645923794; Wed, 16
 Nov 2022 16:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20221115230932.7126-1-khuey@kylehuey.com> <773a9deb-b017-20e5-cebe-d9c35ac4fd3d@intel.com>
In-Reply-To: <773a9deb-b017-20e5-cebe-d9c35ac4fd3d@intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 16 Nov 2022 16:45:12 -0800
Message-ID: <CAP045AozQWf8qKuusXy=1p7UynOHas7mNpMospCOHmMmP993=Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] x86/fpu: Allow PKRU to be (once again) written by ptrace
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 3:31 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/15/22 15:09, Kyle Huey wrote:
> > Following last week's discussion I've reorganized this patch. The goal
> > remains to restore the pre-5.14 behavior of ptrace(PTRACE_SET_REGSET,
> > NT_X86_XSTATE) for the PKRU register (which was equivalent to a hardware
> > XRSTOR instruction).
>
> The new version looks great.  I've applied it.
>
> I did remove the stable@ tags for now.  There were a couple reasons for
> that.  First, most of the x86 stuff marked for stable@ goes via our
> tip/urgent branch and this doesn't seem super urgent.  It also touches
> code that's exposed in at least three separate UABIs, so I want a bit
> more soak time than x86/urgent normally provides.
>
> I have zero objections if anyone wants to submit it to stable@ after it
> hits Linus's tree.

Works for me, thanks.

- Kyle
