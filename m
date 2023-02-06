Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019968B921
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBFJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBFJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:57:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E9E048;
        Mon,  6 Feb 2023 01:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92A7DB80E37;
        Mon,  6 Feb 2023 09:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848D7C433EF;
        Mon,  6 Feb 2023 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675677465;
        bh=yqpJFL7AqTytJlea5SSDhYKVEGfY5DgY2bMudgpP8Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6GwhHp12sZwtSR+/q0P+9Mb/EE88FirlweA+qfOlD5XlnkfHB6f6HurgsgVEzGxP
         mlKzvFu0bi3uVPjSzMGO+PTE7Lnn2wXWKzFtyOeBYu0yDev7RgKzkFMsuQ0M29yHGT
         wY9dhibI9gln78M2Et+AAk8kdZE5S/u2srMdY2w0=
Date:   Mon, 6 Feb 2023 10:57:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-usb@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 13/13] USB: gadget: s3c2410_udc: fix memory leak with
 using debugfs_lookup()
Message-ID: <Y+DPFnpO7XnltD/B@kroah.com>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
 <20230202153235.2412790-13-gregkh@linuxfoundation.org>
 <241f919c-8190-00d6-f89b-6f7f54b29df9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241f919c-8190-00d6-f89b-6f7f54b29df9@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 09:20:10AM +0100, Krzysztof Kozlowski wrote:
> On 02/02/2023 16:32, Greg Kroah-Hartman wrote:
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.  To make things simpler, just
> > call debugfs_lookup_and_remove() instead which handles all of the logic
> > at once.
> > 
> 
> Hi Greg,
> 
> This driver will be removed in v6.3 via Arnd's tree:
> https://lore.kernel.org/all/20221021203329.4143397-13-arnd@kernel.org/
> 
> I think we can skip any work on this.

Ok, thanks, I'll drop it from my patch queue for now.  If it sticks
around, I'll apply it :)

greg k-h
