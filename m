Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98725FE429
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJMV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJMV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:26:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B648A1B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:26:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e15so2476418iof.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGvXzyfaWxsSx0ELvyCr5bspehD/xx7xIHWSGqJXxeE=;
        b=CYbwTQUVAFGPDAams5vEG6YANf8ufOlvCE2X2ftvni16//YJRbDjCSYOrdWiFJduzx
         ctwOznzMbaEbqo8W4ciqa64lgUbbHtVvC8wj/1Pb4UsHXGujE5UC+Wt3TFg5pmiziECU
         +ohjP5/CaEnuyHOVYPU3yj/VeZ9TB2/kk7GZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGvXzyfaWxsSx0ELvyCr5bspehD/xx7xIHWSGqJXxeE=;
        b=USdHWYQZp5OQqVTnti1tM7PTjZWicu3EaQG06Vn2+04lxT23XnLcyMFWOp0eHLE/pT
         kBW/hm7j1oR2gVSDyTOxhuqVDiR2nO/WnecvBhtlrBBl88bRgQRr47MEO9I5YIZsVg0K
         fc/r1jGFsCh2lMLsaJOjWat6KJ3yo3Dwm1mWkT0oOraOFUhiJMrTevqCB1aH53WzLOw/
         g83Pf8ekQYGgl9MKwxTrXelB2jauuV2e2kjA1M2SkUnLPw633Ee/uFRxTIyf0hIPklKd
         qQulKUv6CR4vTKVzc/URqIhKTWkKUASQS8en4/q+GhKr0S3CndKNnBLBe2Qumd+pJX3U
         kPjA==
X-Gm-Message-State: ACrzQf0P6NZRCZ9BEoig+hFk5+QAfIbTI0+2M5Zk+PDT5ifZfiVOeWuL
        E8OxWUbIMmlooumkPPvG7paqyjtRfl0avA==
X-Google-Smtp-Source: AMsMyM6KtVBdDryBmZZGXEaJj+snGglJJ7YiOpYo+1PXo788euUX3Trk3uP7t5I90wQPhmYJj7PMZQ==
X-Received: by 2002:a5d:8052:0:b0:6a5:4b18:ac03 with SMTP id b18-20020a5d8052000000b006a54b18ac03mr886396ior.153.1665696392089;
        Thu, 13 Oct 2022 14:26:32 -0700 (PDT)
Received: from chromium.org ([100.107.108.164])
        by smtp.gmail.com with ESMTPSA id y19-20020a056638039300b00363c1d1ac05sm394535jap.27.2022.10.13.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:26:31 -0700 (PDT)
Date:   Thu, 13 Oct 2022 15:25:58 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v12] firmware: google: Implement cbmem in sysfs driver
Message-ID: <Y0iCZip0k9WcHgsz@chromium.org>
References: <20221004003811.4075765-1-jrosenth@chromium.org>
 <Yzvz9hn1G8rU4VaO@kroah.com>
 <Yzxl2oczTtwEvIqt@chromium.org>
 <Yzxsu2Ms43eTfOYR@kroah.com>
 <Yzy6KNUHFqxWZb9U@chromium.org>
 <CAODwPW-7Y_CbCch+Y5unH3yJD1T=3epYvqja6w_CB-23C9x9sw@mail.gmail.com>
 <Yz0jVbfDOITZfE9M@kroah.com>
 <CAODwPW8R2uXFJ_5V737Dy8z-WJHUwKkLyG4MW_Q50fs-OFm7Sw@mail.gmail.com>
 <Yz52r89A9JYEICCi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz52r89A9JYEICCi@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-06 at 08:33 +0200, Greg KH wrote:
> On Wed, Oct 05, 2022 at 04:26:55PM -0700, Julius Werner wrote:
> > > If the kernel is reporting a value, that value needs to be documented
> > > somewhere.  If the kernel is acting on that value, it needs to know what
> > > those values are.
> > >
> > > In this specific instance it seems that the kernel knows a subset of the
> > > values, and some random userspace tool knows all of them?  Think about
> > > what you would want to see here if you knew nothing about this at all.
> > 
> > The kernel doesn't know any of the values. The kernel is just telling
> > userspace that spaces with these IDs exist and providing an interface
> > to access them, it's not supposed to know what any of them mean.
> 
> Ah, ok, that was not obvious to me, sorry.  If the kernel is just a
> pass-through, no objections.

Does this mean PATCH v13 looks good to you?

thanks,

jack
