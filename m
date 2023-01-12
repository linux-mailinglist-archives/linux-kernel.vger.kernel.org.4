Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D50667109
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjALLgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjALLfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:35:40 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AFFD13F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:27:45 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id v6so976426ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwUGdMdqQ5tbh6fulqHtNli2C4weV3GDfalhUbOh6bU=;
        b=JNn/EK5OMJg07OXhdAwRxuoI9+WGyo1GNL4MX8tRTjqOm6W4I3/SAW5XDSQm/o32CE
         s5t2FVJpFFnfH0z4dArWTR3KEWKwV/U2Xnvu/WhjyTSoCyWMW4CoGrJHCu8Wulcb4SyG
         d4p752RCGdjPONvALvToF3qUNnR4qgbcbMGuUk2aW/q7V7sZFPYya/MVCLWAEp9eaWBU
         NXBkGaqcmUAxM8l5/+r5zNCKxTCX/6jwJNeCkg7cDWWTcm/Dp83Y1jiFnpcTr8L+qF8n
         wEv5jqXSUlkMJ+sps+ofi7jtd3lSxLNxxBqrWPNv+fAb4c6zyqb15mXElL6bdpRCAD72
         GSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwUGdMdqQ5tbh6fulqHtNli2C4weV3GDfalhUbOh6bU=;
        b=XC8IS9yqufotnw2J69hgwz7lgyCmg4uC80rLExoZ1eGvfULbpRftholxLoBKoxCX3s
         rfW3hlwguTENfhanVR89/ld96QwZ03aAE7aOFs1e9qKnyW+P7qntI6QwuJRs0opnimZH
         yKr+RuwIdSc9v6gr2K/hQaQY4JfMeZWAuT4w/BmQ8WRjKt6ty6fPXBDdyFmZm8JYziZz
         7ngE+udyGpHyg8/yIXOn1L4/1guezgLLe8UYK5XJT8+8XGhgaZa6CJVEEFj3QttzU4zX
         e1NusNx7TTUI4IadXwUxPcIJNmnzVsQZgQQsWfwhHQK6MsXChpb0peuKM6x4MRFADh9c
         oPQw==
X-Gm-Message-State: AFqh2kqwW9ac8JjZaGKYwtJ4sgqqWWSfO41LDW+VGnA+aoa9fHHrH0XD
        ar3/124oQBWcJkuA1FE/fInU7Q==
X-Google-Smtp-Source: AMrXdXsrfWRN51qqDzuvW1z46m/MJznhSK3Yxhf2zm98azkkuZjn9djgxtaHw2xxLqxVRs4y26aVqw==
X-Received: by 2002:a17:907:cbc6:b0:7c0:8371:97aa with SMTP id vk6-20020a170907cbc600b007c0837197aamr68472901ejc.28.1673522863656;
        Thu, 12 Jan 2023 03:27:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kv1-20020a17090778c100b00864d20e53ffsm870762ejc.14.2023.01.12.03.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:27:43 -0800 (PST)
Message-ID: <8f37d1cc-41d9-ad4b-ec84-708f1db03e89@linaro.org>
Date:   Thu, 12 Jan 2023 12:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/5] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
 <CAPDyKFrVjenwv0Fe36LBqML-R_w2TjoCwmbnqqOohV_1zH8vJQ@mail.gmail.com>
 <9771639f-5172-8f3b-3ce6-8fd195aa95b3@linaro.org>
 <Y7/inz5ZoQiR3bP3@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7/inz5ZoQiR3bP3@linutronix.de>
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

On 12/01/2023 11:36, Sebastian Andrzej Siewior wrote:
> On 2023-01-06 15:52:57 [+0100], Krzysztof Kozlowski wrote:
>>> Just so I don't get this wrong, since the cpuidle-psci also calls
>>> pm_runtime_* functions so it isn't PREEMPT_RT safe, at least not yet?
>>
>> You are correct. Patch 3 here addresses it by... just not doing runtime
>> PM. This is a hacky workaround but:
>> 1. I don't have any other idea,
>> 2. It's not a big problem because RT systems are not supposed to have
>> any CPU idle (one of first things during RT system tuning is to disable
>> cpuidle).
> 
> so you say you use idle=poll instead? 

This was generic comment that system is not supposed to go into deeper
idle states.

Best regards,
Krzysztof

