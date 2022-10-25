Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB82560C0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJYB1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiJYB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:27:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394F6D577
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:02:51 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u7so7616341qvn.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6x4NyeHIOb8xnnvnRIlkAggzAkRP4Y6+NCcjWrSgBrw=;
        b=IQ2h5W/VdXcKcCHqZdhxMIgDZ36eLpFiMnCu+wiKIn/Tp7DodYCzwFOutjpjlySJZR
         vpE2tn82bO7UEbAXqNq6PQPZyK500l+Je3siM1BUgKglFvjBTx/thHbAYntOfut4L/lf
         HmkKJ00EAIxPj9lNiSx5HYNgBpcftcBuKvnjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x4NyeHIOb8xnnvnRIlkAggzAkRP4Y6+NCcjWrSgBrw=;
        b=sz96sRyYrr2oE0ckU1c9i9A691eWCIHxQWlD66PHIVAGUoPl7a/MRDkTAV4yrvrNsz
         CFKxazjUx7Hntsqqs9wNwpFvpW/f8WtVoYiDA1dRvEUW0OEMmpbdb5C4/33TuuoVMA1F
         OzmtZ/w81ckwMIzg5LcTaZsL+UazN6jebRbFR0gq86mwKgbl+C98vfH80/9bUOt8HlAX
         YQ3p70r9nf2+Z2PpsX32yXg2X9o61NeOCgnuTg6pHh0ubG1c0NR454M0qUbDQNkHJ8Jn
         Pj7SH8git7c1maWRQYWUL0CRnw1IJ3ouCjhrFDTovPpg8DU7hljJQUbSbCy2kdA9hfv2
         9Itg==
X-Gm-Message-State: ACrzQf3vxqhR/mbr4w+lyCClnZnnbzfEvmPviQjcWynvdI+FpvC7akeK
        s/iiazfA3WIZa64TBh2Qhe0iAerGLmeV2w==
X-Google-Smtp-Source: AMsMyM75in+xw6F0+oeo6FTxEQNzYijkmORM19CqIsKPXPlnSIstomIEZ74cZuAchwDX+TFLIoQwmA==
X-Received: by 2002:a0c:f005:0:b0:4bb:847a:5ace with SMTP id z5-20020a0cf005000000b004bb847a5acemr3335298qvk.104.1666659769966;
        Mon, 24 Oct 2022 18:02:49 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id d13-20020a05620a240d00b006bc192d277csm1079262qkn.10.2022.10.24.18.02.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 18:02:48 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i127so12854313ybc.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:02:48 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr33367907ybu.310.1666659768246; Mon, 24
 Oct 2022 18:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221024190311.65b89ecb@gandalf.local.home> <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
 <20221024202133.38e0913e@gandalf.local.home>
In-Reply-To: <20221024202133.38e0913e@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 18:02:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
Message-ID: <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be called
 in early boot
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 5:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's all about updating read only pages that are executable with a shadow mm.

Right. And it doesn't actually need the mm at all, all it wants is the
kernel page tables. Which is why all the "dup_mmap()" stuff seems so
wrong.

I suspect mm_alloc() does everything that VM actually needs.

IOW, it shouldn't have used the fork() helper, it should have used the
execve() helper that actually starts out from a clean slate. Because a
clean slate is exactly what that code wants.

No?

           Linus
