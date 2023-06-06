Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A2724BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbjFFS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbjFFS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9429E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686077764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LE0zlkK0Esy2QlS2Gp22uMzjSQSBkqRGf4r5LqwTAGQ=;
        b=eW82TLC4ZosgOjBluXPTckRAzV1rxxxe+NogTFvXzGvPcrTqaOxz7a48EUwePDqBaJgryE
        Q4u+m7zwa6IC9C0doBN1fMUtBp5qJwM+rQxczxy8UNeqACtfOeR/oEHtcpwtnBIgtD+9Zl
        xiqR4CO5YeRW/sQwMjWWY10u3dtK0fk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-gbcUklX7MxCTO32uC2Uqbg-1; Tue, 06 Jun 2023 14:56:02 -0400
X-MC-Unique: gbcUklX7MxCTO32uC2Uqbg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5142da822cbso11535a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077761; x=1688669761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LE0zlkK0Esy2QlS2Gp22uMzjSQSBkqRGf4r5LqwTAGQ=;
        b=Pb7m/aqfFh86SqRFaYAOLSOmASwRbV/kIQVn6vsfZYtdDqJmrOBfMzb3vXM4+adSPf
         m/k2+UzHuC4WbwjIh8ptMN2ukE+uTnAKCiGPIapEpmyzw5ZiAKWPXggQuGrNFzUZ1MZ6
         Ekyl0UNSCd0aXeFp5nVZWblOnm0wNBh3CbEgundvlpqgI9Lk+lPk+Uos7GG962dHVwAO
         OUw/E6DW5Q8bajS/+LdIZopm7lfAHClr4wCjaISud096M0vm+ODRZkTyxyY8UK/k4Aut
         gCIRLT79XQ2lQIAeVAWDWfDcZNrzsViaaNRTgHyDa7wTmaM9juMxQPdDv9LdmpyiIfB+
         1vbw==
X-Gm-Message-State: AC+VfDwBQllEwgGgu00pGgfgKtxoTx4Z2Oi23kr4DaA/FGm+JIX3YOt0
        c5qkDVw481w7i9vqroOGbj4xY4XayT+VX3iJh3WBq66220JEYUTlab4HroSAad+sHMLkVpl3QD4
        iWFuoMAnqpZeCeOu2ZEl1GgQA
X-Received: by 2002:a17:907:94d6:b0:96f:905e:6117 with SMTP id dn22-20020a17090794d600b0096f905e6117mr3640953ejc.56.1686077761707;
        Tue, 06 Jun 2023 11:56:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cXhiJ5i+1LwJ/b/vtSM76Z2jdjV+ztB2B6zIEYsNRP1PxHkp/3US7hq/6SbKn7rQ9ptdINw==
X-Received: by 2002:a17:907:94d6:b0:96f:905e:6117 with SMTP id dn22-20020a17090794d600b0096f905e6117mr3640938ejc.56.1686077761370;
        Tue, 06 Jun 2023 11:56:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id u12-20020a1709060b0c00b009749b769c95sm5606394ejg.158.2023.06.06.11.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 11:56:00 -0700 (PDT)
Message-ID: <1a7bdcc1-c737-83c4-24af-eb0028ed45f4@redhat.com>
Date:   Tue, 6 Jun 2023 20:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 0/4] input: touchscreen: add initial support for
 Goodix Berlin touchscreen IC
To:     neil.armstrong@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <f5f20de8-851a-fe20-4664-62b6de14ebd7@redhat.com>
 <2677ae8c-59d3-b658-dc3f-918838ac0fb6@linaro.org>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2677ae8c-59d3-b658-dc3f-918838ac0fb6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/6/23 20:12, Neil Armstrong wrote:
> Hi,
> 
> On 06/06/2023 17:31, Hans de Goede wrote:
>> Hi Neil,
>>
>> On 6/6/23 16:31, Neil Armstrong wrote:
>>> These touchscreen ICs support SPI, I2C and I3C interface, up to
>>> 10 finger touch, stylus and gestures events.
>>>
>>> This initial driver is derived from the Goodix goodix_ts_berlin
>>> available at [1] and [2] and only supports the GT9916 IC
>>> present on the Qualcomm SM8550 MTP & QRD touch panel.
>>>
>>> The current implementation only supports BerlinD, aka GT9916.
>>>
>>> Support for advanced features like:
>>> - Firmware & config update
>>> - Stylus events
>>> - Gestures events
>>> - Previous revisions support (BerlinA or BerlinB)
>>> is not included in current version.
>>>
>>> The current support will work with currently flashed firmware
>>> and config, and bail out if firmware or config aren't flashed yet.
>>
>> What I'm missing here / in the commit msg of
>> "input: touchscreen: add core support for Goodix Berlin Touchscreen IC"
>>
>> is an explanation why this is a new driver instead of adding
>> support to the existing goodix.c code.
>>
>> I assume you have good reasons for this, but it would be good
>> if you can write the reasons for this down.
> 
> Sure, should I write it down here and/or update the commit message in a new revision ?

Yes please add this to the commit msg for the next version.

> Anyway, here's the reasons:
> - globally the event handling "looks like" the current goodix.c, but again the offsets
> are again different and none of the register address are the same, and unlike the current
> support all registers are provided by the "ic_info" structure
> - while with the current code it *could* be possible to merge it, with a lot of changes,
> the firmware management looks really different, and it would be really hard to merge.
> 
> But I may be wrong, and may be misleaded by the goodix driver structure (even if it
> went through a really heavy cleaning process).

No doing a new separate driver sounds about right to me. The current goodix driver already has a lot of different code-paths. So since there does not seem to be a whole lot of code sharing potential adding yet more special case handling / paths is not desirable IMHO.

Regards,

Hans



>>> [1] https://github.com/goodix/goodix_ts_berlin
>>> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Neil Armstrong (4):
>>>        dt-bindings: input: document Goodix Berlin Touchscreen IC
>>>        input: touchscreen: add core support for Goodix Berlin Touchscreen IC
>>>        input: touchscreen: add I2C support for Goodix Berlin Touchscreen IC
>>>        input: touchscreen: add SPI support for Goodix Berlin Touchscreen IC
>>>
>>>   .../bindings/input/touchscreen/goodix-berlin.yaml  |  81 ++
>>>   drivers/input/touchscreen/Kconfig                  |  33 +
>>>   drivers/input/touchscreen/Makefile                 |   3 +
>>>   drivers/input/touchscreen/goodix_berlin.h          | 228 +++++
>>>   drivers/input/touchscreen/goodix_berlin_core.c     | 935 +++++++++++++++++++++
>>>   drivers/input/touchscreen/goodix_berlin_i2c.c      |  76 ++
>>>   drivers/input/touchscreen/goodix_berlin_spi.c      | 183 ++++
>>>   7 files changed, 1539 insertions(+)
>>> ---
>>> base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
>>> change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c
>>>
>>> Best regards,
>>
> 

