Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEDE71715A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjE3XIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjE3XIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:08:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A4B102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:08:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64fd7723836so2219364b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488108; x=1688080108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I1XTjeSWZcGMiJuWL5FVq0CXwJ+1oPVvZhAeV/ZW9Hg=;
        b=c4fmrcom4NDh8NHKSBNUSY9k0wao+F4b7jO+o1GuQ+qpu0ilHov/G220o8+Ox9h4SV
         TNsy+GphzgRm607k6xxkGjPbVKpLlrAApnvHCEZEb7+5c4BJEibcWbcO/6oMExiwdAwO
         UBmDN59ZMnn8jQZuQ/rFDtLP/3OsxSDovSr60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488108; x=1688080108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1XTjeSWZcGMiJuWL5FVq0CXwJ+1oPVvZhAeV/ZW9Hg=;
        b=Few3Ffp8kBxLMqx9RWTIIHWYXvBbQE/bwqTTMRLOLntbuYJnsu3SnOz6l1KbB3WsWT
         D8wN8/nCnnb6798UC1JqaqsjBxeNmCHTD6XV1+fZjUos75r507X2Pur0z1kS8wRT+51h
         ixhQOI+skinUcEYI4w6ZKOS2nQEgmZuOTn9J7lEDBSLt11hBOhJjA0Ki/x1PTWn8fl9S
         J9DWvT6XLWNTF7Bf5/KpNqWBhOV/TW0XfEbVKTdN/aT2Ji4NPGd3xhqTIYwHiypVevQM
         kStl1SmiMYvYh0DhN01PUYbYBgdoBN5VdYNLOfrx2DdNf8pqg7ycJ2dZTzyAe4Yu71AH
         W21w==
X-Gm-Message-State: AC+VfDz1bhkIHf+cVpUp+IODM6JjFi02j6EOECUwdKrEGIQFz9HtN/IH
        X//o/+wscjK4+0PAJQ2o2Xt5Vw==
X-Google-Smtp-Source: ACHHUZ7J6pxCYiDXPce2YlnpWudvs+EEkyDWcM4lsiSyFIay8ZQqbkdVA4ksi4O11VIcUrBrzz7+Mw==
X-Received: by 2002:a05:6a00:16c9:b0:64f:835c:a9ff with SMTP id l9-20020a056a0016c900b0064f835ca9ffmr5606232pfc.12.1685488108392;
        Tue, 30 May 2023 16:08:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g16-20020a62e310000000b0064d74808738sm2068241pfh.214.2023.05.30.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:08:27 -0700 (PDT)
Date:   Tue, 30 May 2023 16:08:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/amdgpu/discovery: Replace fake flex-arrays
 with flexible-array members
Message-ID: <202305301608.2982BD3CAF@keescook>
References: <ZHO4/Z+iO+lqV4rW@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHO4/Z+iO+lqV4rW@work>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 02:26:37PM -0600, Gustavo A. R. Silva wrote:
> Zero-length and one-element arrays are deprecated, and we are moving
> towards adopting C99 flexible-array members, instead.
> 
> Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
> arrays in a union into flexible-array members. And replace a one-element
> array with a C99 flexible-array member.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1009:89: warning: array subscript kk is outside array bounds of ‘uint32_t[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1007:94: warning: array subscript kk is outside array bounds of ‘uint64_t[0]’ {aka ‘long long unsigned int[]’} [-Warray-bounds=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1310:94: warning: array subscript k is outside array bounds of ‘uint64_t[0]’ {aka ‘long long unsigned int[]’} [-Warray-bounds=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1309:57: warning: array subscript k is outside array bounds of ‘uint32_t[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/300
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
