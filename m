Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0024B70CAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjEVUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjEVUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:16:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B8EFA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25566708233so1416406a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786577; x=1687378577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXAgSSaBSjm1CetJruAB7G9vGtE1c+hHoYZB1utEDWk=;
        b=QQTUxhTD+GBKEguQUQDkEE7nMOAe18rTZR4yd2iaOBBDSLRz7YTvTiKzOUoz/KfNRX
         53a/09Vvla3KWcqtTiP3yI89difUnrz+iE00qjLf6kPKp7r7w0Bkpvbvvp7WqhswLcI5
         P7LmB9YrcotM+OM13H5iyJWT/jIaabCUXsyr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786577; x=1687378577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXAgSSaBSjm1CetJruAB7G9vGtE1c+hHoYZB1utEDWk=;
        b=DLnknJ0KsVLUeTjVVktWVwZ9y+JvC2bY+fIwbMw5JiK3QAdG4BV0QFcgOqvv+1ldrD
         WYhVDOcRNYKkLUQpH9nE8WbZTQy0BG7idGwQCRYN9OkW9b+kDz4VkUbECCJPw753hrBY
         dpLThymqetA0vd1LuFXGTjYSLczCORXoHpnQ7+xltMmwj5CG42wFoLwm20RBtZbnhNnn
         cyqYkpKPiifbCe7pNwEgdu8Mlz0gebTBGqJkzuA0e4aEDHmN/V1p7+U4reavUTL7vSP1
         nYUlGEOejiLpePa3gdCj+oSfkTGBoOf1q4Vuorf2naPIjxV3y5yi7r0OtgT4Vt8tc1ZR
         uIww==
X-Gm-Message-State: AC+VfDz8AU28ABTUiraJUXOI/itgKNePYCkgTzvWjKrzr71y1l+eSqpV
        XXbbx1CfPl/OUfIiAV5HOBZz0w==
X-Google-Smtp-Source: ACHHUZ51FT7XO9iVtfE7W8pRe2pp+oF+jrhOC7+wSnz9QKew8znPQk021RvlTVHrkhez485O6aBqLg==
X-Received: by 2002:a17:90a:a611:b0:253:2dc5:4e12 with SMTP id c17-20020a17090aa61100b002532dc54e12mr10854532pjq.46.1684786577531;
        Mon, 22 May 2023 13:16:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa12-20020a17090af0cc00b0024de3dff70esm4445821pjb.56.2023.05.22.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:17 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm/sun4i: hdmi: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.FE9BC18975@keescook>
References: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:53:31PM +0000, Azeem Shaikh wrote:
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
