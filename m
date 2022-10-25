Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54360C106
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJYB3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiJYB3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:29:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A841306
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:06:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id bb5so6681628qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMkA+r6Lkdb6N0+izztoT+4iCmOzMvt12DLQ8k8DOjg=;
        b=ScwRDh+MFfI1jr0SDTqzUKqoKymOBLq+rBtnleXEd7FnoayNaCgt8/bry8tWtF4quS
         vlUMiL9MvVQpsdZubFViwegHaiBuEb9Fzz9lSl3hPssMAW5+oHXehHGibXMovtdbIjWb
         MLz4Qmuw2X0Yq/rYSIou7svOPMeIH/lEBJ5CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMkA+r6Lkdb6N0+izztoT+4iCmOzMvt12DLQ8k8DOjg=;
        b=1aBQI3p2A0OHFBBJqTYzcBzIWCEPusv66sqHwMyu+zj39Z20yRR1rt87OMWOtA4+vK
         UZx7Ih7yA3VTYtwFaAExsw9BFBzKqIhvaGABOY4bsSVLoVSa695pX47Ydgm06me0u93z
         p75kSavK0lOm+HBrH5ErrQiwzjFZz9+amqAxbA2oiszjerrhvgMIVsDok0TsOLIeBc3A
         hwIKKlQym9AWbFOm84bud2/WeGOp7bwqCyjFPOYzJvpK2vVIfWaTH3mbi/MA5pp4GuEa
         Gccj3b6+JLBRLIfEKvNYArTZjSOLiisEJTZgJYzCBxdIHd57VGz5vL3OhCu2DXvEDZOP
         INrQ==
X-Gm-Message-State: ACrzQf1D43rs0BiEhu+I8MpkDKj43Z1VrpLA6fbX+1ycXK8onoFRznou
        RYHqTFd6CezB60gV0dfUaiKKmhYElDc97Q==
X-Google-Smtp-Source: AMsMyM4AxHLH+h0DRdqOs68Ns3dlUfhv3qtC1/DvQb3uWo+0CBgf7Gudi9fzOMJ8svgapsFemqbYjg==
X-Received: by 2002:a05:622a:164c:b0:39c:f31d:5d1f with SMTP id y12-20020a05622a164c00b0039cf31d5d1fmr30426655qtj.302.1666659987885;
        Mon, 24 Oct 2022 18:06:27 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006ef1a8f1b81sm1064558qko.5.2022.10.24.18.06.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 18:06:26 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-368edbc2c18so100307437b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:06:26 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr13959508ywr.58.1666659985851; Mon, 24
 Oct 2022 18:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221024190311.65b89ecb@gandalf.local.home> <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
 <20221024202133.38e0913e@gandalf.local.home> <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
 <20221024210535.61174928@gandalf.local.home>
In-Reply-To: <20221024210535.61174928@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 18:06:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdLGWaqw5udT-aZYM2+UjfjsFj=Pb48OGBv2anG=RLmQ@mail.gmail.com>
Message-ID: <CAHk-=wjdLGWaqw5udT-aZYM2+UjfjsFj=Pb48OGBv2anG=RLmQ@mail.gmail.com>
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

On Mon, Oct 24, 2022 at 6:05 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Something to look into. But I'm guessing that's best for the next merge
> window, and not for the -rc releases?

Yes., I just applied your v1 patch.

               Linus
