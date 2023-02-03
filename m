Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BB689F51
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjBCQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjBCQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:32:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6645A8411
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:32:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z1so5750637plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kpK6KgZXQ54pBMdUsHP+HUpnEsKdgQDEGB4BNBeZB9M=;
        b=gEmQGizGKZQHCA1ytHRM6UDGT97glHo2J7W9naosZ1VMVQbEFAURGR1sGpP6uwVbvt
         4FjCWBQ64s0+iMVMRk/Pdg87ZmByxjnhEqBvknvFlw31g48ojNq2Q0J04MnoArHb71ip
         WlF5qPrqDiZDdq6oiyt694Dpp6cDfmOXnqHQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpK6KgZXQ54pBMdUsHP+HUpnEsKdgQDEGB4BNBeZB9M=;
        b=lEG6908v7Q2ts00YpN1ZMuoTROeSojcTD8FPyLb6qOgMD09e+/3YcDn5zllUVW2zpu
         4W8b1A/Pq3sfvMQqGxHiV926csCDMvnQE7bsxgKXGwgj3OEj+gnUpWyNgOiuas/Gp0vQ
         0GN8Si9Git6GZhFJqbB8WVlFJf732k2+a3iRlOrCZxyLF5PaMYNsYXRqqUQhYflm9i2J
         yWsABEc84xEEHNt9TMgnENvWNYfhqJ0RgZQ0TCPcwsvMGSl1PZnYAEcR0nnt2bNr+JCL
         CEqzH4OvbUJnui5wfbpcmkkBYlpsVa+CqbYSFnrqQl7QDg/ZHgJ9X6KMHmi2STxeKVO/
         XaQA==
X-Gm-Message-State: AO0yUKVL3tRA6aZTtzgkXR+aEGMfPYCQgRvgZ2G7mnfiPdSh92iSQ5lq
        sfcgpl8m/kitBAKB8YLE5sTKSg==
X-Google-Smtp-Source: AK7set8qwbVjBH5W+V+grJP9ndtfdT04u2cUvUjM4C67XgmP2kzzkMLxlD4daBx8I9135CQ3ShRNSQ==
X-Received: by 2002:a05:6a20:8bb0:b0:b8:5f00:bbdc with SMTP id m48-20020a056a208bb000b000b85f00bbdcmr10653610pzh.50.1675441937646;
        Fri, 03 Feb 2023 08:32:17 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709027e0900b00198ac2769aesm1803803plm.135.2023.02.03.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:32:17 -0800 (PST)
Message-ID: <63dd3711.170a0220.c22c8.349c@mx.google.com>
X-Google-Original-Message-ID: <202302031631.@keescook>
Date:   Fri, 3 Feb 2023 16:32:16 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
 <Y9zawkok2AWy/brZ@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zawkok2AWy/brZ@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 09:58:26AM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2023 at 10:36:57PM +0000, Kees Cook wrote:
> > On arm64, Clang encodes the UBSAN check type in the esr. Extract this
> > and actually report UBSAN traps with some specificity when building with
> > CONFIG_UBSAN_TRAP. Before:
> 
> Really minor nit, but could we mention CONFIG_UBSAN_TRAP at the start, e.g.
> change that first sentence to:
> 
> | When CONFIG_UBSAN_TRAP=y on arm64, Clang encodes the UBSAN check type into a
> | BRK immediate, which is reported in the ESR.
> 
> I was initially confused since I was aware that there are usually direct
> function calls for the reporting.

Sure, I can rearrange the commit log.

> 
> Other than that, this looks fine to me, and regardless of the above:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

-Kees

-- 
Kees Cook
