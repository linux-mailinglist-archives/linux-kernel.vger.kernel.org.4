Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA972E845
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbjFMQT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbjFMQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:19:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6842E92;
        Tue, 13 Jun 2023 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kSo7oxYAqeqzQOt2hOKeJJzZZSXVTeK57hiOvOHIciQ=; b=axPXUCBs4qxP5Eq6uAZ6LSiMiv
        ZM1H4K0fxuyqvb6mQmMwTYoYn2MC8ajhvI5l9CbSq2Us51zYo7BSziWZj0hZW66h5N/36k2/5z3Bt
        RsNPNlSK4HFvXz/ICq3lXjelSCDOJmVT1nMQevaVL3GcgaoR5fYaYVyiQB+Sr8OQcVcU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q96jT-00Fk4W-0P; Tue, 13 Jun 2023 18:18:59 +0200
Date:   Tue, 13 Jun 2023 18:18:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <612d5964-6034-4188-8da5-53f3f38a25e4@lunn.ch>
References: <20230613143025.111844-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613143025.111844-1-zhaojh329@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define DEVICE_ATTR_C45_ID(i) \
> +static ssize_t \
> +phy_c45_id##i##_show(struct device *dev, \
> +	struct device_attribute *attr, char *buf) \
> +{ \
> +	struct phy_device *phydev = to_phy_device(dev); \
> +\
> +	if (!phydev->is_c45) \
> +		return 0; \
> +\
> +	return sprintf(buf, "0x%.8lx\n", \
> +		(unsigned long)phydev->c45_ids.device_ids[i]); \
> +} \

That is not the most efficient implementation.

You can have one generic

static ssize_t phy_c45_id_show(struct device *dev, char *buf, int i)
{
	struct phy_device *phydev = to_phy_device(dev);

	if (!phydev->is_c45)
		return 0;

	return sprintf(buf, "0x%.8lx\n",
		      (unsigned long)phydev->c45_ids.device_ids[i]);
}

And then your macros becomes

#define DEVICE_ATTR_C45_ID(i)			  \
static ssize_t					  \
phy_c45_id##i##_show(struct device *dev,	  \
	struct device_attribute *attr, char *buf) \
{						  \
	return phy_c45_id_show(dev, buf, i);	  \
}

	Andrew

---
pw-bot: cr
