Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41886B73B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCMKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCMKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:19:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5ABA5BCBE;
        Mon, 13 Mar 2023 03:19:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51AC74B3;
        Mon, 13 Mar 2023 03:20:32 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710783F71A;
        Mon, 13 Mar 2023 03:19:47 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:19:41 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: Use of_property_present() for testing DT
 property presence
Message-ID: <20230313101941.366738a9@slackpad.lan>
In-Reply-To: <20230310144724.1545223-1-robh@kernel.org>
References: <20230310144724.1545223-1-robh@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 08:47:24 -0600
Rob Herring <robh@kernel.org> wrote:

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/soc/sunxi/sunxi_mbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/sunxi/sunxi_mbus.c b/drivers/soc/sunxi/sunxi_mbus.c
> index d90e4a264b6f..1734da357ca2 100644
> --- a/drivers/soc/sunxi/sunxi_mbus.c
> +++ b/drivers/soc/sunxi/sunxi_mbus.c
> @@ -82,7 +82,7 @@ static int sunxi_mbus_notifier(struct notifier_block *nb,
>  	 * Older DTs or SoCs who are not clearly understood need to set
>  	 * that DMA offset though.
>  	 */
> -	if (of_find_property(dev->of_node, "interconnects", NULL))
> +	if (of_property_present(dev->of_node, "interconnects"))
>  		return NOTIFY_DONE;
>  
>  	ret = dma_direct_set_offset(dev, PHYS_OFFSET, 0, SZ_4G);

