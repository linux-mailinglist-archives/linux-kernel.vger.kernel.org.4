Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896465EE21A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiI1QmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiI1QmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:42:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A1D4DD4;
        Wed, 28 Sep 2022 09:42:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 732B947C;
        Wed, 28 Sep 2022 18:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664383335;
        bh=7KA1n0RAEw+lqCsVliprwKrAzzAI6PKXJUVUTsE8vvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhf5yymccXEDElBwJIt9EVPsMTJhdaS+OPOIzhAFb0KKYTCWvhXBCXPVq0m0n32Sw
         rpu+rVv2WBSXKIBQc7SBwG+tCmDelTn/2MDcQNB+cLRLCfNdajVo7oyzBCQ5WlTJkW
         1v1iGNAwQSsnpksEPl/MA7pMSfUlB4hJOx2kwMsc=
Date:   Wed, 28 Sep 2022 19:42:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        git@xilinx.com, saikrishna12468@gmail.com
Subject: Re: [PATCH 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration
 support
Message-ID: <YzR5ZoAbaYONnmPS@pendragon.ideasonboard.com>
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <YzRvEPUWUXP4x7+h@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzRvEPUWUXP4x7+h@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 06:58:10PM +0300, Laurent Pinchart wrote:
> Hi Sai,
> 
> On Fri, Jun 17, 2022 at 04:16:55PM +0530, Sai Krishna Potthuri wrote:
> > This series update the Xilinx firmware, ZynqMP dt-binding and ZynqMP
> > pinctrl driver to handle 'output-enable' and 'bias-high-impedance'
> > configurations. As part of these configurations, ZynqMP pinctrl driver
> > takes care of pin tri-state setting.
> > Also fix the kernel doc warning in ZynqMP pinctrl driver.
> 
> I'm afraid this causes a regression :-( With this series applied, boot
> breaks with the following message being printed to the serial console:
> 
> Received exception
> MSR: 0x200, EAR: 0xFF180198, EDR: 0x0, ESR: 0x64
> 
> I've traced that to the probe of the UART, when it calls into the
> firmware to set pin MIO18 to high impedance. According to v1.7 of the
> ZynqMP registers reference (UG1087), there is no register at address
> 0xFF180198.
> 
> I am using the VCU TRD 2021.1 for testing. Does this series require a
> firmware update ? If so backward compatibility needs to be preserved.
> It's very late in the v6.0-rc cycle for a fix, a revert may be best at
> this point, to give us time to fix the issue properly.

I've now tested the VCU TRD 2022.1 (which AFAIK is the latest available
version), and the problem doesn't occue then. It thus seems this depends
on a firmware update, which is impractical at best for all old designs
:-(

> > Note: Resending the series as i see this series didn't went out due
> > to some issue with my mail client. Please ignore if this series is 
> > already received.
> > 
> > Sai Krishna Potthuri (4):
> >   firmware: xilinx: Add configuration values for tri-state
> >   dt-bindings: pinctrl-zynqmp: Add output-enable configuration
> >   pinctrl: pinctrl-zynqmp: Add support for output-enable and
> >     bias-high-impedance
> >   pinctrl: pinctrl-zynqmp: Fix kernel-doc warning
> > 
> >  .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml         |  4 ++++
> >  drivers/pinctrl/pinctrl-zynqmp.c                      | 11 +++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h                  |  5 +++++
> >  3 files changed, 20 insertions(+)

-- 
Regards,

Laurent Pinchart
