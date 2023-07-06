Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E122B749634
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjGFHUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjGFHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:20:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357981BEB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:20:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so4440461fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688628000; x=1691220000;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=cMM/JKhymf2QTww3ufNFI5eYv4LI0VojyRQq8UqQbR0=;
        b=TCngYVh5UCe5aCujjz8cVO6NfM+vf4AaK153X9x8q1taYuWwF2V2S748W9YntSs0Vs
         /Ce6vCDiIO8VxO8WnoCOzoFt4lE5jQ91NqmQ2ILCSA6VfjoJmRNPRN/CIfMgwTawXNt1
         YGsjfKWsphZP0ryythXMVprouE2vn7FKLJQ2gug32NOG5HMcG9SmkNVtpvW32OfT6xwR
         h2xBoTyQa4o5BkajN+RrqkRN2xBTCSmKyD+IzxxKZnB2hIjuT9+9emA7x2oAJbPNPK7x
         GpjHBTGiAln/vqjmjm4L+hafxgMq6rMPP3X89torWeIUob/ImptdOujse03LWkreJ+e+
         J6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688628000; x=1691220000;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMM/JKhymf2QTww3ufNFI5eYv4LI0VojyRQq8UqQbR0=;
        b=Jz+tAcKgFCAXcFwggMLr9qG/ettbrHYDIJ0p5ihWzVI40UTjdV+4cBNI1e7wN5icWa
         tQzV76HF+ttzV5yCOXg+6tfnX9Zmx5tZHqJJbvzeMo+wbyRblBRkNmRypHPdxNzDaee3
         L4XHuo3QucyAmwNA98y7C+U5bP7BtGRFxnQLx52zuQa6c26wt2XGdR4VkFMIdBpDMKdj
         Jrg4Arqo20XtUpDVF8C2Q8OEVucxdYqsXS+T5hZbZt/UgAub34cPZQAUpXGrVHfdXZwq
         GJxr+02u58ogwyVJ77AXqVh6tcTlAq/TPrd0QMI0NPaEqqkbzHm3I9exmZSOJLNNNM6k
         kL/Q==
X-Gm-Message-State: ABy/qLZKMeUpPjCi9lhIytHb3s9rY0GQMZ1MI0iJmUwpzJekBjUl9vov
        Fxvqx1JQC0nHimH0BjdsqvAfLA==
X-Google-Smtp-Source: APBJJlEOfmx5Lxbc0GW0fcG8wpIqHoQsATTy4OBvCxJoECYIzBSWj41jCXVmvIRvuEdF+uNWBta9jg==
X-Received: by 2002:a2e:8908:0:b0:2b6:ee1c:216a with SMTP id d8-20020a2e8908000000b002b6ee1c216amr669843lji.34.1688628000429;
        Thu, 06 Jul 2023 00:20:00 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb0:4a33:b29e:11b3:752b])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b003112f836d4esm1033839wrm.85.2023.07.06.00.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 00:20:00 -0700 (PDT)
References: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
 <20230705-b4-amlogic-bindings-convert-take2-v2-2-22be915ddc3b@linaro.org>
 <20230705195631.GA1732680-robh@kernel.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-aoclkc.txt to dt-schema
