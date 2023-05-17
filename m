Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705ED7072C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjEQUL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:11:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8010E7C;
        Wed, 17 May 2023 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ncx1qH8n9sOF9FCZslMLbmv0w/78dVsCubBVxxWQ9gE=; b=nSy+KBG+i376ssgh15Q3xm7H/w
        3XNzbdDbyv1xjXNJE9FqV1X823Zjg4sm5tlDoULoBWhxToyEPKex3bV+xciamtVV9ORTyzikMYpps
        /3yzuoNysIx1dzYZqZ7lBAcWpq7FAj2O1McNtBR59TKUEC6UutvH3haEp5gBXb0AhqPE3crcl8lws
        SCMQe5UbPEKFvYxHgtZWonSPhO4WFmhwCcZxwjaOrMomeKjkfQYH5kuaY/0kuMnw95LGkpwdQY/Cy
        IqJICTQ7OrF+7Lx9+UjSL4Rjz93GF4KrVp/c5nklaEu8l5bPjgBFG1YTWd58IVJDDBplB2oBy3yqN
        vJ0QN9xg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53498)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pzNUP-0000B4-8p; Wed, 17 May 2023 21:11:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pzNUM-0002Lp-1y; Wed, 17 May 2023 21:11:10 +0100
Date:   Wed, 17 May 2023 21:11:10 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yeqi Fu <asuk4.q@gmail.com>
Cc:     mw@semihalf.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] net: mvpp2: Fix error checking
Message-ID: <ZGU03muIumVDu0Gt@shell.armlinux.org.uk>
References: <20230517190811.367461-1-asuk4.q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517190811.367461-1-asuk4.q@gmail.com>
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

On Thu, May 18, 2023 at 03:08:11AM +0800, Yeqi Fu wrote:
> The function debugfs_create_dir returns ERR_PTR if an error occurs,
> and the appropriate way to verify for errors is to use the inline
> function IS_ERR. The patch will substitute the null-comparison with
> IS_ERR.

Exactly as I said to a very similar patch received a few days ago
from SikkiLadho:

"The modern wisdom for debugfs is not to check for any errors, so if
we're going to touch this, that's the route that any patch should be
taking.

Thanks."

Your patch seems to have the same Suggested-by: which suggests to me
that you probably know SikkiLadho and are working together with the
person who suggested the change, so it would be good that when a
patch from one of you is commented upon, those comments are taken
into account rather than someone else sending an identical patch to
the first.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
