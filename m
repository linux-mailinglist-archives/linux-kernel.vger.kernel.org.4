Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395605FA025
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJJOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJJOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:24:03 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383626527B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:24:02 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id A809A1F660;
        Mon, 10 Oct 2022 16:23:59 +0200 (CEST)
MIME-Version: 1.0
Date:   Mon, 10 Oct 2022 16:10:42 +0200
From:   konrad.dybcio@somainline.org
To:     Rob Herring <robh@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: apple,aic: Document A7-A11
 compatibles
In-Reply-To: <20221010122727.GA432201-robh@kernel.org>
References: <20221007200022.22844-1-konrad.dybcio@somainline.org>
 <20221007200022.22844-2-konrad.dybcio@somainline.org>
 <20221010122727.GA432201-robh@kernel.org>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <0ff2cede3ac644141ba66f54244eb069@pop.somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-10 14:27, Rob Herring wrote:
> On Fri, Oct 07, 2022 at 10:00:21PM +0200, Konrad Dybcio wrote:
>> Document the compatibles for Apple A7-A11 SoCs.
>> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>> Changes since v3:
>> - Bindings: A7-A10+M1 only get SoC compat and generic fallback,
>> A11 gets M1 fallback and generic fallback (removed A11 compatible)
> 
> I have no idea if that makes sense or not. Do I have to go read the
> rationale in the prior version?
> 
> The question to ask on fallbacks, is would s/w that only understands 
> the
> fallback compatible work as-is?
Yep, A7-A10 share the same feature level ("apple,aic"), but I think 
having a separate, per-SoC
compatible in the DT from the get-go makes a lot of sense, since we're 
not sure what's gonna happen
when we, for example, add SMP support for these older chipsets, maybe 
they'll need some special
handling.

Similar story with A11 and M1. They can both work with "apple,aic", but 
they also support things
that are enabled with the "apple,t8103-aic" compat string.

I do not plan on adding specific compatibles for A7-A11 SoCs in the 
driver, unless we uncover some
bugs / deviations.

Konrad

> 
>> - Drop Rob's A-b as this is essentially yet another rewrite..
>> 
>>  .../bindings/interrupt-controller/apple,aic.yaml | 16 
>> +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml 
>> b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> index e18107eafe7c..1427ea9b04a2 100644
>> --- 
>> a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> @@ -36,9 +36,19 @@ allOf:
>> 
>>  properties:
>>    compatible:
>> -    items:
>> -      - const: apple,t8103-aic
>> -      - const: apple,aic
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - apple,s5l8960x-aic
>> +              - apple,s8000-aic
>> +              - apple,t7000-aic
>> +              - apple,t8010-aic
>> +              - apple,t8103-aic
>> +          - const: apple,aic
>> +      - items:
>> +          - const: apple,t8015-aic
>> +          - const: apple,t8103-aic
>> +          - const: apple,aic
>> 
>>    interrupt-controller: true
>> 
>> --
>> 2.37.3
>> 
>> 
