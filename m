Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADC3607BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJUQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJUQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:11:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D52610B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i3so2972828pfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1n6WS9gwLzO9NZQ68iLdW55eTrE8mdFW63YZmpVqpw=;
        b=PNHUO+oMiw1AtRbglOEq5LakLB6qyp4eKEOXQMKpH7aicNdAUC3FHTZJiz78Arv2OG
         O0lncx58OwP7zNT4I/0qfrinTydPlHpfnukborQzZaRYE5nu8htGYx3dAUdIzE9kPs+u
         oOlfnQMFEv9SNOjV+yVHaCbvVeIET658Yqurk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1n6WS9gwLzO9NZQ68iLdW55eTrE8mdFW63YZmpVqpw=;
        b=HwI3kP95I4/TGmiqNcjT+E3WKMgRcjQ8twrMS4bjE5RjYl4Eo5jsh/lO4eUu4ouZkN
         6Rk5Jk9rdPE4BiazD5/oWIicg5Uz1cgh9ZBvzFQNxNZr+ZEQi5fXtcwDsu9CwinAx05C
         fSqHNQ4s8jK9YETPUxA+lFuv3lRhy0h6V8+xdNZ/rqMM2z3+aBe1JhfU2S+1YU1XinlX
         qKNetFVQwYB+jZxiD81yNpg7xbQTF92TBWG4RHcvxdq3CePNosfkA8DOYOtzG6GOY6EP
         5p/6SbXYPXcActIin+ZjHQ3t9vT9YbInWXOd3r1KMwKV1MjckBzPuURYsaSuQXfdh6TI
         7fIw==
X-Gm-Message-State: ACrzQf0EIBb6qNiRII3tdivCTXt/3+OM6woHFhhI774Apy8U1uZeyDsj
        aielHu31IOIK+AHSNft4ZKClHQ==
X-Google-Smtp-Source: AMsMyM7IQ5foKdM0rYnU1jKXDUYqbMDx601NT2HwcU/HKLMLOFsFp3pzzAFfFqlBBBxDh0+6HCmzXw==
X-Received: by 2002:a63:2a08:0:b0:46a:e2a8:4ead with SMTP id q8-20020a632a08000000b0046ae2a84eadmr17177587pgq.132.1666368692172;
        Fri, 21 Oct 2022 09:11:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm15175956plh.117.2022.10.21.09.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:11:31 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:11:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] compiler-gcc: remove attribute support check for
 `__no_sanitize_undefined__`
Message-ID: <202210210911.1DA1106C@keescook>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-4-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-4-ojeda@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:55PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 4.9, while the minimum GCC version
> supported by the kernel is GCC 5.1.
> 
> Therefore, remove the check.
> 
> Link: https://godbolt.org/z/GrMeo6fYr
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
