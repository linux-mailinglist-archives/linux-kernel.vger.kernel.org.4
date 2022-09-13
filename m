Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21D5B6C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiIMLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiIMLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:53:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E261FCEB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:53:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f24so11570387plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rA+h/BpR2nFkON+0DWJYOa3DP8P23l3UE4nsXqW7d/E=;
        b=gYgaQZuWyFno2J3AzFVUmZJmBZHGDJgNwG0ukoLmu/MUWnZIiTxEYglWSzLW+xNb6T
         hfwm3pgZWfKQ6XCURvixBefWd804Q/sJo2k+W1Qs67u2F3v4HD0nr/Hrk8gDkU/Bhj15
         QgQ1/05UFubJ6cwQrBiWxfIxIs/ND0Dy5VOSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rA+h/BpR2nFkON+0DWJYOa3DP8P23l3UE4nsXqW7d/E=;
        b=kyE4wZviltM5vH+7fucNbc0weltdkjndSIjAPw4qLG6xuJ04GgOIpWI4VXuYeEx62o
         v1l7X9z+F8SB0J/wwXUrlG65kMGKIqtQP7nL78hQ4IwHG501Pv+n/JlIL9UMzoHF9xLZ
         6Fs/3e+2IU0eF3pwbPd0mfWpMXOAhGOuao471fRWHEE7yOhmqXHq7yx3mMJ/JgtwgmfD
         K+3vzE95MKeyd8nQDaRGbrqqpYShrwTzgqnrw4Lo5i8TQtE9tTVBay9MMpsUlKticR9y
         Yc98JkYZEEhB2LQMDPTWpu2/X1GpNME8xOc5xXmH/WiHlzs0mVNbtHS4VGBmJ0KQeZA4
         stAw==
X-Gm-Message-State: ACgBeo3/59e3KS+Y43oyvsWywsqNz4sgqW2hAIOhHdYf5J9vzmaTyUtv
        5DXXPnlGeLIpp7gU0XYIjSe8Sw==
X-Google-Smtp-Source: AA6agR4mA6ByPjenr14O1Z9ZsudvP3Y210g2+ULOLhN/Youfcbu0O0unpcdAkkh12zXab3Fp4mXX1Q==
X-Received: by 2002:a17:902:c944:b0:178:4568:9f99 with SMTP id i4-20020a170902c94400b0017845689f99mr3607268pla.98.1663070015021;
        Tue, 13 Sep 2022 04:53:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm8304208plg.77.2022.09.13.04.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:53:33 -0700 (PDT)
Date:   Tue, 13 Sep 2022 04:53:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: Re: [PATCH v10 2/9] overflow: Move and add few utility macros into
 overflow
Message-ID: <202209130453.5A729A89@keescook>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
 <20220909105913.752049-3-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909105913.752049-3-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:59:06PM +0900, Gwan-gyeong Mun wrote:
> It moves overflows_type utility macro into overflow header from i915_utils
> header. The overflows_type can be used to catch the truncaion (overflow)
> between different data types. And it adds check_assign() macro which
> performs an assigning source value into destination pointer along with an
> overflow check. overflow_type macro has been improved to handle the
> different data types between source and destination by check_add_overflow
> macro. It also adds check_assign_user_ptr macro which performs an assigning
> source value into destination pointer type variable along with an overflow
> check. If an explicit overflow check is required while assigning,
> check_assign_user_ptr() can be used to assign integers into pointers along
> with an overflow check.
> 
> v3: Add is_type_unsigned() macro (Mauro)
>     Modify overflows_type() macro to consider signed data types (Mauro)
>     Fix the problem that safe_conversion() macro always returns true
> v4: Fix kernel-doc markups
> v6: Move macro addition location so that it can be used by other than drm
>     subsystem (Jani, Mauro, Andi)
>     Change is_type_unsigned to is_unsigned_type to have the same name form
>     as is_signed_type macro
> v8: Add check_assign() and remove safe_conversion() (Kees)
>     Fix overflows_type() to use gcc's built-in overflow function (Andrzej)
>     Add overflows_ptr() to allow overflow checking when assigning a value
>     into a pointer variable (G.G.)
> v9: Fix overflows_type() to use __builtin_add_overflow() instead of
>     __builtin_add_overflow_p() (Andrzej)
>     Fix overflows_ptr() to use overflows_type() with the unsigned long type
>     (Andrzej)
> v10: Remove a redundant type checking for a pointer. (Andrzej)
>      Use updated check_add_overflow macro instead of __builtin_add_overflow
>      (G.G)
>      Add check_assign_user_ptr() macro and drop overflows_ptr() macro(Kees)
> 
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
