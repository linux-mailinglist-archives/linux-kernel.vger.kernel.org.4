Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364260C5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiJYH5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiJYH5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:57:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76469167F50
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:57:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so15369561pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwWEryY1wTrlvMcLkLLHD8M1BowwJLAAx+hHBiqXYc0=;
        b=iCEU9cjqduqY3uZL55o+hXygR5rDV47JCm8gGv2BnxBSXYEOYXSHPXk5mkm/xydmxW
         iHO7mD+cJSLVOhxg8VJ4Z9pARipA6mUuxL90PRlP3Jb9A519LwwZmwxR0YBd2duXkQJe
         tBcb7OBtPdI5QX+tPPXaFR/OcYEBjI5AAGpNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwWEryY1wTrlvMcLkLLHD8M1BowwJLAAx+hHBiqXYc0=;
        b=a0otKwM3Gwl4xSZ8zqh9yWymg4q+4f1dVuvOsrsmBgiiM2Sr4pddKASEWWlZWU7D3z
         1MImjonSMgniREZM6re4xeGLXzTSxOzgJXwu/Xv7oJsMJ5mtxCecVTe2Tc+0OhjEjjK1
         DSlofOYy+ZRgRoftZ97FYj5yf28S6DfysxSqdpsZUCHRxLrDFORtpAy8/bqPD+fhR8T2
         VDDr0/d4m3246mRCigqFP0lplZXL9INuKmJipilEYI6Q0ynEIZfZppkYnJpKdsl7ZQ0P
         DzHYdlPkkX7+42VxsD3tYUAtw69bnKQpexoMkt8e8LwNSsck0Mi7L7S/b0e1xm/xKUwN
         CTLw==
X-Gm-Message-State: ACrzQf0aH3sUW6YkYhYv3kpeRXJnuMVwxfMxOXrLrTqnnvJ3a6aKWJ/X
        LrGU5Zb//z5GEZE2hIBloPmZYw==
X-Google-Smtp-Source: AMsMyM4kDeHwWEXeBQtaVqz9E4vv4Oh0PYTSXaqkZcrqSkb5U2sUbEwcKsayOD07si6cPwrTTuj54Q==
X-Received: by 2002:a17:90b:1a81:b0:213:1534:fbda with SMTP id ng1-20020a17090b1a8100b002131534fbdamr9843117pjb.133.1666684631982;
        Tue, 25 Oct 2022 00:57:11 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709026b4300b001868981a18esm786327plt.6.2022.10.25.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:57:11 -0700 (PDT)
Date:   Tue, 25 Oct 2022 16:57:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/6] zsmalloc/zram: configurable zspage size
Message-ID: <Y1eW09v7fgy8nu2R@google.com>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
 <Y1dmdycqFTztP8VE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1dmdycqFTztP8VE@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 13:30), Sergey Senozhatsky wrote:
> On (22/10/25 01:12), Sergey Senozhatsky wrote:
> > Sergey Senozhatsky (6):
> >   zsmalloc: turn zspage order into runtime variable
> >   zsmalloc/zram: pass zspage order to zs_create_pool()
> >   zram: add pool_page_order device attribute
> >   Documentation: document zram pool_page_order attribute
> >   zsmalloc: break out of loop when found perfect zspage order
> >   zsmalloc: make sure we select best zspage size
> 
> Andrew, I want to replace the last 2 patches in the series: I think
> we can drop `usedpc` calculations and instead optimize only for `waste`
> value. Would you prefer me to resend the entire instead?

Andrew, let's do it another way - let's drop the last patch from the
series. But only the last one. The past was a last minute addition to
the series and I have not fully studied it's impact yet. From a
preliminary research I can say that it improves zsmalloc memory usage
only for order 4 zspages and has no statistically significant impact
on order 2 nor order 3 zspages.

Synthetic test, base get_pages_per_zspage() vs 'waste' optimized
get_pages_per_zspage() for order 4 zspages:

x zram-order-4-memused-base
+ zram-order-4-memused-patched
+----------------------------------------------------------------------------+
|+               +        +  +                               x xx           x|
|     |___________A_______M____|                           |____M_A______|   |
+----------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   4 6.3960678e+08 6.3974605e+08 6.3962726e+08 6.3965082e+08     64101.637
+   4 6.3902925e+08 6.3929958e+08 6.3926682e+08 6.3919514e+08     120652.52
Difference at 95.0% confidence
	-455680 +/- 167159
	-0.0712389% +/- 0.0261329%
	(Student's t, pooled s = 96607.6)


If I will have enough confidence in that patch I will submit it
separately, with a proper commit message and clear justification.
