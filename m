Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4F5F2B69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJCIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJCIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D45555081;
        Mon,  3 Oct 2022 00:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D8D760FAC;
        Mon,  3 Oct 2022 07:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E71BC4347C;
        Mon,  3 Oct 2022 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664782787;
        bh=WmLowgdJ78JbzqOin+NSgjpKieVp5BaTxeF9w0oXdZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhyNmavZ1vg0OArINdCF5kljFRVfUbEssRnchDtZ3L3eOQZGdA12yuwgn8pgJL5sa
         GaJzf18B1ThrBg71RYuekgdA2B2nHv2N1ExKUtc2GeY2awxZiG/K95KAOap/CmzlPC
         vpD0bL9SbCJDIVXmUzg1hdV8jP4jYPj4pVPo+6VxJZ1Y7OyEhUfmI2BkQoRxk8GLAJ
         US5bR6dYewzuVkfRrWOG/nkPct6ypvO1p4hFqw1y9C9JN3WoNZSpPosCYDCNgjs4I/
         8V6cy/YPC3QEb4xf1tW5N2bFvmrgkeC/0awpmP7qJm9+mUdWP0GG1LkZEhpARCzrYq
         IrGa94uIWGquQ==
Date:   Mon, 3 Oct 2022 08:39:42 +0100
From:   Lee Jones <lee@kernel.org>
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH] mfd: Add support for UP board CPLD/FPGA
Message-ID: <YzqRvsfsREslOuW2@google.com>
References: <20221001090547.24899-1-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221001090547.24899-1-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Oct 2022, chengwei wrote:

> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control, onboard LEDs or CEC) through an on-board FPGA.
> 
> This mfd driver implements the line protocol to read and write registers
> from the FPGA through regmap. The register address map is also included.
> 
> The UP boards come with a few FPGA-controlled onboard LEDs:
> * UP Board: yellow, green, red
> * UP Squared: blue, yellow, green, red
> 
> The UP Boards provide a few I/O pin headers (for both GPIO and
> functions), including a 40-pin Raspberry Pi compatible header.
> 
> This patch implements support for the FPGA-based pin controller that
> manages direction and enable state for those header pins.
> 
> Partial support UP boards:
> * UP core + CREX
> * UP core + CRST02
> 
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> [merge various fixes]
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> Signed-off-by: chengwei <larry.lai@yunjingtech.com>
> ---
>  drivers/leds/Kconfig             |  10 +
>  drivers/leds/Makefile            |   1 +
>  drivers/leds/leds-upboard.c      |  90 ++++++
>  drivers/mfd/Kconfig              |   9 +
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/upboard-fpga.c       | 486 +++++++++++++++++++++++++++++++
>  include/linux/mfd/upboard-fpga.h |  53 ++++

Please separate the LED and MFD changes into their own patches.

>  7 files changed, 650 insertions(+)
>  create mode 100644 drivers/leds/leds-upboard.c
>  create mode 100644 drivers/mfd/upboard-fpga.c
>  create mode 100644 include/linux/mfd/upboard-fpga.h

-- 
Lee Jones [李琼斯]
