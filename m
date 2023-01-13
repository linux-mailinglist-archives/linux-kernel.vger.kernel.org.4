Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677A669DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjAMQ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjAMQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:26:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A21B1AA23
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:20:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so17737342wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=06yrgHLtubzlVTv8ZMuuqpVVcPSwyPWQD3kou2AtPjE=;
        b=zrFZvqQmSdfN3TP96rg+qCC38kwG2a2tGbIWZCtwPBWu8b5rqlJQvUvwbz0absrUWq
         f2+HygAJ12mlVvFSqx5TBpNtotqYmdNXLnWPsyUwqDE4juqk6dOAqUAhRGf5GL0e94KH
         uzEZ3POXerO0a+xZDIfgQWArn/AsWjsYAtu1sIIUgH6/kNROx4bjNPrfb7N+hpQoyKlD
         SERj4Nc4CMz1D2EZoS9m/34CnijnEtcMHAuuqvQJSu3FKT7sfu7K7pWtby2Jr1l+P2Aa
         zq1w9VM80VOnZ2aN+htvT+5myf2YfzmqW1g4jKu7mfbIMZlsNXgN9wv2uplydNx6tZ8S
         jbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06yrgHLtubzlVTv8ZMuuqpVVcPSwyPWQD3kou2AtPjE=;
        b=QURwey9q/ZQBGuunkbZCqB4f+X5zmJ30U/OddMIQRZHh9MVIEa8zH24ujwjEj3qHdw
         q0skNpp3D9vvCLCaw6lHvRKC0qa16aWZhano2BDaoDZfMTcktROhBo2exc2xXmSN8x7F
         u0RMMniBOEPJ8tbUaHvmVI5fAo+0b5hn59tw++/QxLTl1RC/azaTryjnb15R9OmXxXCm
         HDgJKlQfI2Zzu9bXnzdN0KRbmqXgO3SeoH1KJId+rOb8epJZG+QUQNsXTVmCNrVy7+Ci
         cqQUg1qjwdpdNU3Lf4uZd4SIIt2w5S5V42iq5ANE0mAyvr1BgqrZyY06SYQiVfhD4WkO
         85yA==
X-Gm-Message-State: AFqh2kqDpptmG+CfT4ugd/uAex7Ingen5/j8FEcjv1hTxqOnnlgYKoti
        6NROz5sj7yuYj/Q/bPRATxYqVQ==
X-Google-Smtp-Source: AMrXdXv/fkkqVwAy0FAec0vYcCM6E9mSl/Oq7DvCSvQ2RbgiZMu2Av6NkgVtbj85zzZkDZtaY/excg==
X-Received: by 2002:a05:600c:1d10:b0:3d9:ef75:ea6e with SMTP id l16-20020a05600c1d1000b003d9ef75ea6emr188418wms.38.1673626836588;
        Fri, 13 Jan 2023 08:20:36 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm32412208wmn.28.2023.01.13.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:20:36 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:20:34 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: sky81452: fix sky81452_bl_platform_data
 kernel-doc
Message-ID: <Y8GE0kEJdQpM9M4L@aspen.lan>
References: <20230113064118.30169-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113064118.30169-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:41:18PM -0800, Randy Dunlap wrote:
> Correct the struct name and add a short struct description to fix the
> kernel-doc notation.
>
> Prevents this kernel-doc warning:
> drivers/video/backlight/sky81452-backlight.c:64: warning: expecting prototype for struct sky81452_platform_data. Prototype was for struct sky81452_bl_platform_data instead
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
