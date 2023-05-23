Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5270E3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbjEWRUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbjEWRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:20:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238F8C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:20:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so6754556a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862448; x=1687454448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+vO/cCzHwQuFnPVrGLDZXukRrxNDu5SHC6BXOa81Zs=;
        b=hTrpGv/LdaPA65qPf/L+BSDkbT6zxNZTQPjO/67q6q9Xdc3oYNnP6YT9VTuIFvwA2n
         zzddg+xmleQpDg8/38lvv8BZYegLr+KluMOfzUuair0+1TpySYCCpJhlWYGOgB9PEhXt
         X+fTUDs9r+oaJYcBZwZTy6oX1F0dGqIStzIwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862448; x=1687454448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+vO/cCzHwQuFnPVrGLDZXukRrxNDu5SHC6BXOa81Zs=;
        b=HySY39Yu3IYte6e4jR+3eN/4+j/L/wlObG7Fkd3L6LdbV8Ckz1ePCbjCPeVdimpkMW
         C5gSAqK/cIyOv02JcdxZeX3kBcS1g3sFlfpVvSQDOPSr2I+22+wMmQoLBB3yUeGO5RLL
         YTVXZip+mNQ8P9zadlVcjSZIFScZk5pW3zqfX7TEix0Arjz6GFIOgb9Fn7xt/YJl7Bum
         o/R8GB501yi/36efJgWISHIUvgFZb1NJNfW1a9TukL+jR+J2eBxPxrK8QoRvN6bA+PeB
         eXgIixw00ooQLX7e94np0TEFrNpBsMrgeWvmxHuLJIkZeirvD9zKyKw3kjuoYg2EEq/3
         FimQ==
X-Gm-Message-State: AC+VfDzv/PR/ifRtPxTHMHLGj+U3ikTzzyFxcPl5/cXTVoQRiwgD9KqY
        DSob/o2ubdWqq0cuQIU+8hH3q4uzsqT4fRHe8OQ=
X-Google-Smtp-Source: ACHHUZ4P8xDP0TNAyj32JLK4hmrdVTDjOgl2B0qIzRYWdP+XmmGQKtfRjG2ZNIm+vY9oedRsM1SR9Q==
X-Received: by 2002:a17:903:428a:b0:1ac:4a41:d38d with SMTP id ju10-20020a170903428a00b001ac4a41d38dmr13144028plb.51.1684862448641;
        Tue, 23 May 2023 10:20:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001ae44e2f425sm7007182plg.223.2023.05.23.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:20:48 -0700 (PDT)
Date:   Tue, 23 May 2023 10:20:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, linux-hardening@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305231020.37C95FD@keescook>
References: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:14:25AM +0000, Azeem Shaikh wrote:
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
