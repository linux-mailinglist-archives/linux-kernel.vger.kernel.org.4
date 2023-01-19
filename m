Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4FB674ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjATEiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjATEhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:37:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7BB4E32
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C364CB823F6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6E3C433F1;
        Thu, 19 Jan 2023 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674140952;
        bh=guV+7vZU2mp7GLs0aTWp0QCEGimoOkaahg6PxJ1vaLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isoK5H4UzpNEDiK7U/JPxRpHowtEBJKWH/I8q5mldwVgwYBF+ptPdPmQD3tRpSXQ3
         Qqm0cveU5vcUyB4d1nCG8e8/Eh0hUrtKKF4qLa1/lAHGNy3+hNeUxhQsHrWybXpsy7
         ggkhIpog1JYFflNQj/CtUi3tOOKAyZE2F8Wjau54=
Date:   Thu, 19 Jan 2023 16:09:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patchv2 1/3] VT: Add height parameter to con_font_get/set consw
 operations
Message-ID: <Y8ldFjz7d6/CMA0w@kroah.com>
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.350270019@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218003237.350270019@ens-lyon.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 01:32:10AM +0100, Samuel Thibault wrote:
> The current con_font_get/set API currently hardcodes a 32-pixel-tall
> limitation, which only dates from the old VGA hardware which could not
> handle taller fonts than that.
> 
> This change just adds a vpitch parameter to release this
> constraint. Drivers which do not support vpitch != 32 can just return
> EINVAL when it is not 32, font loading tools will revert to trying 32
> and succeed.
> 
> This change makes the fbcon driver consider vpitch appropriately, thus
> making it able to load large fonts.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> ---
> V1 -> V2: Drop (bogus) sisusb_con.c change, it is being phased out
> 
> Index: linux-6.0/drivers/tty/vt/vt.c

6.0 was really old when you sent this, and because of that:

> Index: linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
> ===================================================================

This file is not even in the tree anymore.

Can you rebase this against 6.2-rc4 and resubmit it so that I can apply
it?  As-is, it will not apply at all :(

thanks,

greg k-h
