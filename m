Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D964E70CA96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjEVUPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEVUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:15:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC92B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso2395592b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786510; x=1687378510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9fN0dQoly88G20mqeG6e3wEqqETJg+h79VSFG9UPZE=;
        b=Vt5mLw1zDYiyC23QcOz7VOSTUfaxfWt+kaBNXr4ct2pwiJ99N4MhY1NbeTx3uv1mm6
         qRnDKSWxiCoUPyGP6Z666O7SSigjCy/AdTJKWo5Ri/TUJ1xBsQ0HVb2fau6I/qb+yU8m
         1r5UJtw9NgpIXzOePa+QVYe0Qj0thwDN6wDuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786510; x=1687378510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9fN0dQoly88G20mqeG6e3wEqqETJg+h79VSFG9UPZE=;
        b=SshO+0rvyWQ69GfrSfI2k0o0YhPkFWQEDvX9CZyBWQ33HZtYyY+k52DQ5Ky1wDSSDM
         zs5J7qemdWOvTtXAbwfeQy4AwnBkPDoOy/l8KzdWKwQQznYsT/jcMFjm5S6rhmgGIPZt
         M1dUuHUhMNYfJZJvm9F9czpXvBkUxIjCcLvsY6oem36u/eRBwolAba0tCWaCbNwbHRqw
         KInZ2EafOLcgk6oLu+UvFpKzdwNtFc5nMfqTnNSJ+3r3QkgY7PKq6XOi+35bnHGFl3Af
         cEzFBWr8VMhVLuUk34eSUaOFNNtT1GnnuzLMHJWSDQEJRE/mt62JwIi0fqLcnSRIvUqH
         ntJg==
X-Gm-Message-State: AC+VfDy3d2xiz//aXO+1/v8GRb5jfwRRwpjSk5wepBn2FQ/3S0LXym8K
        Nv8GOQ9gnqB560DqjhjlPjaGyA==
X-Google-Smtp-Source: ACHHUZ7puI3viaM9u3eCn1pWl+lXzpSStw8vQUJTeuU3YLnaPBQ6edr8Hq6qSp4lKa3v8WUp7Z99Kg==
X-Received: by 2002:a17:902:e74c:b0:1af:a349:3f0d with SMTP id p12-20020a170902e74c00b001afa3493f0dmr8517770plf.23.1684786510093;
        Mon, 22 May 2023 13:15:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b001a634e79af0sm5209204plb.283.2023.05.22.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:09 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        linux-hardening@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/radeon: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221315.4392080E4@keescook>
References: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:50:32PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
