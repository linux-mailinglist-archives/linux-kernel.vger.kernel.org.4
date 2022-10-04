Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF225F4887
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJDRd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJDRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187262A9C;
        Tue,  4 Oct 2022 10:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CD2B614F0;
        Tue,  4 Oct 2022 17:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAA0C4347C;
        Tue,  4 Oct 2022 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904827;
        bh=PwPs9MrC9Nnp8YuXE4YUV6t4bJoGLpNTpwSGttYa7Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tAixdHgrvrMRL7IegAz1OTU6UQXKZBnHxqZglxfcFTG3tW/ysYVojy0xhNtiVt2hG
         TgLKzPoef7vjF2ubyvUoPry8SNTQJp6iiz8jA/lwQKGvRMpHzPSzBZvknZeedb45AI
         ZBeYujjiZaIfaQVwP0hpr+JccVp7YYc4ilWnI/2S2E4aQDdXvwOb/a7bAUVuFY4Zmp
         Px+s4UxtFKdbHcakbg2lJrHk1VElDY6Vz17OKApGn61geIcpptg/oL4sadL1ymoP6D
         uuEOWDRi56Rq0udQDutmX9vjRdg6nd6tQFqAM34iAsDf8b5gWWUTMHoLrjqM+dnKAO
         AiDImc9UmloWQ==
Date:   Tue, 4 Oct 2022 11:33:44 -0600
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
Message-ID: <YzxueNRODpry8L0/@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
 <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
 <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 05:50:49PM +0300, Serge Semin wrote:
> > 
> > This particular condition for hwmon is not something that prevents us from
> > making forward progress.
> 
> If you consider the hwmon functionality as optional (AFAIU you are),
> then just ignore the return value no matter the reason. 

That is not an option. This function does IO, and the controller may not be
usable on the other side of that, which means initialization must abort. We
can't just ignore errors; we just don't need to report errors that don't
prevent forward progress.

> If the problem
> caused the hwmon initialization process to fail turns to be critical
> it will be raised in some other place which is required for the NVME
> driver to work properly. Otherwise the hwmon module initialization may
> still cause the probe procedure to halt, which makes it not optional.
> That's what I meant when was saying about "the function and its
> caller semantics not implying that".
> 
> >  
> > > > The
> > > > driver can participate in memory reclaim, so failing on a low memory condition
> > > > can make matters worse.
> > > 
> > > Yes it can, so can many other places in the driver utilizing kmalloc
> > > with just GFP_KERNEL flag passed including on the same path as the
> > > nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> > > either finished or executed in background anyway in all cases. 
> > 
> > This path is in the first initialization before we've set up a namespace that
> > can be used as a reclaim destination.
> > 
> > > Don't
> > > really see why memory allocation failure is less worse in this case
> > > than in many others in the same driver especially seeing as I said
> > 
> > The other initialization kmalloc's are required to make forward progress toward
> > setting up a namespace. This one is not required.
> 
> Anyway what you say seems still contradicting. First you said that the
> hwmon functionality was optional, but the only error being ignored was
> the no-memory one which was very rare and turned to be not ignored in
> the most of the other places.

> Second you got to accept the second
> patch of the series, which introduced a one more kmalloc followed
> right after the first one in the same function nvme_hwmon_init(). 

My comments on this patch were intended to be applied to all similiarly added
uses.
