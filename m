Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E8717146
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjE3XGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjE3XGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:06:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4EEE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2565b864f9aso2230722a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487976; x=1688079976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIZITtN2bKn4epnZA2aYk+MPyTdtLfd4FD17Mvvuc+s=;
        b=c0hOeQpScZnxVdLys+GcGo36POTD+McxKYLKI2O2AJP93Y+cMku8bLaYjilcymC99G
         ajnfrL573vrFpsgBn7xnJi1Eb3TQetX1BSBfOMfUoZh6xoPjFrnTrPTojvFJxekXH0/k
         AkrK5vEFS4WJq6XtyNCJ0ZQBHeoQmBD8CIPWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487976; x=1688079976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIZITtN2bKn4epnZA2aYk+MPyTdtLfd4FD17Mvvuc+s=;
        b=JszlOK16oNA6F2gLn0TLSQGTaUuSjuACCnbWexLlSK3nJLhamcFsX1e/U4d8VD5wPJ
         8xLSyhOx0R/wjrG3CLlZtUq+2OhrRGHGx3bMp2/mdB7m8QGcldaKYdZR0EZjjwt2PGp3
         VwJ+nx5LLqGKQTpCbOVAxD0n7w+0impQMuM/NLWIxiWu7K43/fxBgNbBoxVjj8nyLdiA
         fgn1E0kSacDry7anjE9VB1kstwHq+B1pYHWMclBVhxFnPB/X311FiLoLocuXul0CpZ1H
         Cuxx3TFbGMl0CGJ/mGYgepfIfFt7CruqOXYz6EnLGlJuEcU1Zs3qxd/B7sotCXkYU8On
         w1gg==
X-Gm-Message-State: AC+VfDwYKSnaQ8ZFNnfS0I56ZRAHyRnTtNGq7zXOApfC6y6Otv9h3G42
        PW271oBRQ+Vut9Dz2kdRM06Vmw==
X-Google-Smtp-Source: ACHHUZ5jQFK+2MaC3xETbHHaMeqzbXfvABdTY+M1OZIR00QqD/GOmMTju4UsQ3310f7NZCUs1aUCcA==
X-Received: by 2002:a17:90b:3908:b0:255:c461:6405 with SMTP id ob8-20020a17090b390800b00255c4616405mr3924044pjb.15.1685487976005;
        Tue, 30 May 2023 16:06:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090a77c800b0025695b06decsm3351803pjs.31.2023.05.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux@armlinux.org.uk, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, airlied@gmail.com
Subject: Re: [PATCH] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:02 -0700
Message-Id: <168548796309.1350188.15805729218836239223.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
References: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 15:53:50 +0000, Azeem Shaikh wrote:
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

[1/1] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/a7aba6fa2750

-- 
Kees Cook

