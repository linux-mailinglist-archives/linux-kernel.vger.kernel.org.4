Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8251E642926
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiLENSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiLENR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:17:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D556C6F;
        Mon,  5 Dec 2022 05:17:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2788395pjh.1;
        Mon, 05 Dec 2022 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLKigQMd2CQVI8yL/UX9DqNgGI+BKPrbaicLA6hflXk=;
        b=AUzt+MIZmSmyj1QldTDRZbHT+OnTPbDo0O9IwoJus5VrCMpZKFVWi5JtIVO/3EEfMe
         +ExsNVqvk0GPgt9QmHdwhKm3KzdJNmk9/dlYJyF08/k8W/dfp+lb7FLcXLRU1YbaPNfV
         nbCek2RzzlRTiv/SD9+tU9f23azeAqo4pJhZuqPRfrI2OkzF+aOZKPxDN7iSBqERedE2
         Q54R/oKtvgBHvcYgLHWmkuz4zNnHGj02Xfkzpy6aJLw3TRgO9c3bJTHFK7cFm/A5Graa
         Rn/FMIsZg9D0481bvSUWn11FGNcX9oo+HpHNEY48SwtZNFokKOJUiKRUY93nmjxzMAQt
         6uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLKigQMd2CQVI8yL/UX9DqNgGI+BKPrbaicLA6hflXk=;
        b=uDfbPanUR+G24HKpPXfaIGpldKOF2d5hdE5vkPWbb7YXDqf4mzy3DDKyjhwARcyZF7
         dbajdoxI3x/saYkVKINsznxEOJ0ZmGLnScu3MLGXSzv8lJGBv0z88MWKprG0hAm0hfHV
         rH4lKEjK8tQL+qEcoHM05ODYdkRzOe95UB2ttHntcQjnyknC0bb+8JKed+ci3arRsmt6
         7Lt+e0BADxyC/8nhT6/BtyyZG4g6oDLzkPT18ATond4zePOWzPUPBzuYBKiEbbQDcQmi
         yTTFfGMzUYsPmbyjww40t9eC3h+yPEGjcG854MwBqcpOxsURY09G1zFIPnTmL7dOrmeM
         DWMQ==
X-Gm-Message-State: ANoB5pkCAOE66iwKRDQ66dpKG/hzruwAtuK1jqnfEVU4XBktq/+tOR8i
        7+cA0qG2j1yCVIhJKTkKI8kx/a7/8qU=
X-Google-Smtp-Source: AA0mqf6m+bljBfXAHeH1bwAI6cFsgQW6Hp8knb5gC4vpyQwCdJerzQIzzqdhPdQI+RtBe7JQv48Unw==
X-Received: by 2002:a17:90b:1947:b0:219:de9b:f3a7 with SMTP id nk7-20020a17090b194700b00219de9bf3a7mr3318038pjb.78.1670246278659;
        Mon, 05 Dec 2022 05:17:58 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b00188f07c10c9sm10581930plf.192.2022.12.05.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:17:58 -0800 (PST)
Date:   Mon, 5 Dec 2022 21:17:52 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hainke <vincent@systemli.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
Message-ID: <Y43vgFY+qnqH8+0P@sol>
References: <20221205123903.159838-1-brgl@bgdev.pl>
 <Y43rPdus/9INC390@smile.fi.intel.com>
 <Y43rmRW1S8PvMJW4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y43rmRW1S8PvMJW4@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 03:01:13PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 05, 2022 at 02:59:42PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 05, 2022 at 01:39:01PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > 
> > > Linus Torvalds pointed out that using trylock here is wrong. This iteration
> > > drops it in favor of unconditional locks but keeps all the fixes that came
> > > later.
> > > 
> > > I will also not send it for this release but make it part of the updates PR
> > > for v6.2 to give it some time in next.
> > > 
> > > v7 -> v8:
> > > - don't use down_read_trylock(), just go straight for a full lock
> > 
> > Yep, it was a good wrap-up explanation.
> 
> But he also suggested to fold NULL check into call_*_locked(). Any points why
> you decided not to go that way?
> 

He also mentioned making it more back-portable.
Does that mean splitting out the patches for uAPI v1 and v2, if not for
each of the Fixes? Or does he mean back-porting it to 6.1?

Cheers,
Kent.
