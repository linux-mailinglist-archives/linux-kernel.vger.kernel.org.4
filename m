Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8973C4D1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjFWXdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFWXds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:33:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800AC2699
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:33:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso995833a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687563227; x=1690155227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BXr6eTNbrAAPMLfItUNBU1GV8gA8JI1s3w/GXSgtiQ=;
        b=T4eNDvej4BSP1rQm+6xqQqAO5mSaxmUuOD4yVwd/MW16mp1HkVi7Gmt8TqmlwIPBsJ
         yWUZHfhdLKjlPSoVnhyEAptnwbesES/JLcrRcxguBJzZNKQ7kUnz9gQDo7szvdxlsGwg
         TX5y4PyA9zFvXsB2PFcRGADDVkbC3NKC14NSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687563227; x=1690155227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BXr6eTNbrAAPMLfItUNBU1GV8gA8JI1s3w/GXSgtiQ=;
        b=isIivzLhxyFWOgBqS6GACenTfsO3kbUXBBO1HbG2SxFYGehhkTIgtP6nN3dzJt9zNG
         hz/qC5b4B3G+fsMovRAyMVAA4aJ6jbfOwrJwJylrsM9Mt5j4kUR9EfHWfKebjc7m0Yr8
         AtnMtGLR9MGlnl2bvWwLWpoJfqQtArwN2gaay9RqtWiFLfxs8NsHnEZeycUnqfisCBY3
         Ab3gvQNpYEb9/9CyTke7ViMA1/E/X5o1oBOcIQzevlwmhXCE2bpMBmUR4lpRXmlxcJcW
         hXi9dXkw2pSl3JF4Z/GHaHq0e9zJw8Ugk+TQMgO/8+VpvyzHhAzG+KGEEoseFxc1dSNZ
         AOaQ==
X-Gm-Message-State: AC+VfDw+3u0BOr5EDAxP7Z+XOpaKWU7xOK5zBUCDWSJDxFRpF8TrdQdv
        p7e5yLhmYLzuxX77zQX7ldZtWXL5aVJa5VeCkVc=
X-Google-Smtp-Source: ACHHUZ69mWqFU5agnEl+Q83+Js77SJdoh72Y42y83F4lW+t475KKF3wSlBzxef4eC2MLbMqu1PNchw==
X-Received: by 2002:a17:902:f68d:b0:1b6:ba60:780e with SMTP id l13-20020a170902f68d00b001b6ba60780emr703673plg.24.1687563227001;
        Fri, 23 Jun 2023 16:33:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170902fb8d00b001b061dcdb6bsm112977plb.28.2023.06.23.16.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 16:33:46 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:33:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Shiji Yang <yangshiji66@outlook.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] carl9170: re-fix fortified-memset warning
Message-ID: <202306231607.8632EBE15@keescook>
References: <20230623152443.2296825-1-arnd@kernel.org>
 <7c4622e7-d7a8-ae5d-e381-f726cb511228@gmail.com>
 <24986b5e-5cd1-4cd5-aff3-b5eab2c0fdde@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24986b5e-5cd1-4cd5-aff3-b5eab2c0fdde@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 06:05:57PM +0200, Arnd Bergmann wrote:
> Doing the randconfig builds with the latest compilers, carl9170 is the
> only one I see with fortified-string warnings, and there are a few
> dozen other drivers that I see with W=1, including one that affects
> all wireless drivers.

Can you post the config that triggers this? I can't reproduce this
warning...

-Kees

-- 
Kees Cook
