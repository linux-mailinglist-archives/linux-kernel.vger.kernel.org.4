Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7E606713
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJTRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165D1DC080
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E6361C54
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40DCC433D6;
        Thu, 20 Oct 2022 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666287195;
        bh=MjfXHu4FwW4pFzBtnl6lMUktQ3H3soNGx30H6Dzd9Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zq4ZAAabNJscRP66mSuU8O63pzSvwwB97XEfaNo0Ni9noqKWNMsVWimqlIT2yIEEQ
         NBF/nDgJ/d5km1glw51d8h07wstKtW99U3/ReZfC/5xwukeX8uSa0O073zMt3zptdo
         sowmWhhZRAl6RcZy9TsPv1qPO4b7S6+BrOaJ1eiyBBUJeHa7HtHwE0dpnD0pi6a9OF
         8/T1nUtD0N6YHZnZdXcKDN9wPzKfgB4sGwUvWOKrv2VmZmucBjiMF5VVAtOr61oqS6
         URBwHj2E0UAhqs37apsDLDepxXrOniBQIO6D4VuD15xRav5c7G7SCh78o/074XBFsW
         1SEV8vX9WlIww==
Date:   Thu, 20 Oct 2022 11:33:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ken Lin <ken_lin5@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        michael.jao@quanta.corp-partner.google.com, derekhuang@google.com,
        chi-jen.chen@quanta.corp-partner.google.com,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/1] nvme-pci: disable write zeros support on WD SSDs
Message-ID: <Y1GGWOzAvZe4tj/d@kbusch-mbp.dhcp.thefacebook.com>
References: <20221014083058.1451914-1-ken_lin5@hotmail.com>
 <TYAPR03MB3085DD9F15177F126E9DF7C6AE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
 <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:15:56AM -0700, Doug Anderson wrote:
> On Fri, Oct 14, 2022 at 1:32 AM Ken Lin <ken_lin5@hotmail.com> wrote:
> >
> > Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> > Write Zeroes command"), Western Digital has the same issue:
> > [ 6305.633887] blk_update_request: operation not supported error,
> > dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES)
> > flags 0x0 phys_seg 0 prio class 0
> >
> > So also disable Write Zeroes command on Western Digital.
> >
> > Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
> > ---
> >
> >  drivers/nvme/host/pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 3a1c37f32f30..5c1b812a3c2b 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
> >                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> >         { PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
> >                 .driver_data = NVME_QUIRK_BOGUS_NID, },
> > +       { PCI_DEVICE(0x15b7, 0x501e),   /* Sandisk 2280 NVMe SSD  */
> > +               .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> 
> So I'm not really an expert and don't really have the context, but you
> CCed me and so I took a quick glance.
> 
> Something smells a little fishy. ${SUBJECT} talks about disabling
> "write zeros". The patch description talks about disabling "Write
> Zeroes". The patch you reference seems to disable "write zeros" by
> setting the quirk NVME_QUIRK_DISABLE_WRITE_ZEROES. ...but the contents
> of your patch doesn't seem to match. Instead it adds the quirk
> NVME_QUIRK_NO_DEEPEST_PS.
> 
> As I said, I'm not an expert and maybe everyone will tell me that it
> all makes sense, but it seems weird.

You're right: this patch does not make sense with the subject!
