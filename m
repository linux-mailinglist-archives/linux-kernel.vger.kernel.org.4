Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9978700341
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjELJCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbjELJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:02:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB5100FD;
        Fri, 12 May 2023 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mggnu95n/RU6DeRgS9ZUs2b/avyHGbZvVWNqilcNijI=; b=MDA2vJcmlGYWbAYVWlbKScMTRY
        vF42WVOhOikWSi9jWbuFHQ1JtHvU+8G0TGE1XfkmCbjSEXOLHOVHrIJ0VnEFagkOI1H6/No9N+j4O
        bWS5qIDeN9+7jVQqNBdeLLEQV9cJTPdrn4oc3QMb1vAo1q3WAOb/RI8dV//oqci/88ItYS0mRLrbH
        +M7Lf+sPQWMHsM3p8dndw1zrdtj6CtRmEQiaKmgMd2CouTyywvldb1/ivBWaaqPCMiFY/9Knc1vbG
        PprqPQeiksn1ahH0l/mpmcEBqq2Fmy6SrZeBdJJkTGwCi3hUQyxwK6WBxkmKQ1Fn44mlmFlEfHbeg
        WP/aYyOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35578)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pxOfA-00081X-H1; Fri, 12 May 2023 10:02:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pxOf7-0004vy-PP; Fri, 12 May 2023 10:02:05 +0100
Date:   Fri, 12 May 2023 10:02:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yan Wang <rk.code@outlook.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] net: mdiobus: Add a function to deassert reset
Message-ID: <ZF4AjX6csKkVJzht@shell.armlinux.org.uk>
References: <KL1PR01MB54486A247214CC72CAB5A433E6759@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR01MB54486A247214CC72CAB5A433E6759@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
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

On Fri, May 12, 2023 at 03:08:53PM +0800, Yan Wang wrote:
> +	gpiod_set_value_cansleep(reset, gpiod_is_active_low(reset));
> +	fsleep(reset_assert_delay);
> +	gpiod_set_value_cansleep(reset, !gpiod_is_active_low(reset));

Andrew, one of the phylib maintainers and thus is responsible for code
in the area you are touching. Andrew has complained about the above
which asserts and then deasserts reset on two occasions now, explained
why it is wrong, but still the code persists in doing this.

I am going to add my voice as another phylib maintainer to this and say
NO to this code, for the exact same reasons that Andrew has given.

You now have two people responsible for the code in question telling
you that this is the wrong approach.

Until this is addressed in some way, it is pointless you posting
another version of this patch.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
