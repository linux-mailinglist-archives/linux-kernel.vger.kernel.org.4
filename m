Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FDD658F66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiL2RKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiL2RKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:10:18 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CEA12AFE;
        Thu, 29 Dec 2022 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=n24bHX1gBmth/ET2IDQOYpiSkmQVrPxAGfP6M/8nc2s=; b=pY
        oR+h6jn+ue96AoT9FoSc7Jzv8kunLFBq6D0sbwOozRllNSJj2+UQm4ZQVOrXMs3w6/pl1MFx85Ci6
        ZLu7n6OjpxS60eIZUZOc7XTZIFeUVDzzIA984AIbhB9YrJ0sJm+JUNMhH4bFO/TR503r24kSRtLhN
        EPkKSZUusWqQjFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pAwPw-000iHz-IQ; Thu, 29 Dec 2022 18:10:08 +0100
Date:   Thu, 29 Dec 2022 18:10:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?Q?Micha=C5=82?= Grzelak <mig@semihalf.com>
Cc:     linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mw@semihalf.com, upstream@semihalf.com, mchl.grzlk@gmail.com
Subject: Re: [PATCH v2] ARM: dts: dove.dtsi: Move ethphy to fix schema error
Message-ID: <Y63J8PGch6nRLQIg@lunn.ch>
References: <20221228200234.86391-1-mig@semihalf.com>
 <Y6zuJrb+8j+XCksN@lunn.ch>
 <CADcojVPnZYtNHJUsLJCcHTnG=j0dfCbDNRqf2xmhcmV3b-oGfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADcojVPnZYtNHJUsLJCcHTnG=j0dfCbDNRqf2xmhcmV3b-oGfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 03:14:47PM +0100, Michał Grzelak wrote:
> Hi Andrew,
> 
> Thanks for quick reply.
> 
> On Thu, Dec 29, 2022 at 2:32 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Wed, Dec 28, 2022 at 09:02:34PM +0100, Michał Grzelak wrote:
> > > Running 'make dtbs_check' with schema in net/marvell,orion-mdio.yaml
> > > gives the following warnings:
> > > mdio-bus@72004: Unevaluated properties are not allowed
> > > ('ethernet-phy' was unexpected)
> > >       arch/arm/boot/dts/dove-cubox.dtb
> > >       arch/arm/boot/dts/dove-cubox-es.dtb
> > >       arch/arm/boot/dts/dove-d2plug.dtb
> > >       arch/arm/boot/dts/dove-d2plug.dtb
> > >       arch/arm/boot/dts/dove-dove-db.dtb
> > >       arch/arm/boot/dts/dove-d3plug.dtb
> > >       arch/arm/boot/dts/dove-sbc-a510.dtb
> > > Fix them by removing empty ethphy subnode from dove.dtsi and describe
> > > PHY on the relevant board .dts files level.
> >
> > I don't think your description is correct. What i think is causing the
> > problem is that the ethphy subnode in dove.dtsi does not have an @X.
> >
> 
> Yes, it is exactly the case. The problem is after adding dummy address
> e.g. ethernet-phy@0 in dove.dtsi 'make dtbs_check' shows warnings
> about missing required 'reg' property, that's why ethernet-phy is
> moved to .dts files.
> 
> > By moving it into the .dts file, you can then give it the correct @1,
> > or @3, which makes the linter happy. The kernel itself does not care
> > about this, it is an example of the linter being much more strict than
> > the kernel.
> >
> > If you agree with me, please update the description.
> 
> This patch exactly fixes this issue by setting proper
> ethernet-phy@<reg value> in board files.
> In such a case would you like me to update the commit message to
> better describe the change or do you have other remarks to the diff?

I would like the description to actually describe the problem, that
the linter allows ethernet-phy@X but not ethernet-phy. You description
does not make any sense to me, it is not an empty node which is
causing the problem, but that node is expected to have an @X.

	Andrew
