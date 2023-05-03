Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00F6F5B48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjECPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjECPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B903449B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5A0C62E5E
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3EBC433D2;
        Wed,  3 May 2023 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683128058;
        bh=gkPd8aDQYb0daSvr4xmJ+11gUtz98UqLKYxVlN45ATI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyO9bcnV+KsXcw5bg/cfFOEme1bnL7xc7MqPEXbMOUKtzM88oLWUsrPhUrA4voE0V
         K8bSrgyvRO5/XAoIIjykJHQx6y5VoOAtx2XrmHWOTuG6wH1RqokcSnkMHKmzWciqvk
         loE+0gnc0T7JWHrNoaXPWKI8d48lL4KCtBzmHU32qFzPCdxiVTHD/gU9yWoOtlf265
         AKOjBxNLLtLlu+e8e5+Xd3LsNqu7sPzI31Ar+fpl8OY5yM6+Uu/CthGjp2ElBXHeAT
         w5Of+AkRLiDPnKObpfEvA20SVksC7mI25EE9zSqtqQfaM+dUpaxuNiL2dMfuY0DSM2
         D/i0/sVVkgnRQ==
Date:   Wed, 3 May 2023 17:34:12 +0200
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
Message-ID: <ZFJ+9Ij+jOJO1+wu@kernel.org>
References: <20230502220818.691444-1-shenwei.wang@nxp.com>
 <20230502220818.691444-2-shenwei.wang@nxp.com>
 <6dff0a5b-c74b-4516-8461-26fcd5d615f3@lunn.ch>
 <PAXPR04MB9185BD38BA486104EE5B7213896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9185BD38BA486104EE5B7213896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 12:53:57PM +0000, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Tuesday, May 2, 2023 6:19 PM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: Wei Fang <wei.fang@nxp.com>; David S. Miller <davem@davemloft.net>;
> > Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > Paolo Abeni <pabeni@redhat.com>; Clark Wang <xiaoning.wang@nxp.com>; dl-
> > linux-imx <linux-imx@nxp.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> > Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> > <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Alexander
> > Lobakin <alexandr.lobakin@intel.com>; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: [EXT] Re: [PATCH v2 net 2/2] net: fec: restructuring the functions to
> > avoid forward declarations
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report this
> > email' button
> > 
> > 
> > On Tue, May 02, 2023 at 05:08:18PM -0500, Shenwei Wang wrote:
> > > The patch reorganizes functions related to XDP frame transmission,
> > > moving them above the fec_enet_run_xdp implementation. This eliminates
> > > the need for forward declarations of these functions.
> > 
> > I'm confused. Are these two patches in the wrong order?
> > 
> > The reason that i asked you to fix the forward declaration in net-next is that it
> > makes your fix two patches. Sometimes that is not obvious to people back
> > porting patches, and one gets lost, causing build problems. So it is better to have
> > a single patch which is maybe not 100% best practice merged to stable, and then
> > a cleanup patch merged to the head of development.
> > 
> 
> If that is the case, we should forgo the second patch. Its purpose was to
> reorganize function order such that the subsequent patch to net-next
> enabling XDP_TX would not encounter forward declaration issues.

I think a good plan would be, as I understood Andrew's original suggestion,
to:

1. Only have patch 2/2, targeted at 'net', for now
2. Later, once that patch has been accepted into 'net', 'net-next' has
   reopened, and that patch is present in 'net-next', then follow-up
   with patch 1/2, which is a cleanup.
