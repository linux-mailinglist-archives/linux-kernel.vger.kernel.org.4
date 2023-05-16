Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6EE7058DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEPUal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjEPUak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:30:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684F1BC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:30:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64cb307d91aso2322309b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684269036; x=1686861036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MG5sNhySl8tMIZRuG6tzpiKwBNEeqYpY6uXsZV7s5Ko=;
        b=oHPBGauVbDdpZJCPw8Rn25qxbk81vNDgF8Hl8sarnVQ1QX1vQP0sI22DzHLExQbUAO
         xAw/Z2/q08Jxo1JiZD/LPYVf+zSTypobhpzdUFtBCah1xlaST++O7z4XEPTtwwV8Z/mu
         /7vR/AGMLlFzkaSZ49NlMnTvmh5t8EfZaAIkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269036; x=1686861036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG5sNhySl8tMIZRuG6tzpiKwBNEeqYpY6uXsZV7s5Ko=;
        b=jgQBiCA2a9jcQ0GUkvnyxSSrE09HCy5iDqIjJ/A2U4FyVRFfBQT2Q/d6pS+4D17kDM
         v9zlycx1uXNt2Phd05ffcfv622w6Yr6226eOSRH0MhDpGjyuNMWv+qt2XPmhSWDLkxRo
         XqaciLRxa1cAeHuXXxDG+JrZIFNLhkK6dUaH0RK33/EqNg7IMMGkE6EDK8z4dIe4cthy
         GtJbu+pFAC3pm9SZCSCS8YZ6WcklPMyJCq4E7MF0BXBUZe4HNq9pr5QZ9Ptbh3zz8EWR
         4OJXHGOHZFJd6tJl1MeP5FE9hVwd/sjbXuT1wEL1kEqKwSd9U6ezGHgRxmvH4uI7RoN+
         9IHA==
X-Gm-Message-State: AC+VfDwyDpP6a9QrtI40+CkhtIesN+pjiF7THF6URwgRX0unCvOQbhoC
        duhhRrisV/a5FK/pFs8FA7Qo0A==
X-Google-Smtp-Source: ACHHUZ59fiwhvXINPUsxwcheEb4K5iUFwWrpffqbK6fCiC8Ox+J+wprvCU15z30wWH2aesHjpd30tw==
X-Received: by 2002:a05:6a00:b55:b0:648:c1be:496 with SMTP id p21-20020a056a000b5500b00648c1be0496mr33025534pfo.22.1684269036345;
        Tue, 16 May 2023 13:30:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78005000000b0064ca36ebb50sm4349521pfi.93.2023.05.16.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:30:35 -0700 (PDT)
Date:   Tue, 16 May 2023 13:30:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Carlos Chinea <carlos.chinea@nokia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jianglei Nie <niejianglei2021@163.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Wang Qing <wangqing@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yuan Can <yuancan@huawei.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hsi: fix ssi_waketest() declaration
Message-ID: <202305161330.FE7311B@keescook>
References: <20230516202226.559733-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516202226.559733-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:22:07PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ssi_waketest() function definition causes a 'make W=1' warning
> because the declaration is hidden away in ssi_protocol.c:
> 
> drivers/hsi/controllers/omap_ssi_core.c:147:6: error: no previous prototype for 'ssi_waketest'
> 
> Move it into a header file instead.
> 
> Fixes: dc7bf5d71868 ("HSI: Introduce driver for SSI Protocol")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
