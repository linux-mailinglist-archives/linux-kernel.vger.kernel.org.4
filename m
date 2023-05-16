Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E57053E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEPQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjEPQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:32:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0E4D045
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:31:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96ab81aa68dso919775966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254656; x=1686846656;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJWf/O6/bgY/LqCBnoW2lN4/EkslAxW6EAY6k6YXlL8=;
        b=Ojeg6VooufgIF0uisRWw0Cvxmi9BoTMv0rTldrBVrDfibSPOWTVVV+qXKhBSBkzpgz
         nPTcYzCg5yFNqh0d6x/w6WCnlAQhywQKvRMRChKYzlWR2NaCWvXkhx4xWPlYlFou/gJ/
         k6ysIyLXLZ1BrjvOdSw/VkJlBfsEMQaX38VKbn3GnTPdQ89W+BQuOmEB4qYrYRztJ/sC
         EuKyP0ZN3yN7ZWC3uGdglk+AK+QGL98mJLAJD+WWKOcHxCLFqdbM+6xCUFx0ZkDxFZ6y
         8PRamJbrerfVoyFekhqEBU8O+0cUdN7y3yuFEk+EM9RR/OaT751/rxb6Q1tlagp2txb4
         KYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254656; x=1686846656;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJWf/O6/bgY/LqCBnoW2lN4/EkslAxW6EAY6k6YXlL8=;
        b=bnRTzyk9L1s5g8etqTJ2VkCMZKbvjZArtek6mPzpZmoKf3XLgJFSf8u9Q8EGLJWN9P
         T9WUd/4tFmu4iz+XX+4hS861ChFccIhw98fto6UWjTuEfNtv1WOutV3aQG+7zK8M/5gm
         YocfWBGWnxrFw0ivIrs9rLyoN18QUzUmiiKwAkTM31DCganjdOFMwHOCo+O5cFnvmqbI
         eHdm52o9poAzIwXxi7JSG6Hm0zLL6r1zgO99vRFI9+AcXtDyy3KcrmP7gfh7wrf0ksCp
         sM6DnklZFSJ1p6J7UkdHmQLiA2pA3PX0VkwvthmkPs+E+FtieJpZ8QHScN5yBODPZ6B9
         shvQ==
X-Gm-Message-State: AC+VfDxw0rifhRZnHpGdkYiY/2skpeu5oX8XmzjReq017i8LCyQygH3m
        bQwdYyKvqjd4DfAAUWLQFcd1oQ==
X-Google-Smtp-Source: ACHHUZ57Vra5TMrVsJpXvtgUTL/v2nF0I/s2y4tc2DOPScDQfuheRUVuNWcYvR1rvkgwwWSFcJpyvA==
X-Received: by 2002:a17:906:db08:b0:965:fa80:bf1 with SMTP id xj8-20020a170906db0800b00965fa800bf1mr36026771ejb.32.1684254656537;
        Tue, 16 May 2023 09:30:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id hx7-20020a170906846700b00965a4350411sm11018102ejc.9.2023.05.16.09.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:30:56 -0700 (PDT)
Message-ID: <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
Date:   Tue, 16 May 2023 18:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>   sparx5_pcb125.dtb: l2-cache0: 'cache-level' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Anyone from Microchip picking this up?

Best regards,
Krzysztof

