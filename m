Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8A623323
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKITHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKITHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:07:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41411EED5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:07:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so4013749pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDep2xTzg7wJbNApQgTgABbwuzhQVUJykl8RQQiftq8=;
        b=BQurSsH56mFh2n1DAucFH0nGFBvGEABBjFzDpVdbF0OUEZHWDAvOsP/G7pxv4eNCWV
         4ajW80cdG/w53j8mTfQm4FDh0XZbRCoYls82xs7G06Or27jBFk5MFV0DRFcT7S/BCshB
         BZ1LMHiue+xtdCc1aftQEQ0M+T9Xseto7C6zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDep2xTzg7wJbNApQgTgABbwuzhQVUJykl8RQQiftq8=;
        b=k9pl/wZ1rzFiE2LA4MTEqvWnlSAfPqabgqDNbj11taxlsrDVssO2weBPNFY62UZUyc
         aOpb2YaSwoLCchJMxtGp0AGxWbanjrPM3LGdmmPzp91o9FlaNq5WMzSRVzEFIWBcIxMm
         2tXv9gwhEODUzXlmhQbwAhw74BDIvTT9jZE9EXxYYIXrsReBYxeCHm8fthNSRL5zQ49J
         qRcyna1DuU2hQPXafqoHCXlrzat40Xx3yv2uIR7rkU+XQfRbh7qYMyByxxgRA8nny/QB
         2fONl4hiyQ0OgWmASj7smZYkfHqvInTJocAa0utYfJ+piQLyyjc3dPZBf1yRNtop3aPx
         YQHw==
X-Gm-Message-State: ACrzQf3RjoXM+UgsUazfCet1uOe1YK2FC1VI3vViJVxew57h3EMnY/Oc
        QVB9yedMESGZlznaBGm2vjxXlQ==
X-Google-Smtp-Source: AMsMyM5Qi9RKSjqi1EKSmHYh0kIPGrBEi36sEsIueAMb3yZymjHoIKLfM6YnRCyWT4Bfo5AfhQSrPw==
X-Received: by 2002:a17:90b:3d8e:b0:213:c01:b8bb with SMTP id pq14-20020a17090b3d8e00b002130c01b8bbmr63663963pjb.68.1668020833460;
        Wed, 09 Nov 2022 11:07:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090a8a0b00b001faf7a88138sm1546027pjn.42.2022.11.09.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:07:12 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:07:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] drm: xlnx: Fix return type of
 zynqmp_dp_bridge_mode_valid
Message-ID: <202211091107.718BF1BE89@keescook>
References: <20221109001424.1422495-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109001424.1422495-1-nathan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 05:14:25PM -0700, Nathan Chancellor wrote:
> From: Nathan Huckleberry <nhuck@google.com>
> 
> The mode_valid field in drm_bridge_helper_funcs is expected to be of
> type
> enum drm_mode_status (* mode_valid) (struct drm_bridge *bridge,
>                                      struct drm_display_mode *mode);
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition. A new
> warning in clang will catch this at compile time:
> 
>   drivers/gpu/drm/xlnx/zynqmp_dp.c:1573:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' with an expression of type 'int (struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = zynqmp_dp_bridge_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> The return type of zynqmp_dp_bridge_mode_valid should be changed from
> int to enum drm_mode_status.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
