Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6D6CF48C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjC2U37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC2U34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:29:56 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA14C5BB1;
        Wed, 29 Mar 2023 13:29:55 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so19811000pjp.1;
        Wed, 29 Mar 2023 13:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680121795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhjZK68miFzbZvBDqHcwEFW8uLUh4vM3IPl/nOojbhg=;
        b=hTeCz1qMQ45+bnazyDi8d+8IjtV+xVRWKwAoh6Amp54LqV8Abot4W5UfPs4+/r4eoU
         Rl3lEylk6jOnrJWR7Gk9KkJVDgUcuqARD2C2G9VtjalsIlLTuSck3IHrNsqvEMflH99t
         C2p0QgNpBH7RCOIuUOr9JOBoAFPSvz9MtimGpQCJdpeCsC8nQMDWTBnyBnKVbb5jdBJT
         USHGRbzuEpKtZGIMaHP9ZuqDO2E0IYm8r8aUQpJPJytpXtB3BCCulVsDU1miimA2Au7I
         cI78drWnWVwlCa5yVQIqhb2YjgZiftC4mjylMsvUPjs66CDfP3apw1AV24A6GzRsHubf
         321Q==
X-Gm-Message-State: AO0yUKU4Udj7rXj+bCh2pe3wDzGD97F4eQus9G2nWN0b8wB7CfE9q7ir
        vdbmCNH/7zl8vw9ICLawmEyAjrA2v5iz5g==
X-Google-Smtp-Source: AK7set/O/9ddHmBGThyh+zMnWVvbVqMsFqKzh2C+9aKf50zRRkUHUyxNz1NSXL472bkex1OwHVnXvA==
X-Received: by 2002:a05:6a20:6d87:b0:cc:aec0:e9b with SMTP id gl7-20020a056a206d8700b000ccaec00e9bmr17055309pzb.19.1680121794902;
        Wed, 29 Mar 2023 13:29:54 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id x32-20020a634a20000000b004fb10399da2sm114139pga.56.2023.03.29.13.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 13:29:54 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:29:52 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: allow mmc to block wait_for_device_probe()
Message-ID: <ZCSfwBiponFGFXlN@snowbird>
References: <20230328223740.69446-1-dennis@kernel.org>
 <ZCPEcxueuGUaRNOP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCPEcxueuGUaRNOP@kroah.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:54:11AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Mar 28, 2023 at 03:37:40PM -0700, Dennis Zhou wrote:
> > I've been hitting a failed data device lookup when using dm-verity and a
> > root device on an emmc partition. This is because there is a race where
> > dm-verity is looking for a data device, but the partitions on the emmc
> > device haven't been probed yet.
> > 
> > Initially I looked at solving this by changing devt_from_devname() to
> > look for partitions, but it seems there is legacy reasons and issues due
> > to dm.
> > 
> > MMC uses 2 levels of probing. The first to handle initializing the
> > host and the second to iterate attached devices. The second is done by
> > a workqueue item. However, this paradigm makes wait_for_device_probe()
> > useless as a barrier for when we can assume attached devices have been
> > probed.
> > 
> > This patch fixes this by exposing 2 methods inc/dec_probe_count() to
> > allow device drivers that do asynchronous probing to delay waiters on
> > wait_for_device_probe() so that when they are released, they can assume
> > attached devices have been probed.
> 

Thanks for the quick reply.

> Please no.  For 2 reasons:
>   - the api names you picked here do not make much sense from a global
>     namespace standpoint.  Always try to do "noun/verb" as well, so if
>     we really wanted to do this it would be "driver_probe_incrememt()"
>     or something like that.

Yeah that is a bit of a blunder on my part...

>  - drivers and subsystems should not be messing around with the probe
>    count as it's a hack in the first place to get around other issues.
>    Please let's not make it worse and make a formal api for it and allow
>    anyone to mess with it.
> 

That's fair.

> Why can't you just use normal deferred probing for this?
> 

I'm not familiar with why mmc is written the way it is, but probing
creates a notion of the host whereas the devices attached are probed
later via a work item.

Examining it a bit closer, inlining the first discovery call
avoids all of this mess. I sent that out just now in [1]. Hopefully
that'll be fine.

[1] https://lore.kernel.org/lkml/20230329202148.71107-1-dennis@kernel.org/T/#u

> thanks,
> 
> greg k-h

Thanks,
Dennis
