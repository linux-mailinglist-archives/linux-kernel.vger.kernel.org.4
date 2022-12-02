Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D528363FD72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiLBBD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiLBBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:03:24 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3870CCB206
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:03:23 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fz10so3300168qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ppydc67sxbhkBUShlFYnXkwzOb+e7DCeIgg6EvDqqfg=;
        b=JbXbM2OJjyAsvZSI103rp+BLBxMpWTKMLaYAITyWwjiSE6k8e8Y9EqgAc474Doh9zw
         DH6WFO+KA9DkKLjToBZTzsFiSg/2T3UoqahuD33ZgFfFj1oY3wteHTbn7VZ3pBtvq75o
         co+/GPUxZMIDHfaKg0hbPwHVTeAE0ioxolY5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppydc67sxbhkBUShlFYnXkwzOb+e7DCeIgg6EvDqqfg=;
        b=kyGmq+S6xIzfNo2a00EGErF1RJArLseym36DzGynMo4U/rh1sUC8AvbP7+lgCke6Pr
         2tAzUsUgrB7UP1f7p0h6qXpidZEo7JoH16BOCsSmT4LZFzqYM42fDHikooFSyAMiPlZ3
         wuURIKqyWPoyei6TUyD0FH/oMresiT8eDP+wOuA/Vcy2TSip088G97u1YLZatlhtLeG+
         x1KXoAHyMMeFFaO7tWNY0ORm/cLKjnHNMEWPH7BBQFsZdJWoBvBPFdk8/NJJZwX47m3F
         LticjohbK/m2YtjJq4RgcyaXCXoW/JnPlnOOTB7zL9d78eVdgk7EHr6kMRuwQMCWX8Jd
         iI4g==
X-Gm-Message-State: ANoB5plc2Z3Hx2Vc/O2mXHQKJKI/XkCxkK0t7PXyUNICoJWG6Wk9ZQbo
        xRDU0okvgtTsuxOLUdSSZbC+qC37+PF/Jg==
X-Google-Smtp-Source: AA0mqf4aMfZr6zI8Q+b3Q18iNCBjNvzpqRtGY7AhPZf8UEYv5VyJ09wp8p8emOcrHsORnoxI6tW63Q==
X-Received: by 2002:ac8:6055:0:b0:3a5:4106:64e with SMTP id k21-20020ac86055000000b003a54106064emr46887486qtm.321.1669943002111;
        Thu, 01 Dec 2022 17:03:22 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id i11-20020ac8764b000000b003a611cb2a95sm3329403qtr.9.2022.12.01.17.03.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 17:03:21 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id fz10so3300132qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:03:21 -0800 (PST)
X-Received: by 2002:ac8:688:0:b0:3a5:122:fb79 with SMTP id f8-20020ac80688000000b003a50122fb79mr53237218qth.452.1669942666724;
 Thu, 01 Dec 2022 16:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20221121104403.1545f9b5@gandalf.local.home> <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic> <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home> <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
 <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
 <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com> <nycvar.YEU.7.76.2212020141280.27249@gjva.wvxbf.pm>
In-Reply-To: <nycvar.YEU.7.76.2212020141280.27249@gjva.wvxbf.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Dec 2022 16:57:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnwupwPOcTxGnDb1-dJ+wZDk1yiVvuDp8dAAAmLesrvA@mail.gmail.com>
Message-ID: <CAHk-=wjnwupwPOcTxGnDb1-dJ+wZDk1yiVvuDp8dAAAmLesrvA@mail.gmail.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Dec 1, 2022 at 4:46 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> Anyway, I believe [1] that ERROR_INJECTION has been designed as a
> debugging feature in the first place, and should stay so. After figuring
> out now that HID-BPF actually has hard dependence on it, I fully agree [2]
> that the series should be ditched for 6.2 and will work with Benjamin to
> have it removed from current hid.git#for-next.

I do think that it is interesting to have a "let's have a bpf
insertion hook here", so I'm not against the _concept_ of HID doing
that.

It's not so different from user-mode drivers, after all, which we also
have. A kind of half-way state where we have a kernel driver, but one
that may need custom site-specific (or machine-specific) tweaks.

So I don't want to come across as being against having bpf used for
tuning some HID issue (and I can imagine it making sense in other
places that have machine-specific tweaks - I'm thinking of all the
thermal probe or pincontrol mess where sometimes you have GPIO's or
motherboard thermal sensors etc that are literally "user connected it
to X").

But the notion that we'd use some error injection framework for it,
and that you'd mix those concepts up - *that* I really think is just
horrendous.

Because even if you end up using some common infrastructure code, we
really should separate things out much better.

              Linus
