Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D7C6698B7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjAMNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjAMNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:36:23 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD958F8F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:28:43 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h21so18883045qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QfeydUrNjvH3jd65uRbW5Kiu1veGiEDsYVQS9PZaFzs=;
        b=Y3oSeYy1LXQRR+tGJDe8q4kt8OjRhJ6ReAe9QZSslvWxSW46gXYhPduF4cb+zJq6V9
         1Zt3lcUAFEuQ/9hIAKOHcIAC3fe8DQMZsyFp3OEzdS5+yZqFPReuXmd26KzyONi7tuEM
         lmlXgeFDgYXP65f2bGC9kNTlXUaEe/IBqwm/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfeydUrNjvH3jd65uRbW5Kiu1veGiEDsYVQS9PZaFzs=;
        b=1ematKrggOfvjRp9xs5pOiOsy/xTvjBOUnuFKS9LzgBUQSe24Wdl4ZDePwGtx9o7UR
         VMqldPIZEDECkeBmGUbJCGq+Mwz+o1rnmuzKDR+Ymm48Qmy6qoa8IjszUfeSEPLALZ0E
         ZoBhX0EqwTuPcze9Qsw5i7549D0Oa4SFqCIkxMn1KBzm8EaaY/jtE50KCWSHcq91XGbM
         wTkpr4K7tTis5Hv/qGp3JcFSliew5xXul8qiI6TP5STuucSHIugKhwGp3gkyAI6QaxrN
         O0GQV8fwE6zv5sdkvErMhYiJbJ2FsSkS9BH9MQXme1BltJqr4FzSDQnCBHGg1MIN5Bby
         uCqw==
X-Gm-Message-State: AFqh2kobi7lJkjHyBJNnOTEdK7XAjO43TBXcXn4mbMclhk9n3nYleaB7
        sZRJ8PjAZnu/hEoESm1yNx0oG1lne4Gy2FFVW7k=
X-Google-Smtp-Source: AMrXdXsVuxSNBIHSCP71IAKp+hr+9ambPcM1bApZqVA0TWTgXtAyLBeA/ypayuMpRD+xK4dgTVwpSA==
X-Received: by 2002:ac8:60d9:0:b0:3b2:1003:37e5 with SMTP id i25-20020ac860d9000000b003b2100337e5mr6493001qtm.55.1673616522550;
        Fri, 13 Jan 2023 05:28:42 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id b3-20020ac86bc3000000b003ab7aee56a0sm10557627qtt.39.2023.01.13.05.28.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 05:28:42 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id y8so14793039qvn.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:28:41 -0800 (PST)
X-Received: by 2002:a0c:f38d:0:b0:534:252f:b091 with SMTP id
 i13-20020a0cf38d000000b00534252fb091mr458074qvk.130.1673616521784; Fri, 13
 Jan 2023 05:28:41 -0800 (PST)
MIME-Version: 1.0
References: <bc4f8b87-101b-381e-debf-6ed87bfec9f3@I-love.SAKURA.ne.jp>
In-Reply-To: <bc4f8b87-101b-381e-debf-6ed87bfec9f3@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Jan 2023 07:28:25 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjbu9USn=hVWQ9v9t1H+8R6qXj8REkm36==w10zM0cM6g@mail.gmail.com>
Message-ID: <CAHk-=wjbu9USn=hVWQ9v9t1H+8R6qXj8REkm36==w10zM0cM6g@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update and hung task update for v6.2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jan 10, 2023 at 5:07 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> A Makefile update for making it possible to remove scripts/bin2c program, and
> an improvement for making it easier to understand syzbot's hung task reports.

That hungtask change I'd _really_ like to get from the locking people,
not from a random - and completely unrelated tree.

               Linus
