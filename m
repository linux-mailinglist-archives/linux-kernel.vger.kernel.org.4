Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133B70E3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjEWRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbjEWRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:22:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D5CE41
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:22:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-253570deb8dso4879452a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862536; x=1687454536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03u0/tcn5hg59vj1b/y7vCowhQbtV8QG/zOnqJg2MbY=;
        b=Hk/CZQcslsvTHa6ce5OSHwlQoUefECc5fkXef1113Xfeu+osxIFBVYEpwvahPDsZI5
         xLrbQvGakq/+dDgqCnePUJKa03MzROJVFDBpWABeqaerNmeuHKqM9wZHe8BmJzlOZKWZ
         G026bOjWFvPMe3lyjUDRt9DsLtQSTuZdI3RrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862536; x=1687454536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03u0/tcn5hg59vj1b/y7vCowhQbtV8QG/zOnqJg2MbY=;
        b=dk7+Kh9KKKsd0TawEmYdJDyq3YJCT3vT54HrKkBQfNxXZ7GS3VWukgtnZ93fo7VkyS
         2rwPvlonV4LnG+BnL7er7XZj8H2Lx0OpMf3oWRhSGLIldOz59nnF9Jwgdq/tNlRF0cmp
         O/V8jX+TMfJThnkwLzLmRhd1U2Tb61mvQwrbBbWlyuWuonL7it/cubHmcQy2vAmnORnD
         pyzL4c5Qn+waTebaIwxPmYt9eGlmiZ4p38vA4stZYl2F0LbyEUb4oFdueXUTcEcod1Nc
         LIpp9v/KBrCUKAce+pbXYp0QGrlG9QehhG6StITDjK/b0cVHroDHt7xFNSdRzyKXhKR+
         K3Cg==
X-Gm-Message-State: AC+VfDwD1UffYJ2xHxwFXPl0OVlvc9pzlN5XguWD42SPjAJ7qSQMGPIK
        8r2wBBbLYFxbergXd4OdxfVdqIIa8vpesKSxRJM=
X-Google-Smtp-Source: ACHHUZ66f4U2B7XNJnJdnlmPlPJKIuCMl9ov9Fb1RZPfglQVpm+hpHJXFT6WCvySaTOZmyIl8ywRsQ==
X-Received: by 2002:a17:90b:384b:b0:252:e7e2:fefe with SMTP id nl11-20020a17090b384b00b00252e7e2fefemr13477732pjb.2.1684862535815;
        Tue, 23 May 2023 10:22:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bk3-20020a17090b080300b0024e0141353dsm7742411pjb.28.2023.05.23.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:22:15 -0700 (PDT)
Date:   Tue, 23 May 2023 10:22:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305231022.4742A5B7@keescook>
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:20:23AM +0000, Azeem Shaikh wrote:
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
