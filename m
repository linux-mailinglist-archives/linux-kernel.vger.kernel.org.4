Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9942603157
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiJRRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJRRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:07:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE22EEA9E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24675B82072
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70173C433D6;
        Tue, 18 Oct 2022 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666112789;
        bh=Zhb/lj2rt5yGFgf8T/KJ6b2c8PnX/hhuM/ohylSM4Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8GEnlVD56mgi40ebmUuPhLjNXC5y9Vt0AHRbRdo2RHMTYuzVbLzf9QG21neMmN0E
         bm/0/0ggPxyUdUiUG7CbDH+CF029eKepjZZwPTk7GQFjC51+TXlPZmfXkUEfKS6clA
         HIb8hBzKqeeFPgsxOt2PrZ/04FVBRiWg+bBxrOiQ=
Date:   Tue, 18 Oct 2022 19:06:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rts5208: Replace instances of udelay by
 usleep_range
Message-ID: <Y07dExeWY5lXgKLr@kroah.com>
References: <Y07OcqPNjSihOByt@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07OcqPNjSihOByt@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:04:02PM +0000, Tanjuate Brunostar wrote:
> Replace the use of udelay by usleep_range as suggested by checkpatch:
> 
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> +               udelay(30);
> 
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> +               udelay(50);
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
> 
> v2: changed the max values of the usleep_rage instances as they cannot
> be equal to the min values as suggested by checkpatch
> 
>  drivers/staging/rts5208/ms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> index 14449f8afad5..a9724ca5eccf 100644
> --- a/drivers/staging/rts5208/ms.c
> +++ b/drivers/staging/rts5208/ms.c
> @@ -3235,7 +3235,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
>  			return STATUS_FAIL;
>  		}
>  
> -		udelay(30);
> +		usleep_range(30, 31);

Did you test this?  And making the range 1 really doesn't make any
sense, right?

thanks,

greg k-h
