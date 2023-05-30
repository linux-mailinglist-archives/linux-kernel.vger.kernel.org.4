Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A18717197
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjE3XVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjE3XVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:21:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22E10A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d426e63baso5702054b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488876; x=1688080876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXrqvWKS+nGr8mCgm8RAk3AjHAfZ4ATcF5aLBTNpjj8=;
        b=ezw18XkZa93bewhzvNi3R0B0kQfTJEXnFDhM+zht5cwBCp9qc1gr0C0PZTAGeE2lZ+
         kXCdtyS4mojGCd8csZRo5uW8VKTFlrjo+4D+Xw2BdddL9Hnyv6Hrt9nyDSK/34ydUS4n
         5j11a2Jn0iujep6UVn00JGln7czzer+JZU6HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488876; x=1688080876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXrqvWKS+nGr8mCgm8RAk3AjHAfZ4ATcF5aLBTNpjj8=;
        b=APUsyYNNj58NmHk9yBam5B1xGdC2zA0eGJGQty3qO8F6baq1q1hovf8dnua5VyrD5D
         Ina28IoCB/UA8g/YImtHxlLf8skZf3gb3OfqRcSfmOvTvAhjf4Doq0ed9OqvU3R/68+1
         +xexaOmhvJy16eG+rm7IByBE6/GXXrI4WN0lNMCFtUBzBpF22NljtDMYC32xv+icug3a
         fctyhXy7a/ZvZ0+FFgF68u8vRMd4BflDLe8tFQsYq0I3taM1BTbutaV9LLfLaoAZPwS6
         itj2M/c10S3I0m8BwIpdbk5wZdFT72ahg7UP81Zl1N8+nX1YwTHTAYYfHKyOvvOT5PEl
         0pSw==
X-Gm-Message-State: AC+VfDxG+xRqYUbHkXiqPXDMTR7/t3mj0U695C6hwxIP2Fc0eklY7u77
        kVH7PAp2sHpocNREcsJov5N+RIhQF7tbK3whHis=
X-Google-Smtp-Source: ACHHUZ5338Jnt0Oo7GgByPkEFl4jNQ7BIOKJt9z+9w+3gSDhP0aqSKM/1yO2crs//in7mttyH7S1Sg==
X-Received: by 2002:a05:6a00:3910:b0:64f:7c9d:9c09 with SMTP id fh16-20020a056a00391000b0064f7c9d9c09mr5323277pfb.32.1685488876528;
        Tue, 30 May 2023 16:21:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b0065001705ea5sm1232849pfh.193.2023.05.30.16.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:21:16 -0700 (PDT)
Date:   Tue, 30 May 2023 16:21:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301621.239F666@keescook>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530164004.986750-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:40:04PM +0000, Azeem Shaikh wrote:
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
