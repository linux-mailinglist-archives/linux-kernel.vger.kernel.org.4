Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5572DFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbjFMKjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbjFMKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:39:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E90E55
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:39:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d2bfed53so2268535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686652757; x=1689244757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaDlJQeO3hH2pBiVZb8UiGCEOJUjl7lCHpBv/xucTak=;
        b=cpvNcFVPA6aGsusVPFb6hFFXQz+6VU2R47CMwhknwlsvy7rIY6Rk+tMn02L9wADk4J
         dtcDrAclhTphN3RmE89KGiy/Z0axMKS5LBRKNXku1MLQ6GEU9yGjd+kU+if4mdozIid7
         52AGaYdCsHmOUPFAhE1ldVMtIhfVu3VgCnQO0zPgDEVuiNZam0DkOX5JJILPJdtaOQQd
         j6O33lazYUT02LUBC2KJRy1LUMNEol9eEIRGr2MH6aIBMLahrL3J0XAhnLlEajROAVRs
         VB2tNLcH6Wm68U77Q1nN6s95j5W4YLQKkXWY0s1kDZ4kiRiqlMbOhAFVrzm/9SIUz7l3
         JZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652757; x=1689244757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaDlJQeO3hH2pBiVZb8UiGCEOJUjl7lCHpBv/xucTak=;
        b=X9w3AJg5+41Rv7/slnlQ/JGadEysK9p3ZcfL9Kc7js6yzH/7zpEbck/bII9coFpXC2
         sYDSHfrGKMWKuwXkwLM3piUiGqJemcG78XlHsKn9rcZVSvq4vjfZoy0ZjgvnTV/jPyJM
         tI9d+rarJruBu+xU8puYzz0o6ZvQj1kE2KLzjnNXqLFWJcQhEpdOiEDYEhOYVZWm34m/
         O5RSJ+2DdSSb4Ix59Kob0Cx1W1B20y1piDfDiidm3Hqx80Q6R/3ogdrjibQmMUg+nNwT
         5F0e5l0bFB2Du4YmaLFDy5Vm37guuwiZfWmckSSrSWUqBXZ7Oh2WbV6hAtbEzywoAwLV
         XrwQ==
X-Gm-Message-State: AC+VfDzpp2MPoG1/1A4T1dMtC/KwY940tCq0um83LTdJaeXM7kJ6q2ae
        KoiiYtTmTAAT5gXdP5DsqHVKzQ==
X-Google-Smtp-Source: ACHHUZ5HyOHzcbog/cShZpBLWaDR0+w362TXtcaS+8aBiQA9iPPqkCG+m8GPuzzU6GS2TikA9g34VA==
X-Received: by 2002:a05:600c:518d:b0:3f8:643:182d with SMTP id fa13-20020a05600c518d00b003f80643182dmr9843519wmb.16.1686652757444;
        Tue, 13 Jun 2023 03:39:17 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b00307bc4e39e5sm14976537wrs.117.2023.06.13.03.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:39:17 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:39:15 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        jingoohan1@gmail.com, dan.carpenter@linaro.org,
        michael.j.ruhl@intel.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v2 04/38] backlight/gpio_backlight: Rename field 'fbdev'
 to 'dev'
Message-ID: <20230613103915.GD169438@aspen.lan>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-5-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:07:42PM +0200, Thomas Zimmermann wrote:
> Rename the field 'fbdev' in struct gpio_backlight_platform_data and
> struct gpio_backlight to 'dev', as they store pointers to the Linux
> platform device; not the fbdev device. Makes the code easier to
> understand.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-sh@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
