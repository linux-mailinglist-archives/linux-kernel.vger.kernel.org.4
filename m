Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688FF660497
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjAFQmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjAFQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:42:13 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212777CBEE;
        Fri,  6 Jan 2023 08:41:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 27C4D426F3;
        Fri,  6 Jan 2023 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673023256; bh=gXgieJ9sHytuKgJOAD+se1IXoDv6b4RgyKmGjkVDxlg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pl5bPON7tKn3exZITOT4qR8AxmLqINqBe1EkSfPfTGJJ4pMwe95KLLviTxrwqLQwB
         gB2OZCPWfbSTQe1RTYksbZw1P3rif1MD6OpxracZDpEAx7BZIXrHRCB81DG5EHfZy2
         lRU8twI8hP0fnB7iVC1/8UFC26t0x3V2ExshBDsPmwEpyfU5YIVUwlCsHtLUh51bBt
         E6IVUFQLb3mIk76yVZBPdCd8Homo90egFg/3zLW44enN2xZ4KpInASlBjQS7dArvEQ
         RFMZwgH3qEQOmOtJurTRDdnruH+rymWSscLNP6ZhTKPUz1yDkrbQfWWvn+tH+AiveM
         DLUFRPoqXdk1Q==
Message-ID: <6a9371e6-6516-5966-f92c-10bb228c8db3@marcan.st>
Date:   Sat, 7 Jan 2023 01:40:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/5] spi: Use a 32-bit DT property for
 spi-cs-setup-delay-ns
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Janne Grunau <j@jannau.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230104093631.15611-4-marcan@marcan.st>
 <Y7hLrxQO9GbgpW1h@sirena.org.uk>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <Y7hLrxQO9GbgpW1h@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2023 01.26, Mark Brown wrote:
> On Wed, Jan 04, 2023 at 06:36:29PM +0900, Janne Grunau wrote:
> 
>> 65us is not a reasonable maximum for this property, as some devices
>> might need a much longer setup time (e.g. those driven by firmware on
>> the other end). Plus, device tree property values are in 32-bit cells
>> and smaller widths should not be used without good reason.
> 
> This breaks allmodconfig builds (I tested x86 but this should happen
> for anything with -Werror):
> 
> /build/stage/linux/drivers/spi/spi.c: In function ‘of_spi_parse_dt’:
> /build/stage/linux/drivers/spi/spi.c:2243:13: error: unused variable ‘cs_setup’ [-Werror=unused-variable]
>  2243 |         u16 cs_setup;
>       |             ^~~~~~~~
> cc1: all warnings being treated as errors

Yeah, the kernel test robot caught this one too. Sorry for missing it
(it got buried in warning noise in a rather large rebuild on my side).
That line should've been removed in #3 :(

I see two patches got applied already. Do you want me to just respin #3-#5?

- Hector
