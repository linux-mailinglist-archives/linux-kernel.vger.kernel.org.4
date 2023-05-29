Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479177146A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjE2IvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjE2IvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:51:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B5010C;
        Mon, 29 May 2023 01:50:56 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F52B6606E70;
        Mon, 29 May 2023 09:50:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685350254;
        bh=vONTs6WMJV8KARE9JFHUrd9Ipnd933O8COixgUoyCrA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PGFjSRa2U0lt4ZTtEAvOlhPCcKsseSMpeyLa28juvIhF2ElLWPq31iHpIbqz/qNg3
         9hDOForVW20w3BkErYjIqsl4AveUVgBJNBJLVgTTpz91cpgfG07djMyaLBRl4zpcMG
         dJesnUN691UkBCBTpH9iFNWOzUE6qapqfRlh8ENhrDqvRWxb0OlqPI/FZTAzDS0uX4
         1q8mLMwKyLXfMus6EXL0cF+2n+JZqDXCHijPuMtCoEouA+odUrGJ9m+SxTFgKwlKSE
         IRv9+qWnqJDSCYheWB6aY/SvXiwd3NTXQxxeTmw3ZYvIRdCCaIPf2sZSN5dx5tVb4K
         Bp4f4D/hd/yMA==
Message-ID: <66d9eaa2-4eb5-e9d1-cc76-0e0b68be44ca@collabora.com>
Date:   Mon, 29 May 2023 10:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] clk: divider: Fix divisions
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>, kernel@collabora.com
References: <20230526171057.66876-1-sebastian.reichel@collabora.com>
 <20230526171057.66876-3-sebastian.reichel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230526171057.66876-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/23 19:10, Sebastian Reichel ha scritto:
> The clock framework handles clock rates as "unsigned long", so u32 on
> 32-bit architectures and u64 on 64-bit architectures.
> 
> The current code pointlessly casts the dividend to u64 on 32-bit
> architectures and thus pointlessly reducing the performance.
> 
> On the other hand on 64-bit architectures the divisor is masked and only
> the lower 32-bit are used. Thus requesting a frequency >= 4.3GHz results
> in incorrect values. For example requesting 4300000000 (4.3 GHz) will
> effectively request ca. 5 MHz. Requesting clk_round_rate(clk, ULONG_MAX)
> is a bit of a special case, since that still returns correct values as
> long as the parent clock is below 8.5 GHz.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


