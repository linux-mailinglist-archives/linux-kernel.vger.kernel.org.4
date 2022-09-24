Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303245E8BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIXL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiIXL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:57:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D3A2858;
        Sat, 24 Sep 2022 04:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8DD0B80B8C;
        Sat, 24 Sep 2022 11:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02697C433C1;
        Sat, 24 Sep 2022 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664020652;
        bh=vnkNDhlyuWFuHtAtX6n8u3cxAUeHMgDdGDReB96XMRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpkWcVb9I7qeW57zLdW+o+rajeAwbSUeNAp6fcfsx1UZBhvG1vegl6WE3QWv+8yGu
         ZWjfBLMCwUg/E3W0iljnZfT20obDk1PpUaxhQ2VONXV9gXcajylrtg9f7k92NfSJfd
         1DyPpzk6pv0lYDs70ML6B6bNvW6UOOXjxzBN/DQM=
Date:   Sat, 24 Sep 2022 13:57:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Magnus Damm <damm+renesas@opensource.se>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/1] serdev: Replace poll loop by readx_poll_timeout()
 macro
Message-ID: <Yy7wqSWVBGwNtiiZ@kroah.com>
References: <20220923171048.37386-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923171048.37386-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:10:48PM +0300, Andy Shevchenko wrote:
> The readx_poll_timeout() consolidates the necessary code under
> macro. Replace current code with it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: dropped TODO: in the Subject line
>  include/linux/serdev.h | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 66f624fc618c..69d9c3188065 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -7,9 +7,11 @@
>  
>  #include <linux/types.h>
>  #include <linux/device.h>
> +#include <linux/iopoll.h>
>  #include <linux/uaccess.h>
>  #include <linux/termios.h>
>  #include <linux/delay.h>
> +#include <vdso/time64.h>

Ick, just for USEC_PER_MSEC?  That should be in units.h, not burried in
a vdso-only .h file.  This feels wrong, sorry.

greg k-h
