Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE072AD9E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjFJRKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFJRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8E2D7E;
        Sat, 10 Jun 2023 10:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 359B6613F8;
        Sat, 10 Jun 2023 17:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B4AC433EF;
        Sat, 10 Jun 2023 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417018;
        bh=ZaO/RYVvXHSOs2jr3g0SgfMw80BeXu3HOAR90E2DWuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBGyVra/pzwdhmhL3FVMM6WbG48PlQnnKFfNLANSLbHuIy7gjbiZFYaBJdmTvH+wd
         SbbDJ4ds5uQ8jhUfia44FtQSLf9rnu43Ujimj0K6MoRLjao28vbHUGSu/mwFL3BtYk
         ItJcJllgNWDny1ajlycFzqneBQQceocwuir3/FJMzZAxg9aTbhaATRR0mu54YjPAwX
         Lj6E4MRAxnOU6T+8rERqemrs44TP3KVcxc6mOgGmWtJmz+Jl6ZqTWEOp87TlBBnqYK
         FBXZGeZNqHnrljM25D+Yf/tGW0nczbauVgGAmCevqO5VY4cEEVbY3zsqCHBKVkNx+8
         Lbem7Fx67r2fw==
Date:   Sat, 10 Jun 2023 19:10:15 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Message-ID: <20230610171015.vf7emd5crpr7n4mg@intel.intel>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
 <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
 <20230610145429.uvmxxgxc5tc6x5b5@intel.intel>
 <eb935f16-1f89-0be9-86c9-24e8a88c2d8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb935f16-1f89-0be9-86c9-24e8a88c2d8b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 06:23:58PM +0200, Krzysztof Kozlowski wrote:
> On 10/06/2023 16:54, Andi Shyti wrote:
> > On Sat, Jun 10, 2023 at 04:07:51PM +0200, Christophe JAILLET wrote:
> >> Le 10/06/2023 à 12:26, Andi Shyti a écrit :
> >>>> @@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
> >>>>   			continue;
> >>>>   		rate = clk_get_rate(clk);
> >>>> -		if (!rate)
> >>>> +		if (!rate) {
> >>>> +			clk_put(clk);
> >>>>   			continue;
> >>>
> >>> could you also print an error here?
> >>>
> >>
> >> Is:
> >> 	dev_err(ourport->port.dev,
> >> 		"Failed to get clock rate for %s.\n", clkname);
> 
> Why do we need it? Most of other users of clk_get_rate() don't print.

that's not a reason not to print it.

> Probably because such condition is highly unlikely if not impossible.

still... that's not a reason not to print it.

All errors are unlikely and if it's unlikely, why there is no
unlikely(!rate)? Which doesn't improve the reason not to print
it.

The more unlikely, the lauder you need to be:

WARN_ON(!rate)... maybe too much!
BUG_ON(!rate)... way too much!

But these are inversely proportional to the likeliness of the
error.

> This makes simple function unnecessarily bigger...

and... that's not a reason not to print it :)

If it's needed, it's needed. If we are considering the error,
then we need to treat it as an error.

In any case, I'm not strong with it, indeed, I r-b it anyway. I
personally prefer and suggested printing the error. Up to
Christophe.

Thanks,
Andi
