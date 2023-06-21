Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF28738CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjFURKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFURKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:10:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3094129
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F5B161626
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB25C433C0;
        Wed, 21 Jun 2023 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687367443;
        bh=qbttSnX61aRCfPZ9doviFJYcYAqStHfzS0R2tONpN9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlgxkyNgnp1V16aJEA+rLpAZS3Uq3r34cV6+czilUjkKDSBf9KQWcYXtYj6fT+2Qh
         L9EKe7trA6o/xYdTnGW/IyHpGgmMDOM+5ki54BbJQMCIzfukpV27yEu+p6sWxFFQAK
         f39c7wuBRI2yLN8i/ZYL5Galo2DfcrQLLhxyFYibzLZF6O/GWHseHrZL3c15wWTHnJ
         XqFGQVbxapHDpzn2PzVEVT3bIUA2LC8OAaSJVp4we/JpN9azytQWYOSoROHrGd9dFa
         STBbpHGB5LE6j5dd8hJ1UwylsgigizvDav9ylQ28RKN938rqzl8adCusle2jtQe2zy
         ctVUa+ybHvaoQ==
Date:   Wed, 21 Jun 2023 18:10:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: ipaq-micro: Use %*ph for printing hexdump of
 a small buffer
Message-ID: <20230621171040.GK10378@google.com>
References: <20230612212007.3621-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612212007.3621-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, Andy Shevchenko wrote:

> The kernel already has a helper to print a hexdump of a small
> buffer via pointer extension. Use that instead of open coded
> variant.

That's not all you're doing is it?

Nice try.  2 patches please.

> In long term it helps to kill pr_cont() or at least narrow down
> its use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/ipaq-micro.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
> index 6d3968458e81..57fb7874fc91 100644
> --- a/drivers/mfd/ipaq-micro.c
> +++ b/drivers/mfd/ipaq-micro.c
> @@ -131,10 +131,8 @@ static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
>  		break;
>  	default:
>  		dev_err(micro->dev,
> -			"unknown msg %d [%d] ", id, len);
> -		for (i = 0; i < len; ++i)
> -			pr_cont("0x%02x ", data[i]);
> -		pr_cont("\n");
> +			"unknown msg %d [%d] %*ph\n", id, len, len, data);
> +		break;
>  	}
>  	spin_unlock(&micro->lock);
>  }
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Lee Jones [李琼斯]
