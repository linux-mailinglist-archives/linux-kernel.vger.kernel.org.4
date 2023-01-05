Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B324A65E513
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjAEF0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAEF0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:26:12 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EC250F68;
        Wed,  4 Jan 2023 21:26:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4266242137;
        Thu,  5 Jan 2023 05:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672895792; bh=6G+K5gRC9t4y2G8nB4otob8iev95c+3AsFRTdh6iaKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=N934kro5t42Ie8SO5mlE3VQJ6FAsRAHdUm5x98+1zshhtrEThZvzw42SxMkAphNkn
         PJSubN1zLTep0pak6PzxjE0+6EFACn79K2jW31p5yva/vPo5xI45kMQOV3PSajzLNX
         vXXzaLRRuq3z9fdY8o9gVyCqvRA592fkbReP6Qh04FiaSyvlI2gg3iuOFAgbUF433m
         C23R2b6uGBN6uDpY+UUE1OTf1C2/WMGJroS+AB1Qz8hT5xS5cyFeG21IbxUxugMLCB
         xLWGjOsoJy3NKicPr8hwgKe4niLyKqNmK4NCfw8Bd1HVqjDzGfG1Aw1RhLb6UQkTw/
         HtvlAGkHxLbMQ==
Message-ID: <57a52e19-e121-6082-a4d8-f58ade353782@marcan.st>
Date:   Thu, 5 Jan 2023 14:16:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/7] iommu: dart: Support different variants with
 different registers
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
 <20230104110013.24738-7-marcan@marcan.st>
 <228a80d4-752b-42ae-84b4-47197ec82c24@app.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <228a80d4-752b-42ae-84b4-47197ec82c24@app.fastmail.com>
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

On 2023/01/04 22:43, Sven Peter wrote:
> On Wed, Jan 4, 2023, at 12:00, Hector Martin wrote:
>> +	u64 enable_streams;
>> +	u64 disable_streams;
> I don't think disable_streams is used anywhere. I assume you just left it in
> here to document it?

Yeah, we don't use this field ever, so we might as well drop it. I'll
leave the #define for T8110 in though, as documentation.

>> +	u64 ttbr;
>> +	u64 ttbr_valid;
>> +	u64 ttbr_addr_off;
> 
> This name confused me a bit since off sounds like offset to me while
> this is actually another shift. Can't really think of a better name
> right now though. I'd at least a comment here to describe it.

How about `ttbr_addr_field_shift`?

- Hector
