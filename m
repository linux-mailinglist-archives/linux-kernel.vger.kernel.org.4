Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9126A67A7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjAYA0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjAYA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:26:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55560521D3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:25:48 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jm10so16358976plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJMUKY3zTm6MQ75YsWGgU7PFwk59bDePXFG7Ge9OoWk=;
        b=2dvCJGjmKzjH5V+egK2r6k3mPZ+wGtMTgrO0Y2AJ45jUrZ0yMxzHpiQIUfptAPk60n
         Juv6Q35aZPqcb65MkchVgu+O+rtZk+Ny2siEy8W/B6z23DjZ5r8DfZ/OIlg+ztDxnBSW
         KNmYf+j6nj/OJnAXzzAtePu+0N16HCQYZtpotShZ8WSlpljP/xltsR79rLXdS/1onXHN
         KLSvPwFuhgNK46cgaVGnFT2GI8AgLN3FCpzmQYk7wf7xrMOtOrOAxuTuSRSWu9mk3Esj
         CpGVyfFDKFULiVnp1it+3Z9s0n0BrV88V/gli060MyahP435OSCf4kEznfhZs0R7q/Rb
         Clrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJMUKY3zTm6MQ75YsWGgU7PFwk59bDePXFG7Ge9OoWk=;
        b=5BibwiYjg/IUeJd7TUlTL81RE6MsO/Vek+TGNoo8szcqewLu9x/NSFKIlRm+B30Pzt
         3LqLNNPEkygMpNgaTiyJcG5f+2JcVlCcV2Myu/JUvSJh3mwS1iV8tY10sMRGd2myYtJq
         Fd6lu5JQ9cqAATTxOfm5Gyka1AKxoRh1rO78yd3qKa9+y4xNtU4IdlFUFGhobNeQZupg
         lLEX7ssEXgHUmFqeBfNVSD/CJD1MKzPgk3ab5M/F83LhtyQYDrKBwxVKuMLsSu9ZxWuj
         IHyTATnUKy4pQS5K7b0LXupumjqYxBTRxCHjT8RW5icavu7CYb+uPKyYRebe4RQvS4kW
         RLsg==
X-Gm-Message-State: AFqh2kqAWb47y/R8DFNg2DngzV/UJkdvbtD7gDKYZaT9t//nBlcHdXh2
        qBVqZgc9T+aMKoaWAEU7QAo5YQ==
X-Google-Smtp-Source: AMrXdXtUJ8P23fSUzQuB7DsEKfl2XNjY2yacBcfoITkTQ3RLFH0GLWO5VixcRx4bdkAn8A0w2uskdw==
X-Received: by 2002:a17:902:e8c1:b0:192:ac33:7f91 with SMTP id v1-20020a170902e8c100b00192ac337f91mr26672038plg.69.1674606345169;
        Tue, 24 Jan 2023 16:25:45 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b00186b3c3e2dasm2243159plo.155.2023.01.24.16.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:25:44 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
Subject: Re: [PATCH V6 1/3] dt-bindings: clock: document Amlogic S4 SoC PLL
 & peripheral clock controller
In-Reply-To: <9c34a8fc-de76-4beb-8841-9bcfd1a55cd1@amlogic.com>
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-2-yu.tu@amlogic.com>
 <02b6b3a6-e2ad-8cbc-fa15-fbd2db6ada64@linaro.org>
 <7c0133a2-ea4d-645e-3df2-2bb832bbd498@amlogic.com>
 <7hwn5jqrxf.fsf@baylibre.com>
 <9c34a8fc-de76-4beb-8841-9bcfd1a55cd1@amlogic.com>
Date:   Tue, 24 Jan 2023 16:25:40 -0800
Message-ID: <7ho7qnh33v.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Tu <yu.tu@amlogic.com> writes:

> Hi Kevin,
>
> On 2023/1/19 8:38, Kevin Hilman wrote:
>> [ EXTERNAL EMAIL ]
>> 
>> Yu Tu <yu.tu@amlogic.com> writes:
>> 
>>> On 2023/1/16 16:29, Krzysztof Kozlowski wrote:
>> 
>> [...]
>> 
>>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>>> new file mode 100644
>>>>> index 000000000000..bbec5094d5c3
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>>> @@ -0,0 +1,131 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>>
>>>> Unusual license... are you sure to license the bindings under GPLv4 or
>>>> GPLv5? Fine by me.
>>>>
>>>
>>> Yes.
>> 
>> The rest of the bindings for Amlogic SoCs are GPL-2.0 (without the '+').
>> Adding the dual-license for MIT seems fine, but adding the '+' is
>> curious.
>> 
>> It would be helpful if you could please explain why you'd like these
>> bindings to be licensed differently than the rest of the SoC family.
>> 
>
> I actually refer to the previous g12a Soc.
> https://elixir.bootlin.com/linux/v6.2-rc4/source/include/dt-bindings/clock/g12a-clkc.h
> https://elixir.bootlin.com/linux/v6.2-rc4/source/include/dt-bindings/clock/axg-clkc.h
> [...]
>
> So if you think it is not necessary, I will delete the '+' as you 
> suggested. Don't know what you choose?

Drop the `+`

Kevin
