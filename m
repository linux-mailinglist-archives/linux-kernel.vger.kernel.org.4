Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E226C8EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCYNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:51:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A3BF749;
        Sat, 25 Mar 2023 06:51:12 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-53d277c1834so85774767b3.10;
        Sat, 25 Mar 2023 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679752272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeMx+51y0jX6AmFg23qU+UO5+vL72ohSvQttXU02rrk=;
        b=GviucWSxUP3oWPKJhEiiMYP8IaOK8nlm2qtLoDolhL3OpW4AIzP/4dxZGsIuEmHHVx
         z2FXK3fKxYbnqdQWxH/p2xRx1Q+dSLwlb1fSn95EYARanmUaKLSZaHEuZE90fYhY7Vjy
         HmNwpxuy/8ghlc+dnGJMgclY8/8mPmxeEGv3xgVJaKUqef/ymuhW5aK0cb4p8yRd5U6S
         G605C9mz7ccAn3cmBZJIUvEfQm861kA2DKJyjhhV20FV78HJnji1G63Vcaa6mcVa/BMW
         8fHweFa1zftL4UhXoV+zMvEt0vs1qro64W7ATePHkrIW24wNVozZaxysgzjLlaCk3kFJ
         9tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679752272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeMx+51y0jX6AmFg23qU+UO5+vL72ohSvQttXU02rrk=;
        b=2x/GxffwCuEyZhnLY/eE0aCeHi+O2rxTatnHAmtfJ4Z1eGhLsffx0zXE9uUki516V9
         Kgg84GIJhgqtHaC+jJRlEJwLN2DF+dzqPvHo7sYthtbijGTO57aOGtDn9Kp3PrRo4/5S
         Mqnr3mhusQWu4zX+R8HPxHcx/iG7xTeqogTigdaXOzBIAo/QG6YX5nFTz65Q6EjGkxGr
         AQVqGqlIvcuoZ57MowM3Tb3bROyeJ8FWICQQKGNPVFDAvRIzOHrmhQos8Cm1VU8lP00Q
         B0H9vWQljMl+6z8Ved6LGg2Kfst3+EXH3UpjqyeBtlADL9YR3UaFqPHwUIYpadOME4SA
         yj8Q==
X-Gm-Message-State: AAQBX9dNVfoF37E7cmdXeFwsNJ8bCCfWD/07A5SzE+UMgXYdrsnB30iT
        hXsRDgM7yeL+0Hqc4Nf6b9Wa4lgcEmU=
X-Google-Smtp-Source: AKy350Z3DzrKwWrvSOrG8gFzdH+L4ldXznlz/pjPvEuMZ/8n3xxXhgWbBFL9MvXeZkvF/DzlD/kvAw==
X-Received: by 2002:a81:4e16:0:b0:541:a029:1591 with SMTP id c22-20020a814e16000000b00541a0291591mr6104211ywb.2.1679752272104;
        Sat, 25 Mar 2023 06:51:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be15-20020a05690c008f00b00545a0818488sm967405ywb.24.2023.03.25.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:51:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Mar 2023 06:51:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tom Rix <trix@redhat.com>
Cc:     juergh@proton.me, jdelvare@suse.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] hwmon: remove unused superio_outb function
Message-ID: <0db043dd-a94b-4f39-a5c0-a0132733c054@roeck-us.net>
References: <20230323211535.2637939-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323211535.2637939-1-trix@redhat.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:15:35PM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/hwmon/vt1211.c:198:20: error: unused function
>   'superio_outb' [-Werror,-Wunused-function]
> static inline void superio_outb(int sio_cip, int reg, int val)
>                    ^
> This function is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Acked-by: Juerg Haefliger <juergh@proton.me>

Applied.

Thanks,
Guenter
