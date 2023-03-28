Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11D6CBB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjC1JkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC1Jjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3775BA5;
        Tue, 28 Mar 2023 02:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E206163C;
        Tue, 28 Mar 2023 09:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE24C4339B;
        Tue, 28 Mar 2023 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679996373;
        bh=Wd9Ay6SO5CAcXIM2nKfNytXszwXbA4x1Yllp/z8nE64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhDTMnACS8BU9XlDEHNeiGmsk2PXPK9tYvnPlubxps5rR6KJPQ9mr1nPpTspQwlSq
         oITu2u1ZCBeqO4BSPhNMswLSeK0zYfZqAfGn5RRpUqZbnJukr33dYgufTUL9G4a6DF
         PiDpKNWo2zE3fBsBh2ExB8rrK4pT2cIrVPDJQJaXMtiDPDf31xKJe+go5EItMzflQx
         WX73XNznOsacVlfXDzipjaVX91Y1AS+agNIAqYaWJi5qpe5NfkAEmw2Par0042S+9O
         H+HeVgrQw+YawW4rFgpDlrHqNtSu5AXOZrG/zU1iyYBjvK8+aQpbsemALDS/phicNT
         gI/KCpt10LDug==
Date:   Tue, 28 Mar 2023 11:39:29 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jannadurai@marvell.com,
        cchavva@marvell.com, Suneel Garapati <sgarapati@marvell.com>
Subject: Re: [PATCH 1/2] spi: octeontx2: Add support for octeontx2 spi
 controller
Message-ID: <20230328093929.qkg2oseuibot3afl@intel.intel>
References: <20230327180753.2279-1-pmalgujar@marvell.com>
 <20230327180753.2279-2-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327180753.2279-2-pmalgujar@marvell.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suneel,

[...]

> +static int tbi_clk_en = 1;

bool?

> +module_param(tbi_clk_en, uint, 0644);
> +MODULE_PARM_DESC(tbi_clk_en,
> +		 "Use Fixed Time Base 100MHz Reference Clock (0=Disable, 1=Enable [default])");

can we avoid using module parameters? You can have these defined
in device tree and you can also make sysfs interfaces, as well.

> +static int cfg_mode_delay = 30;
> +module_param(cfg_mode_delay, uint, 0644);
> +MODULE_PARM_DESC(cfg_mode_delay,
> +		 "Delay in micro-seconds for mode change in MPI CFG register (30 [default])");
> +
> +static void octeontx2_spi_wait_ready(struct octeontx2_spi *p)
> +{
> +	union mpix_sts mpi_sts;
> +	unsigned int loops = 0;
> +
> +	mpi_sts.u64 = 0;
> +	do {
> +		if (loops++)
> +			__delay(500);

mmhhh... why have you chosen __delay() ?

> +		mpi_sts.u64 = readq(p->register_base + OCTEONTX2_SPI_STS(p));
> +	} while (mpi_sts.s.busy);

[...]

> +	if (mpi_cfg.u64 != p->last_cfg) {
> +		p->last_cfg = mpi_cfg.u64;
> +		writeq(mpi_cfg.u64, p->register_base + OCTEONTX2_SPI_CFG(p));
> +		mpi_cfg.u64 = readq(p->register_base + OCTEONTX2_SPI_CFG(p));
> +		udelay(cfg_mode_delay); /* allow CS change to settle */

before "udelaying" anything that the user gives you, I would
check what cfg_mode_delay is.

Andi
