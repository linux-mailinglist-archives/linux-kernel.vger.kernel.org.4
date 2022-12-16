Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3A64EBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLPMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLPMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:53:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627A24979
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x5rJnMBsw+sgODTEHEKln64ytpOB5rN9K492KlVe/Dc=; b=BHfFUPNsPpmMsxwocnthf/T0nG
        mmvkGbF6x8uWtJl1SGmAGXGdmyc2ecHjtHPpWyvFXWVQ3iK78xAnmWgis/Y4jC2H5Nen7FrMuLw5X
        BNzn/3GnGG0SgdSq5tOu7ZD1HAGhn6SN+rrsWnx47bnDkih566c1gp4zDOSPVn9ojDVivbCTEyxQ9
        x2ufzLwyXpraQ34w7LyiHczvaub1KBLEeu+lyUNQ0SlgS/tplpUGsj998cFNOQZxMfKI57mxJMusm
        ydg/1S89NFrr+6MPjG/ihzxgRE6zYTupxVuATM4u45SKEzmLGxmaHUHTYs0bh4cpd6JNfASsefKbp
        L/z9Ykmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35740)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p6ADf-0007Jq-J4; Fri, 16 Dec 2022 12:53:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p6ADe-0000tw-Pc; Fri, 16 Dec 2022 12:53:42 +0000
Date:   Fri, 16 Dec 2022 12:53:42 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Stefan Wiehler <stefan.wiehler@nokia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESENDv2] arm: topology: Consider clock-frequency
 property from parent /cpus node
Message-ID: <Y5xqVmO9ZHWYW3Du@shell.armlinux.org.uk>
References: <20221216124157.13270-1-stefan.wiehler@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216124157.13270-1-stefan.wiehler@nokia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 16, 2022 at 01:41:58PM +0100, Stefan Wiehler wrote:
> +	cn = of_get_cpu_node(cpu, NULL);
> +	if (!cn)
> +		pr_err("missing device node for CPU %d\n", cpu);
> +	cn = of_get_parent(cn);

Doesn't this need to do an of_node_put()?

> +	if (!cn)
> +		pr_err("missing parent node for CPU %d\n", cpu);
> +	common_rate = of_get_property(cn, "clock-frequency", &common_rate_len);

And here too?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
