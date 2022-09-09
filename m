Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6E5B4112
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIIUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiIIUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:53:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0258CE582A;
        Fri,  9 Sep 2022 13:53:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so4769394lfr.2;
        Fri, 09 Sep 2022 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9uJhMPjNtanajGUXFh7EWJy2ETbUMNIiBMvaNfS3PKg=;
        b=iYZRMFOgtxJgEyoS9zaA8hEv3F5GRJ4VR1CwPtWw+QQJwrb4owBjcbOwd56/AfVL6U
         CeGF8+yX2/YvNhnvyfpTf4VUYHjFxDfVpPN2iyHMRgxF9aZEC+RA13t9BU8XCzVojBsg
         T5hiI8TpWCPFUqG9bmmLaPDl8UNBAr43ubo48dvZFiHbQIewUkoNm6q9jWHou2hAG5ty
         2J44+UdiQHxe2RhlNtwfHPwf6twf3bEE76GLPVvqzrB1J3QoJVQfyiNTnm9f+I/hYQaG
         lJdwRnnUS1KI/3oZ2DD45A7dWoImO8ClK4TJ3HKkBa3EshIArPFZGw+Ztn3R1iptnS9h
         WQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9uJhMPjNtanajGUXFh7EWJy2ETbUMNIiBMvaNfS3PKg=;
        b=MUywMsubOKbzuiPILjkUtpmRmr6fNEWl1HKJGSIUPx1ZlqNtav1+oOCPCJfksJJDKp
         sBl/4Pl7jWEMBiBrUyp6pYuGdZyoZNU8GRMkp9KBIZcmXYIl5pR3X1NFsx7qfXSlY2JO
         aanmF+6/zNoiz8OpCP8hK01qpIfgOTalAWa1kMavQi4RSWcNHqlHKUYqyvM3gS+w/wCC
         6nbncR66Iw3kLmeOv44c803/kQn6b55w1rFClFmBkY0IwV3FyCfSV6JKNLq1u3NmOMxf
         Yle/pf+BZuENuM6JrHGLI1gwLgBmItX2BaNYZjhVpo+SOljIE4DA4KbNoWfz7XZF0j5F
         dKcA==
X-Gm-Message-State: ACgBeo2K2m6XO7SUFMc3wr4hJF9JXR4XdNDoJw16PA604UHlS1LyRN5I
        iBrKy+2oYrccgsQf7dXvam4=
X-Google-Smtp-Source: AA6agR5WMB4Pyl705A4BROqcMh9fI4blbkel8r3Vzya7cmCyp8RJc/YwVZvn6Kw4z3o012WBfUTNPA==
X-Received: by 2002:a05:6512:2254:b0:498:f454:ec9a with SMTP id i20-20020a056512225400b00498f454ec9amr2482976lfu.58.1662756811191;
        Fri, 09 Sep 2022 13:53:31 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651c118e00b00261ccf566e3sm47407ljo.65.2022.09.09.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 13:53:30 -0700 (PDT)
Date:   Fri, 9 Sep 2022 23:53:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220909205328.yv6y4f3t2zznhlkp@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <YxuXKrkVbGBJwxRS@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxuXKrkVbGBJwxRS@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 01:42:34PM -0600, Keith Busch wrote:
> On Fri, Sep 09, 2022 at 10:19:15PM +0300, Serge Semin wrote:
> > Recent commit 52fde2c07da6 ("nvme: set dma alignment to dword") has caused
> > 
> > Folks, I've thoroughly studied the whole NVME subsystem looking for
> > similar problems. Turned out there is one more place which may cause the
> > same issue. It's connected with the opal_dev.{cmd,req} buffers passed to
> > the nvme_sec_submit() method. The rest of the buffers involved in the NVME
> > DMA are either allocated by kmalloc (must be cache-line-aligned by design)
> > or bounced-buffered if allocated on the stack (see the blk_rq_map_kern()
> > method implementation).
> 

> What about user space addresses?

Reasonable question. Alas I haven't researched the user-space part as
much thorough. What I can say for sure that we haven't detected any
unaligned buffers passed to the DMA-mapping procedure other than the
ones denoted in this patch and in the next one. So to speak so far
none of the NVME-involved user-space buffers have had unaligned offset
in the physical address space. I have merged in the next patch in our
local kernel tree:
https://patchwork.linux-mips.org/project/linux-mips/patch/20161125184611.28396-3-paul.burton@imgtec.com/
So if an unaligned buffer was passed we would have immediately got it
detected.

> We can map those with cacheline offsets.

If we could do that easily it would have been great. But I don't see
an easy way out. AFAICS we'll need to fix the blk_rq_map_user_iov()
method so one would CPU-based copy the unaligned part of the buffer
and perform the DMA-required operations with the rest of it. Do you
have any better suggestion in mind?

> 
> > ---
> >  drivers/nvme/host/hwmon.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> > index 0a586d712920..94192ab7a02d 100644
> > --- a/drivers/nvme/host/hwmon.c
> > +++ b/drivers/nvme/host/hwmon.c
> > @@ -10,9 +10,10 @@
> >  
> >  #include "nvme.h"
> >  
> > +/* DMA-noncoherent platforms require the cache-aligned buffers */
> >  struct nvme_hwmon_data {
> > +	struct nvme_smart_log log ____cacheline_aligned;
> >  	struct nvme_ctrl *ctrl;
> > -	struct nvme_smart_log log;
> 

> So this by chance happened to work before 52fde2c07da6 because the field
> started at a 4-byte offset on your arch?

Correct. The offset is 4-bytes indeed so the log-field base address is
4-bytes aligned. Due to that the bounce-buffer used to be used for the
NVME SMART log getting. Since the denoted commit the log-buffer have
been directly used for DMA, which has revealed the problem caused by the
cache-invalidation on the buffer mapping.

> 
> The change looks good.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks.

-Sergey

