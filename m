Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77387395BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFVDK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFVDKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:10:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E38D1981
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:10:51 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso2706988a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687403450; x=1689995450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgLDqCZpojqPASYki3iZZPdkOuhPJ8cSSL0f5T0zXIA=;
        b=NaDa2kmtGYXFAl5nKLBIfYEThEldVX1HQN1gWRxGOcR/tb2DdTg4FasoBgOfrzSQGX
         Wrd+fdQeOHg+rZkvxGKK2aYG+Cm4brn8actk4tnZaqCuLMXQg7JApNCdgBDwlQFoLFY/
         9UxhiL6JHCQT1rHWSM+mJUOqFCLcK2RrCaoaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687403450; x=1689995450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgLDqCZpojqPASYki3iZZPdkOuhPJ8cSSL0f5T0zXIA=;
        b=dN7z4PiVc5mpZpaC1T0WnTE4mFY1RvcAAglFdRzFGN08giEL6Zt8XtH4YzRj6BY9Sm
         9mBSNVguN3uSy5ZeIstwZlGo2WUrqUl1qcz5WiPy2oZ2Ms6HQUffaK5adi0xQiwqFYX8
         7Q5xteU0HEuGq9ArEO5kGaL7UCQhp557U9LHTwUah94t49Rs3ru6+kKNeWwNLh++BYDD
         bZw6fKBsdls+7HOcX4MKqUNq2xtmzF2GboBI565aPsJtUlskDZ9iRRFVgIa5jO2wbJZq
         GK70mzRY1QHMm/R7oXfFa2JGUHL3gtj+/lb9YhuQ2w6ePWML25FgcYl9aYczlHmEO5+p
         I8Tg==
X-Gm-Message-State: AC+VfDzUK9utm5dgDbaZvTF29ckoCpCT9iAVbj4vWvPA6g6adcmY8yjO
        yvuTU/xTSE/kMVxTPE9DKrEbPQ==
X-Google-Smtp-Source: ACHHUZ79yf/HjOkQELPW9oOGSexnnFnYi5yuKVtJf8q0GZydqQ65xtZYCRFUeOHxeaV/PHnK2RNtCg==
X-Received: by 2002:a05:6a20:160d:b0:111:c8a6:88ca with SMTP id l13-20020a056a20160d00b00111c8a688camr17825068pzj.58.1687403450536;
        Wed, 21 Jun 2023 20:10:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001a2104d706fsm4125573ple.225.2023.06.21.20.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 20:10:49 -0700 (PDT)
Date:   Wed, 21 Jun 2023 20:10:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usbip: usbip_host: Replace strlcpy with strscpy
Message-ID: <202306212010.E6CBCE23E@keescook>
References: <20230615180504.401169-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615180504.401169-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:05:04PM +0000, Azeem Shaikh wrote:
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
