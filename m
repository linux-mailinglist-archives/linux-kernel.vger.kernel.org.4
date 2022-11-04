Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9CD619891
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKDN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKDN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:56:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2522F001;
        Fri,  4 Nov 2022 06:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DA7EB82E28;
        Fri,  4 Nov 2022 13:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E0BC433D6;
        Fri,  4 Nov 2022 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667570196;
        bh=f+kfsg5vhO3DMtcWUBeGsDvS+k5oJCSMEawyOO9HqgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yy1N37+9MPg01JnN4z4Gd+ER/gLzZnHihM2HkralT5v4DhrIPs3Tfz/iDSlRINpB4
         EXzEW3Irt7Rdu7JF+t9RDmde3T5cjVG5ywdo0ZFAGyBxqH26SX8AKbgK2BfksfTK9Z
         rOHUUufNuVuj0PEXuG0fAuGg9cTe6ZQi1haVTBaTCaOrbs1i5oE1aEl8DQpRu2+LxY
         /7J4OTf9D/owPMsMSE8q954RwatBjGNn3El1d3RiwRWH2xKY43hh6G991iryuJGSzi
         NC+q/iU5C1KkCfRTAu8La5r4ztxehv5Rl4OS1SO/Z+YeE6BDJPEuQmvwkzL0wceGkW
         ypqTTfQWglutg==
Date:   Fri, 4 Nov 2022 13:56:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, tony@atomide.com, vigneshr@ti.com,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com,
        afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Message-ID: <Y2UaCq+EL0f2mJ3p@google.com>
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-5-jneanne@baylibre.com>
 <Y1+q2Usm9ecicXqp@google.com>
 <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Nov 2022, jerome Neanne wrote:

> 
> 
> On 31/10/2022 12:00, Lee Jones wrote:
> > > diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
> > > new file mode 100644
> > > index 000000000000..2c1cf92e92ac
> > > --- /dev/null
> > > +++ b/include/linux/mfd/tps65219.h
> 
> > > +/**
> > > + * struct tps65219 - tps65219 sub-driver chip access routines
> > > + *
> > > + * Device data may be used to access the TPS65219 chip
> > > + *
> > > + * @dev MFD device
> > > + * @regmap Regmap for accessing the device registers
> > > + * @irq_data Regmap irq data used for the irq chip
> > > + * @nb notifier block for the restart handler
> > > + */
> > 
> > This header needs work.
> I'm not sure to get your point here. Just something like below to match
> format or do you expect more:
> 
> /**
>  * struct tps65219 - tps65219 sub-driver chip access routines
>  *
>  * Device data may be used to access the TPS65219 chip
>  *
>  * @dev: MFD device
>  * @regmap: Regmap for accessing the device registers
>  * @irq_data: Regmap irq data used for the irq chip
>  * @nb: notifier block for the restart handler
>  */
> 
> > 
> > Can you try an compile with W=1 please.
> This raise one warning on mfd:

Is that before or after the header was fixed-up?

> drivers/mfd/tps65219.c:28:12: warning: ‘tps65219_soft_shutdown’ defined but
> not used [-Wunused-function]
>    28 | static int tps65219_soft_shutdown(struct tps65219 *tps)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> soft_shutdown has been validated and is used in TI baseline even if not
> hooked in upstream version further to this review:
> https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/

Will tps65219_soft_shutdown() be used?

I think it should be removed until it's utilised in Mainline.

> It was a TI requirement to implement it...
> Let me know if you want me to remove this function or if we can keep it like
> this.
> 

-- 
Lee Jones [李琼斯]
