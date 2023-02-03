Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F469689F69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjBCQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjBCQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:36:15 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05443A8A28
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:36:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so8253992pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LZtc3hBezsFJ+JgXERdSrjKYkX6f+8fQELANbScmeYk=;
        b=mHrlZ7VUo1d79tXgLzaqxxG9hcdPrsDjmdvruc68JlP/BcPGX6egmlSPG7P7It0txU
         9dSU8O56fxinEmwWStz23VSXfaZYMa0GH4lpLKS7aLvcF5ojWn1K1ZD/aInbbKE8BbJ1
         hWhhJvJq4ELKM69xRklBE4mzVGrmH5qINRT1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZtc3hBezsFJ+JgXERdSrjKYkX6f+8fQELANbScmeYk=;
        b=EqgulrUEyJ6sCZq79LZlx8GrH/YqiJOtK8+0pq8+9e/Tb0n/xx4O+hk6Xg+bDs2gec
         b8JkoTHMQ7M5xmReWASRw/jNdg6PGz/OOpSvPvzgeq6KHrct7dkMs5giziRkwFUBh7Ac
         Bn+ImwynQe7Q85L9WR7c9GP2G/lqniQocIXeByzZnPTdbB8Y6lvXWSzbO7xkn3JuMz0k
         UBK2uMDJk2I86HMFqC/365pe+hZF9M6u2GNx5TP/gBmMGQqHLmp43mTXZoyxb0N9IJtK
         w7dbHxiiki3ZGm/sxuTPWEX0t5N1yLR8jODpinYBOmM12hLH24N6SCVvD9qSbY8DHVnI
         ht1A==
X-Gm-Message-State: AO0yUKWDjez6kSPk0kxn3u/a7qKU39E6ErtkS6nZom/QE9V+51Z4PSXF
        5y3pHfzO4a2knSOpbim4l4w+Bw==
X-Google-Smtp-Source: AK7set+3gOK3BkJ0vQrBWtI5HAPi2PUYKNh8e6pqdOUt0vJfLvEQUgDgdUfKrw4YniHqw5Fg1TUcIg==
X-Received: by 2002:a17:90b:38c2:b0:22c:15a4:62a0 with SMTP id nn2-20020a17090b38c200b0022c15a462a0mr10965335pjb.37.1675442165363;
        Fri, 03 Feb 2023 08:36:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gt21-20020a17090af2d500b0022c25153cf0sm1405689pjb.44.2023.02.03.08.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:36:04 -0800 (PST)
Message-ID: <63dd37f4.170a0220.9621b.27b3@mx.google.com>
X-Google-Original-Message-ID: <202302031632.@keescook>
Date:   Fri, 3 Feb 2023 16:36:04 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: Support Clang UBSAN trap codes for better
 reporting
References: <20230202223653.never.473-kees@kernel.org>
 <CAMj1kXHa=jD_YNxymjd8zQo2_QHgh104RcmCY3gZs3rp24X_Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHa=jD_YNxymjd8zQo2_QHgh104RcmCY3gZs3rp24X_Zg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:34:38PM +0100, Ard Biesheuvel wrote:
> [...]
> > +       switch (check_type) {
> > +       case ubsan_add_overflow:
> > +               return "UBSAN: addition overflow";
> 
> It would be nice if we could avoid duplicating this UBSAN: prefix 21x times.

Yeah, agreed. I didn't see a way around it without weirdness or loss of
details. die() takes a string not a format string, so without really
odd shenanigans (re-write a single string in memory?) this is the most
straight forward. One idea, though, is to drop all the strings that'll
never happen -- i.e. wrap individual case statements in the associated
CONFIG_UBSAN_foo. I already dropped several strings that were never
implemented in the kernel's UBSAN. I could be even more picky. I'll try
this in v2...

-- 
Kees Cook
