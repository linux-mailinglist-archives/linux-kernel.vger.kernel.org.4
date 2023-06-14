Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D473075C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjFNSgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:36:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D8E1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:36:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-54fb3c168fcso1804259a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686767765; x=1689359765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZC7B/LsoVqbipb+mOg2a14HKm5zXzGHO5a1f4R/Gm4=;
        b=Y3hBZ1z/uAnBOsK95+BbZC9zIWSEee/T/MkrkxptspQQDnde4K/SPdl1oEvJ5X0BFm
         kEsEINDXDeeMLb3yPGewOfxkPF4i0vwgw8Svi32KHsLb9+Mp0PRNG4UioKnWKQxS59HD
         kXO7TrWoOcEG9/tj9BwrwtPCmIM21fo5NEcTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686767765; x=1689359765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZC7B/LsoVqbipb+mOg2a14HKm5zXzGHO5a1f4R/Gm4=;
        b=at4N8SEKuY7YUgKl24NcSK/TS+3ub3CM1UIZ8FG+Te7OboX3kvCFE7AAFZxi+U0n0l
         UZwJIeKaR/bt2ONWy2glV5sZNpE9zdLHh3jbNa3satpiwyFZtI4z5sVAHQxunkwMd6OR
         rg/0xpldPi/peBbogBYyVp2glH8Nn0POc2C1KK4BnO5gTEY1mdH93a7iZMhKol0icNl7
         fJWx5BeejbgfJ+XEcyUv+yzr5zJod4xwTzgOvvKxUNFid3nFQbELDt6z674hritwXYqd
         VyNqd3gXuUfaAMREoeSfx3E9iIrdpJEnLMQvV475PaWNCLC6ouPEx+ZVXPS8N9m+Khwg
         g4DA==
X-Gm-Message-State: AC+VfDzpvJRJMim3GEoJ83uvIv077POMmqD6riUVRNZlIrlpNRlhTlo6
        E2Feo76mhSHqHltMkXg0RYFqwyHyPx2HMBGTPBQ=
X-Google-Smtp-Source: ACHHUZ5tc3+LgHSq684HcQ1hNhy5WGNkZ6iZvU6mRkzkF7OZs+Z/TWJ/DCYXiY0j2q07csVyJTJo+A==
X-Received: by 2002:a17:90a:14c2:b0:259:343:8e74 with SMTP id k60-20020a17090a14c200b0025903438e74mr2366189pja.7.1686767764818;
        Wed, 14 Jun 2023 11:36:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pw12-20020a17090b278c00b0025bdc3454c6sm6443784pjb.8.2023.06.14.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:36:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     monstr@monstr.eu, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/flattree: Replace all non-returning strlcpy with strscpy
Date:   Wed, 14 Jun 2023 11:35:27 -0700
Message-Id: <168676772560.1899515.3929819267192716409.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530162202.983558-1-azeemshaikh38@gmail.com>
References: <20230530162202.983558-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 16:22:02 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Build tested defconfig with GCC 13.1 from:
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/

Applied to for-next/hardening, thanks!

[1/1] of/flattree: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/a7969f58df35

-- 
Kees Cook

