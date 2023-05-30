Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797BB717185
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjE3XRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjE3XRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:17:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7411B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b01bd7093aso29293075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488647; x=1688080647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHUteLUYvh/51uT822wgzC3UC/lmseb/CzQL8BFKOrc=;
        b=LSb8+cHv8sZlouoCKJB81L8JFOiBRG3ScU+UmR/rKy5K1ASuQ8WY2wLLUv3ygI7wQv
         6O8r5uvdKzrZzuh8OD890tkQ7V2yMRN6neekkRSBVLLmzlOeMr6l6lkdFimxsF0IcoXQ
         klZKH7zz53Bq/nHFRp57i/ZRuUzmFm8BwMteA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488647; x=1688080647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHUteLUYvh/51uT822wgzC3UC/lmseb/CzQL8BFKOrc=;
        b=V783oOYL2sPlBtmf5jb22TgoTU4K5k9Xl6ELIgUuTY85E01dWgxnjqjIVNIWUNtHqa
         mDyz9D2B36s/+XiAmz8pWH1S5O+k6rRwgy0HtyiUly1O+eUAwjIdX8Z0wGgrLKZTANPZ
         X8NmaEgnAilnnY6PeRgVLWKHAhPfnOXZvL5rVV4IovHgZb25NZxSVkRj+YuRQBT43O4o
         6TlLM6QD9xTcRmL7gdYmXKB42OKnSfDmVaevaGh1AeptRhyDQhYjPZwge3vJ8p4lsqrj
         R50a0UkWl0GUhouEGfrwqAQB/nVfZhCXAbURKX1MHJsMyT9PMsLm5fQU/BvDIFPR9oAU
         1eDA==
X-Gm-Message-State: AC+VfDztH+WGvtv+3ShAHs3jSnTdlkh8rYgbJEd9Z8N5ZlpFMj0TQwk1
        fMlRzYVDSEPaDUkdBLGJvv39/A==
X-Google-Smtp-Source: ACHHUZ6fNaQeRwTLdgTPTxJeYnGX1s6sOgZQ3jUFobl2MDArHnYkD1mA6XM0wA5m29XTuVrRMEZelQ==
X-Received: by 2002:a17:902:e74f:b0:1b0:2658:db00 with SMTP id p15-20020a170902e74f00b001b02658db00mr4762889plf.31.1685488647652;
        Tue, 30 May 2023 16:17:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001ac912cac1asm10861519plg.175.2023.05.30.16.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:27 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301617.A25BC88@keescook>
References: <20230530155608.272266-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155608.272266-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:56:08PM +0000, Azeem Shaikh wrote:
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
