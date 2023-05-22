Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3770CBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjEVUzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjEVUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:54:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72E94
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:54:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2535edae73cso4555232a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuElaN/qDTwisrD4X6pHQNWgjgAbUbIATBdO1zpDRq4=;
        b=MhuIchJoSP3VNW834mCsQH8QhVAtF7Te4uKXeNA+vCPR8uLVLXQlSOUUqmD3FnOyFq
         wSE2ePdtuZfdxWOxnqhyyk5C3i51P5jAWLvfCTqGtZm/Hv6oG/eG7QO1GYOPLQn9IsUF
         ukspP2HSGuGjgrmweUS3CD9/nlMyJ2RKTL4hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuElaN/qDTwisrD4X6pHQNWgjgAbUbIATBdO1zpDRq4=;
        b=J/hUTPA0BnS9VGyjmWyYXn6F71D7Sf/AURHKCSegA3sOK4Phij2ecMTtWMpaO8f+jq
         Yy8BCFR3ttaXyavnXEk6b70QTdlqsyCcK5LtoZ41P50rbJ5dr40tonTW9Y6w+Kr+KwoG
         3tcbW3c04GN0jkTtGFpKxtbmVaVDhfbrVvxM6C6kiKO4BybjKvpm3TxxQuAcbV8ICxmB
         LfTAPbYd4CdbDF4lrbH2c/D3bUqP0pCJDamk9a/iMD0Z9IyEFBRnMGOrG4oYkDq6KLnq
         14tdUVi/tW4BMelGkpUPjXNLm0eSPeopNVP1FPlAVrf+fSZRjZER4KojVcVOnC8m8/dS
         b7wA==
X-Gm-Message-State: AC+VfDzBh4SCGWSoZZ/pg9dm0co2eM7U1IJgLmE/2uFFXci9S0NcTBOI
        A1HMFIM+w59xjQpaBBV/ge8iIg==
X-Google-Smtp-Source: ACHHUZ5RojlqCQM3TmsJ+Nx4QRDer9RPXkiS+1C8Bn4fPCBBrUhOW1RX7WMCawCYR7+Mqz7BmU1sxQ==
X-Received: by 2002:a17:90b:3555:b0:253:3b2b:2a3 with SMTP id lt21-20020a17090b355500b002533b2b02a3mr10962552pjb.43.1684788891123;
        Mon, 22 May 2023 13:54:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a31c300b0024de39e8746sm6807748pjf.11.2023.05.22.13.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:54:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Xinhui.Pan@amd.com, azeemshaikh38@gmail.com,
        christian.koenig@amd.com, alexander.deucher@amd.com
Cc:     Kees Cook <keescook@chromium.org>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, airlied@gmail.com,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 13:54:49 -0700
Message-Id: <168478888725.1444594.8281276970110924816.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
References: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 15:50:32 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/radeon: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/76ea3f6ef93f

-- 
Kees Cook

