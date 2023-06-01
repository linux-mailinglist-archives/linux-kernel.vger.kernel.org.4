Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E83571F10C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjFARpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjFARpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:45:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68529189;
        Thu,  1 Jun 2023 10:45:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b05e96dabbso6864005ad.2;
        Thu, 01 Jun 2023 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685641513; x=1688233513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FYUbj1PxaWtwh4DzW6Vay4H94hGaPyKVZYWuV3ZbcXc=;
        b=OZaoMOIBOQ/WOz1KN5ulk6CR+Y5gFgXSaO22TTBv+bmZLnL+Ld1I5u4DYlklnEQyde
         aW54XdWuPR5ilO0qi3REMv/tarOQi6Dm5vDOWDhxrG7S0kmhygCNWnmWMbUbiKla4F42
         wlnkhqEVBaNuV3nJh7oKwDRSAoROzdcqlu1jom2iZJghbk8a5SH8Fym1duIEYuVXipWr
         8gIc+wA3v8ga9RnPbOVuskX3ZBwHeFUsDUSPkmtRyhA60RkR/aGE9IJjfyPNvlQS9jvz
         JWvTuj2M6Rw37IdWXleSCzSNDXhiBgn/0dZrfQSG4Rr8pRm8lCHP7ICsnuEwGBTJAr60
         ke4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641513; x=1688233513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYUbj1PxaWtwh4DzW6Vay4H94hGaPyKVZYWuV3ZbcXc=;
        b=S9y1ovQLZhImZl+9pdRQa6qhXvykMFT8hUuF4NKp5kJoFScrFJHWAmU0ijRAVa9QOG
         sIPk5M/+PlUT/KThkoINwmoUKfjG7V/WB9aVE49gH7fkIiVqjCK5xY0PD4YxgLCjRCF6
         EWv0B6KTpRDWLvfIgD7fkgXpJ6z9gf7pk0kbnK3Q/Kne2F98xRIBVi+M37AHHSW7Rhhe
         rYkoTUT+B+reudGF6V6wpAvShphUvG1V3Toy13sgTUA4WsSt7imumUxZ+6Ldc4uQIZcU
         bTKyqtDXE9egY8zgrQ4bcQYtVAqtMfjgSp9o+jo1mQg8h0x4M55rsQjmlXSuuFjMbJsn
         Zl4g==
X-Gm-Message-State: AC+VfDzHcZaA70EURqPELBlY6B7lNPApiYEqDhbHJWTTwiJgSd3lI8GO
        sCybTYBX59SLEuIR/z9iq8E=
X-Google-Smtp-Source: ACHHUZ4zagpsQ+SjZ4Qm58lG7Do6V5t3Qo41xpHVOqY52Y6876LAbjAqiXp98gMaeErSNLCycz6LFw==
X-Received: by 2002:a17:902:aa96:b0:1b0:4687:ba0c with SMTP id d22-20020a170902aa9600b001b04687ba0cmr151029plr.8.1685641512798;
        Thu, 01 Jun 2023 10:45:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001b01547d0e8sm3794525plg.142.2023.06.01.10.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:45:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8bd7d122-18b5-b9b4-0090-6344caf903fd@roeck-us.net>
Date:   Thu, 1 Jun 2023 10:45:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-5-nick.hawkins@hpe.com>
 <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net>
 <DM4PR84MB19274F575858CBCB2FA5C23E88489@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <b1d8f851-4e87-333c-229c-b9dc37ea3c40@roeck-us.net>
 <DM4PR84MB19273A008BB11589CEEF697188499@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CACRpkdarJCSCif+r1e_jXbbAgv03OgGAO6pkW9x-yiYZJxdGeQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CACRpkdarJCSCif+r1e_jXbbAgv03OgGAO6pkW9x-yiYZJxdGeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 10:11, Linus Walleij wrote:
> On Thu, Jun 1, 2023 at 5:48 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> 
>> Thank you for your valuable feedback with the solutions you have provided.
>> Before I proceed though I have a quick query about the fan driver.
>> If I were to let the user space "own" gpio pins, would it be permissible for
>> the userspace to feed a kernel driver data via sysfs?
>>
>> Ex:
>> GPIO Driver -> (OpenBMC) -> Fandriver (sysfs).
>>
>> Here the GPIO driver would provide fan presence information to OpenBMC
>> and then OpenBMC would provide fan presence info to the fan driver.
> 
> But why? Don't be so obsessed about userspace doing stuff using
> sysfs, usually it is a better idea to let the kernel handle hardware.
> 
> I think this is a simple thermal zone you can define in the device
> tree as indicated in my previous comment.
> 
>> If it were permissible to provide data to the driver via this method I could
>> apply it to the PSU driver as well. the PSU driver which requires presence
>> info to verify a PSU is inserted / removed.
> 
> It feels like you are looking for a way for two drivers to communicate
> with each other.
> 
> This can be done several ways, the most straight-forward is notifiers.
> include/linux/notifier.h
> 

This is all unnecessary. The hwmon driver could register a gpio pin,
including interrupt, and then report state changes to userspace with
sysfs or udev events on the registered hwmon sysfs attributes.

If they really want to use userspace for everything, they should
just use userspace for everything and not bother with a kernel driver.

Guenter

