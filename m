Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EED70698E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjEQNTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjEQNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:19:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A4213A;
        Wed, 17 May 2023 06:19:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA71E1FD68;
        Wed, 17 May 2023 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684329545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0yEaZ9wXA+cWPA25h9EIXyAIeYp+OM3Sb2sM7l1qBrs=;
        b=ZuDLXj2q3LjuAXxfYXFwPYc1S7uyoELs8tGkJ7Jk1zO1qX9fWmrsZfajes9lw068PoF9A8
        nJKMvRxm5U5TINr5p/kRbnck4/ydolVIGq2cFp0CFMmEQXFCeIUVIwUkDmNH2b3DtvKlSg
        vIsrlolp/vXZpqcYLsGp1czILwqvVkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684329545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0yEaZ9wXA+cWPA25h9EIXyAIeYp+OM3Sb2sM7l1qBrs=;
        b=HBCJlgZNK6zh9eXCRf0J3+tjRLv9+YX1OfIXxgyCNUkoGgaQx+IyxviEZsX9mxGTmQCIZP
        9Lep3ohD8ldxieDA==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 516F72C141;
        Wed, 17 May 2023 13:19:05 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 39BA64A04DB; Wed, 17 May 2023 15:19:05 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 08/10] reset: starfive: jh7110: Add StarFive
 STG/ISP/VOUT resets support
In-Reply-To: <20230424135409.6648-9-xingyu.wu@starfivetech.com> (Xingyu Wu's
        message of "Mon, 24 Apr 2023 21:54:07 +0800")
References: <20230424135409.6648-1-xingyu.wu@starfivetech.com>
        <20230424135409.6648-9-xingyu.wu@starfivetech.com>
X-Yow:  Yow!  I'm imagining a surfer van filled with soy sauce!
Date:   Wed, 17 May 2023 15:19:05 +0200
Message-ID: <mvmsfbvgkom.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24 2023, Xingyu Wu wrote:

> @@ -58,6 +76,18 @@ static const struct auxiliary_device_id jh7110_reset_ids[] = {
>  		.name = "clk_starfive_jh7110_sys.rst-aon",
>  		.driver_data = (kernel_ulong_t)&jh7110_aon_info,
>  	},
> +	{
> +		.name = "clk_starfive_jh7110_sys.rst-stg",
> +		.driver_data = (kernel_ulong_t)&jh7110_stg_info,
> +	},
> +	{
> +		.name = "clk_starfive_jh7110_sys.rst-isp",
> +		.driver_data = (kernel_ulong_t)&jh7110_isp_info,
> +	},
> +	{
> +		.name = "clk_starfive_jh7110_sys.rst-vout",

"clk_starfive_jh7110_sys.rst-vout" is exactly AUXILIARY_NAME_SIZE long,
thus lacks a null termination.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
