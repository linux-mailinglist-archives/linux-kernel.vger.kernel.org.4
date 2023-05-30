Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166017166E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjE3PZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjE3PZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:25:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2239CBE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:25:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64fd7723836so1818811b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685460312; x=1688052312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65YOy14KMjF5ua6wfSM9SgJP7pUpC09nseL8YabAbGE=;
        b=bUIqXb3Z6M2ZIfHony+JhWR0leab4kufYLvG4tsfYd6A/MdB1pXPaiBeeP8o9bUTvb
         pUQkYgK0CFqSNK1paP9VTpFgxvG46E7a7qfNRJ7fIx/hAPUQhchaUCGqEgEJmtJWMB/D
         BXuW97S23yiqbslmLlg4mtC4C9k1KtZu4iHmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685460312; x=1688052312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65YOy14KMjF5ua6wfSM9SgJP7pUpC09nseL8YabAbGE=;
        b=a3gdIOfgstaBfsm8Bo2tPFfiXNZU3a4Ad4PaQ0kzivc7LDX2oGV7sXsjR/Pl0MxiYj
         XdG8NbBEA4jprf5IIKIs45g1ZFygch7nCuDwf/op2nuZdIpyrndynmk2m7WJsmnfG8iM
         GtJVriHTeevVPKSY/AI3oP4/6DE/ZEsmrAB1N3GtQAL04qlS6KHM8eRvlmCh21Glrnuw
         mw2oBJQTr1xPaeWcbD1+NKdFkRV9S7xsRESix7goDMqjID4T8bI9ykXgexYzIj7KO4sf
         3n7I6XiSVDWuNc5Y4SBE34XFVqvNqR6nMwcvGmUW711SufjoKkvRdAbFXLQtRh5+A6qc
         1dVg==
X-Gm-Message-State: AC+VfDzPG9Iqq70JLrrz9B2vUzTWO1vPBBaVa5ekx23IzkcoUVY/154E
        xyGWYFPZUORIGjbNrnmTmJ6dBw==
X-Google-Smtp-Source: ACHHUZ7H4UAKXt+/KKSohvZbKFyJ73bR2I/IFmH9FxmHt9seSR1k0sRz31SKI5rIqFcM31JnCVqY3Q==
X-Received: by 2002:a05:6a20:9c8f:b0:110:9210:f6af with SMTP id mj15-20020a056a209c8f00b001109210f6afmr2699102pzb.27.1685460312650;
        Tue, 30 May 2023 08:25:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a3-20020a634d03000000b0053f3797fc4asm8308349pgb.0.2023.05.30.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:25:11 -0700 (PDT)
Date:   Tue, 30 May 2023 08:25:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib/ucs2_string: Add UCS-2 strlcpy function
Message-ID: <202305300820.9B2154B@keescook>
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-2-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528230351.168210-2-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 01:03:48AM +0200, Maximilian Luz wrote:
> Add a ucs2_strlcpy() function for UCS-2 strings. The behavior is
> equivalent to the standard strlcpy() function, just for 16-bit character
> UCS-2 strings.

Eek, no. strlcpy() is dangerous in multiple ways[1]. Please implement
strscpy() (i.e. use strnlen(), negative error on truncation, etc).
Additionally, it'd be nice of the ucs2 helpers here also implemented the
rest of the CONFIG_FORTIFY_SOURCE mitigations (i.e. checking for source
and destination buffer size overflows at compile-time and run-time with
__builtin_object_size() and __builtin_dynamoc_object_size() respectively).

-Kees

[1] https://docs.kernel.org/process/deprecated.html#strlcpy

-- 
Kees Cook
