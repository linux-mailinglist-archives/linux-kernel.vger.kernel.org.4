Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95806F913A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjEFKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjEFKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:35:39 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B472BA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ij+1FzzEw0ym9IbkYj6bEJ+/bJ6G7Dj6d3TKP9aE6jo=; b=WIjEsXlFHZ1WekLHRfCNWc8M6g
        DxA2APOp5AQ+giFx4VMXtU+rtZFa89Hz8mMCXPQMgSKQ+pYlQnU+VK9hFhUtD6gk0nEz2aNABNTII
        yEd0iIqRVLL3Lp9Gs4MtwHT3VfqzTkJ9CwxOcZXxQhCfQWaU0WwSkR/3WBWLnpNI6evh+9XCf7kLo
        wcQ71htCvigcqR6zXCoJUbPbN7S0BgpGdEQNQP+2k2yw8NAnrvenjAK+Gq7bp4+mGRr20AS78ZqKz
        7Ci/tWEEUaDhfEXy8NdU09jUiNm1yhKxGu9Ag2t9HO+5r/HGXxh9n4u7Qo0QXrKXL84HjpzRLLMQ9
        zxRZqnmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59408)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pvFGI-0007hM-6H; Sat, 06 May 2023 11:35:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pvFGG-0004yS-5s; Sat, 06 May 2023 11:35:32 +0100
Date:   Sat, 6 May 2023 11:35:32 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     ye.xingchen@zte.com.cn
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mm: use bitmap_zero() API
Message-ID: <ZFYtdB4KB7+q5tk1@shell.armlinux.org.uk>
References: <202305061635221161194@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305061635221161194@zte.com.cn>
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

On Sat, May 06, 2023 at 04:35:22PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> bitmap_zero() is faster than bitmap_clear(), so use bitmap_zero()
> instead of bitmap_clear().

Maybe in theory, but as NUM_USER_ASIDS is a power of two (256),
and therefore both start and nbits are aigned to BITMAP_MEM_ALIGNMENT,
bitmap_clear() will call memset().

The only difference between the two are that bitmap_zero() doesn't
involve the compiler working out that it can call memset() (which
will be worked out at compile time not run time).

So, I doubt that this change makes any difference what so ever to the
generated code, and thus this change is just for change sake. In
other words, it's just useless churn.

Thanks anyway.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
