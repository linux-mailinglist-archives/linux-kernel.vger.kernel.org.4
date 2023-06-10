Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79172AB04
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjFJK5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFJK5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071819A;
        Sat, 10 Jun 2023 03:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A0E61286;
        Sat, 10 Jun 2023 10:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB82C433D2;
        Sat, 10 Jun 2023 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686394633;
        bh=xmXIIUoIPhbHB+5cKM2HQ7wmex/ZG5xI1clFiieoASQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9L8wwnKMlDjtPr/d3+a0NmUf0G1FF0bqLgxJwwEtM1Sezj4CAOgbQcRQJnpcNYms
         AHhL/vBfcA9uW0sbgP9gXiOuJecbMLEcGafR1I79NNA/TNX3jn5InoWG5wwiASpGk/
         slV1EL8SwfZHn6mjDTmcgPJ/6sZR6Rr5NtJIa/znFrpkNw/qkI1SCTLbcFTtl/ecU5
         JFRnf34vdanndit99oS/lpIjB747vOK2avosQrl2C+s7rhfk4AV8uhr3FUXzaINpPO
         nvFKg6Pxly1QtGz55pVipjhbki/MaeRwi1tRleZGTDPC3vK31DzkF+lVn5SAaoCtxE
         hj/fcE6Yg8UQA==
Date:   Sat, 10 Jun 2023 12:57:10 +0200
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
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Message-ID: <20230610105710.v6w2ibltfgishali@intel.intel>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610103958.jwfe45zm52ehiovn@intel.intel>
 <d86a0c13-f2c1-2595-adac-71c8c6452a89@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86a0c13-f2c1-2595-adac-71c8c6452a89@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> On Sat, Jun 10, 2023 at 12:45:53PM +0200, Krzysztof Kozlowski wrote:
> On 10/06/2023 12:39, Andi Shyti wrote:
> > Hi Christophe,
> > 
> > On Fri, Jun 09, 2023 at 06:45:39AM +0200, Christophe JAILLET wrote:
> >> When the best clk is searched, we iterate over all possible clk.
> >>
> >> If we find a better match, the previous one, if any, needs to be freed.
> >> If a better match has already been found, we still need to free the new
> >> one, otherwise it leaks.
> >>
> >> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >> This patch is speculative. Review with care.
> >>
> >> I think that some clk_put() are also missing somewhere else in the driver
> >> but won't be able to investigate further.
> >> ---
> >>  drivers/tty/serial/samsung_tty.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> >> index dd751e7010e3..c07877dd25fa 100644
> >> --- a/drivers/tty/serial/samsung_tty.c
> >> +++ b/drivers/tty/serial/samsung_tty.c
> >> @@ -1488,10 +1488,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
> >>  			calc_deviation = -calc_deviation;
> >>  
> >>  		if (calc_deviation < deviation) {
> >> +			/*
> >> +			 * If we find a better clk, release the previous one, if
> >> +			 * any.
> >> +			 */
> >> +			if (!IS_ERR(*best_clk))
> > 
> > what is the case when *best_clk has an error in it?
> 
> The initial one? Open the place where the function is being called.

Right!

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi

> 
> Best regards,
> Krzysztof
> 
