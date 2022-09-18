Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5049F5BBF1E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIRR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D7186C8;
        Sun, 18 Sep 2022 10:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D9D615B3;
        Sun, 18 Sep 2022 17:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB17C433C1;
        Sun, 18 Sep 2022 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663521984;
        bh=LFojQE3Tofgqym9S96rNzo5hxMzpgPxPJkTV1h+fBII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L2tBmmhEOVDk6M6LGlh/D76yQd9iS8OhTLshev0q8bd5fPOm7KnfnphFY/Lx3Th70
         u6p5p8mvvQ8R8cJtsR4Jfa/Uj8BJnHHUC/2mN0EN7Ftr5Ece4+A6TCcp6iWkUPrTr8
         8NZNGg10a/e14InFy32JuaL1A8VRtqthw7SGVq+odKjHxFv49bF+bl12fh3NAdE/qI
         VmHwWoRuIq01grHs+3vSD3LDTf8IBric47qJiLNG3nIM/8g18KBzEvAUf28roi0c97
         zBbOYgqT2grv+KyqMI2Ca0tINvA3vJPCoDVqWyWcyQIXDuinjPYGKyiNfDOlKT3Vgh
         JanupFjNjU2XQ==
Date:   Sun, 18 Sep 2022 18:26:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [v7 13/14] iio: imu: add BNO055 I2C driver
Message-ID: <20220918182626.00aae26d@jic23-huawei>
In-Reply-To: <CAN8YU5MbGWbE6nRBCs3gYwyN2yYk7OsmaQsTrZvJctQOhgLBng@mail.gmail.com>
References: <20220907132205.28021-1-andrea.merello@iit.it>
        <20220907132205.28021-14-andrea.merello@iit.it>
        <CAHp75Vdc8bAiqiUhEmgjNmcpY5s0fArTy26g2i0wH7srwY6RQA@mail.gmail.com>
        <CAN8YU5MbGWbE6nRBCs3gYwyN2yYk7OsmaQsTrZvJctQOhgLBng@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 08:42:01 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> > Hmm... It has my tag but I have noticed something to improve.  
> 
> One comment below, OK for the rest.
> 
> > ...
> >  
> > > +#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */  
> >
> > Can we elaborate what to fix and why it can't be fixed right now?  
> 
> Ah, this is a stale comment; I'll drop it..

I fixed up Andy's comments on this patch whilst applying.

Thanks,

Jonathan
