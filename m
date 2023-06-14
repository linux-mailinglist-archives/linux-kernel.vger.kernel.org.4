Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADECE730755
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjFNS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjFNS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:26:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7257A172A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:26:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b51414b080so1046335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686767193; x=1689359193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qYnv+m/ICTRu2LbpcoNjP2kgdHd9b8SbAiUmYNlsVk=;
        b=bIT1zmjdB4Vp5Np/y1tDGfQHd7EG+EwoSeSFUubX6UvfPXXZ9UYSb3HmWwPY7EW4XW
         hBFMSmioyx9Qasx1vkTkT1KNsXvcOXF/ccAq4p1uvRr2k1CDY2pEPkkIRHfNVQmmeLID
         pqrsnw1fDvZ0Qk7l4ZkM7JzuR+dY8r3Rx+GWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686767193; x=1689359193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qYnv+m/ICTRu2LbpcoNjP2kgdHd9b8SbAiUmYNlsVk=;
        b=LZ1zfjzpPUt66/Y77rp82oPMwKN2yCMbjCO0UdSPAZwJ6lkqap7x3xL5rG+25UtOIa
         uQuAZUk72mnrPRITpjDIyIrUse405aRi8xW9Skn+A+fYgM+DW4F8zDFTG7UZhu9pm71h
         Cq6z4F7qM6icMpbl+559DQdaang7JbMn6LIEpD8e7hBDiYBUFWa7FyjBaKeflm9MiGLk
         CCAydl9IfKYPi2ciJgzf/TXGtG0zg6xDp/j/cBf5hO3FB21l43OzaDurO/xykfPExavE
         +hdAG3ezj9eng+VTOSusrH+rR85YwNVpY4IhSDA6uJIUUsnrsk1IdpkF5YeWjdHvQSBd
         hWAw==
X-Gm-Message-State: AC+VfDzczFAB5MmaHI+wibUKNjRXUOnkLL/MUJZJfC51OQuPkxJYT6dZ
        YdKu/djWvZ/O/AZlu2siRvsvJA==
X-Google-Smtp-Source: ACHHUZ5KGGDal2761z+iPC80n/f5vNYcYplyOjHdl2Dan2lKNUQuHS1DMW+ICrcGAXFEMS6sqAUtQA==
X-Received: by 2002:a17:903:41ce:b0:1ac:8837:df8 with SMTP id u14-20020a17090341ce00b001ac88370df8mr15021519ple.6.1686767192871;
        Wed, 14 Jun 2023 11:26:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001b3f9a6e3b9sm2560092plb.31.2023.06.14.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:26:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     davem@davemloft.net, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc64: Replace all non-returning strlcpy with strscpy
Date:   Wed, 14 Jun 2023 11:26:06 -0700
Message-Id: <168676716423.1877080.11129946294131048538.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530163001.985256-1-azeemshaikh38@gmail.com>
References: <20230530163001.985256-1-azeemshaikh38@gmail.com>
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

On Tue, 30 May 2023 16:30:01 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Build tested with GCC 12 with 32-bit and 64-bit defconfigs.

Applied to for-next/hardening, thanks!

[1/1] sparc64: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/7136be35e71c

-- 
Kees Cook

