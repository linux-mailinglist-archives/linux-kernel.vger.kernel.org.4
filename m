Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0E6B22BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCILXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCILXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:23:12 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC7DCF61
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:19:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id k10so5390306edk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112; t=1678360773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWVpJa9jafiWR7ReoMFeoCuLxbY0yAV8qbCl/kR+OT0=;
        b=xCCdR6eqOl+6/f9crf2vidUY5zc1EMelNM3VS9yVHDAUSVklvgnwmGiFx1g0rl2YWm
         aoGzi2BF6Oq1noINisonCJEQ3XKLIpo2NZRaJuZDsRbalM6vCbEdr2z575eUJ0CrKS7F
         ntyumgh12mp8juBAwk6RyQ12P1FY6DQnsNDqk/OVl92bLjlkKJN4kxRdTfWAEbBtFz2i
         9ktFGRdlf4kfZ5GtjZyGiunHrjuH+WK7dMJHdbpNke3bnSqf9Koo3FYwWMNcHZyRp+Y5
         9ya2c/fF/j1HhnMg1aWUGbV34HbNOohIYjQJ8vens0h6o77UglCgpgdIyjv6kLh/2GCw
         SHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678360773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWVpJa9jafiWR7ReoMFeoCuLxbY0yAV8qbCl/kR+OT0=;
        b=8Jdqs1R1Np7uAkfJ/evSL3kQhLE3s0u8xEQrNbRN9FqMo7RVsuDr2u7hOyoRM4QtZ2
         MtrElqmS7XITwJKqQmtbawaODh5j7aP3nbotDOAarkfW9rBE4YkpPovNF5fE2ZNQX003
         xUeNNMRcrLn4oFzfbJpxcOe909oCfs3crnD4Nudl1NyT/3StNI2oarGDBy+eVluGqD+o
         /yQ6sBhc0LHNS3N3kx2ShUcTDoKI1ITvqKOyaNipbMIskRVMLv5v0TeQNKiQuJcBXLEK
         +m+/aSjxQYIDI/jntZRATUMrEOekr8wO6wcMonV67Oru3HYIhRP2NT6h8hJMKQvxYlwd
         t/6A==
X-Gm-Message-State: AO0yUKX/zq4H+f50iS/+LSrCBbmZsopQt1p/fj7rDQDm78CQVML7zlPA
        nXAzRjmw1Ob47eEv6UECreZd0Q==
X-Google-Smtp-Source: AK7set8k4fSEXWaELTNHKVeA7K8J+G9hhXyqnw7tcYQjDGeZ1yaogb8DKUf8YHlc11QJiwYSbaaE3w==
X-Received: by 2002:a17:906:2da2:b0:8ae:f1cd:9551 with SMTP id g2-20020a1709062da200b008aef1cd9551mr21558887eji.76.1678360772840;
        Thu, 09 Mar 2023 03:19:32 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t16-20020a170906949000b008b30e2a450csm8806450ejx.144.2023.03.09.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 03:19:32 -0800 (PST)
Date:   Thu, 9 Mar 2023 12:19:29 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Eizan Miyamoto <eizan@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Anton Lundin <glance@acc.umu.se>
Subject: Re: [PATCHv3 net 1/2] net: asix: fix modprobe "sysfs: cannot create
 duplicate filename"
Message-ID: <ZAnAwQ1LO81F6ssZ@nanopsycho>
References: <20230308202159.2419227-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308202159.2419227-1-grundler@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 08, 2023 at 09:21:58PM CET, grundler@chromium.org wrote:
>"modprobe asix ; rmmod asix ; modprobe asix" fails with:
>   sysfs: cannot create duplicate filename \
>   	'/devices/virtual/mdio_bus/usb-003:004'
>
>Issue was originally reported by Anton Lundin on 2022-06-22 14:16 UTC:
>
>Chrome OS team hit the same issue in Feb, 2023 when trying to find
>work arounds for other issues with AX88172 devices.
>
>The use of devm_mdiobus_register() with usbnet devices results in the
>MDIO data being associated with the USB device. When the asix driver
>is unloaded, the USB device continues to exist and the corresponding
>"mdiobus_unregister()" is NOT called until the USB device is unplugged
>or unauthorized. So the next "modprobe asix" will fail because the MDIO
>phy sysfs attributes still exist.
>
>The 'easy' (from a design PoV) fix is to use the non-devm variants of
>mdiobus_* functions and explicitly manage this use in the asix_bind
>and asix_unbind function calls. I've not explored trying to fix usbnet
>initialization so devm_* stuff will work.
>
>Fixes: e532a096be0e ("net: usb: asix: ax88772: add phylib support")
>Reported-by: Anton Lundin <glance@acc.umu.se>
>Link: https://lore.kernel.org/netdev/20220623063649.GD23685@pengutronix.de/T/
>Tested-by: Eizan Miyamoto <eizan@chromium.org>
>Signed-off-by: Grant Grundler <grundler@chromium.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
