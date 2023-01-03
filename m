Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFF165C035
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjACMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjACMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:03 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B322CD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZaHND2LIe18ZX8Nyvi0cT4E76kdV89XTyg9t2stIFjg=; b=polUZinCdMNuV/UaKXheRK93sZ
        d6ZFz+UxhFc6r61eswtpUQvRK2jURTG2CY/1OlT0lcAaHFTyi1SDOLCfTznUJH0QTXAy2S3auA4Sp
        CYlQPrC4jgaA3BphQ7sKzzk1RCI6MIsT7/YyoPDZT1VwFZ7HfUpl0HEaCDL5yeV+oV3aknzMULVPj
        v9Rj4s+54EchY3T0JT4ejh5vx4qqI3hvqq6GscqbCJBvQOZB3jGbcCGgt2D6ZQZy6vA8q/i+J2/iV
        hEnNI0aad8ymva0lEbd731lhyF84uhM10rnrlmFSoOV4dX+PAHzsWN0gyBkLS9BM8Bj2iABC6z+7s
        mJsemxlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35928)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pCgiw-0005Ic-Dw; Tue, 03 Jan 2023 12:48:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pCgis-00024q-Uk; Tue, 03 Jan 2023 12:48:54 +0000
Date:   Tue, 3 Jan 2023 12:48:54 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] nvmem: fix registration vs use race
Message-ID: <Y7QkNpGF92X5hUz6@shell.armlinux.org.uk>
References: <E1pCdoY-0044aT-A5@rmk-PC.armlinux.org.uk>
 <bad6a162-3e82-2f5e-1822-23951b61450b@linaro.org>
 <Y7QVh8/LPQ7H8ehp@shell.armlinux.org.uk>
 <a1143ca2-9460-f156-58a7-66072034559c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1143ca2-9460-f156-58a7-66072034559c@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 12:42:49PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 03/01/2023 11:46, Russell King (Oracle) wrote:
> > On Tue, Jan 03, 2023 at 11:30:36AM +0000, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 03/01/2023 09:42, Russell King (Oracle) wrote:
> > > > The i.MX6 CPU frequency driver sometimes fails to register at boot time
> > > > due to nvmem_cell_read_u32() sporadically returning -ENOENT.
> > > > 
> > > > This happens because there is a window where __nvmem_device_get() in
> > > > of_nvmem_cell_get() is able to return the nvmem device, but as cells
> > > > have been setup, nvmem_find_cell_entry_by_node() returns NULL.
> > > > 
> > > > The occurs because the nvmem core registration code violates one of the
> > > > fundamental principles of kernel programming: do not publish data
> > > > structures before their setup is complete.
> > > > 
> > > > Fix this by making nvmem core code conform with this principle.
> > > > 
> > > how about a Fixes tag and Cc stable?
> > 
> > Which commit do you suggest? This error goes all the way back to the
> > inception of nvmem, commit
> > 
> > eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> > 
> > but clearly its going to be a lot of effort to backport it all the
> > way due to all the changes.
> 
> I understand the backport issue, On the other hand as this a real issue
> backporting to atleast stable kernels would be worth.

I'll add this commit as a fixes tag, but I don't have the ability to
test backports of this, since the use of nvmem on imx6 platforms is
relatively recent. How do you suggest we end up with tested backports
for stable trees?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
