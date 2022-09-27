Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8A5ECAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiI0Rfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI0Rfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:35:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A410251F;
        Tue, 27 Sep 2022 10:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37D54B80D15;
        Tue, 27 Sep 2022 17:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA7DC433D6;
        Tue, 27 Sep 2022 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664300138;
        bh=7nMM1gFZWXh4WpyxP+YyX/c8KsBjoyFaNAd2c6yxXUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHI4lQ2oL+4hfcvf0qxRhB/1SrXANqpCZ8jrjQnfsOYwjjToN16H8OZRxenUvI675
         DCJUXZ/2ye+cKu0dZC1mzvhlP8KDaqVk/t3E+IOiFlA9kilUn8I40KZGD4BqBONxkZ
         IMKZJaaJ3t6iGn1oVx3IhChkxE8z+OJAfJx2Nth4=
Date:   Tue, 27 Sep 2022 19:35:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Problem with modprobe
Message-ID: <YzM0Z4gXsjZTDkX0@kroah.com>
References: <6c1ca180-8df7-c4d0-bd9f-d6b70f6c5142@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c1ca180-8df7-c4d0-bd9f-d6b70f6c5142@lwfinger.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:11:24PM -0500, Larry Finger wrote:
> Hi,
> 
> The driver for the Realtek RTL8821CE network card show some asymmetrical
> behavior between loading and unloading.
> 
> Starting from scratch, a load command provides the expected results:
> 
> finger@localhost:~/rtw88>sudo modprobe -v rtw88_8821ce
> insmod /lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
> 
> insmod /lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_pci.ko
> 
> insmod /lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821c.ko
> 
> insmod /lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821ce.ko
> 
> Unloading produces a different result:
> 
> finger@localhost:~/rtw88>sudo modprobe -rv rtw88_8821ce
> rmmod rtw88_8821ce
> rmmod rtw88_pci
> rmmod rtw88_8821c
> 
> Note that rtw88_core is still loaded and needs to be unloaded separately:
> 
> finger@localhost:~/rtw88>sudo modprobe -rv rtw88_core
> rmmod rtw88_core
> 
> The appropriate lines from modules.dep reformatted for clarity are as follows:
> 
> kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko:
>    kernel/net/mac80211/mac80211.ko
>    kernel/lib/crypto/libarc4.ko
>    kernel/net/wireless/cfg80211.ko
> kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821c.ko:
>    kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
>    kernel/net/mac80211/mac80211.ko
>    kernel/lib/crypto/libarc4.ko
>    kernel/net/wireless/cfg80211.ko
> kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821ce.ko:
>    kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821c.ko
>    kernel/drivers/net/wireless/realtek/rtw88/rtw88_pci.ko
>    kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
>    kernel/net/mac80211/mac80211.ko
>    kernel/lib/crypto/libarc4.ko
>    kernel/net/wireless/cfg80211.ko
> kernel/drivers/net/wireless/realtek/rtw88/rtw88_pci.ko:
>    kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
>    kernel/net/mac80211/mac80211.ko
>    kernel/lib/crypto/libarc4.ko
>    kernel/net/wireless/cfg80211.ko
> 
> What is the explanation for the failure to auto-unload rtw88_core?

I don't think we ever auto-unload dependant modules as we don't know if
they are still in use or not (hint, module references is not a
representation if the module is in use or not.)

So this is working as intended, right?  And how it's always worked?

thanks,

greg k-h
