Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FED70CAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjEVUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjEVUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:16:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440B3B5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so2454617b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786573; x=1687378573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBzsEFEBaOoamjuMu6tkFnCdq33AsZWodYlngR5umYI=;
        b=NQpIylAo879lZg+bIGPMAEf7DDZr1HUjRDRjXgFFzOZAqJismdNG2vT6fvEGnxixbE
         AO59fHineVN3ZV8SGUip2kK2YNl7yCMhINlOucn3D9rFDYquHDJDjZqxyorrI6Aa1PG3
         dgDmEFNb5d5Gy4SPsHORvJXWSanJ+OBQLiiBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786573; x=1687378573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBzsEFEBaOoamjuMu6tkFnCdq33AsZWodYlngR5umYI=;
        b=b6EaBHIYWTyNEa/osCMuxkhIed3nTmMNIg57WSerXVyKQ8wy73UGB2/2XTVUMfgLkV
         Sk7+yaqytfdJVO6JfkqkPsYQNvhL22LATrfOfhW0Nxt70yoL5jpNFR6kdnKJkEcueicE
         KRBiqzwvK+3MvfeCgkcazvvtQT4iGZ4b84ETEe2J7eRhnKwQBZzCOBh41kpoi0faQFK9
         /0miSJQrurOo1B52v298opQ/gNJWz10RE508bhbhWotD4If3GIKbgMUl/VzbLP+ZEcIW
         +dvj8d75qUO+BW3NplgnLenJEu3KwjnuN2OniGxJJPdPduzA62qb4e6SaEnoiTz6lyie
         tTwg==
X-Gm-Message-State: AC+VfDxUn/tKOKOzeVGi/u5umk62zH19PkCVAb5zlndL3oLFdo2GqrYn
        7/4P+mWUtYjNLQhOJzeZZVMoGg==
X-Google-Smtp-Source: ACHHUZ5ATfKSsDeoySmt4TpoCC/s6QT9JMih/7kH5QlewrwQzwJyKfURuuEBVyEFMexNU1NyLHmTzg==
X-Received: by 2002:a05:6a00:a20:b0:64a:4bfa:6b8d with SMTP id p32-20020a056a000a2000b0064a4bfa6b8dmr16642693pfh.6.1684786572799;
        Mon, 22 May 2023 13:16:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b00640ddad2e0dsm4512884pfo.47.2023.05.22.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:12 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.5C8770098@keescook>
References: <20230522155306.2336889-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155306.2336889-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:53:06PM +0000, Azeem Shaikh wrote:
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
