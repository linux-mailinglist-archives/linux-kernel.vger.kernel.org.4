Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BE70C89C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjEVTkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjEVTjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:39:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A19A12B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d41763796so2185225b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784389; x=1687376389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5RqcsZrHQ+sjRlKQFXMF6X3aaR4SZn4pKZGgKU1YWg=;
        b=R31XgMZUzGR6DdVrmbq8rfIYc7SyOMXqcY0H7pvGchQt1B4VQC4D7lXyV+gm6ZUtxW
         01HtBFXbSkM9NyGXFvOS6DtSfjwr9fPnJ6nEAa0ZvZ1vfTzDpQRHpecl78vUq0HCssYL
         6QxuF3n/ucpgcH4XjhN3wiiYtJW0l0l0wBoao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784389; x=1687376389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5RqcsZrHQ+sjRlKQFXMF6X3aaR4SZn4pKZGgKU1YWg=;
        b=H1z7vXOfX7RYsbYrl7CJqH0iV90IXC3WGLTVSGkcwsHjH1lohIONemyywCX17ShKuj
         MoCxBewo+T6YUsSBzbuZQ+wPF+dSLWceCtM64fBsO5fHQz73U7QE7R2zXCL+CNOcQtMU
         AAmhJl1Qjab+vd5ZgWmSz7byNjgbBCAO1dajTyPwKoKpSqR7J4dtfLnioQsIIbY+EVHf
         Div3HJtpG78JFINg7UUTkvYAXWB51Dm0AvryZ9hqCTYCqLXkqZVaM/ZakBjqy3yfXPC+
         6GGhz07UssYB0nB4nNJGEcU2xQv/iarCF2+aOk5JB3LWlNCUyuFYuMmIWf51FmVBKuPP
         jRVg==
X-Gm-Message-State: AC+VfDyu1xt75TWB9rDAOakiGwBEEiQPZIoMMqJcm6rrTTIMm0+UYTCX
        MoNR8sAtQiu2rz3H7Voj37f4Ow==
X-Google-Smtp-Source: ACHHUZ5Feu4PuUW4w9WTgTQrMG+v/QmFNOiL5RD1syYCI0wPs30vDwADkA8yVxZQTalAjCJLq+cnJQ==
X-Received: by 2002:a05:6a00:2e01:b0:64d:3fb3:9ed9 with SMTP id fc1-20020a056a002e0100b0064d3fb39ed9mr13637170pfb.23.1684784389535;
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a19-20020aa78653000000b0064d74808738sm1625690pfo.214.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, Adam Radford <aradford@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-9xxx: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:37 -0700
Message-Id: <168478437626.244538.8257051598276343700.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517142955.1519572-1-azeemshaikh38@gmail.com>
References: <20230517142955.1519572-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 14:29:55 +0000, Azeem Shaikh wrote:
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

[1/1] scsi: 3w-9xxx: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/fa36c95739ab

-- 
Kees Cook

