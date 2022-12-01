Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51A63F99C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLAVN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:13:55 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABCA1C1A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:13:54 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id fp23so2336906qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+Ty/71vBz7a1g1Y5lX48RafM8N+vzJrXXZkn3ZmfZQ=;
        b=Osn2+8UumebclUI0lYV6mJV6O30OJZ2SNqLMtZUA0RJcwnkD+326VktQ4cbdCFv6hD
         oTJtPRTgmKhiHpOFvxyjO9xtzWzfp3PfHXLyTTnkaPgSQbu7MhMwDoX/1y6PHSvxNQvg
         ni+9QQtYy8DKEBlVjvrzeegaV5vFE+A3fVHS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+Ty/71vBz7a1g1Y5lX48RafM8N+vzJrXXZkn3ZmfZQ=;
        b=CuRVQngGOvVNOLvbWCFC2gOWdMjegMCxkNB1rCZMreBajzLnhXFEV1izXQPxMhWwlC
         rcI3ppy0A4EJVIsxsaDZiDPZ8wBIU9b+/4H5JwzuybCw+wR36HziNx8SICwp9X7mFchL
         w1Q+GaquvAkGla09y7Omzs26OeAimaCNofTK6hr1D9d+qrfzWMOoGMHnOacNDldg+qIR
         n2XJ2bXwHmVKF5XEkyEVU6Kim6kRDEtdia/64KtWkqEYA2p6e5A1iimDeUV4fSZoFlX1
         j03/KtRPFH5W2a8NgixdsHbRASIuBeW0sr7W32H+dHiX78es0A6hIMFGU0fZvvS+cPPt
         JChA==
X-Gm-Message-State: ANoB5pkCKZnqm2P+PwW9CS83GcCeD3o5mbQV/HPww0NAA+Uh8Bhx5FVh
        E1Zs3LvUVW3qshwfzjtuKcp9/aEqawXs9g==
X-Google-Smtp-Source: AA0mqf4b/2g24d9P+hS9D3dixRfl0ovyz9i4rXHqenvMLAGWAJlDokNE8SDK+D0+ERaPixUBWE2ZBQ==
X-Received: by 2002:ac8:4501:0:b0:3a5:cb81:aff5 with SMTP id q1-20020ac84501000000b003a5cb81aff5mr54045956qtn.662.1669929233478;
        Thu, 01 Dec 2022 13:13:53 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id u12-20020ac8750c000000b003a622111f2csm3045686qtq.86.2022.12.01.13.13.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 13:13:51 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id cg5so2597981qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:13:51 -0800 (PST)
X-Received: by 2002:ac8:688:0:b0:3a5:122:fb79 with SMTP id f8-20020ac80688000000b003a50122fb79mr52533065qth.452.1669929231060;
 Thu, 01 Dec 2022 13:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20221121104403.1545f9b5@gandalf.local.home> <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic> <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home> <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org> <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
In-Reply-To: <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Dec 2022 13:13:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
Message-ID: <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 8:59 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> The hid-bpf framework depends on it.

Ok, this is completely unacceptably disgusting hack.

That needs fixing.

> Either hid-bpf or bpf core can add
> "depends on FUNCTION_ERROR_INJECTION"

No, it needs to be narrowed down a lot. Nobody sane wants error
injection just because they want some random HID thing.

And no, BPF shouldn't need it either.

This needs to be narrowed down to the point where HID can say "I want
*this* particular call to be able to be a bpf call.

Stop this crazy "bpf / hid needs error injection" when that then
implies a _lot_ more than that, plus is documented to be something
entirely different anyway.

I realize that HID has mis-used the "we could just use error injection
here to instead insert random bpf code", but that's a complete hack.

Plus it seems to happily not even have made it into mainline anyway,
and only exists in linux-next. Let's head that disgusting hack off at
the pass.

I'm going to apply Steven's patch, because honestly, we need to fix
this disgusting mess *before* it gets to mainline, rather than say
"oh, we already have broken users in next, so let's bend over
backwards for that".

The code is called "error injection", not "random bpf extension"

               Linus
