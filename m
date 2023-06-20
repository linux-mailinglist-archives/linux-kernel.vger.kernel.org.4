Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B4E737613
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFTUaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFTUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:30:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934DA1986
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:29:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b5452b77b4so31629685ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687292976; x=1689884976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPFs3uVWPT6nJKMmIMIPxr8aRitNSwy0YXMDxcyWXso=;
        b=Pw7VaMvtxnN4fZi3fFWHGeX9UxQaXH2HgWtS4WEucROuqhFr62Ix8JsilD6EEhHZZq
         Vxcc3Rghof8w03f6b9SjLg/zyCXFoVeDgdmgsCfi1lG+R+0NM4QyII/vNnCVTWuaYawU
         72Hs+57FycYVAv7g7/BJxY5RJPgNwDhAIj5Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292976; x=1689884976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPFs3uVWPT6nJKMmIMIPxr8aRitNSwy0YXMDxcyWXso=;
        b=AxMcsx5mO5Uru5f3yfCHcM5sWQL+lbAT1SHKxaKgeQTJrl7MUAXMtwPA7Jnbjp4oX4
         FRtqtx5+KuqUKnwFCJmenTGlmB798NdCCMr5gGY0je4IIlQ4gonWkz+trBYhGTfkOWx3
         DmqYr1zWu/V0RrP0Osf4mi7g+q33yvGvYFSzCiqplXazXyyeOD6VAEF6XaQRDiWduFrU
         cfWUwFj3E4v6i5lKrZFWmQobJyUI5klC4oqMQ+N2c4U4BdBPu1en7Gv8xNWsYzXdR9eX
         Oa/Ly2gKFW0LOdm0i16k7y0YR+MXTLWMirTOn1pkMyE6xKV87dDqaHiN4ted938A9hM2
         kGNw==
X-Gm-Message-State: AC+VfDymV78zBP9ibVcU1mkbmiTQRfJ1KDAFH/SXBbz0V4bKHFfEqeUs
        9KqFnDotsgpsDClNKjhFWYz3LhQ5UjRNEDsFWYs=
X-Google-Smtp-Source: ACHHUZ6Lr7Zx7zoSHtMy6zaWdGNHawJ5qjjajote3IAnnWw3CBH3x1aCNyhXHix9H6Lo6IAJsItsdg==
X-Received: by 2002:a17:902:bc85:b0:1b5:54cc:fcb8 with SMTP id bb5-20020a170902bc8500b001b554ccfcb8mr8563548plb.19.1687292975896;
        Tue, 20 Jun 2023 13:29:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170903054a00b001a183ade911sm2005117plb.56.2023.06.20.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:29:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     anton.ivanov@cambridgegreys.com, richard@nod.at,
        azeemshaikh38@gmail.com, maxk@qti.qualcomm.com,
        johannes@sipsolutions.net
Cc:     Kees Cook <keescook@chromium.org>, linux-um@lists.infradead.org,
        Jason@zx2c4.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] uml: Replace strlcpy with strscpy
Date:   Tue, 20 Jun 2023 13:28:28 -0700
Message-Id: <168729290244.455922.3413650622482867613.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614003604.1021205-1-azeemshaikh38@gmail.com>
References: <20230614003604.1021205-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 00:36:04 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Build tested with "ARCH=um".

Applied to for-next/hardening, thanks!

[1/1] uml: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/e1ca49d0291a

-- 
Kees Cook

