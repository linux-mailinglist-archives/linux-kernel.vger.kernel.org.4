Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F715FD44D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJMFuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMFt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:49:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47842A424
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ABE1B81CAB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDDCC433C1;
        Thu, 13 Oct 2022 05:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665640192;
        bh=3fyap5LhSza2L+4JHuJ6ML5HQdF9DEP7yZF+q8oMha8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyQeKUdorM33zBwvzzNEUPgVBlmD2cDNcA7+SGKG2KEwXmLfzjMxK3Z/ClCy9eSmC
         9OkKwOOTLxCCq/YJOqPu3bk60BkkixwJQleCpjlCTEfviv9UTwm48OG3TMXYlh3QAI
         IFFHWdwbXHfbisPzsXCufu3m1+sfw9dYdDITzAnagZ/oq6f/hL8UDQUbxzq43WUmgh
         CPKfI+hsnvxILmduWxaJIiyvZ76Jj6hkmHg6NcMqHhiXIiqjg3rNE3Oyfl0typN80Z
         d6bChRUzjISnf7FnQi44gVp/7oTgyebM6iyHHU7phwbBxk8HvUzijSpyTEtlC+xbMJ
         J7rJXyICY3S0Q==
Date:   Thu, 13 Oct 2022 13:49:49 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Dan Callaghan <dcallagh@chromium.org>
Cc:     chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v5 1/1] platform/chrome: add a driver for HPS
Message-ID: <Y0em/bnh3uk/zw6b@google.com>
References: <20221012040918.272582-1-dcallagh@chromium.org>
 <20221012040918.272582-2-dcallagh@chromium.org>
 <Y0Z++9QUAOOUAQrj@google.com>
 <CAL=kDigzLLfqxJyGCon3Tk6jHH0r=Zw9ZJDT0LL4Rcr8tmmppw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL=kDigzLLfqxJyGCon3Tk6jHH0r=Zw9ZJDT0LL4Rcr8tmmppw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:29:03PM -0700, Dan Callaghan wrote:
> Excerpts from Tzung-Bi Shih’s message of 2022-10-12 19:46:51 +1100:
> > On Wed, Oct 12, 2022 at 03:09:18PM +1100, Dan Callaghan wrote:
> > > +     hps->enable_gpio = devm_gpiod_get(&client->dev, "enable", GPIOD_OUT_HIGH);
> > > +     if (IS_ERR(hps->enable_gpio)) {
> > > +             ret = PTR_ERR(hps->enable_gpio);
> > > +             dev_err(&client->dev, "failed to get enable gpio: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret = misc_register(&hps->misc_device);
> > > +     if (ret) {
> > > +             dev_err(&client->dev, "failed to initialize misc device: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     hps_set_power(hps, false);
> >
> > IIUC, the GPIO will raise to HIGH in the first place, and then fall
> > to LOW until here.  Is it an expected behavior?  How about gpiod_get()
> > with GPIOD_OUT_LOW?
> 
> It might seem a little unusual, but it is intentional. The enable line is
> already high when we enter the kernel from firmware. Acquiring the GPIO
> line with GPIOD_OUT_HIGH preserves its existing state (high) in case later
> steps fail.
> 
> We power off the periphal only once the driver is successfully bound and has
> taken control of its power state.

I see.  Please put some context comments before calling devm_gpiod_get().

> > > +static int hps_i2c_remove(struct i2c_client *client)
> > > +{
> > > +     struct hps_drvdata *hps = i2c_get_clientdata(client);
> > > +
> > > +     pm_runtime_disable(&client->dev);
> > > +     misc_deregister(&hps->misc_device);
> > > +     hps_set_power(hps, true);
> >
> > Why does it need to raise the GPIO again when removing the device?
> 
> Similar to the above, we want to preserve the default power state
> (i.e. powered on) whenever the driver is not bound to the device.
> 
> This behaviour made sense to us mainly because we were originally controlling
> the peripheral entirely from userspace, so it was always powered on by default.
> 
> Do you think this behaviour is acceptable, or do we need to change it?

I think it's fine.  Please put some context comments before calling
hps_set_power().
