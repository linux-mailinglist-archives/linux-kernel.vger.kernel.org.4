Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A965E4CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjAEEo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjAEEoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:44:16 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189042617;
        Wed,  4 Jan 2023 20:44:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B287E3FB17;
        Thu,  5 Jan 2023 04:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672893840; bh=DJFwNUoKB/UR71s75mzuMGeNsfe9rog8IsGcCazIn0s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Hg3L7LNtuu+NUhRLVJ1RsE1pg5d1trRhwcI9TNMjpYeAYGE09jrE4aM6ev/6H7hWF
         tR/YtI8q0N77OvjKGREUfiR4MzeYWzLUfW8tNqpu+kEnM2bjkKDGDJ2FU/dt2fTDab
         KDq5SvZDAP+NWKXSNQgtHecvp1/yZ7LBQSeaICQLCJzy+N2TS59lhuJIb135hF+4Sx
         GOeKYptu8Rz+yciSmqqC3Jrhg/7Iv2Njqp+H2bgD+wOxSr3PF0tN0s+EzVaMBLs3KF
         vqgoDQmyPwhDDPmXWgfkBbNV0hfCXc9yUcDhzCiGzmG4S7HVuM+tMbiPA6kgQ/ZtWZ
         s2U+Vme/xBL4g==
Message-ID: <3af091e9-09b4-53a0-da2d-5b2640040b9d@marcan.st>
Date:   Thu, 5 Jan 2023 13:43:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] iommu: dart: Support >64 stream IDs
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-4-marcan@marcan.st>
 <71bffbd4-f8b0-4201-b2eb-7a15847ac2c6@app.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <71bffbd4-f8b0-4201-b2eb-7a15847ac2c6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/04 22:37, Sven Peter wrote:
>>  #include "dma-iommu.h"
>>
>> -#define DART_MAX_STREAMS 16
>> +#define DART_MAX_STREAMS 256
> 
> Feels a bit wasteful to allocate 256-wide sid2group and save_{tcr,ttbr}
> arrays even for the M1 where 16 are enough. But then again, that's still <100 KiB
> for all DARTs combined and these machine have >8 GiB of RAM so it probably won't
> make a difference

Yeah, I don't think this is worth the extra fumbling around with dynamic
allocation.

>>  	/* enable all streams globally since TCR is used to control isolation */
>> -	writel(DART_STREAM_ALL, dart->regs + DART_STREAMS_ENABLE);
>> +	for (i = 0; i < BITS_TO_U32(dart->num_streams); i++)
>> +		writel(U32_MAX, dart->regs + DART_STREAMS_ENABLE);
> 
> This seems weird: this code writes U32_MAX to the same register
> again and again. 

Whoops, that was supposed to have a `+ 4 * i` in there. Fixed for v2.

- Hector
