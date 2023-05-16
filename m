Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24836705815
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjEPT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjEPT4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:56:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62317ABD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:56:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64ab2a37812so8189335b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684266999; x=1686858999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlgAAtiyihh7bx5P71pi2o6dPtZSer+A46AGpW/5WPM=;
        b=kef7EitnyZ6qVVLdsWjYeAdWG/vB35cqybAGBIj/wVTjUV6BlKvSCGjnNbHNOsCEOL
         h+BT20FpTWmXn29KSAWGRqAhQG7dYi4HpAICRT9xWClylv6xSJEyF5aX71CJi1iWwCBV
         AskpSJ9ywL4mhKKAIE30RromysT+Wz3FHQz7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266999; x=1686858999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlgAAtiyihh7bx5P71pi2o6dPtZSer+A46AGpW/5WPM=;
        b=U5qAJDHPwnHTSUykNs3dFMzvc3NWaHnjq+XFydEdbkXxARs4+tjKrI2KocHW35vvOK
         tKS6iYh8jmO6Rc5aY5gc6l5PiMRWBpgMFYducI/7jD4mXxOhZyzrSZpaxt+tda/3SgT7
         kbSezfz9hJtXqa2rZ3WinihbDVEX5BDirUAiGg9+thrpCfE2N0Op6N9PkAOVNtpvIUHs
         AbarGPbO6l995UGMXyVexwuzD1PE7ve7QcCFjbXyra16WjzwVOOG1mkGOSG+sME7ESOT
         5K5G/80F5SMLUnLOj3yLwEYDYFQ5OMXjL4i9NfbkUMaZUgzBPslSj09nhnzHtYxYQtOJ
         7YRw==
X-Gm-Message-State: AC+VfDyP/pvnIw5YT/0ijhPW9YYacLYFABaeA9tEN0ILYdLzikxyIWJh
        srSGPL4beVlopA6r7JFnIcCoHA==
X-Google-Smtp-Source: ACHHUZ504MnZSV1lW6m3lpadzxSZtXTyWWnmbMDexEhPigrkHEzEuE9njCOaI6ApJ1b+OCtl1rWdcQ==
X-Received: by 2002:a05:6a00:e8f:b0:643:a6d1:b27 with SMTP id bo15-20020a056a000e8f00b00643a6d10b27mr34066068pfb.15.1684266999152;
        Tue, 16 May 2023 12:56:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m3-20020aa79003000000b006466f0af9b2sm14238048pfo.179.2023.05.16.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:56:38 -0700 (PDT)
Date:   Tue, 16 May 2023 12:56:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/16] ARM: address -Wmissing-prototype warnings
Message-ID: <202305161256.F6C079EAA@keescook>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 05:45:49PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This addresses all arm specific warnings outside of the mach-*/ code,
> which I've submitted separately. The majority of the patches should be
> straightforward, either adding an #include statement to get the right
> header, or ensuring that an unused global function is left out of the
> build when the prototype is hidden.
> 
> The ones that are a bit awkward are those that just add a prototype to
> shut up the warning, but the prototypes are never used for calling the
> function because the only caller is in assembler code. I tried to come
> up with other ways to shut up the compiler, and ideally this would be
> triggered by the 'asmlinkage' keyword as Ard suggested in the past, but
> I could not come up with a way to do this.
> 
> All of the warnings have to be addressed in some form before the
> warning can be enabled by default.

Thanks! These are all long overdue. For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
