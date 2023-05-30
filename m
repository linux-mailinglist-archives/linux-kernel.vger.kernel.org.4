Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C771719D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjE3XV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjE3XVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:21:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497518C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64fbfe0d037so265075b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488865; x=1688080865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljljFYrI9j90T96SUu8HKEzV53F0QD906Y79Nui+Mxk=;
        b=V6TNfBdP2n2BwA8y8Za2WqcyGJgtgxNpLpZmkOvvEuzyhLnuI3dAzTEPb3/YB/4FUo
         N1trzFO72irFDZ9qOssEHn+eicEFQFPo9qtiIO/2LwmPwIScvQJiOWjfXX0wP81gUzMK
         0iimHJac+WyZS3y8G6a1tuIwZfXNtVlBAZm+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488865; x=1688080865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljljFYrI9j90T96SUu8HKEzV53F0QD906Y79Nui+Mxk=;
        b=iFHAs/v50ALl7TwcRzXDJIy8vq5m/XSROa2l2Ke55c7wUbBwUH7wJTRdPkA4MM+2Bf
         g4IB03m41+1qTvseGkEPufDN9rWjrTQ398AScD/5Byp4FLz3QJ8LKRVK1Lis40pcy6UR
         TaEafigQnJ2pFeZilEEkh8qmbnaXgX/MZte8iXvc9wJr/9oli04zVJIH8bf+kRNFaPt1
         IR4dVlseuIvD4/n6Uj1s1gy6ZFiqR6ybxD0bmQp0wGXt5HH2JUZ66ECJ2s3dmRuyiDFd
         /yZqh5ozt/k1OmJoJTamv/iH0Et2aXPv7Jl0iJHS142M9hYzeZhoPpzETDuWv7SkEQ1P
         XOAw==
X-Gm-Message-State: AC+VfDyEso5qusJaDpEdEYpHxp8t8PGicJ9ykwqpqTeX+Vs0CosqX7p1
        8SUFJG2J66bDwxEKooAyCXkgfQ==
X-Google-Smtp-Source: ACHHUZ6xiNFeo5o/L25vvvqopT3t7JyxdHwIM1PpkhrHKD9JuPWUxyfvbMrXvUn38HWPjPPXTxo+aQ==
X-Received: by 2002:a05:6a20:3d84:b0:10d:515:ff2d with SMTP id s4-20020a056a203d8400b0010d0515ff2dmr13086359pzi.4.1685488865544;
        Tue, 30 May 2023 16:21:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b0053b92b26412sm9050237pgk.14.2023.05.30.16.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:21:05 -0700 (PDT)
Date:   Tue, 30 May 2023 16:21:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301621.87C228E@keescook>
References: <20230530163001.985256-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530163001.985256-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:30:01PM +0000, Azeem Shaikh wrote:
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
