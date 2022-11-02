Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0EF616665
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKBPnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKBPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:43:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B3A286C2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:43:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z26so3608446pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbzfHUK/OIe01GljM+tYcwS2aLG1wlQhszOS90aIPbk=;
        b=TnvBNqsScJgJGa9F6e4NUp0WnQSFcyWRX8Px7ptg6cO6ctt1BRBZcdYb69cwPtIwyN
         QoHb48pAlpwFaQk7ewUS76qc4+cdspn2SEn24wD7ztEg1qPECfbSrnmQfKNybPMUuQua
         osc2GMsfESHWanbfjNZictRM04i534QWu1ZfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbzfHUK/OIe01GljM+tYcwS2aLG1wlQhszOS90aIPbk=;
        b=t4YDGVjYEG07LrUE5YX5aFf74WkDs6Oq5DmdBPVtvOhlm5SjEyrVVHie4N3JBz9/az
         7X+vOtARCOmr099GlFLfjHaQSlmTdPtpHoMRU8d2cbrvHOhlslys0INcJOXcRIkLtOqu
         CXAwqy3rO2SNr1TSc5aIkrTVrkrz4aee8eVGHgw6Pfy6Dg3jjkH5sxLS/skCknPoWUdf
         UMDTDKu08ZbFFxnht0mXJJDCUzIIiCFTs7/k7xT0qgItW+wl+Lb9X0uA21LqajJSaXF1
         ZSPq3QgG2fL2lp/vbkQl9AVIHYLO4dzAs1MDTDS+pA2e34YqQJmZUlTx05KjpZpDTmIw
         Gihg==
X-Gm-Message-State: ACrzQf3UaTTrTX7/haTFVgnraIIS8c/GwU3xruOQq3W2uR/cIOEY45I8
        LjSechLzj9Nt3IMvRVwlaGq9iRnCel8WQg==
X-Google-Smtp-Source: AMsMyM7zf3RSyPAO0SeThAybZk/yt9Nw3pqPZ2/rk3+peKB5InTdiurM9tAyqpCR0+JSZHkWzA3xrw==
X-Received: by 2002:a65:6b81:0:b0:461:4049:7df7 with SMTP id d1-20020a656b81000000b0046140497df7mr22347812pgw.593.1667403780934;
        Wed, 02 Nov 2022 08:43:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b00186afd756edsm8431471plk.283.2022.11.02.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:43:00 -0700 (PDT)
Date:   Wed, 2 Nov 2022 08:42:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix type of second parameter in
 odn_edit_dpm_table() callback
Message-ID: <202211020842.8B8E29F8@keescook>
References: <20221102152540.2389891-1-nathan@kernel.org>
 <20221102152540.2389891-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152540.2389891-2-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:25:40AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:3008:29: error: incompatible function pointer types initializing 'int (*)(void *, uint32_t, long *, uint32_t)' (aka 'int (*)(void *, unsigned int, long *, unsigned int)') with an expression of type 'int (void *, enum PP_OD_DPM_TABLE_COMMAND, long *, uint32_t)' (aka 'int (void *, enum PP_OD_DPM_TABLE_COMMAND, long *, unsigned int)') [-Werror,-Wincompatible-function-pointer-types-strict]
>           .odn_edit_dpm_table      = smu_od_edit_dpm_table,
>                                      ^~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> There are only two implementations of ->odn_edit_dpm_table() in 'struct
> amd_pm_funcs': smu_od_edit_dpm_table() and pp_odn_edit_dpm_table(). One
> has a second parameter type of 'enum PP_OD_DPM_TABLE_COMMAND' and the
> other uses 'u32'. Ultimately, smu_od_edit_dpm_table() calls
> ->od_edit_dpm_table() from 'struct pptable_funcs' and
> pp_odn_edit_dpm_table() calls ->odn_edit_dpm_table() from 'struct
> pp_hwmgr_func', which both have a second parameter type of 'enum
> PP_OD_DPM_TABLE_COMMAND'.
> 
> Update the type parameter in both the prototype in 'struct amd_pm_funcs'
> and pp_odn_edit_dpm_table() to 'enum PP_OD_DPM_TABLE_COMMAND', which
> cleans up the warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
