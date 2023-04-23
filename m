Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A46EC0CC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDWP23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDWP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:28:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1B510E4;
        Sun, 23 Apr 2023 08:28:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24736992dd3so2378933a91.1;
        Sun, 23 Apr 2023 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682263706; x=1684855706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3Eu4k72Ucvdn/BUleBlCM3imQ7w0xRLbGLWiYnDOlwg=;
        b=L5HFsqkRB7t6Vs8LoDa9sGnVnWbbaUhWvawz3uOr3N8PxYywaJH4o3ryS/iyIzZ0Mr
         L+yRc0XT4YNtVOvozFWmWbyon5aOISy1oJFRj7Zhj0AWoNkQLXGhtPK+IsKA+Trqcbzc
         iNSYK7qhxCrSVDKSvQt5SZw5/oJIMXaYpPM6ZnNhOpzrKLjsem11BdHjmvM78cqU09ka
         WMyFk6jf7jZQwRUC5fU0+wlQvLlVabCcmEwbVV5ioa98+uIcasGb5iFVf/bQSnUmnEjS
         gOynuJBGGj5/96Txic6b0O48TKsQBBZuRMJp+LbRBmRqbmrvPHhpj1x8x3fLLgoolsBK
         pXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682263706; x=1684855706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Eu4k72Ucvdn/BUleBlCM3imQ7w0xRLbGLWiYnDOlwg=;
        b=A56rx9sXrVZDDLOosKrd1Uujs0YzjJckPGzu2MJ+Xap8oBcrnjiBIkxNi6PPSlnebg
         +37V3D1dByxEVxry9rOeZcTY+9V67WJwy+NG/B6HHNIAqIVSfkElH0+wfIy9746wONEq
         egF9/KTf97HkK3EIvihX+5U9pTo8qj+X3JrQ+uXA33sc1GZFSIJOXBgdGp8lKUzLXrW5
         pfsC88YrJUA1No6TdIHeJjI7T+UDG6jdtAF3czo2zApLeNaP+r1oAf4O1g8IvN3wW8fH
         niKVCRGXCGUwkPZpyVsCmhEKnWr9VRhQwyXzYIpXzBGSxoC0MCYsGc/1ysu8rzM0Lgf8
         s+Fg==
X-Gm-Message-State: AAQBX9fbvV20NwCVzzmAd8Wsv0HG+XIn0H9lKLDnbgP4V2j/6/fWY0ue
        bHigBviK6Yps0n0y+TrFOfg=
X-Google-Smtp-Source: AKy350Y4jywVCB32W0UTXS24nQNvRdmvGxJZGEoPazo52YLqbE9LOmDS+cOWjux9JOLAXkNsT4SC7A==
X-Received: by 2002:a17:90a:8c85:b0:247:5e62:3288 with SMTP id b5-20020a17090a8c8500b002475e623288mr11051472pjo.33.1682263705712;
        Sun, 23 Apr 2023 08:28:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a49c900b002353082958csm6867290pjm.10.2023.04.23.08.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 08:28:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4641afaf-9797-3a29-7eb1-8dadbf3b713d@roeck-us.net>
Date:   Sun, 23 Apr 2023 08:28:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH,RESEND] dt-bindings: watchdog: brcm,kona-wdt: convert to
 YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230423143951.GA10743@standask-GA-A55M-S2HP>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230423143951.GA10743@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/23 07:39, Stanislav Jakubek wrote:
> Convert Broadcom Kona family watchdog timer bindings to DT schema.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> RESEND because I originally sent this to the wrong maintainers and
> mailing lists by accident. Sorry for the noise.
> 

Is this patch supposed to replace / compete with the other patch
doing the same ?
https://patchwork.kernel.org/project/linux-watchdog/patch/20230418170341.28805-1-n2h9z4@gmail.com/

What is the difference, and what is the purpose ?

Guenter

>   .../bindings/watchdog/brcm,kona-wdt.txt       | 15 --------
>   .../bindings/watchdog/brcm,kona-wdt.yaml      | 37 +++++++++++++++++++
>   2 files changed, 37 insertions(+), 15 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
>   create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> deleted file mode 100644
> index 2b86a00e351d..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Broadcom Kona Family Watchdog Timer
> ------------------------------------
> -
> -This watchdog timer is used in the following Broadcom SoCs:
> -  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> -
> -Required properties:
> -  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> -  - reg: memory address & range
> -
> -Example:
> -	watchdog@35002f40 {
> -		compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> -		reg = <0x35002f40 0x6c>;
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> new file mode 100644
> index 000000000000..5de1b022847b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/brcm,kona-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Kona family watchdog timer
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm11351-wdt
> +      - const: brcm,kona-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@35002f40 {
> +        compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> +        reg = <0x35002f40 0x6c>;
> +    };
> +...

