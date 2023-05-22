Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AED70C8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjEVTkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjEVTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:39:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D418B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2532c2c419dso4515897a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfaqv2IW7j0ktP6l11yDGjlEMAVbqVfA7CnllaEK2Rs=;
        b=ZRoUXeZmwyWzkn0eXCQdTEgaG/5JOaNMWRu5CALSkJ2ClASO5oVeRcfc/Pw0ZgbzhK
         WgB6Lbi/XaCPOj+u0LOVQe+qc7i+tOCIlZE+G7tWpKqScZSS05qgEIUyNiFmaqQdbmhq
         NdWRXcpcjuevxIjne0Fad+6PDzEmk3PG9QeKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfaqv2IW7j0ktP6l11yDGjlEMAVbqVfA7CnllaEK2Rs=;
        b=MNehhLmov4WF3ByykMSN0lOyTplYi+24v9uOIZZXGF4Fr2mfLLwOavu0jgg21P0y8X
         e+JvYWXRoIm/T88yufYuvLZfgzeQNpVrJt/VZmh+6M+l4GVVM6iqUOc7BJueUyLlCp/B
         t0FkM/gOYE9zbW7pGEAH/l9a/4m+WUxotnOVeHWBo+bmKVaZcuXF7KqAXrJX4MCZXoNx
         GFOTD1XILQNL7Ut/4cY2k8ffRw6SsFZn/RUDfpVuqLEVP9vPzVfREXWYhpbEHmNZAXPS
         xyEbQjRS3ahN5U8e531IbXCvLR6JiIhRB9HG0D8Are+uwraohUxHjCAsBjM+S2CHZctF
         E1hg==
X-Gm-Message-State: AC+VfDyQelrDUpYVixt1XFc4LLr/MRq3NFBkBPorNaJkZM9gVhtiX+6F
        fE3RLFRcHUnt4bRhId9j/2DnHg==
X-Google-Smtp-Source: ACHHUZ4NYfF3iCEwTe4ycC+JoW8VPmMThArz1vR1M1V4rL/Npj8HuuJy+7FLa0RBPTgwstI9ecayWA==
X-Received: by 2002:a17:90a:ea94:b0:255:2dfc:6c6f with SMTP id h20-20020a17090aea9400b002552dfc6c6fmr8179344pjz.24.1684784388625;
        Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bf7-20020a17090b0b0700b00250bf8495b3sm6191495pjb.39.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     dhowells@redhat.com, jarkko@kernel.org, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        linux-hardening@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH] KEYS: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:35 -0700
Message-Id: <168478437622.244538.16496528769625155302.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518041513.1669386-1-azeemshaikh38@gmail.com>
References: <20230518041513.1669386-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 04:15:13 +0000, Azeem Shaikh wrote:
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

[1/1] KEYS: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/8d27fcac4a08

-- 
Kees Cook

