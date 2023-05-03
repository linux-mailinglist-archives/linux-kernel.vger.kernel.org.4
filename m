Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7366F5EE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjECTHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECTH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09677D8C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C7F762FA1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0920C433D2;
        Wed,  3 May 2023 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683140847;
        bh=v+P+/PX3TjpN24HnLhMA+gdDju8JpUR7dNJVSbynO7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heCwGJg1a8j9gEZnvDK9MSYpw2IWch2gK3oBWWIec3F4mxsyADM9tGsGtnifTVo/H
         sejlVC6YlRFOOtFAy03iHzwWNfxR+tl3AFuzLH5mQ9VIl0OuoskBLFGMDZXAZgDUXx
         XiT4hTs3GCI/BXwS0svV6VzYAm1FD586k5B7JSlTr7wiE+TbyXE5/9myA7JzQZm9a2
         mzk8quiBZHnDwwZ28RF3EgPwX8n3kl5AkRo+dl+24JMx2Ous0KiKz50KV120B9aTsx
         ftsxDIZUHnJtu9rWdSf64/qSkX0inUaeebY7DuvwpPn8rKVzdc3hexZELU05l+l3pO
         BBIXGxkc9Br/A==
Date:   Wed, 3 May 2023 21:07:18 +0200
From:   Simon Horman <horms@kernel.org>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH v2 net 2/2] net: fec: restructuring the
 functions to avoid forward declarations
Message-ID: <ZFKw5seP5WclDCG2@kernel.org>
References: <20230502220818.691444-1-shenwei.wang@nxp.com>
 <20230502220818.691444-2-shenwei.wang@nxp.com>
 <6dff0a5b-c74b-4516-8461-26fcd5d615f3@lunn.ch>
 <PAXPR04MB9185BD38BA486104EE5B7213896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZFJ+9Ij+jOJO1+wu@kernel.org>
 <PAXPR04MB918564D93054CEDF255DA251896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB918564D93054CEDF255DA251896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 06:41:59PM +0000, Shenwei Wang wrote:

...

> > > > On Tue, May 02, 2023 at 05:08:18PM -0500, Shenwei Wang wrote:
> > > > > The patch reorganizes functions related to XDP frame transmission,
> > > > > moving them above the fec_enet_run_xdp implementation. This
> > > > > eliminates the need for forward declarations of these functions.
> > > >
> > > > I'm confused. Are these two patches in the wrong order?
> > > >
> > > > The reason that i asked you to fix the forward declaration in
> > > > net-next is that it makes your fix two patches. Sometimes that is
> > > > not obvious to people back porting patches, and one gets lost,
> > > > causing build problems. So it is better to have a single patch which
> > > > is maybe not 100% best practice merged to stable, and then a cleanup patch
> > merged to the head of development.
> > > >
> > >
> > > If that is the case, we should forgo the second patch. Its purpose was
> > > to reorganize function order such that the subsequent patch to
> > > net-next enabling XDP_TX would not encounter forward declaration issues.
> > 
> > I think a good plan would be, as I understood Andrew's original suggestion,
> > to:
> > 
> > 1. Only have patch 2/2, targeted at 'net', for now 2. Later, once that patch has
> > been accepted into 'net', 'net-next' has
> >    reopened, and that patch is present in 'net-next', then follow-up
> >    with patch 1/2, which is a cleanup.
> 
> So should I re-submit the patch? Or you just take the 1st patch and drop
> the 2nd one?

net and net-next work on a granularity of patch-sets.
So I would suggest re-submitting only patch 2/2 for 'net'.

I would also suggest waiting 24h between posting v2 and v3,
as per https://kernel.org/doc/html/next/process/maintainer-netdev.html

