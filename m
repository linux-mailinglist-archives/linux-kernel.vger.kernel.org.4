Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384BF5EAB14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiIZPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbiIZPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:30:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044051EAE7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rhmwAa3yjvJEAtWrZIFUSXTAZj6LNMHdXMY1MRcUVwo=; b=Xxmx7kKKB1tsGVdyE48THLkO4x
        giNesbp2ujEN48oFnmeyCreegaQ6+m4bIzQ1+Gre4+NYFBroVLvqMwLxEF60nUxgaWrHDUglzVrrS
        8rmzuFiP0mVuO632RfDCzMxbFJjg2D3gAPva2VStpYlrbcSgxGy1PLKhhxj9C8xkSIxXArN1hIjZE
        6kJuQHBEDbN1lZpY7IiR6ddxf8NedRp2t49xIM+9LexIROQL4jlDsYxk5t5dcspoa54SZWwGzgYuf
        tR2fr9MhEv19cjgNfDhBqvf4y0uVJDA+9kx2fVnH443+9AEx3BIJBgwLUtG9VVXYHdzO++V9VTc2f
        ZHRg56PQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34500)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ocot7-0000cH-SW; Mon, 26 Sep 2022 15:15:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ocot3-0005CR-Fg; Mon, 26 Sep 2022 15:15:09 +0100
Date:   Mon, 26 Sep 2022 15:15:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: mm: Provide better fault message for permission
 fault
Message-ID: <YzGz7QnI0EwGheqj@shell.armlinux.org.uk>
References: <20220919103845.100809-1-wangkefeng.wang@huawei.com>
 <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
 <6fc308aa-a0ac-3f0e-b484-352512ad6793@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc308aa-a0ac-3f0e-b484-352512ad6793@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:26:50PM +0800, Kefeng Wang wrote:
> 
> On 2022/9/26 18:13, Russell King (Oracle) wrote:
> > On Mon, Sep 19, 2022 at 06:38:45PM +0800, Kefeng Wang wrote:
> > > If there is a permission fault in __do_kernel_fault(), we only
> > > print the generic "paging request" message which don't show
> > > read, write or excute information, let's provide better fault
> > > message for them.
> > I don't like this change. With CPUs that do not have the ability to
> > relocate the vectors to 0xffff0000, the vectors live at address 0,
> > so NULL pointer dereferences can produce permission faults.
> The __do_user_fault(), do_DataAbort() and do_PrefetchAbort() shows
> the FSR when printing, we could do it in die_kernel_fault(), and
> which will be easy for us to check whether the page fault is permision
> fault,

We print the hex value already in the oops:

Internal error: Oops: (fsr hex value) [#num] ...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
