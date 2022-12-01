Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04863EE80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLAK5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLAK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:57:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B017EBA;
        Thu,  1 Dec 2022 02:57:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cm20so1520077pjb.1;
        Thu, 01 Dec 2022 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIb/xnkOcLzDBfMMI5+irwhwqvuv+eQoxX8/tJ9k828=;
        b=XE9ifM+hN7D9HhGTdSCTJI0MtCQcFLmn5B+Nw0cm63sIIAqtxvv+i8S/tL4fsjBvSP
         uW1xeH/ZgRSOv//Zedj7cFjbPicvwsjrvXprC7SyihIYgdrHukmBGUUY9tgOCiwk8fnB
         PPqP1oIdSsuSsIC4W9jIGW5C/gFg5pLbnmhgvPIuDm7pLN499CyXE3nB0+Y1TwrspWUz
         XudceUPSVA1NCjAJQOXUi9qnvVGFQkDKwmUfnlvm9iGuHgUCaAN0IKI8tJ6UlbwZrIpQ
         MvhGqBWjETeXkkzDHk3of9MZMDVAiT0g4NTtJtZ6BmM+ss3/2/TxCjaW0vwYDGdDUpbH
         IPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIb/xnkOcLzDBfMMI5+irwhwqvuv+eQoxX8/tJ9k828=;
        b=w4kZ0wZ2BtOYU9za8B+ZY5NbC43udH6zouwF7uy2em7nU8UAgbK78wAzV6F2oXBfdJ
         Tsx2WlH9hA8H0I942U6gyA0Aci9XdEyn4nZsQH8fp/oxSekvz541jpDpq0dLeCRI4vT6
         oyqYeaKYGrgt0V1t07V/jVow7/Yk7n24rBcerWHNYwtbBEcm5SrdMc277pDsGEUc1bbx
         Wk1ovrV3z1u+v2k+p9y4wfpQew9c+ndnX/rTRxAbMM/baMQUa8Zm6SuzzivVykV6xIYg
         Gy5oLkeCGzBXgn9vUw94y+c9GLCiz8D76oSUE2L2b5Pfx+K0lLEjmtX9JZioQUUAffAO
         lGCw==
X-Gm-Message-State: ANoB5pltzzIzDIetKc4GWvSKS9ULnHxEHoc0JbSinjF9RNbUTAFQh1A4
        3IyhG2p9w78tXSAh3+yIkbE=
X-Google-Smtp-Source: AA0mqf4nDgABhbxxE7inb5KsHTbmx7qwoNB/ixZBuivXYQXGgyS1ftEiAihNtfuGAVmetfl9r6bRVQ==
X-Received: by 2002:a17:903:286:b0:189:39e4:c50b with SMTP id j6-20020a170903028600b0018939e4c50bmr45368594plr.101.1669892248809;
        Thu, 01 Dec 2022 02:57:28 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903244b00b0017f592a7eccsm3280626pls.298.2022.12.01.02.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:57:28 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:57:22 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4iIkgvnsBMxsE89@sol>
References: <20221201083335.819190-1-brgl@bgdev.pl>
 <20221201083335.819190-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201083335.819190-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 09:33:34AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are several places where we can crash the kernel by requesting
> lines, unbinding the GPIO device, then calling any of the system calls
> relevant to the GPIO character device's annonymous file descriptors:
> ioctl(), read(), poll().
> 
> While I observed it with the GPIO simulator, it will also happen for any
> of the GPIO devices that can be hot-unplugged - for instance any HID GPIO
> expander (e.g. CP2112).
> 
> This affects both v1 and v2 uAPI.
> 
> This fixes it partially by checking if gdev->chip is not NULL but it
> doesn't entirely remedy the situation as we still have a race condition
> in which another thread can remove the device after the check.
> 
> Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As per v4, I'm fine with whole series, so

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
