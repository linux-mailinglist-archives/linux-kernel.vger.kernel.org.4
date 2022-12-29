Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F265883C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiL2BG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiL2BG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:06:56 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5AD13D76;
        Wed, 28 Dec 2022 17:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=r8S+2+1FZWy59YIIbl64G7IjD9qpeWhTPs6TR1Ry090=; b=PrYXOeC2KTiyVJl1ncrgb5e2n9
        aX7JdiJWT9iNn94I2vPz0MbPgd+ig0r5W2+4YEHFKJMcVc9lre2J54J3zVARIbGZTpyOXif5uI4Fl
        +NsW9hFZ5j7BJ7xNL8zimTGiUlPv2C/t7e1f68d23HcRLKxHYI+H06LgHRIECZcByhAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pAhNb-000g1W-1R; Thu, 29 Dec 2022 02:06:43 +0100
Date:   Thu, 29 Dec 2022 02:06:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang =?utf-8?B?KOm7hOW9qik=?= <Biao.Huang@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: mt8195: Add Ethernet controller
Message-ID: <Y6zoI3XYnFFbN/Z5@lunn.ch>
References: <20221228063331.10756-1-biao.huang@mediatek.com>
 <20221228063331.10756-3-biao.huang@mediatek.com>
 <Y6xrNAyvJhP22RdF@lunn.ch>
 <a3959ffb49cd8ab2f3b0fad5149c222b08fc2032.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3959ffb49cd8ab2f3b0fad5149c222b08fc2032.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is the PHY integrated into the SoC, or on the board?
> The PHY is on the board, an external device as to SoC.
> >
> > You also don't need the compatible, if the PHY correctly implements
> > the ID registers.
> But without the compatible, it seems PHY driver will not be attached.
> How should I do? Thanks in advance.

Check what happens in mdiobus_scan() and get_phy_device(). When it
reads registers 2 and 3, does it get valid ID register contents?

      Andrew
