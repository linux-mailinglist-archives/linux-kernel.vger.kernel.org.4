Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D15BC56E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiISJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiISJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C07140A2;
        Mon, 19 Sep 2022 02:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 154ED60F99;
        Mon, 19 Sep 2022 09:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6D9C433D7;
        Mon, 19 Sep 2022 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663580015;
        bh=sXaESeI9KLY37vE8YRK7ngG6mV0/XxtLB0fUxYPXA2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srRfoAbZjrOWGV248YikFk4lX1JffZgCUR/nD2Q1XnID0m6HU6C9bKV+vQqB3Jfxs
         CfYZUbXmiD6orqzbOamy7ZpHUR9RzzyKzCdYNgS+0R/u9lal5+mFlkOdgjHlb96abL
         O7xPYcObnwaX2qPXUhwydnPsht+hA1rtCYutlRzU=
Date:   Mon, 19 Sep 2022 11:34:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai (A)" <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH v8 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <Yyg3ig+Y/w9eS6h0@kroah.com>
References: <20220902031304.37516-1-yekai13@huawei.com>
 <20220902031304.37516-3-yekai13@huawei.com>
 <Yxr5BpM+VIjKhVpZ@kroah.com>
 <45a50cf5-7416-4fcf-925b-ecca787425a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a50cf5-7416-4fcf-925b-ecca787425a5@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:21:30AM +0800, yekai (A) wrote:
> 
> 
> On 2022/9/9 16:27, Greg KH wrote:
> > On Fri, Sep 02, 2022 at 03:13:03AM +0000, Kai Ye wrote:
> >> Update documentation describing sysfs node that could help to
> >> configure isolation strategy for users in the user space. And
> >> describing sysfs node that could read the device isolated state.
> >>
> >> Signed-off-by: Kai Ye <yekai13@huawei.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-driver-uacce | 26 ++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> >> index 08f2591138af..af5bc2f326d2 100644
> >> --- a/Documentation/ABI/testing/sysfs-driver-uacce
> >> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> >> @@ -19,6 +19,32 @@ Contact:        linux-accelerators@lists.ozlabs.org
> >>  Description:    Available instances left of the device
> >>                  Return -ENODEV if uacce_ops get_available_instances is not provided
> >>  
> >> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> >> +Date:           Sep 2022
> >> +KernelVersion:  6.0
> >> +Contact:        linux-accelerators@lists.ozlabs.org
> >> +Description:    (RW) Configure the frequency size for the hardware error
> >> +                isolation strategy. This size is a configured integer value.
> >> +                The default is 0. The maximum value is 65535. This value is a
> >> +                threshold based on your driver strategies.
> > I do not understand what the units are here.
> >
> > How is anyone supposed to know what they are?
> 
> This unit is the number of times. Number of occurrences in a period, also means threshold.
> If the number of device pci AER error exceeds the threshold in a time window, the device is
> isolated. 

Please document this very very well.

> >> +                For example, in the hisilicon accelerator engine, first we will
> >> +                time-stamp every slot AER error. Then check the AER error log
> >> +                when the device AER error occurred. if the device slot AER error
> >> +                count exceeds the preset the number of times in one hour, the
> >> +                isolated state will be set to true. So the device will be
> >> +                isolated. And the AER error log that exceed one hour will be
> >> +                cleared. Of course, different strategies can be defined in
> >> +                different drivers.
> > So this file can contain values of different units depending on the
> > different driver that creates it?  How is anyone supposed to know what
> > it is and what it should be?
> >
> > This feels very loose, please define this much better so that it can be
> > understood and maintained properly.
> >
> > thanks,
> >
> > greg k-h
> > .
> >
> Yes,  We started out with the idea of not restricting the different drive,  only specifying the input and output.
> Because we think different drivers require different processing  strategy.

What different drivers?  You only have one!  And why do you need a
framework for only one driver?  You should only add that when you have
multiple users to ensure you got the framework correct otherwise you do
not know how it will be used.

thanks,

greg k-h
