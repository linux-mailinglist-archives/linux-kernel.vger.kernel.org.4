Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACD5B9285
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIOCIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIOCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:08:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A573A8E9B1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:08:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so16150847pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FLZxkfBmaabZYnbKdl7XPTVOmUvhvV3i8qNs091c6j8=;
        b=fuznWo7HxoyOPNZxYDC5sDs/0sQBXV9o3uq+JbseHvgOdHpgqAZzDy5RPY6cBbPvqU
         c7NHzec7EM0UVfx8J/8RPytLz1YANOyGafmmjrXWPkXWmU53dmY3DybBpng/NNzXVWJI
         wHfA59u1gUd0fBq/oCFdwIJIjB/Wdj8mF++KmcVi+TyOOwL8D26H1G7W3CXxjmWy8X+p
         c+d/ezevqLcSkBWKAiRFF4oEpInwjLi7bkJh7dpZCjyi1UZNIez9lGk9Byb5Vc+XyOQd
         ij+LdHdo1Nc4Z/Wi9thleqBypjCnV8rjCnAZvvsa1xxaXqnd+4FXL1vp32Hz8E/w1BYH
         bx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FLZxkfBmaabZYnbKdl7XPTVOmUvhvV3i8qNs091c6j8=;
        b=aM0lRrAHEmI4kacplvaA91g7o9vGsKQ1WycHhHyT5MfbGirL3LFac1FIe5WpH8XWyD
         /COlt88pCxxYCaN7Q2vFVmJmlINhJv5Ky1vTrGXNmIwvRLM6GLDQnS2k2p1zDUlHBbCZ
         bIYAByJX74f30iSzrNhOKASbX9PtowAEZEQU3olhuJELwNd3JP7h9CRN0hZoWrpJNynZ
         isTvzleYHhGGvF/OFAuYtCUoIEfunecs4O1mroYdGvCEHmv3yFySE5Aqo4INOvFpcx7S
         2JfeJb2+KJ4IHOB3Mx/MXopa7QWQXAm+pHshCRg/v62GwogwQhmsPukJPebuhLKkRXjM
         Yr4A==
X-Gm-Message-State: ACrzQf1jbpY/6doIQA7d9VyrxohQwXmd1lcR6HCJMkxid8sfM/+uaB8w
        9DDbBCPYK1R8xo0LWc59l4A=
X-Google-Smtp-Source: AMsMyM7cI773wpAoBDymce/nxStZFAUAmNg1TU+Pp1SVHhGRHHZSriGPnv48xiFabqOyNzsHnwTUnw==
X-Received: by 2002:a17:902:ab5e:b0:178:99a:4f1 with SMTP id ij30-20020a170902ab5e00b00178099a04f1mr2022091plb.6.1663207719128;
        Wed, 14 Sep 2022 19:08:39 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902f64400b001709e3c755fsm11413794plg.230.2022.09.14.19.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 19:08:38 -0700 (PDT)
Date:   Wed, 14 Sep 2022 19:08:34 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, laforge@gnumonks.org,
        gregkh@linuxfoundation.org
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Paul Fulghum <paulkf@microgate.com>, akpm@osdl.org,
        imv4bel@gmail.com
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Message-ID: <20220915020834.GA110086@ubuntu>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous mailing list is here:
https://lore.kernel.org/lkml/20220913052020.GA85241@ubuntu/#r


There are 3 other pcmica drivers in the path "drivers/char/pcmcia/synclink_cs.c", 
the path of the "synclink_cs.c" driver I reported the UAF to.
A similar UAF occurs in the "cm4000_cs.c" and "cm4040_cs.c" drivers. 
(this does not happen in scr24x_cs.c)

The flow of UAF occurrence in cm4040_cs.c driver is as follows:
```
                cpu0                                                cpu1
       1. open()
          cm4040_open()
                                                             2. reader_detach()
                                                                reader_release()
                                                                cm4040_reader_release()
                                                                while (link->open) { ...
       3. link->open = 1;
                                                             4. kfree(dev);
                                                                device_destroy()
       5. read()   <- device_destroy() was called, but read() can be called because fd is open
          cm4040_read()
          int iobase = dev->p_dev->resource[0]->start;   <- UAF
```
In cm4040_open() function, link->open is set to 1.
And in the .remove callback reader_detach() function, if link->open is 1, 
cm4040_close() is called and wait()s until link->open becomes 0.
However, if the above race condition occurs in these two functions, 
the link->open check in reader_detach() can be bypassed.
After that, you can call read() on the task that acquired fd to raise a 
UAF for the kfree()d "dev".


The flow of UAF occurrence in cm4000_cs.c driver is as follows:

```
                cpu0                                                cpu1
       1. open()
          cmm_open()
                                                             2. cm4000_detach()
                                                                stop_monitor()
                                                                if (dev->monitor_running) { ...
       3. start_monitor()
          dev->monitor_running = 1;
                                                             4. cm4000_release()
                                                                cmm_cm4000_release()
                                                                while (link->open) { ...
       5. link->open = 1;
                                                             6. kfree(dev);
                                                                device_destroy()
       7. read()   <- device_destroy() was called, but read() can be called because fd is open
          cmm_read()
          unsigned int iobase = dev->p_dev->resource[0]->start;   <- UAF
```
In the cm4000_cs.c driver, the race condition flow is tricky because of 
the start/stop_monitor() functions.

The overall flow is similar to cm4040_cs.c.
Added one race condition to bypass the "dev->monitor_running" check.


So, should the above two drivers be removed from the kernel like the synclink_cs.c driver?

Or should I submit a patch that fixes the UAF?


Best Regards,
Hyunwoo Kim.
