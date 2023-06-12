Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71B72C925
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbjFLPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbjFLPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:00:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7010B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:00:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso31453545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686582055; x=1689174055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/UCUFMga2EMcERlpB49Y2fRq+ymUyOKrUgYsHf0ed/0=;
        b=L7nqJsGZJ4kjY557qHqALuPae3RMHgvnYVpXo9/i2LZxf+CHtnV8BP7RS0uaMpPTwT
         X+6kER9YLs5NxP7uKsF8cHFD32Ls6Scn2FTrCk9nnG09Yp6PZMYOkG1tQkgHjBix6xY7
         xuhU29+n8M9LCoUamZ9pqUzT8dDv7DywYHg8fIZMxw8t7F+5VYUwNYFTYo9GfgqeretD
         EmsVU0NZjuohlcKKvHC1OpmyXxOWixpyOSKcW7xV3NEfYWS56ZHkZZAui0yWoIrkt/Qe
         cHuDOT6CHhLJpMAmKvexEECF0ia6zcRfZkBvR9gopfAI64jbHon5ing/2AKGWvSwP9r3
         IlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582055; x=1689174055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UCUFMga2EMcERlpB49Y2fRq+ymUyOKrUgYsHf0ed/0=;
        b=dO6KDSsV2bTXTdC0ctUIhO1dzcEYPOs1NLBejUC+7coXCdpA3L23M02v/DIk/Wj6ke
         p7FqrinBebl+yGLZMS8j1ngHOO3PbRjVVgcn4mvI3Shfm5ErhAZ03F0vLX5F2LPZxh6W
         WvQa5ukLdRW6Cbz5EOXAlx5rwb+l3AQwp1WeRRB1lM6bbyuavblF/H0JVg9rv5IJTntV
         3j5exPvgw/v59YNoxOhMC8YVeF5cKFaWwRMfeu1qDNfGqOK7LctrdaVAPnReNUd3wzQp
         UtWhnvytXdm2VPIs2KVPt5FneOatoaZ1C1FSiUttRe6ztRcNaJF0qh/3QTTBT9OGRL8t
         8/OQ==
X-Gm-Message-State: AC+VfDwmma0dBoAftacL0Xu9CQf9kie6kYcC9ANNQRJGbZLsp6pNhVDF
        11502xq+r/0S8WETeEhfKEfqPQ==
X-Google-Smtp-Source: ACHHUZ5u3c8rRm+E7KnayrCIdvayKld94mEi/X7AbulId0IMRsAxTcEdEsJfHEZekp046ksej9BC6w==
X-Received: by 2002:a05:600c:21c4:b0:3f7:e48b:9752 with SMTP id x4-20020a05600c21c400b003f7e48b9752mr5759053wmj.32.1686582054775;
        Mon, 12 Jun 2023 08:00:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f8140763c7sm6545492wml.30.2023.06.12.08.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:00:53 -0700 (PDT)
Date:   Mon, 12 Jun 2023 18:00:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        michael.j.ruhl@intel.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 01/38] backlight/bd6107: Compare against struct
 fb_info.device
Message-ID: <573e1bac-57a6-466c-ab69-28366a300143@kadam.mountain>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-2-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:07:39PM +0200, Thomas Zimmermann wrote:
> Struct bd6107_platform_data refers to a platform device within
> the Linux device hierarchy. The test in bd6107_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
> 
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
> 
> v2:
> 	* move renames into separate patch (Javier, Sam, Michael)
> 

Thanks.  This helps a lot.  I stared at this for a long time without
seeing the fix.  Then I misunderstood Sam's review comments (my fault,
they were clear in retrospect) so I got completely lost.

regards,
dan carpenter

