Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B747122FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbjEZJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbjEZJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:05:45 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF93112C;
        Fri, 26 May 2023 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WfyvF+/NECwYo9ZudJFD/DZL9T1Xq6mvSda7aihRN9s=; b=SGlbDl7+BOB8Rof4kWDOWcR6FX
        jerwkKmwBd/A5c5M5S0eJv9W3sjxeOhBI0op7H03b1s8Tc6n1Bdh79i0dYyBjDvSUqf1SR9Wouwnb
        VLRLaBhjJNGC3ddzth67g0dxqQx2JlbT0lB/jsJ9Y1STQNAOa4IyflcRiqio7xCfFlm311YqfXYtj
        08IjIPPt12qJkyPvoEwy+KoTR2VNjiNi898K8v6PCka8B4AhnUw2XnaJTnqpg9wMILClI12GBvD1L
        HUIaxEhIaTbhVrJ+aVLYvqW5+/vdQcf3ck+YWyOdFXkNjiLGvpfVVXTPRTlOcU+7B78rPb23ip3Q+
        AY9/qlrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45018)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q2TNz-0005G2-4j; Fri, 26 May 2023 10:05:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q2TNt-0003an-Sm; Fri, 26 May 2023 10:05:17 +0100
Date:   Fri, 26 May 2023 10:05:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Mark Brown <broonie@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Subject: Re: [PATCH net-next v3 2/4] net: ethernet: altera-tse: Convert to
 mdio-regmap and use PCS Lynx
Message-ID: <ZHB2Tfn9yZPs6l56@shell.armlinux.org.uk>
References: <20230526074252.480200-1-maxime.chevallier@bootlin.com>
 <20230526074252.480200-3-maxime.chevallier@bootlin.com>
 <ZHBwLBnKacQCG2/U@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBwLBnKacQCG2/U@corigine.com>
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

On Fri, May 26, 2023 at 10:39:08AM +0200, Simon Horman wrote:
> On Fri, May 26, 2023 at 09:42:50AM +0200, Maxime Chevallier wrote:
> > The newly introduced regmap-based MDIO driver allows for an easy mapping
> > of an mdiodevice onto the memory-mapped TSE PCS, which is actually a
> > Lynx PCS.
> > 
> > Convert Altera TSE to use this PCS instead of the pcs-altera-tse, which
> > is nothing more than a memory-mapped Lynx PCS.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Hi Maxime,
> 
> I have some concerns about the error paths in this patch.

We've had similar problems with mdio_device_create() vs the XPCS
driver.

I think it's time that we made this easier for users.

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index b87c69c4cdd7..802222581feb 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1240,6 +1240,7 @@ struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	if (!xpcs)
 		return ERR_PTR(-ENOMEM);
 
+	mdio_device_get(mdiodev);
 	xpcs->mdiodev = mdiodev;
 
 	xpcs_id = xpcs_get_id(xpcs);
@@ -1272,6 +1273,7 @@ struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	ret = -ENODEV;
 
 out:
+	mdio_device_put(mdiodev);
 	kfree(xpcs);
 
 	return ERR_PTR(ret);
@@ -1280,8 +1282,33 @@ EXPORT_SYMBOL_GPL(xpcs_create);
 
 void xpcs_destroy(struct dw_xpcs *xpcs)
 {
+	mdio_device_put(mdiodev);
 	kfree(xpcs);
 }
 EXPORT_SYMBOL_GPL(xpcs_destroy);
 
+struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
+				    phy_interface_t interface)
+{
+	struct mdio_device *mdiodev;
+	struct dw_xpcs *xpcs;
+
+	mdiodev = mdio_device_create(bus, addr);
+	if (IS_ERR(mdiodev))
+		return ERR_CAST(mdiodev);
+
+	xpcs = xpcs_create(mdiodev, interface);
+
+	/* xpcs_create() has taken a refcount on the mdiodev if it was
+	 * successful. If xpcs_create() fails, this will free the mdio
+	 * device here. In any case, we don't need to hold our reference
+	 * anymore, and putting it here will allow mdio_device_put() in
+	 * xpcs_destroy() to automatically free the mdio device.
+	 */
+	mdio_device_put(mdiodev);
+
+	return xpcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
+
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 1d7d550bbf1a..537b62330c90 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -108,6 +108,16 @@ int mdio_driver_register(struct mdio_driver *drv);
 void mdio_driver_unregister(struct mdio_driver *drv);
 int mdio_device_bus_match(struct device *dev, struct device_driver *drv);
 
+static inline void mdio_device_get(struct mdio_device *mdiodev)
+{
+	get_device(&mdiodev->dev);
+}
+
+static inline void mdio_device_put(struct mdio_device *mdiodev)
+{
+	mdio_device_free(mdiodev);
+}
+
 static inline bool mdio_phy_id_is_c45(int phy_id)
 {
 	return (phy_id & MDIO_PHY_ID_C45) && !(phy_id & ~MDIO_PHY_ID_C45_MASK);

The same for pcs-lynx. That way we remove the need for driver authors
to get the creation and destruction of the mdio device correct
without messing up the existing users - they only have to worry about
creating the PCS via the xxx_create_mdiodev() function and destroying
it via xxx_destroy().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
