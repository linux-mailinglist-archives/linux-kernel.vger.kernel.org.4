Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015DF6FEE64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEKJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEKJMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:12:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB88F;
        Thu, 11 May 2023 02:12:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f42b984405so21219555e9.3;
        Thu, 11 May 2023 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796324; x=1686388324;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=pnafcl02etMrYNZASMiERvbl/U+JxONMdNxYsuSq0xQ=;
        b=ol1gXP5tsJHILHK+8uKNFWsFILHNuSYxMMJ3ivVJj0b4v7/d0TJoN+V1Z/iViEXK+p
         AVl7yS8rvJU1RSheMbowSjCpvzSctqK+l/Pclepi4XPoPWqBTVvc1SrOai0kS1ixVL90
         dD7VOZuVN2G65q0K9519UUG3zvcTwalWMskx1n6MBrkuOT+Aa1387qwAEYya4ts2zmzz
         4TZuVR7ECc+z9b5A+QwaxE480n/dOkIVyS07OJ1dh+lRiYEY+tj93JRMR0mwlfHrlX1u
         nMdoEXkzKtkTVW0Xz7DPpahAw8Zt5u7ssoURwGg1ueqrXD8v/V/EAci8NStGxE++vYtT
         SMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796324; x=1686388324;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnafcl02etMrYNZASMiERvbl/U+JxONMdNxYsuSq0xQ=;
        b=Z8AZ75kclua3FkksDlFR4bkcYG2pdRvSEADuR4qTdClXqqIkDcR0dZBqHBevQwU5Aj
         lbBsUs1tfbz1RZOhwjYY5dN7xzUoAvycLH5QHP8K9lSgYu48aiHG3jDY29n1L9MYtS4G
         nWRfd60LBy+z/9DKJhKrfUD2zy04hEn00mTHs+7IYEgUeI9cX4h9T2/FFCvuogqnBpOV
         /spWf7nL/E+C9M6WJR2rj623D9dwxt4t3qtZS/VIndx5w1LFQ2uxDfXhYF7RPgyf2PWX
         jloSDijebQpliPGC9ac+K7Sya3RT0WBZFAmS1AQ9uqSA/5YSRrHzdDDmjVh7Uc9vvRSf
         hEQA==
X-Gm-Message-State: AC+VfDzaA+l7JmvP78rOvagB27Z3zuju/2DPQZ14NTad3ERlo1RSVvTL
        kHeAY6S2hcG80nARmYd3snU=
X-Google-Smtp-Source: ACHHUZ6MXl59aa1AWNAr7h3bDg9yAizIbCbY29vLEWjDUq4ITKp4XBManCmNPTvuU/HpS5mgeSXEBQ==
X-Received: by 2002:a05:600c:204e:b0:3f4:ebfb:7414 with SMTP id p14-20020a05600c204e00b003f4ebfb7414mr794698wmg.1.1683796323506;
        Thu, 11 May 2023 02:12:03 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b003f1957ace1fsm24959021wml.13.2023.05.11.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:12:03 -0700 (PDT)
References: <20230510151542.312588-1-aidanmacdonald.0x0@gmail.com>
 <20230510151542.312588-2-aidanmacdonald.0x0@gmail.com>
 <20230510-rage-amazingly-d090d1e838f0@spud>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: mfd: add bindings for AXP192 MFD
 device
Date:   Thu, 11 May 2023 10:11:23 +0100
In-reply-to: <20230510-rage-amazingly-d090d1e838f0@spud>
Message-ID: <zbeLZZMhaBipXvZQZrMkRktJ8jiXpfNG@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Conor Dooley <conor@kernel.org> writes:

> [[PGP Signed Part:Undecided]]
> On Wed, May 10, 2023 at 04:15:42PM +0100, Aidan MacDonald wrote:
>> The AXP192 is another X-Powers PMIC similar to the existing ones.
>
> In the driver patch the commit message says:
> | The AXP192 PMIC is similar to the AXP202/AXP209, but with different
> | regulators, additional GPIOs, and a different IRQ register layout.
>
> That'd be nice to have in the commit message here too, to explain why
> you're adding to the enum rather than listing a fallback.
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>

Will do, I'll send a v2 shortly.

Regards, Aidan

>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
>> index f7f0f2c0421a..9ad55746133b 100644
>> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
>> @@ -90,6 +90,7 @@ properties:
>>      oneOf:
>>        - enum:
>>            - x-powers,axp152
>> +          - x-powers,axp192
>>            - x-powers,axp202
>>            - x-powers,axp209
>>            - x-powers,axp221
>> --
>> 2.39.2
>>
>
> [[End of PGP Signed Part]]
