Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23A46C458F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCVJEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:04:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B621A35;
        Wed, 22 Mar 2023 02:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3BCAB818F9;
        Wed, 22 Mar 2023 09:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D7DC433EF;
        Wed, 22 Mar 2023 09:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679475883;
        bh=oz2PN3tKGuhTQo56pqzJbIezCGcNGA9n5ON2iB/N3K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMEqf3qUQsh0QDJZ0PJY25wqSIlbuILMOKwl8D2bTsqPCIHol9i51F3HlRrkxcAa9
         HyuXIIxpj09P1x1q7PlUgmnV8b1QGANM/vllb2lLiNeC4kP9BdDwZP3HB8K3NQHijf
         BuHuIrMnv3JnVn9rMN6wp7qxs0qYtS3toZTUGUtU=
Date:   Wed, 22 Mar 2023 10:04:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/36] cpuidle: move to use bus_get_dev_root()
Message-ID: <ZBrEqDV3IqbfokwK@kroah.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-6-gregkh@linuxfoundation.org>
 <CAJZ5v0hRScLjW27k_rHZ1jnLyn7B3O26oP9Jd3AwDL97VSJ8tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hRScLjW27k_rHZ1jnLyn7B3O26oP9Jd3AwDL97VSJ8tQ@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:58:02PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 13, 2023 at 7:30 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Direct access to the struct bus_type dev_root pointer is going away soon
> > so replace that with a call to bus_get_dev_root() instead, which is what
> > it is there for.
> >
> > This allows us to clean up the cpuidle_add_interface() call a bit as it
> > was only called in one place, with the same argument so just put that
> > into the function itself.  Note that cpuidle_remove_interface() should
> > also probably be removed in the future as there are no callers of it for
> > some reason.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Note, this is a patch that is a prepatory cleanup as part of a larger
> > series of patches that is working on resolving some old driver core
> > design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> > its own, but I'd prefer if I could take it through my driver-core tree
> > so that the driver core changes can be taken through there for 6.4-rc1.
> >
> >  drivers/cpuidle/cpuidle.c |  2 +-
> >  drivers/cpuidle/cpuidle.h |  2 +-
> >  drivers/cpuidle/sysfs.c   | 12 +++++++++---
> >  3 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 0b00f21cefe3..8e929f6602ce 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -808,7 +808,7 @@ static int __init cpuidle_init(void)
> >         if (cpuidle_disabled())
> >                 return -ENODEV;
> >
> > -       return cpuidle_add_interface(cpu_subsys.dev_root);
> > +       return cpuidle_add_interface();
> >  }
> >
> >  module_param(off, int, 0444);
> > diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> > index 9f336af17fa6..52701d9588f1 100644
> > --- a/drivers/cpuidle/cpuidle.h
> > +++ b/drivers/cpuidle/cpuidle.h
> > @@ -30,7 +30,7 @@ extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
> >
> >  struct device;
> >
> > -extern int cpuidle_add_interface(struct device *dev);
> > +extern int cpuidle_add_interface(void);
> >  extern void cpuidle_remove_interface(struct device *dev);
> >  extern int cpuidle_add_device_sysfs(struct cpuidle_device *device);
> >  extern void cpuidle_remove_device_sysfs(struct cpuidle_device *device);
> > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > index 48948b171749..84e4946f1072 100644
> > --- a/drivers/cpuidle/sysfs.c
> > +++ b/drivers/cpuidle/sysfs.c
> > @@ -119,11 +119,17 @@ static struct attribute_group cpuidle_attr_group = {
> >
> >  /**
> >   * cpuidle_add_interface - add CPU global sysfs attributes
> > - * @dev: the target device
> >   */
> > -int cpuidle_add_interface(struct device *dev)
> > +int cpuidle_add_interface(void)
> >  {
> > -       return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
> > +       struct device *dev_root = bus_get_dev_root(&cpu_subsys);
> > +       int retval = -EINVAL;
> > +
> > +       if (dev_root) {
> > +               retval = sysfs_create_group(&dev_root->kobj, &cpuidle_attr_group);
> > +               put_device(dev_root);
> > +       }
> > +       return retval;
> 
> I would prefer
> 
>   if (!dev_root)
>           return -EINVAL;
> 
>   retval = sysfs_create_group(&dev_root->kobj, &cpuidle_attr_group);
>   put_device(dev_root);
>   return retval;
> 
> assuming that successful group creation will bump up the reference
> counter of dev_root.

That is correct.  I'll respin this with this change in it now, thanks
for the review!

greg k-h
