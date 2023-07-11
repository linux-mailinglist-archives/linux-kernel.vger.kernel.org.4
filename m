Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D682174F14A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjGKOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0546B0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE90614E5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED1CC433C7;
        Tue, 11 Jul 2023 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689084729;
        bh=NRBCd7EYg1Ttg7Sd52hrW/FKaUnozUqBArGH46pm5Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dv3ZPcOrttwlRQ7ym+XMaMprZg4jGyXAIcnMCZRSQeRCMr+rPOx+AR2x6FEX+gXnQ
         JsZ9nzbfIpxOMv7EyoXY5LJgHFl8NMwBFdr6qI/rnUm22VqNc+CWNgEThskgCZR0JZ
         9XOm7XCRs+H/vlnlGMQ5Vg0k9wAffpQtZ8WSlAYw=
Date:   Tue, 11 Jul 2023 16:12:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?utf-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <2023071135-opt-choosing-51dd@gregkh>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
 <20230711120609.GB27050@lst.de>
 <23017407-83eb-8fb0-5d91-2c7c4ae02544@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23017407-83eb-8fb0-5d91-2c7c4ae02544@grimberg.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:14:54PM +0300, Sagi Grimberg wrote:
> 
> > > Well, that "They keep pumping out more and more devices with the same
> > > breakage" and the "new device" comment from Pankaj below bear the
> > > question: should we stop trying to play "whack a mole" with all those
> > > quirk entries and handle devices with duplicate ids just like Windows does?
> > 
> > As far as I can tell Windows completely ignores the IDs.  Which, looking
> > back, I'd love to be able to do as well, but they are already used
> > by udev for the /dev/disk/by-id/ links.   Those are usually not used
> > on desktop systems, as they use the file system labels and UUIDs, but
> > that doesn't work for non-file system uses.
> > 
> > And all this has been working really well with the good old enterprise
> > SSDs, it's just that the cheap consumer devices keep fucking it up.
> > 
> > If we'd take it away now we'd break existing users, which puts us between
> > a rock and a hard place.
> 
> Maybe the compromise would be to add a modparam that tells the driver
> to ignore it altogether (like allow_bogus_identifiers) that would
> default to false. Then people can just workaround the problem instead
> of having the back-and-fourth with the vendor?
> 

Module parameters do not work on a per-device basis, sorry.  This isn't
the 1990's anymore, please do not attempt to add new ones :)

thanks,

greg k-h
