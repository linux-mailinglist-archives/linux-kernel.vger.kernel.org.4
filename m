Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3846F69AF90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBQPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBQPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:32:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487786FF10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:32:26 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1pT2ii-0000fo-9L; Fri, 17 Feb 2023 16:32:20 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1pT2ic-0006Rh-25; Fri, 17 Feb 2023 16:32:14 +0100
Date:   Fri, 17 Feb 2023 16:32:14 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
        frattaroli.nicolas@gmail.com, heiko@sntech.de,
        jacob-chen@iotwrt.com, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
Message-ID: <20230217153214.GB28242@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
        Shengyu Qu <wiagn233@outlook.com>, devicetree@vger.kernel.org,
        ezequiel@vanguardiasur.com.ar, frattaroli.nicolas@gmail.com,
        heiko@sntech.de, jacob-chen@iotwrt.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de
References: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
 <TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230217110413.GA28242@pengutronix.de>
 <TY3P286MB2611256E28AF951F2B38A5B098A19@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611256E28AF951F2B38A5B098A19@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengyu,

On Fri, 17 Feb 2023 22:14:13 +0800, Shengyu Qu wrote:
> Seems we could use GFP_DMA32 flag to limit memory required by driver into
> upper size range(actually using ZONE_DMA32 configured by device tree). Just
> some driver modification needed. 

I don't think the GFP_DMA32 flag works with DmaBuf import. The buffer may be
allocated by some other driver that is able to address more than 4G and
imported into the RGA driver. In this case, limiting the allocations is not
enough, but we would still need error handling in the map function for buffers
that cannot be addressed by the RGA.

I guess we need both, a limit for the allocation and error checking for the
map.

Michael

> Maybe Nicolas could help testing? I would
> 
> like to fix this, but I don't have much free time these days.
> 
> Best regards,
> 
> Shengyu
> 
> > Hi,
> > 
> > On Sun, 22 Jan 2023 00:50:37 +0800, Shengyu Qu wrote:
> > > Since we have the over-4GB problem now, should we mark this problem as a
> > > TODO or something?
> > I am not really sure where to put such a TODO to make it visible for people
> > that are running into the issue and to make sure that it is removed once it is
> > fixed.
> > 
> > Maybe it would be better to add error handling to the rga_buf_map function to
> > fail if the address of the buffer that should be mapped has the upper 32 bit
> > set and print a warning. Furthermore, the driver would be able to skip the
> > buffer and prevent potential memory corruption caused by the erroneous
> > mapping.
> > 
> > Unfortunately, I don't have hardware that allows me to test this.
> > 
> > Michael
