Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2C86C0DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCTJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCTJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:55:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339CC8A4C;
        Mon, 20 Mar 2023 02:55:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33B101257;
        Mon, 20 Mar 2023 10:55:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679306108;
        bh=EKjW1R7h+yja6osOOOMwfX4qtMew8wgQB1kQ/QcnDA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlYZ/6zgLyhtixQ1oN2VTaAMtAR1L/5xZ2gU8sHqJRjuYyyvFlzfrevArxn6EBg8n
         MNiqv+qNdc9xnj6mkJqrC2GTLFPyUmz4tLRYpvyceUzBIpohfgz9PW9D7ewY3RF7qe
         Q6hcyLO4w7IebBC51RZz6PeAiGyJz+WQ2r/SOjsw=
Date:   Mon, 20 Mar 2023 11:55:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <20230320095514.GF20234@pendragon.ideasonboard.com>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com>
 <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> Hi Laurent,
> 
> On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> > In a (simplified) nutshell,
> > 
> > ---------+     +----------+     +---------+     +-----+     +-----+
> > | Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> > | Sensor |     |          |     | Gasket  |     |     |     |     |
> > ---------+     +----------+     +---------+     +-----+     +-----+
> 
> Thank you, this is helpful.
> 
> I suppose the mux here at least won't actively do anything to the data. So
> presumably its endpoint won't contain the active configuration, but its
> superset.
> 
> > 
> > All those blocks, except for the gasket, have a node in DT.
> > 
> > The IPU driver needs to know the number of CSI-2 data lanes, which is
> > encoded in the data-lanes DT property present in both the sensor output
> > endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> > the pipeline.
> 
> This doesn't yet explain why the sensor would need to implement
> get_mbus_config if its bus configuration remains constant.

If I recall correctly, the IPU driver calls .g_mbus_config() on the
camera sensor to get the number of lanes, as it can't get it from its
own endpoint. That's a hack, and as Jacopo proposed, calling
.g_mbus_config() on the CSI-2 RX would be better, as the CSI-2 RX driver
can then get the value from its own endpoint, without requiring all
sensor drivers to implement .g_mbus_config().

> I suppose those blocks in between would probably need something to convey
> their active configuration from upstream sub-devices.

-- 
Regards,

Laurent Pinchart
