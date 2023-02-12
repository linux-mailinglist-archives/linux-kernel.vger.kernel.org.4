Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CF693657
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBLHJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLHJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:09:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB148113F7;
        Sat, 11 Feb 2023 23:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45EAF60C21;
        Sun, 12 Feb 2023 07:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C03CC433D2;
        Sun, 12 Feb 2023 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676185761;
        bh=jcRHjbPv8wQxeze3vZkBGsQR8bZVaJgYulEkUJEEn14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSk0ui7WTL9SnNrXI63kYaAVxZVnj0bsbW7Q4Vbl+eZjco5qSOx6Gu2J1kJocvUB5
         bCDFYnt9TmgVGQ2bTvG7QZqhExHtBaPF6iRthLvOaFu7CgTrbHaFGDw7hesJ8GkWKX
         7cWU+9zwelItxcsFZJfyjRUheyhp0AMjgbl4w2lo=
Date:   Sun, 12 Feb 2023 08:09:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        arnd@arndb.de, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+iQnfR65M0El34R@kroah.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 09:27:43AM +0530, Tharun Kumar P wrote:
> +	/* Wait for the EPC_BUSY bit to get cleared */
> +	do {
> +		data = readl(priv->reg_base + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +	} while (data & EEPROM_CMD_EPC_BUSY_BIT);

Again, you can not sit and spin in a busy-wait like this with no chance
to recover if something goes wrong with the hardware (hint, what if it
got removed?)

please fix.

thanks,

greg k-h
