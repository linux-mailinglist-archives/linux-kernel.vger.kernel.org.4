Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3CF66E148
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjAQOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjAQOuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:50:00 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E588A3D089;
        Tue, 17 Jan 2023 06:49:59 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id tz11so11518772ejc.0;
        Tue, 17 Jan 2023 06:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bppxrMkq51i/JLaTlCczbx6rM6G6JhbOwGfgeDwuFis=;
        b=tsn/hUJThKvDrO8WZ4UmL04gCjrYYtojN6cXOUxSk3cqOi55rdT3o2jChMW48ars8D
         8oy9Fwi2WUtx1ftIV18D1b61hlFvxZT18Buq78jTpgKDs9L8jUikREZDssLgZ7kwaK50
         bQ6uAZh79PdS4XwLA9gpSvyR90Efmfmr9cKhv/HK8Xht57GdLHYcDdQxnY8Iz6PYrXzg
         HmkYQPA/ScaQAEuIYg1mRPyYoL9lMl2tdgSBpX2CW9slMw9Pla7HL8Z3jWeonRGMO1jP
         D5e1NhniZulx01LhowwfTQooIhDqbGoV5bs9VpowGwH4TLQ87Idjgq8P3n7pPz/+yiYx
         zOXQ==
X-Gm-Message-State: AFqh2kogb/TQ30MS+ZRJveu051N4t+eUqhW0jEkUhuu/vHS0hwQuh8CU
        lhfe03i7wc87+bBWTsSjQcj2Pb37j02cOR1GT9U=
X-Google-Smtp-Source: AMrXdXv39vFkAySTyIePrnITdo8Rc0OQ93BIScX5sGEmOmmS/7UrjKhxlKY8BJ4K/Ef/2fPDZePrZwQsP4VfeKRxUEE=
X-Received: by 2002:a17:907:8d01:b0:870:db2e:ec67 with SMTP id
 tc1-20020a1709078d0100b00870db2eec67mr343202ejc.209.1673966998536; Tue, 17
 Jan 2023 06:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
 <20230117020742.2760307-4-srinivas.pandruvada@linux.intel.com> <e2b1b18a-26c7-1a45-bad1-4233024062eb@linaro.org>
In-Reply-To: <e2b1b18a-26c7-1a45-bad1-4233024062eb@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 15:49:47 +0100
Message-ID: <CAJZ5v0h5uu5UWyzTJV=RPdoyEB41-dBheOy4C05tVXpKinZtvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] thermal/drivers/intel_powerclamp: Use powercap
 idle-inject framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        amitk@kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:16 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 17/01/2023 03:07, Srinivas Pandruvada wrote:
>
> [ ... ]
>
> > diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> > index f0c845679250..6c2a95f41c81 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -3,6 +3,8 @@ config INTEL_POWERCLAMP
> >       tristate "Intel PowerClamp idle injection driver"
> >       depends on X86
> >       depends on CPU_SUP_INTEL
> > +     select POWERCAP
> > +     select IDLE_INJECT
>
> Just a question, not a comment. As IDLE_INJECT depends on POWERCAP, is
> it necessary to select POWERCAP also here ?

Yes, it is.

If IDLE_INJECT alone is selected, POWERCAP may not be and there will
be a broken dependency.
