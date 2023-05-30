Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA1717193
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjE3XUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjE3XUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:20:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84076107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:20:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so3770298b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488846; x=1688080846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Vwudjwyl03xNqdmEt3B/zK+8nDlcD2+obxiHedFtc=;
        b=UpKCPRGTApVb+TnbUkA1rmKWwn3cbDDqGG87xKnLphX3hLSXpvmZJ7vh4sbHMO4K/F
         rReUuw4P2VmI92qdg7np8UhXfw4V0zswbJS9y7zcsH/wjthAk2oboKs8vzMoDI+VY9cs
         xzHJYPVHMWUI/MT4C9/3+MzpMi7T5KAz1M6+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488846; x=1688080846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1Vwudjwyl03xNqdmEt3B/zK+8nDlcD2+obxiHedFtc=;
        b=dthziis3EhVMcQFax+rN65l6SXSPJlp2dygFPlGajc4bAIAUegESigeZqTRB/OslzC
         CyrR0tB14bbJHwKUh1a0vnEQW9YTilh9VoCJeFrnEFU/vDd9pma8yU2vYR9Kr1ErbsPV
         7CBWd5hulh1XhA/O6+fgJdjTZrokVAongFdDtBgthpvGhNhM48as6xZwAokksbwXjBHW
         +ksJQNWXyP5rckhh+7tl2bH/W9VXKcQQLGx/pCa1R0cTYeHggqL5yHWClH+EFHO1UFsq
         Yt3Pc9An/uxiDGwO9ARIfd4Y2PgsWcWWpDuILnE5ZXsETDPPm3+Qt50Kpe8pPdtObORo
         70Mw==
X-Gm-Message-State: AC+VfDyIBmslE0PLFDrEG7mJ7XCyaQ7AxCHrLsIfcrQpDslYtUt15J5Q
        X3rhyrT96gA1xHG14V4KeTMvBbM9Z0P+RbF+wKU=
X-Google-Smtp-Source: ACHHUZ4/ikUrzoQRWgtj8W7r0NCpEjCwxIwlmB9MrrGvTXySQQTcE+FkqJIm8sbd4vfJu7fOFdam8Q==
X-Received: by 2002:aa7:88c5:0:b0:63f:ffd:5360 with SMTP id k5-20020aa788c5000000b0063f0ffd5360mr5340134pff.21.1685488845916;
        Tue, 30 May 2023 16:20:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b0064ceb16a1a2sm2110446pfi.182.2023.05.30.16.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:45 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Michal Simek <monstr@monstr.eu>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/flattree: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305301620.44CC8F786@keescook>
References: <20230530162202.983558-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162202.983558-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:22:02PM +0000, Azeem Shaikh wrote:
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
