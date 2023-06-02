Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8750E72020E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjFBM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjFBM0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:26:51 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3738397;
        Fri,  2 Jun 2023 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=rYQR8bOrJkw5CscO46dN+AC+qv5NIBbmKe5bpcO+QiU=; b=dYl9Bi53H/sQHVncl6ZUk03S2v
        6avzLyGjYH2y0e9R0O8QNoTAohWLONOsuv8rnsk7Gku6uk5GlmH/LvJW7DSHto7l6Q+w945Nu4jZH
        9bIfL++Jdd+7cyozGJ/T/kFM/1e63XV6hG6KROTJPIBaR2Q9j6j3AjoAiVa5Q9u6fdoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q53rb-00Efsd-98; Fri, 02 Jun 2023 14:26:39 +0200
Date:   Fri, 2 Jun 2023 14:26:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     Alexander H Duyck <alexander.duyck@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pengdonglin@sangfor.com.cn, huangcun@sangfor.com.cn
Subject: Re: [PATCH net-next] net: ethtool: Fix out-of-bounds copy to user
Message-ID: <6110cf9f-c10e-4b9b-934d-8d202b7f5794@lunn.ch>
References: <20230601112839.13799-1-dinghui@sangfor.com.cn>
 <135a45b2c388fbaf9db4620cb01b95230709b9ac.camel@gmail.com>
 <eed0cbf7-ff12-057e-e133-0ddf5e98ef68@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eed0cbf7-ff12-057e-e133-0ddf5e98ef68@sangfor.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Changing the copy size would not fix this. The problem is the driver
> > will be overwriting with the size that it thinks it should be using.
> > Reducing the value that is provided for the memory allocations will
> > cause the driver to corrupt memory.
> > 
> 
> I noticed that, in fact I did use the returned length to allocate
> kernel memory, and only use adjusted length to copy to user.

This is also something i checked when quickly looking at the patch. It
does look correct.

Also, RTNL should be held during the time both calls are made into the
driver. So nothing from userspace should be able to get in the middle
of these calls to change the number of queues.

	Andrew
