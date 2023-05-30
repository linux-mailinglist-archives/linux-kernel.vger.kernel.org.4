Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA971714A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjE3XGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjE3XGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:06:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0414EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b01d3bb571so28108685ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487974; x=1688079974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSt3Az2tny3eQlaVqB2zu16ttm63V7AZ7el7ka8wKXU=;
        b=X9z9+aQDWH74vRy4IFplfW22Zx5BEwKFKnlpZHyhVJxEScox69ft1HKu2FLKLcSrge
         Vd01P1Id4crkK4Hcd6tBX8pKrEOECwVQjb9ZktMnA4BEPLyas9jK1raP4sSjp79/Qxz0
         LeIwDXRtXCqgbmHoSHUaf6xq8WrxB3sDiqNBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487974; x=1688079974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSt3Az2tny3eQlaVqB2zu16ttm63V7AZ7el7ka8wKXU=;
        b=NhgQRnry1uUIxrTrj6OzsQP8y9F1B9jZjfLm3iTfg8mfwd2cc7llVyAtavzixBgc/a
         173Dns+0qDA/0JBwQU9c9hoHX4SKDwLUgByTQqTQafuBJDEAADGLVMJBTr9DdcghxOYf
         Z7nwtFgAKjodhh01bi+KSzcKObQPubdhi9XO8ZECn40cVnf8QNPitLHwHI196f4P4rKn
         S9fLlgsPg/eUxlhdDD/HSegLH7mKyRXxR1w21OEvYQvK+g4IMqRK871B821fsMgTt+sL
         W6pVVX9xVV3S0CdUCQcAWXRbMqhogLWycuEAtpWzVRZmEg8ov4cxqyyaAJKjDy59sI2l
         9dpQ==
X-Gm-Message-State: AC+VfDwvTLQeypLQOZXQYQhEvDWi5GhdaiMfiSLXVmf49HVFqok39gpS
        T93/NLICcJ9CJFo/iUHY7cOW/w==
X-Google-Smtp-Source: ACHHUZ5RyXdOh/r8J51+MHLiWlyfvyIhJb8ljPwpidWRnHRRfPfGJtDpjXj925079sXa9tjNwK9UlA==
X-Received: by 2002:a17:903:2303:b0:1b0:7739:657a with SMTP id d3-20020a170903230300b001b07739657amr1763269plh.50.1685487974391;
        Tue, 30 May 2023 16:06:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm10810243plr.172.2023.05.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch,
        samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, airlied@gmail.com
Subject: Re: [PATCH] drm/sun4i: hdmi: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:05 -0700
Message-Id: <168548796308.1350188.7857893772168629136.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
References: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 15:53:31 +0000, Azeem Shaikh wrote:
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

[1/1] drm/sun4i: hdmi: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/6036094a9380

-- 
Kees Cook

