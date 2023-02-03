Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849768A0EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjBCRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjBCRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:09 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9248639
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:54:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 144so4232373pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LLnqCYAl80KX/AnP1MJvwNbR1JOT9Aa+XpKrlSinwlU=;
        b=gFMT+46x88hehfxt5nx2SHbG2j17btymqYVEISu7Bm/njCyE3UWdBByqE0ygnOpqbq
         RyXlYuL4F5rbEaCNn+aV31qhLuDPXngVVgCbE1BKV6mZgSIgQh9L8CMbZwo8khDT5YyX
         x/M7eOzHzP5TXUSTLQ1ZMWBgXCRirXQmAIqoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLnqCYAl80KX/AnP1MJvwNbR1JOT9Aa+XpKrlSinwlU=;
        b=DX9X2Uxjceuc+mFucBkE9WKZkJYcJwMMxIzgDunhJpXoKsd6udbCd6WsoKUi9kaEKM
         3ELngau9jhvNG+mGCLnas8fGzRIzl8UOLUTl2WXJlPZOmY9G1iCyzHNWLaQrm2b+Hl7H
         HuT/cUxlAM4kqpMHdCYVKq28RwAEoBg7WIBOdX6fr8Sm1Il2nGL7gNaZYBkUl5alP2P4
         18k+p9GG+QoAyo1ovP9geJkkyUkrI9ldqIBQCP+Pd1XO/RSBZEIsucmkhdedgHl5C3U6
         No+e2kZGCf/Ko69BLY8YHeNdPVIVb8RWj8gQWr40NTQXmyPQseMvm1nDS9iBT3y8VGBO
         54yA==
X-Gm-Message-State: AO0yUKXa3IWsWBYWEXHAUIFkH8pp2i5AktubO5vNm0MHoc6fuitbgZ47
        P3P3H3nS9gJ3iB71pCRyjo1wWw==
X-Google-Smtp-Source: AK7set9g3wK6cBF7u1oZ+DgClsdvFB5iS6W2QtUSeUf14md3Qq7pBO/9xIF/z0HeTuuWMIvw3W6qcQ==
X-Received: by 2002:a05:6a00:22cc:b0:58d:f20b:5f2e with SMTP id f12-20020a056a0022cc00b0058df20b5f2emr14077223pfj.1.1675446847523;
        Fri, 03 Feb 2023 09:54:07 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p21-20020a056a000a1500b00593d7db7f29sm2068958pfh.216.2023.02.03.09.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:54:07 -0800 (PST)
Message-ID: <63dd4a3f.050a0220.fd05.3c7a@mx.google.com>
X-Google-Original-Message-ID: <202302031754.@keescook>
Date:   Fri, 3 Feb 2023 17:54:06 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/vmwgfx: Replace one-element array with
 flexible-array member
References: <Y9xi7nFWRV3S9gCg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xi7nFWRV3S9gCg@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 07:27:10PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct vmw_view.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/254
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
