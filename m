Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7E73A8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFVTSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjFVTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:18:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2ADC;
        Thu, 22 Jun 2023 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=7VEmrQnGXRHXrWZPRkJkOjP72y6Jj4SAv5mBcJAJcwQ=; b=loAZj+yP3rtmbP9MdVjS04Wp4K
        I0bKPeVKRM1eDmATNW/FIYrCl69pSEtPx7EgR8G6gloZrHLBJYnY6gnXlRIJ1wA6b1x0ebQj+A/vG
        ofyh0KtEE7N6rsZn/1ArsTov+AJ9tjfUUkQDag3DVAoQQa7v8uE41RQCgJCwsZ8H7ySo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCPop-00HIJb-VM; Thu, 22 Jun 2023 21:18:11 +0200
Date:   Thu, 22 Jun 2023 21:18:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     netdev@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        Robert Hancock <robert.hancock@calian.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Message-ID: <5e8b2552-0dcb-4683-ad52-57a239517d2d@lunn.ch>
References: <20230622175200.74033-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622175200.74033-1-fido_max@inbox.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Reset core now that clocks are enabled, prior to accessing MDIO */
> +	ret = __axienet_device_reset(lp);
> +	if (ret)
> +		goto cleanup_clk;
> +
>  	/* Autodetect the need for 64-bit DMA pointers.

I would say the comment is now not fully correct. It probably should
be extended to include 64 bit DMA.

	Andrew
