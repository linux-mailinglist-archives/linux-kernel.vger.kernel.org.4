Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD46F6218B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiKHPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiKHPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:46:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776085C74E;
        Tue,  8 Nov 2022 07:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C97615F0;
        Tue,  8 Nov 2022 15:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E03AC433D6;
        Tue,  8 Nov 2022 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667922399;
        bh=j94Kohmh15MKz9lwMvrlIvKWFYBll4GPXGwEB1XBuW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7JzbPHHSkCyXSWhKqlGPbaZeOVjLckME6v52kNoeGkQnduDNLmokEphEGUHUKDmn
         dYJFQHJC4j80+D+XW+CR5mm5JHsne/WZMNaftjWBCHHmzYC+H2FC4wd/hvkk1m1GgU
         BaRhU/+ZYfbfXOeGYsCZke/vQ+gN/i1wTmtYwXJE=
Date:   Tue, 8 Nov 2022 16:46:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     stern@rowland.harvard.edu, m.grzeschik@pengutronix.de,
        albertccwang@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [Patch v5] usb: core: stop USB enumeration if too many retries
Message-ID: <Y2p52y7h2h0YCgXj@kroah.com>
References: <20221107072754.3336357-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107072754.3336357-1-raychi@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:27:54PM +0800, Ray Chi wrote:
> When a broken USB accessory connects to a USB host, usbcore might
> keep doing enumeration retries. If the host has a watchdog mechanism,
> the kernel panic will happen on the host.
> 
> This patch provides an attribute early_stop to limit the numbers of retries
> for each port of a hub. If a port was marked with early_stop attribute,
> unsuccessful connection attempts will fail quickly. In addition, if an
> early_stop port has failed to initialize, it will ignore all future
> connection events until early_stop attribute is clear.
> 
> Signed-off-by: Ray Chi <raychi@google.com>
> ---

Much nicer, thanks for sticking with this!  I'll go queue it up now

greg k-h
