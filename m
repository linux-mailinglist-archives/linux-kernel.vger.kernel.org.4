Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538AA73A157
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjFVNBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFVNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:01:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045161BD0;
        Thu, 22 Jun 2023 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=T+JzroaYPGRedMf7AobUJGzDjOZU8+KsM2kMdTfTlf0=; b=W9
        80D4Ah5R4ghyLS0x9i6GNslJ8+8KoA5MO5exWEQRoUUiGrhvoi2JVUFI4UbL4nBoAuk1GR0mdtE4Q
        FT1JQK3T7S1B2mmQOt0G2doX0QL9uYGT7GTRJlxJwLgKtFykmMt5uXjEsgeSdRrjgVC+B3nZ3civm
        Tx51DAeR8I1ffEY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCJvq-00HGSV-8b; Thu, 22 Jun 2023 15:01:02 +0200
Date:   Thu, 22 Jun 2023 15:01:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set
 function
Message-ID: <70f3b45f-7c57-4394-b96e-20a014718f5f@lunn.ch>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-2-paweldembicki@gmail.com>
 <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
 <CAJN1KkxGNZgzSA2_gVmMRg-LsZmZC2hQEvEjQQ3RSTT9ddGcAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkxGNZgzSA2_gVmMRg-LsZmZC2hQEvEjQQ3RSTT9ddGcAQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:38:22PM +0200, Paweł Dembicki wrote:
> śr., 21 cze 2023 o 21:33 Andrew Lunn <andrew@lunn.ch> napisał(a):
> >
> > > +     struct vsc73xx *vsc = ds->priv;
> > > +     /* FIXME: STP frames isn't forwarded at this moment. BPDU frames are
> > > +      * forwarded only from to PI/SI interface. For more info see chapter
> > > +      * 2.7.1 (CPU Forwarding) in datasheet.
> >
> > Do you mean the CPU never gets to see the BPDU frames?
> >
> > Does the hardware have any sort of packet matching to trap frames to
> > the CPU? Can you match on the destination MAC address
> > 01:80:C2:00:00:00 ?
> >
> 
> Analyzer in VSC73XX switches can send some kind of packages to (and
> from) processor via registers available from SPI/Platform BUS (for
> some external analysis).  In some cases it's possible to configure: if
> packet will be copied or forwarded to this special CPU queue.  But
> BPDU frames could be sent to processor via CPU queue only. So It's
> impossible to forward bridge control data via rgmii interface.

So am i correct in saying, if you actually enable STP, and it decides
to block a port, the BPDUs are also blocked. After a while it will
decide the peer has gone, and unblock the port. A broadcast storm will
then happen for a while, until a BPDU is received, at which point it
will block the port again.

     Andrew
