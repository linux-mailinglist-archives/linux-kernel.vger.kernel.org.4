Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3585ECF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiI0VO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiI0VO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:14:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1971E0C5C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:14:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so10516010pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vr5U1/Tp0dWjc28cdfWtq8kpHUXGkwFcQBACPTsH4qM=;
        b=PxytvV3E8ptfSPFZPgiDl5QehMVxAMIkZegdERh6kOaI0UcS0sOA2IlLFuPxidDKQr
         B7nBcywswUREageYf5cMRc4WBMPRiWFUykq3qs6K8+W593r915ttr6+i0ifQ9NmIKFwZ
         z38MOvHH/UAkk16a1I0Gi5JIPxWxYaNAd1uoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vr5U1/Tp0dWjc28cdfWtq8kpHUXGkwFcQBACPTsH4qM=;
        b=2SjbNOSiCIvVWe7PWkpXsl+R7RbZ52dJ3v/sFqRPgog08nJnH0+PpWAKHTI4NTa9fC
         8r8hhRWnA4P6z1Fnqj4RJzf1Ij/o2VHIW7XsUS88QIY66nH+zOSBaB04h3UpzYsBngk+
         RwI8jrelxp9cBYyJj6lpFhlwXf8MlcrWWZ5RBBVkkU/JaW8R28h6FQTBSq8jssv3a0Ak
         ob4F8U80pqwXxRadTz5lbzsTdu74vd1vd2w642GyNj258lIXb3uyf3xWXKAbug4SjBT5
         SmzNw54OsCqJ0JAFzjDPDDHd6+xN9qaLzPEv1kFl6aCKyUlLneogY6DxHr+C45hVweiY
         VL+Q==
X-Gm-Message-State: ACrzQf1qNFyDysPNHcR+L/n9Hh+C7iCRG1DgTaauztun9Vm124KQPXYK
        SL2Z72F/7WjNyjacjUVSsm9xeQ==
X-Google-Smtp-Source: AMsMyM7G84JWu4fHxWchj8R6lVupO6711unh8QcM5a4TLwAgLSyywVnLEuq4FNDU5VXhgb7WM8Koeg==
X-Received: by 2002:a63:6b83:0:b0:43c:17e8:c2a5 with SMTP id g125-20020a636b83000000b0043c17e8c2a5mr25080332pgc.457.1664313264405;
        Tue, 27 Sep 2022 14:14:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902ca0300b00172751a2fa4sm2019681pld.80.2022.09.27.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:14:23 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:14:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3] x86, mem: move memmove to out of line assembler
Message-ID: <202209271413.314FCFC3@keescook>
References: <202209271333.10AE3E1D@keescook>
 <20220927210248.3950201-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927210248.3950201-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:02:48PM -0700, Nick Desaulniers wrote:
> [...]
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v2 -> v3:
> * Fix bug I introduced in v1 when I changed one of temp register
>   operands for one of the two instructions performing a mem to mem swap,
>   but not the other instruction's operand, and discovered by Kees.
>   Verified KUnit memcpy tests are passing via:
>   $ ./tools/testing/kunit/kunit.py run --arch=i386 --make_options LLVM=1
>   $ ./tools/testing/kunit/kunit.py run --arch=i386
>   Fixed by using symbolic identifiers rather than open coded registers
>   for the less-than-word-size temporary registers.
> * Expand the comment about callee saved registers on i386 with a
>   reference to the psABI.

Thanks! This looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
