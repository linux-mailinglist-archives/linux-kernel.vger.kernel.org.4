Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8358C733243
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbjFPNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344375AbjFPNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:33:53 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB13592;
        Fri, 16 Jun 2023 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M46nk+xQMnki5q5tHbFlZVxQ1c0fpeb+0aLvaugATU4=; b=k72XIuyD++1/InJ/SNgA55+1eF
        9ddkF00eZerFQBQOXWtRjZ9tpWHfBJb0tpYPfS5IVjcuSMzaulsiC3mtZ27MMy7sS8euTCtXpgE+Q
        2/359qTlEf6g6rmYtSv/gU3f2nZqEYqXlt6vn9fYhreTH2bQsvixUcj64Iy4Q2KEY6ZsAZE4B5YhB
        EEXE0gJ8LcWz4PrjD2n5tzWEDJg7TQinzGgUKfib8O2d+xZNuafVX+1Y7UMtSPVRT6TNWiOCpRoY5
        kLAGShKWDjZWG8L2XiLOmpvyvC8wDfFFtb+Bg+s8jTII7pVr2wqG5nGLrMaPY1nqq2iMVj04PjNYx
        1AqA4sng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35844)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qA9aD-0005En-2a; Fri, 16 Jun 2023 14:33:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qA9aB-0002YG-6P; Fri, 16 Jun 2023 14:33:43 +0100
Date:   Fri, 16 Jun 2023 14:33:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <ZIxkt3VmmNY2zs1m@shell.armlinux.org.uk>
References: <20230616131246.41989-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616131246.41989-1-zhaojh329@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:12:46PM +0800, Jianhui Zhao wrote:
> +static umode_t phy_dev_c45_visible(struct kobject *kobj, struct attribute *attr, int foo)
> +{
> +	struct phy_c45_devid_attribute *devattr =
> +		(struct phy_c45_devid_attribute *)container_of(attr, struct device_attribute, attr);

1. (struct phy_c45_devid_attribute *) cast is not required.
2. we now have two places that we convert the attribute to a
   phy_c45_devid_attribute, it's time for a macro to do that.

> +	struct phy_device *phydev = to_phy_device(kobj_to_dev(kobj));
> +
> +	if (!phydev->is_c45 || phydev->c45_ids.device_ids[devattr->index] == 0xffffffff)

	if (!phydev->is_c45 ||
	    phydev->c45_ids.device_ids[devattr->index] == 0xffffffff)

And lastly... please don't be so quick to post a new version.

https://www.kernel.org/doc/html/v6.1/process/maintainer-netdev.html#i-have-received-review-feedback-when-should-i-post-a-revised-version-of-the-patches

Particularly the bit about "Do not post a new version of the code if the
discussion about the previous version is still ongoing, unless directly
instructed by a reviewer." is relevent.

You have not given enough time for Andrew to respond to my suggestion
which I invited him to (by "Andrew, any opinions?"), instead rushing
out v4 that implements my suggestion without first waiting to see if
Andrew agrees with it.

This seems to be becoming common place, so I think it's about time I
created a vim macro to insert a boilerplate explaining this process in
every review. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
