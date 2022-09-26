Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B865E9ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiIZKOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiIZKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:13:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15FDC4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2tkAUDQhqX2MUEa67IDFMo3NC6iPlLEfNVovQdjsDkQ=; b=Zp3G3RMI9vngezfV6YpVxFwi9y
        CHe1zfHC57xMs875E2OOSaAqL7MX3h0KraU11DTe2GCUK2a/xpjesT3frvle23GcxhIN2qeqFoVHF
        fcxOgXquwG0AxGHq7r8+oaOiTPQgvSCp8ENGae8gHZIHI6y2lhTXIBF2BmaUPALN6rV0+6qrRK/6u
        lZhGjN37MVsLKS+/GpoP+dN9iBFXTtB4T9yIgh68fcYs3Cx4JyYNeHIS1cTZmBTSee6mdYWWN4oj8
        yE0ACi3T534ONw3rt28QGyqrcQaT1VGXSDq3NAUA6oZaAlciV6SH/9pk7Iee03cHmJz3apeGP0Ny7
        NL6IN8UA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34494)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ocl7Y-0000LO-2n; Mon, 26 Sep 2022 11:13:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ocl7X-00054A-GG; Mon, 26 Sep 2022 11:13:51 +0100
Date:   Mon, 26 Sep 2022 11:13:51 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: mm: Provide better fault message for permission
 fault
Message-ID: <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
References: <20220919103845.100809-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919103845.100809-1-wangkefeng.wang@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 06:38:45PM +0800, Kefeng Wang wrote:
> If there is a permission fault in __do_kernel_fault(), we only
> print the generic "paging request" message which don't show
> read, write or excute information, let's provide better fault
> message for them.

I don't like this change. With CPUs that do not have the ability to
relocate the vectors to 0xffff0000, the vectors live at address 0,
so NULL pointer dereferences can produce permission faults.

I would much rather we did something similar to what x86 does:

        pr_alert("#PF: %s %s in %s mode\n",
                 (error_code & X86_PF_USER)  ? "user" : "supervisor",
                 (error_code & X86_PF_INSTR) ? "instruction fetch" :
                 (error_code & X86_PF_WRITE) ? "write access" :
                                               "read access",
                             user_mode(regs) ? "user" : "kernel");

As we already print whether we're in user or kernel mode in the
register dump, there's no need to repeat that. I think we just
need an extra line to decode the FSR PF and write bits.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
