Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971077375AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFTUMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFTUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:12:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9571A2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:12:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686708c986so3387901b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687291930; x=1689883930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mZw/sH51+Uar7fU1OzH0F4S7kdt3jyea8NkuZO28Fc=;
        b=ACC8bD/ipJx7pFzTlJOQa4nyrUG0GCpU0e6G0XEoriY8gcAwE7ALynO0pU1O0kgraM
         CkjuTcns0qiLbR847qdCQpfBleJWKbiMFilCJpuB4SKzHaW73B6qWlc5+edSEeylFROW
         zHY2Wg+k+MboEax1G49d1ghl0fO8gG1GE+MFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291930; x=1689883930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mZw/sH51+Uar7fU1OzH0F4S7kdt3jyea8NkuZO28Fc=;
        b=WkO9Qdzd/BVQizH0+lChlYBJPJg8Qcz+bBmNtB7XA9nT/KLqczLYsvIbZ/Rt7x/05a
         ER/RVu4tGCCYEPasmTlwv+yt450zjYP+neCW10fdHNhHD/BMylDJGka8v+DhyOFDu+q9
         JfY02SrYDnHcuGOjnZOnW5zbD574hsTRB2Ai2AQrc9IwdK17j8R9b8f/rXiNZL5/xCYO
         I9T/KiDGcRK/I6CY9rroLCR1lXNY3ZfpK3oqxXlrjIKGxIrksFitKSE9L05L3ohROMcZ
         7cFDUQcCpm9i54efXjeiuCaUXXgTSv4syFsqlVZ29IVRLJfvSCOUAL9I9mLKff1z74SL
         WKKw==
X-Gm-Message-State: AC+VfDzliOEVxXG+YX5UulOeIqD6N8vXTqwqZXhSGVRzDQhPF5owJ3Ir
        Q5JjBWxcxl2gYRdK6UHNeVXWqA==
X-Google-Smtp-Source: ACHHUZ476FchPEseFt3P2/D+fre3+HimYul2bkAmS8gzNZ1hQn6cmMersQMwS8bCAUAN42ovupcufw==
X-Received: by 2002:a05:6a21:6daa:b0:105:12ab:878f with SMTP id wl42-20020a056a216daa00b0010512ab878fmr16307871pzb.56.1687291930016;
        Tue, 20 Jun 2023 13:12:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r23-20020a634417000000b005143448896csm1761874pga.58.2023.06.20.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:12:09 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:12:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-hardening@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: Replace strlcpy with strscpy
Message-ID: <202306201311.862B05981F@keescook>
References: <20230620200832.3379741-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620200832.3379741-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:08:32PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Thanks for fixing up the variable type. (And thank you Eric for catching
the signedness problem!)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
