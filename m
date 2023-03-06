Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E216ABDE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCFLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCFLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:11:15 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC512886D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5W24hg8V6+9XmiKC0OundHSlZuYb8IjU3arczR9x17U=; b=DTYir6aaDo4hJYYmxL6XJzzdGW
        E85wttpF/dNNREYF5QBafssaZCMEjB9RYq1exNZGCsGeDKqshNULNmgdlnVVhqesNT/E3fHlGMFf/
        ruH7Czg/HE8IPpdfHjXEzlAl3HKZVg8F3zYMfC9rxe/gtoR3EZZTRMTXbekNl2VZ4HLMdtOZZ83Iv
        YEvtR2aYxhIiN6iulnvnwg4xL3Wowaiex3me/j8cchMIHYt+ZbXxuKirhAipgqoV2fyUKtH+R+I57
        JwUOlgzvuSnUbztQvgmapskvXd7XZ8GjDU9doYy6MqQXWxCsLHgZSECZzKJpMud6mlzDT4dY4DQTk
        SrUfE+Qw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52064)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pZ8jV-0005Yy-Rk; Mon, 06 Mar 2023 11:10:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pZ8jV-0000Ql-0p; Mon, 06 Mar 2023 11:10:21 +0000
Date:   Mon, 6 Mar 2023 11:10:20 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jungseung Lee <js07.lee@samsung.com>
Cc:     linus.walleij@linaro.org, amit.kachhap@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, js07.lee@gmail.com
Subject: Re: [PATCH 2/2] arm/mm : Report actual image regions in /proc/iomem
Message-ID: <ZAXKHDb4QY1awyRA@shell.armlinux.org.uk>
References: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
 <CGME20230306061057epcas1p17def087649be56b75c7830385ff2fb2f@epcas1p1.samsung.com>
 <1678081915-12599-2-git-send-email-js07.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678081915-12599-2-git-send-email-js07.lee@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:51:55PM +0900, Jungseung Lee wrote:
>  The resource reservations in /proc/iomem made for the kernel image did
>  not reflect the gaps between text, rodata, and data.
>  Add the "rodata" resource and update the start/end calculations.
> 
>  Before :
> 04000000-2f7fffff : System RAM
>   04100000-04cfffff : Kernel code
>   04e00000-05369a27 : Kernel data
> 
>  After :
> 04000000-2f7fffff : System RAM
>   04100000-049fffff : Kernel code
>   04a00000-04cb2fff : Kernel rodata
>   04e00000-05369a27 : Kernel data

NAK. This is API, and programs do read and parse this file. It is
important that this file reports these parameters in a similar way
to other architectures. Other architectures do not split up the
individual regions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
