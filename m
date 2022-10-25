Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC960C5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiJYIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJYIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:01:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C344456A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:01:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id h10so8049539qvq.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZfId2D7R3IsHmX8oa6uBuFcosPjWoQjftQaCLnfakY=;
        b=mXVFmSyWnNqvqnRUkMT88INCUvTR2N5j51gVt/4VJ3d3/YqrM9yGzsjgkukLkhFYvS
         zgipHr2s2TtUM0xRCPU+lymLZstHJ1V2Ge3rbY9u9fs1v9CTk0uWmB+9C3cWFqV4eDGl
         3sLAfZLRDSjGvxhNmwUMY3TeQXECZgRmefZ/A5Si5B6YAWfSLoJJyliEVgE9lONMuMEk
         eBC5Fo3d17dDOeSxrq0fQwDYYPakCu+/6Cv+cDneEhfIWFffsOE43hi3aQtAtJktr9KJ
         klezc3Dkk9oC+WCJo3c2M1eCCA199dRGaEk/0NvsIME7CznP8mkzY2EZsLWYDcgpz4X5
         OXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZfId2D7R3IsHmX8oa6uBuFcosPjWoQjftQaCLnfakY=;
        b=A/i+Nh3EEI2lQPvaGQ0C38L/G8Hq6s/qAHFwMSYf9bmHiSEzVbDFxxv5xcvUIeOy3Z
         imz8IG7XXQpf+gkM+g0d5MYmHzbuUaYBKXLJ5gUE0mNszOyRYG+1QDaP9+4Ky2DL0Bku
         IPsuBVmFVFrp5jP5iGVXOXOrKSJ1+K9KuSo9d1EHkOqSaa2Z0aq0Bano+QzcF9Zsxh9t
         zIfvcMkSzMZ+U3HdItdYKQifk5ScyNDz4bAn2+bDJ4igOddURh+mPPMRj9TnsB8Q1cTQ
         tj+sj83nttIO1867IIYa/KXBS69o6l6HhS7zHbWAvRYfVmxnhvuGh6g+Ur3xR6ByckKl
         WLzA==
X-Gm-Message-State: ACrzQf0m0KdsXMUBLZmwW0s4p0irXlFRpfbEY3cHkiHAGB7s4bC2sYkA
        cu12PksPi6qM4UC/0oskHoeO0+spSLLxFA223POhrYxEHFI=
X-Google-Smtp-Source: AMsMyM7QNJlyGpclkVLrMNWD4FsLCEG/kULH3h/Y1A9Du+pFApSwWwx2/GjeV6gi2EsiEo4lOr0GVomMUhKgxjO+L+4=
X-Received: by 2002:a05:6214:29ee:b0:4b1:c1d2:6635 with SMTP id
 jv14-20020a05621429ee00b004b1c1d26635mr31224127qvb.82.1666684872509; Tue, 25
 Oct 2022 01:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
In-Reply-To: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Oct 2022 11:00:36 +0300
Message-ID: <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
To:     Nathan Moinvaziri <nathan@nathanm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 4:46 AM Nathan Moinvaziri <nathan@nathanm.com> wrote:
>
> From fcb0159ee74908f92adc34143657d8ca56e9a811 Mon Sep 17 00:00:00 2001
> From: Nathan Moinvaziri <nathan@nathanm.com>
> Date: Mon, 24 Oct 2022 16:37:59 -0700
> Subject: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
>  chars match.

Why is the above in the commit message?

> With strings where many characters match exactly each character is needlessly
> converted to lowercase before comparing. This patch improves the comparison
> by only converting to lowercase after checking that the characters don't match.
>
> The more characters that match exactly the better performance we expect versus
> the old function.
>
> When running tests using Quick Benchmark with two matching 256 character
> strings these changes result in anywhere between ~6-9x speed improvement.
>
> * We use unsigned char instead of int similar to strncasecmp.
> * We only subtract c1 - c2 when they are not equal.

Nobody can take it. Please, read Submitting Patches documentation and
fix your contribution accordingly.

...

>         do {
> -               c1 = tolower(*s1++);
> -               c2 = tolower(*s2++);
> -       } while (c1 == c2 && c1 != 0);
> -       return c1 - c2;
> +               c1 = *s1++;
> +               c2 = *s2++;
> +               if (c1 != c2) {
> +                       c1 = tolower(c1);
> +                       c2 = tolower(c2);
> +                       if (c1 != c2)
> +                               return (int)c1 - (int)c2;
> +               }
> +       } while (c1 != 0);

You tell us that this is more preformant, but have not provided the
numbers. Can we see those, please?

Note, that you basically trash CPU cache lines when characters are not
equal, and before doing that you have a branching. I'm unsure that
your way is more performant than the original one.

-- 
With Best Regards,
Andy Shevchenko
