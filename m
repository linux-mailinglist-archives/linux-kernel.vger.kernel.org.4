Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC171714D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjE3XG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjE3XGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:06:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C73CE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b01d7b3ee8so31203735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487975; x=1688079975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTDjzev2g/dFwqXAbBNLlrXlZTn+kHPstDE3zCS5cQY=;
        b=GUpfbl+sC9QIc+kIV56cwMaviZrBRnvqS3CIUdUd6vOC1zkRyJf4Ad8fOhD5VXs0Lf
         8eUIAPNzc6PnrKqn7mCyaAW81LriRxS7r48I6U0BXV0AaQIjsEdckuShmd32VTbQXR4J
         Hh96JXPWeuMwLpRkDOYsuLjQiUxaXAteiTWYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487975; x=1688079975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTDjzev2g/dFwqXAbBNLlrXlZTn+kHPstDE3zCS5cQY=;
        b=RybsB28p2Q++l0nS8TNXAZhlN1t8Bz+rucbWIlfbUNHwx/ygIMZWGtcgJWq/NbdFmf
         wTeeVMbf3yfgDCEUNuxTbGWeuvQ5FwNRlbD88psBvKwNjTicFfroW8EmiD6W7w3YJBsY
         X6EAKJ18NNm9Z1raeLElQk2QWvbS09lEaoVC/RMsJfcqFYJ3Rq4b3XvwLNmypw7XtivR
         ZyftSAiakCHE3ZRCMQquZXuWWmrLaVZMkyHgY6QH9AXBsZvOLaXsvKtDBLRJbb1vRRE/
         N2OSj+9Ddkks+8Ph4WyhwhwssH476p2c9Th/VpjpD6mmTlF7ASOjMLgea/ttVb/HoS1y
         TyNg==
X-Gm-Message-State: AC+VfDxyHIQZRZo6XG2OXuh2b6FK6ToUs0/O1RCTQXgFGbyiHNOOorrh
        O3TNBZ+g+aerJxMJmsDG9h4gRQ==
X-Google-Smtp-Source: ACHHUZ7lVzzQbfe9FHzoVRjHe+lwb9YnUIYN/bR8MPHORNI3UhJpQCoHt959/WC7Eg62hE/pMm6l7Q==
X-Received: by 2002:a17:903:2449:b0:1b0:42c0:93b2 with SMTP id l9-20020a170903244900b001b042c093b2mr4463117pls.45.1685487975185;
        Tue, 30 May 2023 16:06:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001ab1cdb41d6sm10800248plg.235.2023.05.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, p.zabel@pengutronix.de,
        chunkuang.hu@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, linux-hardening@vger.kernel.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        angelogioacchino.delregno@collabora.com, airlied@gmail.com
Subject: Re: [PATCH] drm/mediatek: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:03 -0700
Message-Id: <168548796307.1350188.12826442108899002892.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155306.2336889-1-azeemshaikh38@gmail.com>
References: <20230522155306.2336889-1-azeemshaikh38@gmail.com>
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

On Mon, 22 May 2023 15:53:06 +0000, Azeem Shaikh wrote:
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

[1/1] drm/mediatek: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/99ae1670e488

-- 
Kees Cook

