Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DCD65A36E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiLaJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLaJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:58:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B996AE0C2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:58:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ECC060A71
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF1BC433EF;
        Sat, 31 Dec 2022 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672480703;
        bh=c3GP3BWw7hX/GbErfIHklPnihWYlOThTtcWXdppJMrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w00PN8zabbL96idkE4Q0S0LZRbk34evycGwnbddiNEIeIiaLisuMR1VePQK85hHCb
         hZrNqcO4MwYGDZ9rOJ5octTgDPwXczyB5GBoNgAq8eDj+SiAv9yaOkYxjVKhelqM+c
         3d9WH8MqkJCppwjPnjdy8jZ23MdmtEZq3nAd3+3E=
Date:   Sat, 31 Dec 2022 10:58:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoochan Lee <yoochan1026@gmail.com>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
Message-ID: <Y7AHvYfZreO/G/kT@kroah.com>
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231055310.2040648-1-yoochan1026@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 02:53:10PM +0900, Yoochan Lee wrote:
> --- a/drivers/misc/hpilo.h
> +++ b/drivers/misc/hpilo.h
> @@ -62,6 +62,7 @@ struct ilo_hwinfo {
>  	spinlock_t fifo_lock;
>  
>  	struct cdev cdev;
> +	struct kref refcnt;

This is obviously incorrect, please never have 2 reference counts for
the same structure.

greg k-h
