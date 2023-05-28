Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B520E7138D5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjE1JNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjE1JNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 05:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8890C9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 02:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4410A60D2B
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 09:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2D2C433EF;
        Sun, 28 May 2023 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685265198;
        bh=X+wEkGcFPxyLRRStAYn+nV5CgUbOCpIYtQ2VqRZYruI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sz2PySYvXFdgPJGBwyCyzEzvDRi1So/HQhfyir6PYcl2zPP6aT1qyQVnrD1EKa3mW
         xULxaQ+2dpamAVCEiIiKSVwCJHERaXbkU+gAcpFMDQI6Z76QdChGWrpt8qnlX5Cpfj
         S8gDVdgYjzWO/lbzMry5w/kKn1KzuvtISSPmuQuo=
Date:   Sun, 28 May 2023 10:13:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        Adrien Thierry <athierry@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: mark vchiq_platform_init() static
Message-ID: <2023052856-tidal-trapdoor-1112@gregkh>
References: <20230516202603.560554-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516202603.560554-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:25:55PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has no callers from other files, and the declaration
> was removed a while ago, causing a W=1 warning:
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:465:5: error: no previous prototype for 'vchiq_platform_init'
> 
> Marking it static solves this problem but introduces a new warning
> since gcc determines that 'g_fragments_base' is never initialized
> in some kernel configurations:
> 
> In file included from include/linux/string.h:254,
>                  from include/linux/bitmap.h:11,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/mm_types_task.h:14,
>                  from include/linux/mm_types.h:5,
>                  from include/linux/buildid.h:5,
>                  from include/linux/module.h:14,
>                  from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
> In function 'memcpy_to_page',
>     inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:433:4:
> include/linux/fortify-string.h:57:33: error: argument 2 null where non-null expected [-Werror=nonnull]
> include/linux/highmem.h:427:9: note: in expansion of macro 'memcpy'
>   427 |         memcpy(to + offset, from, len);
>       |         ^~~~~~
> 
> Add a NULL pointer check for this in addition to the static annotation
> to avoid both.
> 
> Fixes: 89cc4218f640 ("staging: vchiq_arm: drop unnecessary declarations")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Nice, thanks for finally fixing this up, it's been a low-grade annoyance
for a very long time.

greg k-h
