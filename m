Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDCE72A111
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjFIRQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFIRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:16:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81097E4A;
        Fri,  9 Jun 2023 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fJHuQ8zacvpe7ZvXvHuaj0SxXvb3ZjOuhHjQXHcZ+tc=; b=mBz5wKWg4QpH7XJ7Um49Ge35eK
        21DL30tvw1vdJEcJM4x7mEM3JRl7ClTuABp7L1eX3yXFf7YfJEZgfRS7KujAduEaLEAQb0DXL6X67
        EUHo0181Ghca2uYi9fsz+QAV9TD8dPenVCHeaOxSPTVnGDFHgF+zUq+Psc0aMlyjd478=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q7fiW-00FMuM-A0; Fri, 09 Jun 2023 19:16:04 +0200
Date:   Fri, 9 Jun 2023 19:16:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: implement egress tbf
 qdisc for 6393x family
Message-ID: <176f073a-b5ab-4d8a-8850-fcd8eff65aa7@lunn.ch>
References: <20230609141812.297521-1-alexis.lothore@bootlin.com>
 <20230609141812.297521-3-alexis.lothore@bootlin.com>
 <d196f8c7-19f7-4a7c-9024-e97001c21b90@lunn.ch>
 <dbec77de-ee34-e281-3dd4-2332116a0910@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbec77de-ee34-e281-3dd4-2332116a0910@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I can do that (or maybe -EINVAL to match Vladimir's comment ?). I think
> it's worth mentioning that I encountered an issue regarding those values during
> tests: I use tc program to set the tbf, and I observed that tc does not even
> reach kernel to set the qdisc if we pass no burst/latency value OR if we set it
> to 0. So tc enforces right on userspace side non-zero value for those
> parameters, and I have passed random values and ignored them on kernel side.

That is not good. Please take a look around and see if any other
driver offloads TBF, and what they do with burst.

> Checking available doc about tc-tbf makes me feel like that indeed a TBF qdisc
> command without burst or latency value makes no sense, except my use case can
> not have such values. That's what I struggled a bit to find a proper qdisc to
> match hardware cap. I may fallback to a custom netlink program to improve testing.

We don't really want a custom application, since we want users to use
TC to set this up.

Looking at the 6390 datasheet, Queue Counter Registers, mode 8 gives
the number of egress buffers for a port. You could validate that the
switch has at least the requested number of buffers assigned to the
port? There is quite a bit you can configure, so maybe there is a way
to influence the number of buffers, so you can actually implement the
burst parameter?

      Andrew
