Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1669E1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjBUNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBUNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:46:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE91DB82;
        Tue, 21 Feb 2023 05:46:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85E18B80E95;
        Tue, 21 Feb 2023 13:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FCFC433D2;
        Tue, 21 Feb 2023 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676987175;
        bh=Lw525gjUx17DnYBHbXcQF+IG0mBL4Ru3ppXMtzQyUQE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GIiNLYNJzZVCmfnzit3Yfhfcb+qJ5O7io0osFGTKDP+4RZeVe8qk/eQjQp2SVIQj3
         NWbFPBlMwocFP2cM/rYV57KVwcy23W9xts0J4vIZ0EDZfHjwiVDBZQhyBcJU27WYNF
         1PdVoB9B1Kb7JRU+8m7c4elSZxTRGgYGGzk8vS1Jgiw/tYzNBdw54cNO93vw/IQ/6c
         86fUgLE2JXjMcvL+ofMkIxyIXmhAgbnrdonvhdcUCRhi+5I2aSO40c7GudtNNuyjhU
         NTRmKm83xv4HlexrmLFSRthUmgIngxuUsJobYHKAu502SCTDlwqeFiEZdCnZUAUFc3
         NtD7kwYiduDBA==
Message-ID: <8ad45f24-dc78-dfc4-23d2-ad5a5d0e42d4@kernel.org>
Date:   Tue, 21 Feb 2023 14:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Content-Language: en-US
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220123232.413029-1-marius.cristea@microchip.com>
 <20230220123232.413029-3-marius.cristea@microchip.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230220123232.413029-3-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 13:32, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  MAINTAINERS               |    7 +
>  drivers/iio/adc/Kconfig   |   12 +
>  drivers/iio/adc/Makefile  |    1 +
>  drivers/iio/adc/pac193x.c | 2072 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 2092 insertions(+)
>  create mode 100644 drivers/iio/adc/pac193x.c
> 


Thank you for your patch. There is something to discuss/improve.

> +
> +#define PAC193X_NEG_PWR_CH1_BIDI(x)	((x) ? BIT(7) : 0)
> +#define PAC193X_NEG_PWR_CH2_BIDI(x)	((x) ? BIT(6) : 0)
> +#define PAC193X_NEG_PWR_CH3_BIDI(x)	((x) ? BIT(5) : 0)
> +#define PAC193X_NEG_PWR_CH4_BIDI(x)	((x) ? BIT(4) : 0)
> +#define PAC193X_NEG_PWR_CH1_BIDV(x)	((x) ? BIT(3) : 0)
> +#define PAC193X_NEG_PWR_CH2_BIDV(x)	((x) ? BIT(2) : 0)
> +#define PAC193X_NEG_PWR_CH3_BIDV(x)	((x) ? BIT(1) : 0)
> +#define PAC193X_NEG_PWR_CH4_BIDV(x)	((x) ? BIT(0) : 0)
> +
> +/*
> + * Universal Unique Identifier (UUID),
> + * 033771E0-1705-47B4-9535-D1BBE14D9A09, is
> + * reserved to Microchip for the PAC193X and must not be changed
> + */
> +#define PAC193X_DSM_UUID		"033771E0-1705-47B4-9535-D1BBE14D9A09"
> +
> +enum pac193x_ids {
> +	pac1934,
> +	pac1933,
> +	pac1932,
> +	pac1931

Enums are usually uppercase.



Best regards,
Krzysztof

