Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587FC604B71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJSPbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiJSPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:30:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE6216EA15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:23:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u21so25774713edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VNHbXxSW7m+bZUVbzSdjwBQQzi1pwoEug4lryfW9UVw=;
        b=VvKHZHVrCjwMBIBMOSm8jl1Vp7/WFMtlMQ01/1g/KHw6JwxVmWqFjjIZXklHCaciJR
         dprsOwZGQYK/S9vox+G0VXON4SDyqeLBdLfQjy/6mFNAbyG65E2Ko4Cg9aggQhRbOAYJ
         eavheiAk6MVutzf+Ga4UGQligCa+W+N6faK0LoK28Tj0pcggPel0yUUq2IOS3EE64t7p
         x3Z0iEYOFonD0wgSnznmDIOBOpzlPC6ajGofl2YnEVfWkDWDYUNHDnQqbEjuFpqGAY5d
         3QpMr7/PA4h7kFYU/H37wwuk0buNel7SuGnek9j2L2zobENwKN6zLZO2eTL1fvJrQpGW
         uK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNHbXxSW7m+bZUVbzSdjwBQQzi1pwoEug4lryfW9UVw=;
        b=49fes1TJEurP6pYy3Mvgfzo0BNo7+JKyFVZxX7JQtAAJgzenx6PTMW0DZb800D1GVJ
         lX8NPdtkTf8lnWj5/YKTDT4aFC9GaArIlahrXTSd5Q4EuHqNnlZd4FAYfrnm4DK/ewBB
         /wEeui7DeVRmh8q801y17Eh0CbnKyW7ttXovbY4+iQG9Ydj2vfGqkrxZDi5lqnft+jPo
         C0QSFUFLnB5IqMhKgd8OVnO5iY6UXDyuDOqF40MdDuTefbEnbCqp2/D0Q5O6nIexQFeN
         xlodhzv8ojoDmCvzhP+mjIM7tRucaBLBxQB71tV5RV9tn8kHZXd3ElEeX19P+QyV/FT5
         xOHg==
X-Gm-Message-State: ACrzQf1c4u+M3kixFgLRWkPcH+CXhqt5u1OcFVga5v9uOQUesL572NOY
        uXGGrBbRQyaXLs3H4TQrkOH9cxNO7bBywx5E119Q/Q==
X-Google-Smtp-Source: AMsMyM5twfx6TWunL+YgtK6VSVbs/MiaHaogi/kqvv3rZgGFrWG15SQkXLJXIHrJQlpPQpq+2CMse8+Imrf/CxJ0tt8=
X-Received: by 2002:a05:6402:27cd:b0:45c:db6f:7e77 with SMTP id
 c13-20020a05640227cd00b0045cdb6f7e77mr8197159ede.149.1666192973743; Wed, 19
 Oct 2022 08:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook> <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
 <202210182200.50680AE@keescook> <Y0/npwZ3UO9+ZSS4@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0/npwZ3UO9+ZSS4@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 19 Oct 2022 08:22:17 -0700
Message-ID: <CABCJKudc4uS87oxdXyXOyuoT1XqwR4ARrS2N9htGbz1y016AcQ@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 18, 2022 at 10:05:26PM -0700, Kees Cook wrote:
> >
> > The one glitch here is that the resulting hash needs to not contain
> > an endbr...
>
> Oh right,.. duh. How about something like:
>
> static u32 cfi_rehash(u32 hash)
> {
>         hash ^= cfi_hash;
>         while (unlikely(is_endbr(hash))) {
>                 bool lsb = hash & 1;
>                 hash >>= 1;
>                 if (lsb)
>                         hash ^= 0x80200003;
>         }
>         return hash;
> }
>
> Which seems properly over-engineered :-)

Also, -hash can't be endbr with KCFI since we use that in the check itself.

Sami
