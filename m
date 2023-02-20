Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4303D69CD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjBTNso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjBTNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:48:42 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC7D40C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=S6Y7CnuntEyfbGHtpqgiBcYVIvTwSKr2ZcoA34g5GRo=; b=qA8uNmaorVd0CNCpmcdP6I019t
        9vTOygK4IsYJTquJ2Ax2o+FFuuywEC8hEYDTzZXcVLVSlc46fwC3h1fvt3sB/0o0AV0gp3H4UzDHf
        dynoaxRzDQKr4CPBb95pHLLG2qT20+GiFfPvdEm4DT0NdFWulZmbKBRzb+POofzQUAs8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pU6Wn-005Vf4-G2; Mon, 20 Feb 2023 14:48:25 +0100
Date:   Mon, 20 Feb 2023 14:48:25 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH v2 1/3] mfd: tqmx86: do not access I2C_DETECT register
 through io_base
Message-ID: <Y/N6KY3sQ2ySQ6zM@lunn.ch>
References: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 12:25:44PM +0100, Matthias Schiffer wrote:
> The I2C_DETECT register is at IO port 0x1a7, which is outside the range
> passed to devm_ioport_map() for io_base, and was only working because
> there aren't actually any bounds checks for IO port accesses.
> 
> Extending the range does not seem like a good solution here, as it would
> then conflict with the IO resource assigned to the I2C controller. As
> this is just a one-off access during probe, use a simple inb() instead.
> 
> While we're at it, drop the unused define TQMX86_REG_I2C_INT_EN.
> 
> Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
