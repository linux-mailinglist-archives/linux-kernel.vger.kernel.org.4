Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD33663F46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjAJLdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjAJLdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:33:13 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87AE50142
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:33:11 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g7so10651847qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4NsNfiiBBjcSZ+7yRkZ7ruIkhFB6Oy8YMpgnDQruC/E=;
        b=fdNV2qxft2Ef/Iev+PFuQscPhWLqoR85gJrHP089EUgVhf13mhoXqmubhwwZV2hmhR
         Vx8Cmnev7T5tMPO8eSe31P4IG5aQfWkN69aboxDiJxRlCtaBOqyFD1F6QqD13ZxXM9mX
         Ka2AzHJ3PpAN8PZllSalhApI7sGyAI7xEd34Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NsNfiiBBjcSZ+7yRkZ7ruIkhFB6Oy8YMpgnDQruC/E=;
        b=1rNoy4FYzmi2e8oEA0SY959ThRVxE6bKZKI8MkmrFR7qjA/ERsr+38t39t0MGCkfBD
         I40kOMtB72yHAEBBhHyvln4Iou6SGe5s0acveB1I8Qw+EkNY4341ncoFhX4hVzQLCvhQ
         yvBp0oILHaTM/TUtmqgb0jSynh6kUJp+YTKMOrsQ+80fsyV76un0kYCfbfjRir8a0lLR
         Ei45Lojm522sZKEpW3ediV3rZetv4i4NuEICfsx/6EmV09piI1pZ+c6skgnEoHJaiGNV
         I+OXka7TZfRzexLNWT8KsNGZs/+TGTJpw8YfBZzzBXlRH8HPhHwA7KioQkoFTfyomoK+
         IsVA==
X-Gm-Message-State: AFqh2kr1PcHTi7DPYpvvmW8LVks6R3oINE+UDxaVc/OlVO3tt6MF3GP8
        a7RIDFo5mnCmR4vhOaqzHk9ykRAxAIt8kXN5ZIs=
X-Google-Smtp-Source: AMrXdXszkyLJhhmw/iw6YUFlAnmhnVWwFquar/mB34m2fBzPpVISK6BT4RCvNwG+C5jLTy4x2naR3Q==
X-Received: by 2002:ac8:45c8:0:b0:3a8:5d1:aaca with SMTP id e8-20020ac845c8000000b003a805d1aacamr3723571qto.11.1673350390659;
        Tue, 10 Jan 2023 03:33:10 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b007055dce4cecsm7050682qkn.97.2023.01.10.03.33.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 03:33:09 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id m12so6312248qvt.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:33:09 -0800 (PST)
X-Received: by 2002:a0c:e90a:0:b0:532:31b0:b4fa with SMTP id
 a10-20020a0ce90a000000b0053231b0b4famr515920qvo.129.1673350389357; Tue, 10
 Jan 2023 03:33:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net> <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
 <Y71Bo3yKcLJhe/om@hirez.programming.kicks-ass.net>
In-Reply-To: <Y71Bo3yKcLJhe/om@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jan 2023 05:32:53 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjmhAwNk1QqaFSDvf=PAm2aMt9+dL3BXYtZeVHRd_XsAw@mail.gmail.com>
Message-ID: <CAHk-=wjmhAwNk1QqaFSDvf=PAm2aMt9+dL3BXYtZeVHRd_XsAw@mail.gmail.com>
Subject: Re: Linux 6.2-rc3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dalias@libc.org
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

On Tue, Jan 10, 2023 at 4:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So the original patch came in through x86/mm, but this is very much a SH
> only fix how do we route this? Linus you want to take this directly or
> Rich do you have an urgent queue for the next -rc somewhere?

I took it directly. Thanks,

               Linus
