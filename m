Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C325F2049
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJAWOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 18:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJAWON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 18:14:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A65BC21;
        Sat,  1 Oct 2022 15:14:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id b5so6884145pgb.6;
        Sat, 01 Oct 2022 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qAiOnwHR8DxVKCfEBvHJAc0mY4o0LnTr9T51yYAditQ=;
        b=IyT+lPFUg6tAoUW+XBtBdT0dkO48oz1cbgTHcZ6WZVjk1Me09JIgVyY7Rt2sQ9xKuZ
         LgIcY7/XIa4Z/yqkN+TgGZLRIn4/vmf/6GB7Y3fCHVO/QMno0Tv88EEHCNwzvawBs/GD
         jGjE4CXFEYgqS9eilgEJO4F3HA9dqkRb5vNsbaVuKYn8Jl13b8VQjY8K33u4QbjSA0KL
         KLaojOtWdUbVB9x+hYiiWocL30Gm82zcPLX0ka5jnrHhYYBlmTSqe82RgHX+5FFp3Z4u
         wcg7q7YMtI83lnzwBTNJ88ssV3eR3f+u2pkdK5HrJSGnECe6v848R5bVQRktuOnLcuKL
         BTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qAiOnwHR8DxVKCfEBvHJAc0mY4o0LnTr9T51yYAditQ=;
        b=uGqRCdzw/3VOv8JynfP8cEojb2ZFZAD/d4fumWR9QEXK6NsaCCcTSizC4vsWN+KxOZ
         7DawVxaMUN/wsjARzm9M+49Mq+e6ZFNrhCsmzciih+K4SwBUVKAFupK8lS7dvD4oyRd9
         Rs7yldjeGCFHlhDt/LHO6ZUV2co+97Fl5bfFfSOoY3p9crr2L2f8yntpRXfpbAGodzxk
         S5w+4I05S+JHZB0nZBoda9ViamReV8zqfcULIYsbH2mSvLE0j+LtI7MlXTbcM1erzV+5
         9RB66KtcFi4ZQK/GiPKRjLW4HBDi8rsvBLQOUSxaW6FL0VuSQyEAPpP6dK4ytrA6Crc2
         vOBA==
X-Gm-Message-State: ACrzQf2vrCFdsFb7mZ3fNuceTdYS8npDBFrffrxH1Ueeg7cyO3+ctPV6
        wqYohCeGxgP53P2IV8lF4t0=
X-Google-Smtp-Source: AMsMyM4JHBhKCOQBTNZ7L3+7+rNTZFbX38gmTC4RE8WJg24VVadUh1+XQp5ULZ1vXnkDmW7jvIY7Bg==
X-Received: by 2002:a05:6a00:99f:b0:543:198b:f995 with SMTP id u31-20020a056a00099f00b00543198bf995mr15367834pfg.45.1664662451683;
        Sat, 01 Oct 2022 15:14:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id nn10-20020a17090b38ca00b0020669c8bd87sm3446036pjb.36.2022.10.01.15.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 15:14:11 -0700 (PDT)
Date:   Sat, 1 Oct 2022 15:14:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <Yzi7sBI+kEHrJjHz@google.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
 <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
 <YzMisM73yj/APB86@smile.fi.intel.com>
 <20221001180705.7002796a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001180705.7002796a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 06:07:05PM +0100, Jonathan Cameron wrote:
> On Tue, 27 Sep 2022 19:20:00 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, Sep 27, 2022 at 08:46:11AM -0700, Dmitry Torokhov wrote:
> > > The driver is using of_device_id/of_match_ptr() and therefore needs
> > > to include of.h header. We used to get this definition indirectly via
> > > inclusion of matrix_keypad.h from twl.h, but we are cleaning up
> > > matrix_keypad.h from unnecessary includes.  
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Applied to the togreg branch of iio.git and pushed out as testing for
> 0-day to take a look.
> 
> Note that this is 6.2 material now - if that's an issue for the matrix_keypad.h
> cleanup then feel free to take it via the input tree with
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> but shout in reply to this so I know to drop it from the iio tree.

OK, it is not urgent, but I do not want to lose matrix keypad changes...

How about I'll wait to see where the rest of the patches end, and if
they end up in 6.1 I'll queue twl4030-madc.c through my tree together
with the header change?

Thanks.

-- 
Dmitry
