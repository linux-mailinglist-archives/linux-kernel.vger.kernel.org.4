Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3870B8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjEVJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjEVJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:11:39 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C210D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mvntBB6S4OGDk0cblEN3QofRB9SrGuLJq25V60Cs1QI=; b=MmzvZFNipp1kcQ8t4CWw8qk3uj
        rAxuMiyX2e/NPYNHx3fPJC6dNDLeiVudzTnBJcmibbzxBqz+RLOFipZuDl5c/0580AI/AWAHuK/8j
        c9wSTEpwq97vUFrRmCrQ2HNpwiQ9DKW8sgRTvgERlde0fkjEP/aIR6JUBwG8Ji6YF3UIhrZpy78Av
        3yUDgBu2s9i9Twu23WcNCZywloaGYDZ6fVuzkcuyFcqOp24euJ2E9tryvWMKiHXmsqhXFWWp81dXq
        iWyIciJUGToRipqU5cD6xyOjBALBhG0t7H9MCzuePn5RqyWOe/dvpuFEVkSIC7DX5lvuFOLys71Xh
        X2AWzpbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42496)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q11Zb-0006MA-TV; Mon, 22 May 2023 10:11:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q11Zb-0007pE-2p; Mon, 22 May 2023 10:11:23 +0100
Date:   Mon, 22 May 2023 10:11:23 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: at91: pm: fix imbalanced reference counter for
 ethernet devices
Message-ID: <ZGsxuzyq5ZtRvptg@shell.armlinux.org.uk>
References: <20230518062511.2988500-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518062511.2988500-1-claudiu.beznea@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 09:25:11AM +0300, Claudiu Beznea wrote:
> WARNING: CPU: 0 PID: 378 at lib/refcount.c:25 0xc07ffc08
> refcount_t: addition on 0; use-after-free.
> Modules linked in:
> CPU: 0 PID: 378 Comm: sh Not tainted 6.1.22-linux4microchip-2023.04-rc3+ #7
> Hardware name: Microchip SAMA7
> Function entered at [<c010c134>] from [<c010993c>]
> Function entered at [<c010993c>] from [<c0823754>]
> Function entered at [<c0823754>] from [<c01162ac>]
> Function entered at [<c01162ac>] from [<c0116340>]
> Function entered at [<c0116340>] from [<c07ffc08>]
> Function entered at [<c07ffc08>] from [<c045fe88>]
> Function entered at [<c045fe88>] from [<c046004c>]
> Function entered at [<c046004c>] from [<c0141e94>]
> Function entered at [<c0141e94>] from [<c0142448>]
> Function entered at [<c0142448>] from [<c0140da8>]
> Function entered at [<c0140da8>] from [<c023dba0>]
> Function entered at [<c023dba0>] from [<c01d0700>]
> Function entered at [<c01d0700>] from [<c01d092c>]
> Function entered at [<c01d092c>] from [<c0100060>]

There is no point what so ever including the backtrace in your commit
message - the hex numbers here are specific to your kernel build and
are meaningless for everyone else.

Please either convert them to symbolic information so that they are
meaningful to other people, or omit them. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
