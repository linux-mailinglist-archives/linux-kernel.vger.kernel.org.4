Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0770E6ABDAE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCFLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCFLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:06:24 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0823851
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6+2f3w3qpSci3gVKHyFWRQcLrRTY51VgoSMXT3tTuOI=; b=TtS5a+0/C37z+jl+vgVW7Gy/S8
        jwVoyB8rRNThETM1HU0RWHyCTEVAv/US9tT+8tJhjh6lLnPEE8ciV/l0qOPknSSAf0iL99oCBbGgI
        4iLpwdKhfejWuePBUiVUli+NQIOJGc0Bvkek8kWOOuyFlPU0H4M5W9ITxA4llp/JPWS71keFtuFea
        z7KdgIIpIU5iiFXSHtXqIGpAv5esj54iH9RvZuxMt46D+kvy1NhnaS7fzVo/5tXhXRuwh5nUyX7BT
        pOhGJfz1Mhsj8bcfMhp+wXcW74S21zC6t/VG1i4SJn1od0V1bMK6utnC/AHwI62cprRkh73yVQMVC
        wHnp4wzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56512)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pZ8fR-0005YT-6N; Mon, 06 Mar 2023 11:06:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pZ8fN-0000Pp-Nx; Mon, 06 Mar 2023 11:06:05 +0000
Date:   Mon, 6 Mar 2023 11:06:05 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jungseung Lee <js07.lee@samsung.com>
Cc:     linus.walleij@linaro.org, amit.kachhap@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, js07.lee@gmail.com
Subject: Re: [PATCH 1/2] arm/mm : omit [_text, _stext) from kernel code region
Message-ID: <ZAXJHbHAhD42o36F@shell.armlinux.org.uk>
References: <CGME20230306061055epcas1p1f7718c46c10f84845e086f9ce9f9a41f@epcas1p1.samsung.com>
 <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:51:54PM +0900, Jungseung Lee wrote:
> The resource reservations in /proc/iomem made for the kernel code did
> not reflect the gaps between pagetable and text.
> 
> In particular, if the CONFIG_STRICT_KERNEL_RWX option is turned on,
> the wrong area is shown as the kernel code area.
> 
> Fix it by removing [_text, _stext) from kernel code region.
> 
> Before:
> 04000000-2f7fffff : System RAM
>   04008000-04cfffff : Kernel code
>   04e00000-05369a27 : Kernel data
> 
> After :
> 04000000-2f7fffff : System RAM
>   04100000-04cfffff : Kernel code
>   04e00000-05369a27 : Kernel data

And why do you think this is correct? Isn't the head text, which
isn't discarded and is located at 0x04008000, still part of kernel
code?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
