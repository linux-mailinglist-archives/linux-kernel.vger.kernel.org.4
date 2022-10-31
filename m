Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95BE6132C0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJaJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJaJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E2DDEA4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1483BB812A4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA16EC433D7;
        Mon, 31 Oct 2022 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667208649;
        bh=YUaMUT+y1DS8GEe/2s5XYv+66QzbLrUvEAKg+RlLAas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcyLFXzEzb51ObBFj5edtmJIMhemVpWqNdFLb5Vrco53qC6L2JJlJPRQZMts6qDyF
         OZJ+2R5amzFUvaYgWDUlLPGffKvkOIwIiGen7yQ8xoAYGqE4BPCnbpkoNfF2D/nvIk
         5N6Lp7vts4XeR8xqaXrrel6waJ2h2jJL0Rte4nr71oUXf5Vw1KjEDMS4qlTdr3IqwF
         +IE0REc7yPqaf2yuEFMzb9i/BgSXdAifCyphCcTg2Ykg2KX2kR8+80c4vgW8v8E1F4
         I+ZG06yoZprOSS0pRsTVZ8YKkFv5gSL5Z8vEvaX5Y1C6vUI2vSQ4Pzj7dEdVa342Ys
         nty91idJVoOXA==
Date:   Mon, 31 Oct 2022 09:30:44 +0000
From:   Lee Jones <lee@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
Message-ID: <Y1+VxDIyGlwClP5U@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
 <c7114aed1e21a6903137ba9288c4d6f6c429fded.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7114aed1e21a6903137ba9288c4d6f6c429fded.camel@nxp.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Liu Ying wrote:

> On Mon, 2022-10-17 at 15:57 +0800, Liu Ying wrote:
> > Freescale i.MX8qxp Control and Status Registers (CSR) module is a system
> > controller. It represents a set of miscellaneous registers of a specific
> > subsystem. It may provide control and/or status report interfaces to a
> > mix of standalone hardware devices within that subsystem.
> > 
> > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple power-managed
> > bus(i.MX8qxp pixel link MSI bus). To propagate power management operations
> > of the CSR module's child devices to that simple power-managed bus, add a
> > dedicated driver for the CSR module. Also, the driver would populate the CSR
> > module's child devices.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > The Freescale i.MX8qxp CSR DT bindings is at
> > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > 
> > Resend the patch based on v6.1-rc1.
> > 
> >  drivers/mfd/Kconfig           | 10 +++++++
> >  drivers/mfd/Makefile          |  1 +
> >  drivers/mfd/fsl-imx8qxp-csr.c | 53 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 64 insertions(+)
> >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> 
> [...]
> 
> Gentle ping...

Content-less pings will never be received well.

> Any comments please?

You're in the queue.

-- 
Lee Jones [李琼斯]
