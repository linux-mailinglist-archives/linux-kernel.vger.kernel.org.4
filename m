Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD573334A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFPORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344911AbjFPORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:17:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4530DE;
        Fri, 16 Jun 2023 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=B/BeAODtPMJM5GYMY6qmn/c1+m2koEH73p+4kcHr2Ws=; b=0mXhPJ3d46GuL/LB90OVb5RNTq
        PxMBFFYYl7Wwq+kWXcSPVWoj/v1tlO0XfHW31jExBL6DD7cTQFtYGmvERB0HtlPmMkxjV468Maagw
        UXLN1OskCPQZYOYRT5KBcRRS3Qos8O3RXCwLIzAQzPdM+kxUrHvX0UGuqt7vwxCOPGlQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qAAFt-00GjBb-9p; Fri, 16 Jun 2023 16:16:49 +0200
Date:   Fri, 16 Jun 2023 16:16:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jianhui Zhao <zhaojh329@gmail.com>, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <037cfb16-0d40-47bc-bafe-7a1b3964d6ec@lunn.ch>
References: <20230614134522.11169-1-zhaojh329@gmail.com>
 <ZIwUFXOCCKZYSUBi@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIwUFXOCCKZYSUBi@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:49:41AM +0100, Russell King (Oracle) wrote:
> On Wed, Jun 14, 2023 at 09:45:22PM +0800, Jianhui Zhao wrote:
> > +static const struct attribute_group phy_dev_c45_ids_group = {
> > +	.name = "c45_ids",
> > +	.attrs = phy_c45_id_attrs
> > +};
> 
> One last thing - is there any point to creating these attributes if
> the PHY isn't c45?
> 
> We could add here:
> 
> 	.is_visible = phy_dev_c45_visible,
> 
> with:
> 
> static umode_t phy_dev_c45_visible(struct kobject *kobj,
> 				   struct attribute *attr, int foo)
> {
> 	struct phy_device *phydev = to_phy_device(kobj_to_dev(kobj));
> 
> 	return phydev->is_c45 ? attr->mode : 0;
> }
> 
> which will only show the c45 attributes if the PHY is a c45 PHY.
> 
> Andrew, any opinions?

There are PHYs which get detected via their C22 ID, but the driver
then uses C45. So phydev->is_c45 could be false yet the device does
have C45 IDs. But i don't see a good solution to this. If the point of
these values is to aid debugging matching devices to drivers, this
does not really matter. Its C22 ID is what will be used, and that
sysfs file will be populated.

So this .is_visible seems reasonable.

I suppose there is the flip condition. Do we want the C22 sysfs file
visible if there is no C22 ID? But that is probably ABI, we cannot
change it now.

   Andrew
