Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8257260D7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiJYXHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiJYXHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:07:45 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626EE984C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:07:44 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o8so10018999qvw.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1ZCWeMRw9t6L46uJ0bGfjVwbep7LBM2Gsx21FAuoFQ=;
        b=TJMX12Es9a2VtcXhg0BL5lI6ZietlM2O6e+Bd5nYvFWg414Q/iqaNORhdD4kuSzW1t
         Ggx3c9XyPFt4N4nWTTvtqddGD8Sb2O8FoKejpTj+G1SbfHCaIiroJhbPGYxK7pHVxAUO
         BPV+MBeqkawQpT8YqTX/qJpLPaKckLvSnu+N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1ZCWeMRw9t6L46uJ0bGfjVwbep7LBM2Gsx21FAuoFQ=;
        b=kvI5ifYHcJhSr9YfRzGu4DViJPCbKMqupuJDzdbdnR5w9fO5b84TfW4+HcbhhuiVKD
         sq+Wc6mNurHNml2ktTwftukNorZGKKXwdMJqyN2A3IWQbKOh10EVzwdnBNeIMt7GwpE0
         zCn+yiWQQrMn21LYUSI28inT7zHpC4GvkNvfF/4L/wDgZ916YY3C9YvBHyd2WfeUBxHT
         Hf5kSdoaG8t2VcAQUWzMLx4Xjs9HcVMZwMgqqbU8gC58ksy7zh2/mPeheBerK4WKVEqy
         hE5dHJ64/AlVqc144LYCZqhleG2rz5lNpKP/F5BynUESb/HipZ74jLPfJLCpIBQannZ8
         4h0g==
X-Gm-Message-State: ACrzQf3kMj+Rc7S+3WMNO2zspyMNpKTDdCKDX4qfzduNBy8fX2deEtFG
        wG001irQvwsgtpDu68+tfQmVBUgHk0YzkA==
X-Google-Smtp-Source: AMsMyM7ManmYHnuDYinISEo0Y4SH9Zbi9eU9JdNwAYdLF0tkcG9nUJH4Oe99oLfJWCdtTLYh4UV1Wg==
X-Received: by 2002:a05:6214:c6f:b0:4b2:b0e2:2122 with SMTP id t15-20020a0562140c6f00b004b2b0e22122mr34484478qvj.55.1666739263668;
        Tue, 25 Oct 2022 16:07:43 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id k11-20020ac85fcb000000b0039953dcc480sm2311735qta.88.2022.10.25.16.07.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 16:07:42 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 185so6172453ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:07:42 -0700 (PDT)
X-Received: by 2002:a05:6902:702:b0:6ca:a588:2904 with SMTP id
 k2-20020a056902070200b006caa5882904mr16964027ybt.571.1666739261697; Tue, 25
 Oct 2022 16:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221025200656.951281799@infradead.org>
In-Reply-To: <20221025200656.951281799@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Oct 2022 16:07:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
Message-ID: <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt@goodmis.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 1:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> These few patches re-work and re-order boot things enough to avoid ftrace
> creating boot time W+X maps.

Thanks, looks fine.

> The patches compile and boot for the one config I tested things on (with
> ftrace=function enabled; *slooooow*).

So this might be just tracing overhead, but it might also be that you
slowed down text_poke() at bootup a _lot_.

The only part that the NX^W checking cared about was that

-       if (likely(system_state != SYSTEM_BOOTING))
-               set_memory_ro((unsigned long)trampoline, npages);
+       set_memory_ro((unsigned long)trampoline, npages);
        set_memory_x((unsigned long)trampoline, npages);

for the create_trampoline(), because without the 'set_memory_ro()',
the 'set_memory_x()' will complain.

It does strike me that it's stupid to make those be two calls that do
exactly the same thing, and we should have a combined "set it
read-only and executable" function, but that's a separate issue.

The slowness is probably not the trampilines, but just the regular
"text_poke of kernel text" that we probably want to keep special just
because otherwise it's _so_ slow to do for every alternative etc.

                Linus
