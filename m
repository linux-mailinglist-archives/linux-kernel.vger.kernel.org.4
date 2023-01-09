Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0266229D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjAIKM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbjAIKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:11:38 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D512B15831;
        Mon,  9 Jan 2023 02:10:24 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id p17so5903320qvn.1;
        Mon, 09 Jan 2023 02:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eo6tmCzXWkWNQyGQ2z8UwN/W/4YHU6wHtrG3LPCA6o=;
        b=rOcqaScSLbJkq4Dz9IuFiS82wo/G0uSwH3MNr19NdMGb/RZAmKLtU2vu2uBSS144Rr
         q84OM3TYBUqBGoHKHm8GdctHGtHaNPekPt9zfTV3H4EYJZbb9T4vfuViSZ4Tzv+IomTN
         ARYw2Bt1h+DFX+ZZBhiZvHKsZ1uAJRl0UpcNNm2eR4Wr79UqSTpSWYMvQ5P8p/yPTeDq
         y8drnciD3e0AjIW6HHPVdcFgjYHtpslo3ecpZ7cbxyZzQ1rBxxhQxkhlbrbGiN2KSdvO
         b2l4Nh85kiet2FQOisLGhkU6gEsXWk9yyvYj8HLsZs0prJizsXWmdrNpmsnuKIKaTGsQ
         Inlw==
X-Gm-Message-State: AFqh2kqW3HTPmSAC3aOXGJDYd048pD5f3LFDGil9UfQYtyiTGqmQxOav
        vp389pMB4tHSuRRsw7ueV4Hmwd6dBRFwjg==
X-Google-Smtp-Source: AMrXdXvIh1vFGfP8JViQZonPEDjxWjYNewL8+RyI0sSZrOwP0oKZZO64EOS3DIQ9IsNPOMvtIlx7Mw==
X-Received: by 2002:a0c:d602:0:b0:52d:937c:cd7b with SMTP id c2-20020a0cd602000000b0052d937ccd7bmr88560948qvj.21.1673259023728;
        Mon, 09 Jan 2023 02:10:23 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a13f700b006fefa5f7fc9sm4998432qkl.134.2023.01.09.02.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:10:23 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-4c186ff0506so106649927b3.6;
        Mon, 09 Jan 2023 02:10:22 -0800 (PST)
X-Received: by 2002:a81:ac18:0:b0:475:f3f5:c6c with SMTP id
 k24-20020a81ac18000000b00475f3f50c6cmr203733ywh.358.1673259022692; Mon, 09
 Jan 2023 02:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1> <20230105005126.1772294-6-paulmck@kernel.org>
In-Reply-To: <20230105005126.1772294-6-paulmck@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 11:10:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_+t=msiusxi3BxgFVxMO8Y-mMDoTLnx_RUzPXVWrdOQ@mail.gmail.com>
Message-ID: <CAMuHMdU_+t=msiusxi3BxgFVxMO8Y-mMDoTLnx_RUzPXVWrdOQ@mail.gmail.com>
Subject: Re: [PATCH rcu 6/6] rcu: Allow up to five minutes expedited RCU CPU
 stall-warning timeouts
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dave Chinner <david@fromorbit.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for your patch, which is now commit 0d49d9123dcf41f7 ("rcu:
Allow up to five minutes expedited RCU CPU stall-warning timeouts")
in next-20230109.

On Thu, Jan 5, 2023 at 2:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> The maximum value of RCU CPU stall-warning timeouts has historically been
> five minutes (300 seconds).  However, the recently introduced expedited
> RCU CPU stall-warning timeout is instead limited to 21 seconds.  This
> causes problems for CI/fuzzing services such as syzkaller by obscuring
> the issue in question with expedited RCU CPU stall-warning timeout splats.
>
> This commit therefore sets the RCU_EXP_CPU_STALL_TIMEOUT Kconfig options
> upper bound to 300000 milliseconds, which is 300 seconds and 5 minutes.

s/and/or/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
