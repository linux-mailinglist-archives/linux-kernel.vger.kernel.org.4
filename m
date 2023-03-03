Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D56A96F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCCMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCCMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:04:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC61ACD1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4D9AB8161F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8482FC433EF;
        Fri,  3 Mar 2023 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845073;
        bh=ly38t2tZ2PEWYpOa933MR85bFm8oPVgAVD8GHbhbBOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRwvmE5l4KIgNJvfHbUa6+5gnhT2ggQjvmWu+XxCuCAOLsKq+DVdS5GwQSN5v5gnY
         9RN4IO+Ytol8rZu6Yu7h9/T0a3JhVj+XsC2x97yk8eaCZpEEzdcJDJrG04hFO0vcyZ
         pUKPN6PfVd5vjoYUFt1NS6bA1Krr0XGh+ykehYpHlGtJpMNLf2LUHdmQneljcj1wc8
         bRgnUNVYL7MPaAUO9RiLDQaLVj/5ueTKjmjGYDy5sss/jUkWMQM3BpkpDtd0CiCKe4
         UoXDauZgRKRrifzulyVGltr6RKNKx1r4V8Enl4Db0xOcMpq27dBpbNifdkbM8Na8in
         Qzdl15ydD2A4Q==
Date:   Fri, 3 Mar 2023 12:04:29 +0000
From:   Lee Jones <lee@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH v2 1/3] mfd: tqmx86: do not access I2C_DETECT register
 through io_base
Message-ID: <20230303120429.GJ2420672@google.com>
References: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023, Matthias Schiffer wrote:

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
> ---
> 
> Notes:
>     v2: add comment regarding use of inb() as suggested by Andrew
> 
>  drivers/mfd/tqmx86.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
