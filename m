Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF16EE3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjDYOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjDYOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:34:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EBD4EDF;
        Tue, 25 Apr 2023 07:34:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so7291850b3a.2;
        Tue, 25 Apr 2023 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682433268; x=1685025268;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqwUK/4eDJzCyEyFFhnH/3a1vPRmvk8A4cA3eKhviTk=;
        b=quJ+O1JlEpa0/H7U9zxcAuDqT+96tvcHOGzW2761RkODSrwBIzReeuokM+2BIehR25
         DZHnZziOGE2b55/n5niAtH2oGOqNU1EWGVoE+Si6hltvPCjw8xh9xQu+gjWQtj6n9yio
         9WbQGHC9lhSnx3fpHcS5/4+E5ga2yLKcFiYJPhpvdsZaJJoxoZPab7DtQY6fVzUPGmo6
         pQTVY3fmbuqLFQ9iwGU9aPo3etOD3aq9VQMzxv9pQia35k5yWICtiTjuKnpXs0J5ABP3
         54v8nNfmdTIdKNk3ogwoR9Zgvw7WDveDDR4tTWYO4enThTwO/t9U6h3XH7D6APl5IbFX
         uyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682433268; x=1685025268;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqwUK/4eDJzCyEyFFhnH/3a1vPRmvk8A4cA3eKhviTk=;
        b=jyovsDe1kk+7vooogB7OzEp2xZoH/ICgpwsHjNmLkaZEpxiQJhFCzwjJHZz1ZLxWK7
         cQGI7P6rX69PA7xUB6IfykbO3n5ij3EbAig4S3/fgwjkStMqCmV9bwssYcQFjFMVof6Z
         r1+diBeJ5VMPpV+AzengDdDQExONLEKqPq8zpEeUTO7uCkdEUIB3ewcT/lSUDoxt3puk
         jrffgwccmkdzTDXvksanQOpni02LpKmVnoUn7zTanH63TODgoJmcXSU2UveUwBWhnP0H
         /vc5F/flktF4UkWlXwETbQmwVn/altKQs8WZccdByVq4/0NSzcw5n3rkoHS639LQSjXV
         BkOg==
X-Gm-Message-State: AAQBX9eXcnQK41SMc8weefPYVyqNxOYudeTWFntfGNTocMhL8gHEhN4K
        CqGEiuAMSsc+TVp4VKhMkx4=
X-Google-Smtp-Source: AKy350Y/E8488smZu+2JGMu6TX8xn7ALx3Mxgu5yA+GFI+yG+/7nEkaAj10nUbQhH/HxbbANkIq0Iw==
X-Received: by 2002:a05:6a00:b51:b0:628:1b3:d499 with SMTP id p17-20020a056a000b5100b0062801b3d499mr23898372pfo.21.1682433267834;
        Tue, 25 Apr 2023 07:34:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h133-20020a62838b000000b0063b8a30b571sm9329133pfe.9.2023.04.25.07.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 07:34:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a1e940aa-7ede-572a-80ca-d950273e5ba6@roeck-us.net>
Date:   Tue, 25 Apr 2023 07:34:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Neha Malcom Francis <n-francis@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, kristo@kernel.org
References: <20230424105011.70674-1-n-francis@ti.com>
 <aabe7488-29b8-895b-38b8-67e5a7d1dd35@roeck-us.net>
 <705557cd-0a60-3cda-d78b-d78e2faef856@ti.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH RESEND v3 0/3] Add support for ESM
In-Reply-To: <705557cd-0a60-3cda-d78b-d78e2faef856@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 01:49, Neha Malcom Francis wrote:
> Hi Guenter
> 
> On 24/04/23 20:27, Guenter Roeck wrote:
>> On 4/24/23 03:50, Neha Malcom Francis wrote:
>>> Resending as no major changes, commit subject change only.
>>>
>>
>> Maybe you consider changing the subject of the bindings from "misc"
>> to "hwmon" as not being a major change, but it made me aware that you
>> are trying to sneak bindings which in my opinion don't belong there
>> into the hwmon bindings directory. This is not a hardware monitoring
>> device, it doesn't have anything to do with hardware monitoring, and the
>> bindings do not belong into bindings/hwmon/.
>>
> 
> I understand, it's a thin line across which I pushed ESM into hwmon; my reasoning was ESM also actively looks for signals that it aggregates, and is overall monitoring the device health. But if there was an option, in order of fitting: fault/ > misc/ > hwmon/
> 

That is really a stretch. It doesn't monitor anything. It is a signal
routing mechanism.

With that logic every transistor would be a hardware monitoring device.

Guenter

