Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376C612310
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJ2MyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2MyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E060961750;
        Sat, 29 Oct 2022 05:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AD360A6A;
        Sat, 29 Oct 2022 12:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475C1C433C1;
        Sat, 29 Oct 2022 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667048061;
        bh=tRSGboT9HfbW6usCNnc8KAfNitwKrg6obJLTXnSR+Cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mftKKVoNUvEpYmo4CFy9y045V/KCam9EHtFebQIMWXjCyx4g6fhufDGZuDrQqDyqu
         Jnsw+ui5BXrICpOY9JY9AiHcDDIlldOS+VnfzuHk+h6fTYTLQRRqZTLNNLobsMHC0v
         4xJQ4LKMHG888ycm473ef7qeHIB2gqkrimkZxElhx3sCdo2CoAy77/l8AXDx/MhpLH
         mRfotTRSeSAKnuPcAudlWw5n/O2+jWSzhoVQ5AzGy0ygAiaUbMFv11vOntvLjV8Wu0
         OVuYhGNyz7YagaDsdJi8MaUB+UtLoQrxo7rEGvVpyBRNp3PSjpPBgK+rUgC3WAmFt1
         TCSfO9QahVPvg==
Date:   Sat, 29 Oct 2022 20:54:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/9] media: i2c: ov5645 driver enhancements
Message-ID: <20221029125412.GX125525@dragon>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pQJP1DMZvdioZF@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pQJP1DMZvdioZF@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 09:32:20AM +0000, Sakari Ailus wrote:
> Hello,
> 
> On Wed, Oct 26, 2022 at 02:06:49PM +0100, Prabhakar wrote:
> >   ARM: dts: imx6qdl-pico: Drop clock-names property
> >   ARM: dts: imx6qdl-wandboard: Drop clock-names property
> >   arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock-names
> >     property
> 
> Are Freescale/Renesas arch maintainers fine with me taking these patches
> or should they be merged through another tree?

Go ahead to take i.MX DTS patches:

Acked-by: Shawn Guo <shawnguo@kernel.org>
