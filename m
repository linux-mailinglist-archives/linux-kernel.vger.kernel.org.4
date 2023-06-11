Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25D72B281
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFKPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:40:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A46E52;
        Sun, 11 Jun 2023 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=RutoNArEYQZGN8ybN4ls2X8dqBM+4ETZYWHrF3/MlLc=; b=dQsIEdTzVTPMgWe7x7aysmw8ku
        NIB9djGQCEFlOLZU5VEDYAE/dUHbV82rgZFeKM+5hMU8+lhymalHrbDYZLswvF/+RAXy0NDl1sdIv
        zwLEwYWQ1qzA07k4utVq0oAChWPMDGnJuwB4+cXIbgHKRjsUoTqDnktCihgui78fRZQ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8NAy-00FVnq-Ee; Sun, 11 Jun 2023 17:40:20 +0200
Date:   Sun, 11 Jun 2023 17:40:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <310bf56a-f2dc-4c2d-a7fe-f90b419cdccd@lunn.ch>
References: <20230611152743.2158-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611152743.2158-1-zhaojh329@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 11:27:43PM +0800, Jianhui Zhao wrote:
> If a phydevice use c45, its phy_id property is always 0, so
> this adds a phy_c45_ids sysfs attribute to MDIO devices. This
> attribute can be useful when debugging problems related to
> phy drivers.

> +	for (i = 1; i < num_ids; i++) {
> +		if (phydev->c45_ids.device_ids[i] == 0xffffffff)
> +			continue;
> +
> +		ret += sprintf(buf + ret, "%d: 0x%.8lx\n", i,
> +			(unsigned long)phydev->c45_ids.device_ids[i]);
> +	}

https://www.kernel.org/doc/html/next/filesystems/sysfs.html says:

  Attributes should be ASCII text files, preferably with only one
  value per file. It is noted that it may not be efficient to contain
  only one value per file, so it is socially acceptable to express an
  array of values of the same type.

How about putting all 32 values in a subdirectory, one file per MMD?

Please also remember to document the attributes in
Documentation/ABI/testing/sysfs-class-net-phydev.

    Andrew
