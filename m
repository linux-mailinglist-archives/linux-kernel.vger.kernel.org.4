Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C095F0E27
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiI3O5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3O5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:57:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE486708;
        Fri, 30 Sep 2022 07:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB403B8291B;
        Fri, 30 Sep 2022 14:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1262C433C1;
        Fri, 30 Sep 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664549825;
        bh=H2o4bIptk3E/SP0ZFh8Y+k2fFYZReWspuAdBMZkKXnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hdci3QXo3ykxMK7yoVc/vmDwDkp6kfl6iPdVfmfSp0NfC/xHXC+6AVALOPBwe6CO+
         DyzbFxk2qG5QMuW19IY6IEbIo47pnNsN9YoPDFbBayxgQ900fSc7pEhlDWZ1A8wRAi
         9ufdV0y4DyotlNESD0G1/jxLwcz7zpyk8B3M/UDYJH0Xwp8zew4BIB5giRyhOwd6r6
         xz6TssaWSKAO9Bwfw5cu2inhDgMF0odP14LM+8HDS6W4wTLAUWPQyuj27ViT3D78ft
         qyAhhgl+9eS32AGz4xaeCd/qGOaaAuYkTjUEE/suqugq78dEeTMDekpodwBLXvSEp1
         1JTU//iO6E1iA==
Date:   Fri, 30 Sep 2022 08:57:02 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930095247.vqtdc53rr66uaiwv@mobilestation>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 12:52:47PM +0300, Serge Semin wrote:
> On Thu, Sep 29, 2022 at 05:53:43PM -0600, Keith Busch wrote:
> > On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> > > Inability to allocate a buffer is a critical error which shouldn't be
> > > tolerated since most likely the rest of the driver won't work correctly.
> > > Thus instead of returning the zero status let's return the -ENOMEM error
> > > if the nvme_hwmon_data structure instance couldn't be created.
> > 
> 
> > Nak for this one. The hwmon is not necessary for the rest of the driver to
> > function, so having the driver detach from the device seems a bit harsh.
> 
> Even if it is as you say, neither the method semantic nor the way it's
> called imply that. Any failures except the allocation one are
> perceived as erroneous.

This is called by nvme_init_ctrl_finish(), and returns the error to
nvme_reset_work() only if it's < 0, which indicates we can't go on and the
driver unbinds.

This particular condition for hwmon is not something that prevents us from
making forward progress.
 
> > The
> > driver can participate in memory reclaim, so failing on a low memory condition
> > can make matters worse.
> 
> Yes it can, so can many other places in the driver utilizing kmalloc
> with just GFP_KERNEL flag passed including on the same path as the
> nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> either finished or executed in background anyway in all cases. 

This path is in the first initialization before we've set up a namespace that
can be used as a reclaim destination.

> Don't
> really see why memory allocation failure is less worse in this case
> than in many others in the same driver especially seeing as I said

The other initialization kmalloc's are required to make forward progress toward
setting up a namespace. This one is not required.