Date:   Thu, 06 Jul 2023 09:15:26 +0200
In-reply-to: <20230705195631.GA1732680-robh@kernel.org>
Message-ID: <1jttuh5www.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 05 Jul 2023 at 13:56, Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 05, 2023 at 01:41:52PM +0200, Neil Armstrong wrote:
>> Convert the Amlogic Always-On Clock Controller bindings to dt-schema.
>> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>  .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 -------------
>>  .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 101 +++++++++++++++++++++
>>  2 files changed, 101 insertions(+), 64 deletions(-)
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> deleted file mode 100644
>> index c41f0be5d438..000000000000
>> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> +++ /dev/null
>> @@ -1,64 +0,0 @@
>> -* Amlogic GXBB AO Clock and Reset Unit
>> -
>> -The Amlogic GXBB AO clock controller generates and supplies clock to various
>> -controllers within the Always-On part of the SoC.
>> -
>> -Required Properties:
>> -
>> -- compatible: value should be different for each SoC family as :
>> -	- GXBB (S905) : "amlogic,meson-gxbb-aoclkc"
>> -	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
>> -	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
>> -	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
>> -	- G12A (S905X2, S905D2, S905Y2) : "amlogic,meson-g12a-aoclkc"
>> -	followed by the common "amlogic,meson-gx-aoclkc"
>> -- clocks: list of clock phandle, one for each entry clock-names.
>> -- clock-names: should contain the following:
>> -  * "xtal"     : the platform xtal
>> -  * "mpeg-clk" : the main clock controller mother clock (aka clk81)
>> -  * "ext-32k-0"  : external 32kHz reference #0 if any (optional)
>> -  * "ext-32k-1"  : external 32kHz reference #1 if any (optional - gx only)
>> -  * "ext-32k-2"  : external 32kHz reference #2 if any (optional - gx only)
>> -
>> -- #clock-cells: should be 1.
>> -
>> -Each clock is assigned an identifier and client nodes can use this identifier
>> -to specify the clock which they consume. All available clocks are defined as
>> -preprocessor macros in the dt-bindings/clock/gxbb-aoclkc.h header and can be
>> -used in device tree sources.
>> -
>> -- #reset-cells: should be 1.
>> -
>> -Each reset is assigned an identifier and client nodes can use this identifier
>> -to specify the reset which they consume. All available resets are defined as
>> -preprocessor macros in the dt-bindings/reset/gxbb-aoclkc.h header and can be
>> -used in device tree sources.
>> -
>> -Parent node should have the following properties :
>> -- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
>> -- reg: base address and size of the AO system control register space.
>> -
>> -Example: AO Clock controller node:
>> -
>> -ao_sysctrl: sys-ctrl@0 {
>> -	compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
>> -	reg =  <0x0 0x0 0x0 0x100>;
>> -
>> -	clkc_AO: clock-controller {
>> -		compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
>> -		#clock-cells = <1>;
>> -		#reset-cells = <1>;
>> -		clocks = <&xtal>, <&clkc CLKID_CLK81>;
>> -		clock-names = "xtal", "mpeg-clk";
>> -	};
>> -
>> -Example: UART controller node that consumes the clock and reset generated
>> -  by the clock controller:
>> -
>> -	uart_AO: serial@4c0 {
>> -		compatible = "amlogic,meson-uart";
>> -		reg = <0x4c0 0x14>;
>> -		interrupts = <0 90 1>;
>> -		clocks = <&clkc_AO CLKID_AO_UART1>;
>> -		resets = <&clkc_AO RESET_AO_UART1>;
>> -	};
>> diff --git
>> a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
>> b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
>> new file mode 100644
>> index 000000000000..0adcfbcf5c85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
>> @@ -0,0 +1,101 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,gxbb-aoclkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Always-On Clock Controller
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - amlogic,meson-gxbb-aoclkc
>> +              - amlogic,meson-gxl-aoclkc
>> +              - amlogic,meson-gxm-aoclkc
>> +              - amlogic,meson-axg-aoclkc
>> +          - const: amlogic,meson-gx-aoclkc
>> +      - enum:
>> +          - amlogic,meson-axg-aoclkc
>> +          - amlogic,meson-g12a-aoclkc
>> +
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 5
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 5
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
>> +  - '#reset-cells'
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - amlogic,meson-gxbb-aoclkc
>> +
>> +    then:
>> +      properties:
>> +        clock-names:
>> +          minItems: 2
>> +          items:
>> +            - const: xtal 
>> +            - const: mpeg-clk
>> +            - const: ext-32k-0
>> +            - const: ext-32k-1
>> +            - const: ext-32k-2
>
> As the names are always the same, move this to top-level and just set 
> the length here (except the constraints are the same as top-level, so 
> you can just drop this if/then).

If this is done, aren't we losing information ?

For example, "ext-32k-1" would become valid with a g12a as long as the
number of clocks is alright, which it is not.

I'm not concerned by the automated verification, more the information
provided to the users, which we used to have in the txt format.

>
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - amlogic,meson-g12a-aoclkc
>> +
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 3
>> +
>> +        clock-names:
>> +          minItems: 2
>> +          items:
>> +            - const: xtal 
>> +            - const: mpeg-clk
>> +            - const: ext-32k-0
>
> Just 'maxItems: 3'
>
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - amlogic,meson-gxl-aoclkc
>> +            - amlogic,meson-gxm-aoclkc
>> +            - amlogic,meson-axg-aoclkc
>> +
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 2
>> +
>> +        clock-names:
>> +          items:
>> +            - const: xtal 
>> +            - const: mpeg-clk
>
> maxItems: 2
>
>> +
>> +additionalProperties: false
>> 
>> -- 
>> 2.34.1
>> 

