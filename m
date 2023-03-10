Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2336B3E95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCJMC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCJMCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:02:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC98E7754;
        Fri, 10 Mar 2023 04:02:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C56461376;
        Fri, 10 Mar 2023 12:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A34C433D2;
        Fri, 10 Mar 2023 12:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678449735;
        bh=8DW/LYgCUONCctCnDq4qvjU4rdTwW+KdDdND0ium5HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZl6N5bDfdbh6CPz85FEB6qbTu6Q7lOXXLptgxaiNH3G7i6a4gZn4rcr+WUJ8zzfv
         UfSAtEW1lb3I/cC6fZ68b65Krs6uBQW360w6uYLRJwbl82vn/rd5nejjzTMOSivJBw
         A1sPZA2Qb5ale9462b3nypNpkAInDPOl9mfl5X88V5QPgiFVIqHE6ELYz8lBoNSaZ/
         /u+h2V3UC0pAYYX+Ak8cwnTrxLE4ufIgTnnVHQvEeIpfp90cFTQrqLZSBOjr/nf61C
         CYsWgvfrOak/DoO6G2tozKa1/K54PUqfueD7SEC9W7JgnIzysZ0u08Nf1iLcpmKKs3
         ETURGC2UF2wAQ==
Date:   Fri, 10 Mar 2023 17:32:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Fabio Porcedda <fabio.porcedda@gmail.com>
Cc:     Slark Xiao <slark_xiao@163.com>, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Revert "Add a secondary AT
 port to Telit FN990"
Message-ID: <20230310120209.GB6838@thinkpad>
References: <20230310101715.69209-1-slark_xiao@163.com>
 <20230310103126.GA6838@thinkpad>
 <CAHkwnC_S_qPOfkoJ-uZ7GNW4J26AXik=33f2=uMfw72yFOFXLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHkwnC_S_qPOfkoJ-uZ7GNW4J26AXik=33f2=uMfw72yFOFXLg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:33:56AM +0100, Fabio Porcedda wrote:
> Il giorno ven 10 mar 2023 alle ore 11:31 Manivannan Sadhasivam
> <mani@kernel.org> ha scritto:
> >
> > On Fri, Mar 10, 2023 at 06:17:15PM +0800, Slark Xiao wrote:
> > > This reverts commit 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.
> > > There are 2 commits with commit message "Add a secondary AT
> > > port to Telit FN990". But the last one 2d5253a096 was added
> >
> > Btw, we usually refer the commit SHA by 12 digits. Like, 2d5253a096c6.
> > I can fix it up while applying.
> >
> > > on Foxconn devices. Actually the second AT port of Foxconn
> > > devices doesn't work in PCIe mode. And the commit message
> > > mismatch with the changes. So we need to remove it.
> > >
> >
> > Sigh... the subject itself was wrong :( thanks for catching.
> >
> > > Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >
> > For future Foxconn patches, please help with the review to catch issues like
> > this. Unfortunately, I do not own any Foxconn modems :/
> >
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Reviewed-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> 
> Just to clarify, the original patch change just the Telit FN990:
> https://lore.kernel.org/netdev/CAMZdPi8gGrbkKnDR+WLadF92shJbwH-ksQY+dbpgfZ21iAp9ug@mail.gmail.com/
> 
> The problem is caused by the fact that it was merged two times and the
> second time was merged wrongly.
> The correct one is commit 479aa3b0ec2e000ac99dd0661936d9685d6cac64 and
> the wrong one is 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.
> 

Ah, so the patch was merged into netdev first and then through MHI, then git
ended up with a resolution :(

Thanks,
Mani 

> BR
> Fabio
> 
> > Thanks,
> > Mani
> >
> > > ---
> > >  drivers/bus/mhi/host/pci_generic.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> > > index 6e13c43a84d1..91d02f84ba21 100644
> > > --- a/drivers/bus/mhi/host/pci_generic.c
> > > +++ b/drivers/bus/mhi/host/pci_generic.c
> > > @@ -343,8 +343,6 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
> > >       MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
> > >       MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> > >       MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> > > -     MHI_CHANNEL_CONFIG_UL(92, "DUN2", 32, 1),
> > > -     MHI_CHANNEL_CONFIG_DL(93, "DUN2", 32, 1),
> > >       MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
> > >       MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
> > >  };
> > > --
> > > 2.34.1
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> 
> 
> 
> -- 
> Fabio Porcedda

-- 
மணிவண்ணன் சதாசிவம்
