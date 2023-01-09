Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F71662B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAIQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAIQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:13:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591710B8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:13:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w1so8697998wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfiNGwJ7nUW2t/7W07NzXNetigfULajsYrYfNX1hTqI=;
        b=V32aGgayNcRgyV3hZzHKzk9rB+/sTElIiVBlCUFiadIhjVdF09ElSQL5sfaDtUfERK
         Y73xmvp0NAnblGHZc18oF3DHYK+9X6MHX3vpA9wNCh4ckp/R+7Ly5z5tyh5KbjxwWrlY
         ypqBs9gxgMOwNYJgC4OOlGPDqHDk4KgKS7ZO8NQ4ijY5oRuw4UprjvS73G4qmZ90M/ZY
         hswiQ1jt2mefqxFStgsPpdTOUNek6w+A2FtghsxuKhQwhw7njWaU6CZAO3TpdikBemL/
         0m7d4/EMWu87X6Aqm5m1Q+urHQjtslk1MzGPx2U2KIT62uFld08tiQU77jUHagkijePw
         qBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfiNGwJ7nUW2t/7W07NzXNetigfULajsYrYfNX1hTqI=;
        b=etbm71lb/V8KIngooBmarBAdrHMtJ/1PJlcYh2S2VPMPzlCiSj94EPq8vCfvkR7vqV
         DF/7LiXXV5Umn3bqem7aKAsK48j8PSO+B4VDS4k22RYJPII/oZJaEO3pCGBOUy62pnWJ
         CQZFzV66KAs9DGEdvhBuMMgKNzZDmmsPBwI2GNYvurRHfsQKJ0Dhli27IOy5ZW6lo6cn
         jmHxQcf4VrxDuu2IPHC3K5yguGko+dcsdiOdFRnCzcSZyRHNFcS/u+tibpQbeCrjhcQV
         GQVaV6ytejuMNciHm0uawbYuCdchK/B4w4TqhwfctPHibDjxKqSZ0TmKr8XQhQbYyYeI
         fabw==
X-Gm-Message-State: AFqh2kqBxyhTwaqLD3uxlvy3hxlGVbF+jXIqAoCFwhyGJ4LulR5cgdlk
        LtDzsPc7lArJHX+n6UotnTaF/Q==
X-Google-Smtp-Source: AMrXdXva9ejqrScLSqJndmjhzGnLcXaKNxvT63XElWgwEiO/vbKsn8Gw5EoGvIn5+AWshodqmk7R9Q==
X-Received: by 2002:adf:f482:0:b0:2bb:f4bf:e758 with SMTP id l2-20020adff482000000b002bbf4bfe758mr2736091wro.48.1673280800820;
        Mon, 09 Jan 2023 08:13:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m10-20020a056000008a00b002683695bf97sm8825933wrx.58.2023.01.09.08.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 08:13:20 -0800 (PST)
Message-ID: <3b4d93e1-a065-49f9-93d7-cec4807d411e@linaro.org>
Date:   Mon, 9 Jan 2023 17:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 3/6] cacheinfo: Check 'cache-unified' property to count
 cache leaves
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-4-pierre.gondois@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230104183033.755668-4-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 19:30, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> '[d-|i-|]cache-size' property is required. The 'cache-unified'
> property is specifies whether the cache level is separate
> or unified.
> 
> If the cache-size property is missing, no cache leaves is accounted.
> This can lead to a 'BUG: KASAN: slab-out-of-bounds' [1] bug.
> 
> Check 'cache-unified' property and always account for at least
> one cache leave when parsing the device tree.
> 
> [1] https://lore.kernel.org/all/0f19cb3f-d6cf-4032-66d2-dedc9d09a0e3@linaro.org/
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Thanks, solves the issue:

Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

