Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE374866A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjGEOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGEOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:33:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7B71703
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:33:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so80951185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688567603; x=1691159603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQUXAkyiQApMq+ZE6mPnwyJ3KTToGXwRWpzxeS6gtoU=;
        b=TP49Ly4bRH4lLTT35h8wVfAwVxrJgc8Hm8iAUo+nhTxeYBA+AKk1HSKDGzn94tP3jJ
         /UIxJ4/uo8yuFDr/vJUsJmog42GwssD1cqtABp7hqCH8wmX3QJ92ttJqCTg2dGDN2OGm
         rDcsmLUR7aL3zpWnpNRYgW7Pe6E6+onYViN1i5ZyhJq+in7lkAX5KFaZr8Oiq/8tPWzz
         o0gw3qO+o6bNrEqL6giVppiT7lA/FpOF5OYwCN2/Ze7DwE+48Pb/gJXVuNiID9PkG3LS
         4RinTWPpx4VsGESZDsQ1rXLnLtquh+aKBRLdw9D+xY1KGPufXXcKZwLrW5hr6u3akx8S
         UgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688567603; x=1691159603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQUXAkyiQApMq+ZE6mPnwyJ3KTToGXwRWpzxeS6gtoU=;
        b=ekLL6T81Cxe1GJm0f1gJSimDpvGNnduj4biah2Z747/fwrPpNzlDJ6J2nlwV2tMTzU
         3uDjcwt2aVwrutqtKUeFdgKNaCPaL2ffKPppQh76UaX6xJHo/bt3ImzMUijmUbPeG8tb
         ylk2NqcmA2RvwuZHt/WTZuzyxi6xmRrNyEZFaGqZnz7TXxfzvbowecL5BjQrNCVMA8+M
         S4Oc8SK1rJW5xI+yC/j0Tnh4KpIO3bN+YdHbINSh9ra83Tru0tXTqN6tPNEv7lwaTCkf
         LEbe944Cy+Qjk+H0AR+peK4GPDXhfMuWzvvtTXsaoca9K2tYDMNXMBzeoiIKLD/Qvkpz
         4vPA==
X-Gm-Message-State: ABy/qLbEz004NV7kYHe3CnuiAbZYXzI+KMqBDAY4SEW6iqxPewD4DCRg
        KpIIaLt81kKA5nAhcWqXndGuUNP99kPZdcqjFblMAw==
X-Google-Smtp-Source: APBJJlEcP9KsqrX0torxAaick855DXdlm/LSXir4ylL4od030uqLUgvwXNO/rx9wm36ZF/1GfIK8cQ==
X-Received: by 2002:a1c:f713:0:b0:3fb:d72b:b2a0 with SMTP id v19-20020a1cf713000000b003fbd72bb2a0mr9242635wmh.6.1688567602750;
        Wed, 05 Jul 2023 07:33:22 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003fbda7d2d41sm2280190wmj.48.2023.07.05.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:33:22 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:33:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
Message-ID: <20230705143320.GE6265@aspen.lan>
References: <20230705142447.15546-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705142447.15546-1-mans@mansr.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:24:14PM +0100, Mans Rullgard wrote:
> The condition for the initial power state based on the default
> brightness value is reversed.  Fix it.
>
> Furthermore, use the actual state of the LEDs rather than the default
> brightness specified in the devicetree as the latter should not cause
> the backlight to be automatically turned on.
>
> If the backlight device is not linked to any display, set the initial
> power to on unconditionally.
>
> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changes in v3:
> - Add comment

This mismatches the subject line ;-) but I can live with that if Lee
and Jingoo can!

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
