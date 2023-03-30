Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14F6CFE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC3Ifq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjC3IfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:35:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F36EA5;
        Thu, 30 Mar 2023 01:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E8EAB82682;
        Thu, 30 Mar 2023 08:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB43C433EF;
        Thu, 30 Mar 2023 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680165313;
        bh=VexdsD+y0VorUzO1MJy7DQZ7xA7FoNIWym8yR4KmJ4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0qsid/tmIiqipI6TTO1pmVAFTJ5IAuwfkPXVuXigieT2h1COo7U8zUF/yjFQWvnqv
         4sVpN25psc6F3OU2NBmE6ce+cZJTYaXz0P2l2A4jXNPo+If619sul0c8rrQIIYD3wu
         80UWeRkhSG8VsRJy+8pjFCRDtlok8OiQegg/aRys=
Date:   Thu, 30 Mar 2023 10:35:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: Re: [PATCH v5 4/4] misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM
Message-ID: <ZCVJv-erahM_Jdug@kroah.com>
References: <20230330082006.11216-1-jpanis@baylibre.com>
 <20230330082006.11216-5-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330082006.11216-5-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:20:06AM +0200, Julien Panis wrote:
> This PFSM controls the operational modes of the PMIC:
> - STANDBY and LP_STANDBY,
> - ACTIVE state,
> - MCU_ONLY state,
> - RETENTION state, with or without DDR and/or GPIO retention.
> Depending on the current operational mode, some voltage domains
> remain energized while others can be off.
> 
> This PFSM is also used to trigger a firmware update, and provides
> R/W access to device registers.

What userspace code uses these new ioctls?  Do you have a pointer to it
anywhere?

> --- /dev/null
> +++ b/include/uapi/linux/tps6594_pfsm.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace ABI for TPS6594 PMIC Pre-configurable Finite State Machine
> + *
> + * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
> + */
> +
> +#ifndef __TPS6594_PFSM_H
> +#define __TPS6594_PFSM_H
> +
> +#include <linux/const.h>
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* PFSM state definitions */
> +enum pfsm_state {
> +	PMIC_ACTIVE_STATE,
> +	PMIC_MCU_ONLY_STATE,
> +	PMIC_RETENTION_STATE
> +};
> +
> +/**
> + * struct pmic_state - PMIC state identification
> + * @state:   PFSM destination state
> + * @options: options for destination state
> + */
> +struct pmic_state {
> +	enum pfsm_state state;
> +	__u8 options;
> +};
> +
> +/* Commands */
> +#define	PMIC_BASE			'P'
> +
> +#define	PMIC_GOTO_STANDBY		_IO(PMIC_BASE, 0)
> +#define	PMIC_GOTO_LP_STANDBY		_IO(PMIC_BASE, 1)
> +#define	PMIC_UPDATE_PGM			_IO(PMIC_BASE, 2)
> +#define	PMIC_SET_STATE			_IOW(PMIC_BASE, 3, struct pmic_state)
> +
> +/* Options for destination state */
> +#define PMIC_GPIO_RETENTION		_BITUL(0)
> +#define PMIC_DDR_RETENTION		_BITUL(1)
> +#define PMIC_MCU_ONLY_STARTUP_DEST	_BITUL(2)

Please read Documentation/driver-api/ioctl.rst which says:

* Bitfields and enums generally work as one would expect them to,
  but some properties of them are implementation-defined, so it is
  better to avoid them completely in ioctl interfaces.

For a brand-new ioctl interface, you did both of these unrecommended
things.  Why set yourself for complexity when you do not need to?

thanks,

greg k-h
