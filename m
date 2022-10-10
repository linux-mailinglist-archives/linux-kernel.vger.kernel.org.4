Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BF5FA191
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJJQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJJQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:06:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678982624
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t3g1v5ZZ5rh9HioeyTcJutznI+Yd/lJFzFx2I7x8Z0U=; b=1CrS8UMlauySYX1rpIBVaWrbtA
        PWmbQCpv3Ts79b8AbBlNhD1wb/rrs6VfyimxCtkp3DiIK7zOXDK3bhkF//GAqfgxikHlRdyX69aBT
        8ALUFu25R19rJsdXoqpP8CSSRtoe2IbIfCpwdOekoPBy9kLZgx4+Cv0eJ26knZYqYv2T9f2GEdE7Q
        TAiG54bYT0jq+5cuv0AgqITBwS1rEpyR56aO6UK53cBsEZVU8t5i94rylQS8upOG+pQRqh/bBvpTI
        CY3twNnDtgDWWxhyu+WGIf7HNHp9R4le/2cFiAjh2C6Ss5SKfR4wXmT/d6M2rtCSNJPMkdVqmM6E7
        0upnqoAw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34666)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ohvHn-0004rI-NR; Mon, 10 Oct 2022 17:05:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ohvHn-0001y0-3L; Mon, 10 Oct 2022 17:05:47 +0100
Date:   Mon, 10 Oct 2022 17:05:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
Message-ID: <Y0RC213QSASPZekQ@shell.armlinux.org.uk>
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010095346.1957-2-thunder.leizhen@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:53:45PM +0800, Zhen Lei wrote:
> Fix the following warnings:
>  warning: incorrect type in initializer (different address spaces)
>     expected unsigned short [noderef] __user *register __p
>     got unsigned short [usertype] *
>  warning: cast removes address space '__user' of expression

I have a general principle that not all warnings should be fixed,
especially when it comes to sparse.

The aim is not to get to zero warnings - it's to get to a point where
the code is correct, and plastering the code with __force casts means
it isn't correct - you're just masking the warning.

So no, I really don't like this. And I really don't like seeing
__force being used in open code in casts.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
