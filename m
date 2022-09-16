Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D495BA638
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 07:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIPFDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 01:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIPFDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:03:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541DB8A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:03:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k21so9836297pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GGt+P3tyB6IbayXHNd03wUTY/fcs3eacafLGKOqD3vo=;
        b=pmS5LL2SU51x6XwLGrV2YezKCWPO2kYTmhvIaldZwaWh6RwJvfxeCxHhAVW/jecCfO
         vlFMEESi5hJ+SDD/wcQlHRMtoR8VkRk+fxIPyyxVLxYmyE60LY0xSZ6zTXRUjnZ2p/DD
         cBESEFTEPtUAhbvNi23HoxMsxOQdbAd4t1TxzTDy3+6jbBhoQUdJ5VSpC/fCcU+057n1
         EYH1OjQIJmPnZRhvaHttQw/MP//HhkjFTgbo34th3T+7x+RCBS/zPtCBHOJTylMP5reV
         W/Z5M4lB5Z/AsH4yJ44T4N9hnsCAeIQAvN2MuUn08wHVLQmmTjKGhc8odbwad6rEopxz
         LUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GGt+P3tyB6IbayXHNd03wUTY/fcs3eacafLGKOqD3vo=;
        b=Vk9kWNQD93QfFC0p5JcuxwAl8MuzMqCg6V6C4MsteqcpxEDoZCldARqHh4lPlSl4uG
         kgG5etHG/88vqRV4bfAr+IYN0Sfcf+LpkdSj3ClXk9cgZ8mwzKkIOtmTQqT6u4CH242U
         vdwg1iOqg4KEMHvHa8UL9KGC9RDeSZ9ySqvo/D75sz0oS9/UeUmOza5LEtGGFm/XA0/T
         mmQHw8s3Z0GpSxdDojqaQ2MG2D6rszwzMb9CGgKpvWAZEYiahQPeCDVcMQjuY4cTKMrl
         WF/Ejd5bzEPGbS/1XqqloRPsM7iA44qzu6KcYziyuDWzaOY+PyYHM9yAdjA3cHzZ8gU9
         7UiQ==
X-Gm-Message-State: ACrzQf3tuwyUgowWdpqNBZNrvaZOGWHZCUMGFI3lvOdN7H8se7Fi1Atl
        knn3tPeegzMRIQ0YzMnmA8s=
X-Google-Smtp-Source: AMsMyM7WjxLGdyDHCUi+Qd3hzRkzcigiyOkUetVpXfQ8fbC8jxzOE4spaHqusvT6aOYKmpXZgBwXGQ==
X-Received: by 2002:a17:902:778c:b0:178:49a1:dae8 with SMTP id o12-20020a170902778c00b0017849a1dae8mr2883578pll.147.1663304618631;
        Thu, 15 Sep 2022 22:03:38 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id 2-20020a621902000000b0054aa69bc192sm577691pfz.72.2022.09.15.22.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 22:03:38 -0700 (PDT)
Date:   Thu, 15 Sep 2022 22:03:33 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, laforge@gnumonks.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Paul Fulghum <paulkf@microgate.com>,
        akpm@osdl.org, Lubomir Rintel <lkundrak@v3.sk>, imv4bel@gmail.com
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Message-ID: <20220916050333.GA188358@ubuntu>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
 <20220915020834.GA110086@ubuntu>
 <f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com>
 <YyLcG1hG5d6D4zNN@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyLcG1hG5d6D4zNN@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous mailing list is here:
https://lore.kernel.org/lkml/20220913052020.GA85241@ubuntu/#r


Dear all,


I reported that the scr24x_cs driver does not cause UAF, which is incorrect.

UAFs can also occur in the scr24x_cs driver in the following order:
```
                cpu0                                                cpu1
       1. open()
                                                             2. scr24x_remove()
                                                                device_destroy()
                                                                cdev_del()
                                                                kref_put()
       3. scr24x_open()
          kref_get()   <- refcount_t: addition on 0;
                                                             4. scr24x_delete()
                                                                kfree(dev);
       5. scr24x_read()    <- UAF
```
Because this driver uses kref_init, it looks as if no UAF is happening, but it does.

Since there is no lock between .open and .remove, kref_get() is called after kref_put() 
is called, so "refcount_t: addition on 0;" This is what happens.


So I submitted a patch for all drivers in this path:
- synclink_cs.c "v2" patch : https://lore.kernel.org/lkml/20220916045734.GA187909@ubuntu/T/#u
- cm4040_cs.c : https://lore.kernel.org/lkml/20220916045834.GA188033@ubuntu/T/#u
- cm4000_cs.c : https://lore.kernel.org/lkml/20220916045929.GA188153@ubuntu/T/#u
- scr24x_cs.c : https://lore.kernel.org/lkml/20220916050006.GA188273@ubuntu/T/#u


Best Regards,
Hyunwoo Kim.
