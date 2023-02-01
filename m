Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB268658D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBALqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBALqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:46:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFAA1207E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:46:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 802EDB82127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B8CC433D2;
        Wed,  1 Feb 2023 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675252007;
        bh=8zY9HL8SA760e0+goNcAHg1Z3ldcC/GIG4fiYUhdcMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmL/IopwbpieYFpoJt0G/Obm7qwSVbzVm3z2TT5zcgTE/jbQGRa3Fmlg+Fm65iIhe
         UYs373agseCg8TJPCsh6FNtG9zBewlV3iHUEf3/eQSrCXBb0v7PS4/PRMR06XIdPSp
         wkSxV7qhZqld8TSx+hleUovuWrh4nqcvFsnP959Q=
Date:   Wed, 1 Feb 2023 12:46:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, arnd@arndb.de,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v2 15/16] driver core: make struct bus_type.uevent() take
 a const *
Message-ID: <Y9pRIwStDHbgoCVl@kroah.com>
References: <20230111113018.459199-16-gregkh@linuxfoundation.org>
 <20230201112122.16098-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201112122.16098-1-naresh.kamboju@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:51:22PM +0530, Naresh Kamboju wrote:
> Following build regression started from next-20230130.
> 
> Regressions found on sh:
> 
>   - build/gcc-11-dreamcast_defconfig
> 
> drivers/sh/maple/maple.c:785:19: error: initialization of 'int (*)(const struct device *, struct kobj_uevent_env *)' from incompatible pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=incompatible-pointer-types]
>   785 |         .uevent = maple_bus_uevent,
>       |                   ^~~~~~~~~~~~~~~~
>       
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230201/testrun/14479366/suite/build/test/gcc-11-dreamcast_defconfig/history/
> 
> The bisection pointed to this commit,
>   2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")

Odd that no other build system reported this (linux-next, 0-day, etc.)
I guess no one really cares about sh and the dreamcast anymore?  :)

Anyway, thanks, I'll fix this up.

greg k-h
