Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20DA749712
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjGFIFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFIFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:05:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31286124
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:05:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso2906815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688630726; x=1691222726;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zJHWi0dKqNhNEFb0P2yrmf3OGLkGZqjsHWf4Z19C/yk=;
        b=Zp3D4DRuWFgPbPNbJZaRkRdVCKJUNLkXwvScJ0MfjjHchKBoNAA/6/G3t0ovPvhY+3
         mn5ax++SedHlInpD2KmtCLfUsuda8Y5nHRUf+7LOtyT2l+YK0AMmil2DjZSXT8dFpfB5
         mPl+ScXd5+w+ElzZtEVTeznnIsSQjFtdyccXhpYCN1XC7Q/tYUEQccI70NenQ6ebuA4M
         DBSJSnhv9aQl4eHzsMjzzpUMNS+BIBvj52ba1pP/P/pNchFduVSe9sbQOHKMhyChUkNn
         9qcHWOuYskJLZBFv9zzA7Htp/1wlk2GFXHt5EnDcOJOBDJVErkHzS0637m8E0eASFzKQ
         QD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630726; x=1691222726;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJHWi0dKqNhNEFb0P2yrmf3OGLkGZqjsHWf4Z19C/yk=;
        b=gEjbbZdvyBULCd6lmEqoG+6e2cJhBMSXRP8P+icqLnw8gNKkuglQtnb+iHYvQMufDt
         5MV50W3M8v8DPQs+RzJp32ZA6AJ7BvZ7DcHE73rn6S2PPfC1sSfOMpXXH4SYRVq/oZKQ
         FfKBGlIUNO7nsrmYJvaNAtLWZK4lFmOEcd79kGnIinEMr4Frf0LoBJz3OQHoGqRktt4g
         rIKoHNKBUv/GdTDpwsBl3RTzyFREp3skkJq2Max2ccdRicma7EoXy79RlD/1T68K7F56
         A09olYZEbx33oTV+LiIBwc1uSVeykL4ZI9OF7GH885alnYlXNYuAXlZokOMcH4w1kawU
         XMog==
X-Gm-Message-State: ABy/qLZpKFwV4ugPSlZqvma17a9NtbTRFvzW1lf3+jjpxRlRf2LRBZcL
        uXx/u3HUHZyuZysC28QdY/7bgz87SzOM8xl5ybA=
X-Google-Smtp-Source: APBJJlEYhCxm6pyqAs9nqvYnWqjDAvElsQCZ7tCEFYVVzKXx31jc4bQGlKqT2o4Gce1OGcJdhpmu7Q==
X-Received: by 2002:a7b:c8d4:0:b0:3fb:e1d0:6417 with SMTP id f20-20020a7bc8d4000000b003fbe1d06417mr4265922wml.19.1688630726546;
        Thu, 06 Jul 2023 01:05:26 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb0:4a33:b29e:11b3:752b])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c22d100b003fbca05faa9sm1315735wmg.24.2023.07.06.01.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:05:26 -0700 (PDT)
References: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
 <20230705-b4-amlogic-bindings-convert-take2-v2-2-22be915ddc3b@linaro.org>
 <20230705195631.GA1732680-robh@kernel.org>
 <1jttuh5www.fsf@starbuckisacylon.baylibre.com>
 <e1e12c86-da0d-0ae0-0542-86bdc4c81bb3@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
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
Date:   Thu, 06 Jul 2023 10:03:32 +0200
In-reply-to: <e1e12c86-da0d-0ae0-0542-86bdc4c81bb3@linaro.org>
Message-ID: <1jpm555ut6.fsf@starbuckisacylon.baylibre.com>
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


On Thu 06 Jul 2023 at 09:51, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/07/2023 09:15, Jerome Brunet wrote:
>>>> +    then:
>>>> +      properties:
>>>> +        clock-names:
>>>> +          minItems: 2
>>>> +          items:
>>>> +            - const: xtal 
>>>> +            - const: mpeg-clk
>>>> +            - const: ext-32k-0
>>>> +            - const: ext-32k-1
>>>> +            - const: ext-32k-2
>>>
>>> As the names are always the same, move this to top-level and just set 
>>> the length here (except the constraints are the same as top-level, so 
>>> you can just drop this if/then).
>> 
>> If this is done, aren't we losing information ?
>> 
>> For example, "ext-32k-1" would become valid with a g12a as long as the
>> number of clocks is alright, which it is not.
>
> How it would be valid? It would be fourth item but only three are allowed.
>

I missed that the order in 'items' mattered. Thanks for the
clarification.

>> 
>> I'm not concerned by the automated verification, more the information
>> provided to the users, which we used to have in the txt format.
>
> No information is lost here, unless you claim that entries are entirely
> different?
>
>
> Best regards,
> Krzysztof

