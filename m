Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8067449B9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGAObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGAObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:31:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47FC35AB;
        Sat,  1 Jul 2023 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=UrDZd01sY17XlPpwW8xUpVN2IB66JmwiqhYlu+kmtRQ=; b=g4Ja9GZy2jHlncKMd7gzAhhx6+
        n7kqR7ool2GLwQldH2udK0P8VRqNLHxvz0Hj8ec9zXPArf0DDiCUx9cRcpbIyvgZI6NtvBws52OU+
        2QYCozry/7SqpsOu9xJljfjioUolX7uN3LqBbo8dRRMlZVLWKXvrVZdkuP61YTlWXU8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qFbcZ-000N7J-I4; Sat, 01 Jul 2023 16:30:43 +0200
Date:   Sat, 1 Jul 2023 16:30:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: phy: at803x: support qca8081 1G chip type
Message-ID: <3e0477e6-f96e-4842-a0c2-b2cb744ee83a@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-2-quic_luoj@quicinc.com>
 <48e41540-6857-4f61-bcc5-4d0a6dbb9ec1@lunn.ch>
 <b735b442-8818-c66e-5498-9faa2e4984f2@quicinc.com>
 <c2e8eeac-7e2b-48fa-bdf8-fa036e40a8a2@lunn.ch>
 <bcedc53f-9393-2bd5-4f37-5a3f02c41887@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcedc53f-9393-2bd5-4f37-5a3f02c41887@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There are MMD device 1, 3, 7 in qca8081 PHY, the PMA abilities
> 10/100/1000/2500 are compliant with genphy_c45_pma_read_abilities, but the
> MDIO_AN_STAT1_ABLE does not exist in MMD7.1 register.
> 
> so the genphy_c45_pma_read_abilities can't be fully supported by qca8081
> phy, sorry for this misunderstanding.

If all you are missing is MDIO_AN_STAT1_ABLE, then i assume you are
missing Autoneg? So have your tried using
genphy_c45_pma_read_abilities() and then just doing:

                        linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
                                         phydev->supported);

with a comment explaining why.

	Andrew					 
