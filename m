Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF6669DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjAMQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAMQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:25:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F077D1E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:19:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so17734222wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhz9fWOoERNBAN38ex2htt2h7c3lJT7eoS2NI1GaWwA=;
        b=CbuR3CX0p4skKGw4xsujWI8bAF7IwZzXvafQLAFYWfdT0cxwQOuyzMYog3nQApK4yI
         mCW7BeHY/pvbQTUb59i30dWLoZhyWomHHyOS+sGJxH8Y/dR2vu5seIdkLfGG+7YsA9Fb
         qpQWX+O6m5BmLLqlpzcxO9JUiBRoRmS4yzxX3efqbhb3HvpWz5lhknuFi+wKcE0psmb1
         lj0uMe9tPyg41MpQ13/XWD74HsAN+WUzcJz53QwLEpIaoCIY11CH3xkk++CgkGN/fZzh
         4bo/t6CCMyiBaClf424D7IxEmdHPI7DinlsDlmKY/ne9mgijFk51gpnJU8oLiap7TS7G
         MQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhz9fWOoERNBAN38ex2htt2h7c3lJT7eoS2NI1GaWwA=;
        b=jMEbRj9wz+d12Pn8bK1iYquIAK0MDpa3BSH5m5K6QlD7GHyb/s0h1yMo2U5V51ovSv
         PndBCHZQ1U45kTjqnRs0vz1j39yoLztJJk51zG6lbWR8HodY+P98guUcmP5loMgULsLe
         UwZo4TJ3Gr+QgN+c5GmPHp4oAPXTZIiH+PJHzUNu9/to5Bnp9vyTGMhbqCol2U9KSWY7
         1m8xBnhX4/OPy2sGP973i1px83pCCG+nQlk9JdZN/UbDmimeBfIMQPP//pBYBtw5hDrf
         p+Cur883mNcW6QMIIy4T73Qu8AFARX4l2MAnQqXtoG9Z+LYY8wX0ZFnmZB6iWdy2JwTV
         U+rg==
X-Gm-Message-State: AFqh2kpXiIKlmMu7PVeF0brOyy3D6uNbve+vnc26TpMIclECKA6Fsdkx
        Zn/k0HSdfECl1QGIslmeH176mw==
X-Google-Smtp-Source: AMrXdXtIgncPdiydx2VlDE0pGuWdm7d/in7Wu/0hk+2SCGaU6GE63Rke3KKAMtwlBX6B8wIfaEEE0g==
X-Received: by 2002:a05:600c:3844:b0:3d2:191d:2420 with SMTP id s4-20020a05600c384400b003d2191d2420mr59847990wmr.7.1673626754635;
        Fri, 13 Jan 2023 08:19:14 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003b492753826sm23729637wme.43.2023.01.13.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:19:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:19:12 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: ili922x: fix kernel-doc warnings
Message-ID: <Y8GEgFlw+q0P+2em@aspen.lan>
References: <20230113064108.29172-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113064108.29172-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:41:08PM -0800, Randy Dunlap wrote:
> Convert comments for START_BYTE() and CHECK_FREQ_REG() macros into
> kernel-doc notation to avoid these kernel-doc warnings:
>
> drivers/video/backlight/ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * START_BYTE(id, rs, rw)
> drivers/video/backlight/ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
