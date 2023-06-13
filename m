Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE772E8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjFMQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjFMQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:47:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF5EC;
        Tue, 13 Jun 2023 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MPlFvYbPj0zRiedZYtDVq48XcSin/HHiLDsLfTxEPjs=; b=bzyyuuO1wXO4P6JhJ8fvVxGi0C
        E73zFPqLI9Qy4PwXztTntyzzFk59hF8bYeUqsagBIbnYTWUXVlCTObrBG+7zXTF/3CU+0EfdlalRp
        RDsX5suYs027TjZG0LqE5/eV/UiV8/YCd6CNp7jQN8pSeFU+pIw66VeLTZb9dcoY17EBi1atvad0o
        SkEFlW3OSxiL7H3+n2JRPhm+IXwzjcXaSuo7hMMobf1WwH4ckm+sgIoEeSsge2bGFDJovhPcX1CmN
        QGZblBFVaqmzJ/aF+UlWIrqAUlZ50b2w75iBgUySnv3ZCsx3d0c0P2TnaP9B+Jrs1T1j4yu/HKicU
        oGWkF/dQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35810)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q97BI-0000O8-51; Tue, 13 Jun 2023 17:47:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q97BG-0006Bw-3D; Tue, 13 Jun 2023 17:47:42 +0100
Date:   Tue, 13 Jun 2023 17:47:42 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jianhui Zhao <zhaojh329@gmail.com>, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <ZIidrqudxBaOva90@shell.armlinux.org.uk>
References: <20230613143025.111844-1-zhaojh329@gmail.com>
 <612d5964-6034-4188-8da5-53f3f38a25e4@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612d5964-6034-4188-8da5-53f3f38a25e4@lunn.ch>
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

On Tue, Jun 13, 2023 at 06:18:58PM +0200, Andrew Lunn wrote:
> > +#define DEVICE_ATTR_C45_ID(i) \
> > +static ssize_t \
> > +phy_c45_id##i##_show(struct device *dev, \
> > +	struct device_attribute *attr, char *buf) \
> > +{ \
> > +	struct phy_device *phydev = to_phy_device(dev); \
> > +\
> > +	if (!phydev->is_c45) \
> > +		return 0; \
> > +\
> > +	return sprintf(buf, "0x%.8lx\n", \
> > +		(unsigned long)phydev->c45_ids.device_ids[i]); \
> > +} \
> 
> That is not the most efficient implementation.
> 
> You can have one generic
> 
> static ssize_t phy_c45_id_show(struct device *dev, char *buf, int i)
> {
> 	struct phy_device *phydev = to_phy_device(dev);
> 
> 	if (!phydev->is_c45)
> 		return 0;
> 
> 	return sprintf(buf, "0x%.8lx\n",
> 		      (unsigned long)phydev->c45_ids.device_ids[i]);
> }
> 
> And then your macros becomes
> 
> #define DEVICE_ATTR_C45_ID(i)			  \
> static ssize_t					  \
> phy_c45_id##i##_show(struct device *dev,	  \
> 	struct device_attribute *attr, char *buf) \
> {						  \
> 	return phy_c45_id_show(dev, buf, i);	  \
> }
> 

I have a further suggestion, which I think will result in yet more
efficiencies:

struct phy_c45_devid_attribute {
	struct device_attribute attr;
	int index;
};

#define to_phy_c45_devid_attr(attr) \
	container_of(attr, struct phy_c45_devid_attribute, attr)

static ssize_t phy_c45_id_show(struct device *dev,
			       struct device_attribute *attr, char *buf)
{
	struct phy_c45_devid_attribute *devattr = to_phy_c45_devid_attr(attr);
	struct phy_device *phydev = to_phy_device(dev);
	unsigned long id;

	if (!phydev->is_c45)
		return 0;

	id = phydev->c45_ids.device_ids[devattr->index];

	return sprintf(buf, "0x%.8lx\n", id);
}

#define DEVICE_ATTR_C45_ID(i) \
static struct phy_c45_devid_attribute dev_attr_phy_c45_id##i = { \
	.attr = { \
		.attr   = { .name = __stringify(mmd##i), .mode = 0444 }, \
		.show   = phy_c45_id_show \
	}, \
	.index = i, \
}

which will probably result in less code size for a little larger data
size. Note that the references to this would need to be:

	&dev_attr_phy_c45_id1.attr.attr

in the array (adding an extra .attr).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
