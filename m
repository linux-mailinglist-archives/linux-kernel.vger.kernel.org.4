Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084B4605038
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJSTM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJSTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:11:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2D1C73F1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:11:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f9-20020a17090a654900b00210928389f8so1055499pjs.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhu8V94jGdFAJfWlKuQJBLxMXBDTgqOAY04Z9XkILB0=;
        b=WI+E6mdE7KikoyYbx1G5v3rb1cKskrFPEPpUcFSezZZHvmjimQNtiqHHiCfc4pM22J
         AymUmLfO5HWh/AVsMrYSl5w3Q0rrVH5CxgWqe6ZQxBmHLQykRxTrpcQ0o1fUiTWSrSH0
         rlUAd65tlLGEfN/PG8A2OCHLDa9Y8zuGOoBRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhu8V94jGdFAJfWlKuQJBLxMXBDTgqOAY04Z9XkILB0=;
        b=T63qtrXgUxhZcA11hns+xmvXW3FSfw495uUSmmDXLSs3bn1ZAzdqFMG69BvqecG1Tf
         3BaPwuRz3Qks4ve+QcBmRakcye4VIajjL+tjivY4vRjubpqIoa6In3HYcGrINSv4KdqP
         /62e5YUiYpP4+Zlpr4Ubpux2lh/KTeHt1hHWyqCIMiNzN92bVNDjy2QaeM0yWnoXVyt9
         dHKdF9/Fet0xq55BB6ccMwnW5+XE2S84xB+pHRPu2h+upqCiyUkAqyYXDfo3Vvl0pi4p
         kdx+M7MIFwt+BnddSmbn5DWceswOO1NNpMAwztoML7AdbVCrTY6GBlWAMxcAegU+xuFB
         pRmw==
X-Gm-Message-State: ACrzQf0XIFUyuPmxgVgsIQHNTZPsDb8n8wIPOOg4aXa/D3HoZG+ci0Va
        nMUfHx8cBxbgT9DhRG8uDeLbjQ==
X-Google-Smtp-Source: AMsMyM4zLj3pDGeqBxExWHkpvRO0zSZiZQezSqyo+Hqz1J5Sd+WMFDOQKLR6oMdA/dpI4i+RVsiYBg==
X-Received: by 2002:a17:90b:4b46:b0:20a:e906:426d with SMTP id mi6-20020a17090b4b4600b0020ae906426dmr11831505pjb.48.1666206703114;
        Wed, 19 Oct 2022 12:11:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902bd4400b0016d72804664sm11019006plx.205.2022.10.19.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:11:42 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:11:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <202210191209.919149F4@keescook>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
 <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:56:00AM -0700, Linus Torvalds wrote:
> Hundreds and hundreds of that atomic_try_cmpxchg_acquire(), for
> example. And they might be trivial to fix (it might be similar to the
> fortify-string.h one where it's just a header file that generates most
> of them in one single place), but with all the ones that are just
> clearly the compiler being silly, they aren't really even worth
> looking at.

Yeah, I've had to fight these casts in fortify-string.h from time to
time. I'd love to see the patch you used -- I bet it would keep future
problems at bay.

-- 
Kees Cook
