Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE77462F707
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiKRORf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbiKRORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:17:05 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CE8369DE5;
        Fri, 18 Nov 2022 06:16:24 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Nov 2022 23:16:23 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DBCB520584CE;
        Fri, 18 Nov 2022 23:16:23 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 18 Nov 2022 23:16:23 +0900
Received: from [10.212.158.119] (unknown [10.212.158.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 36093B62BA;
        Fri, 18 Nov 2022 23:16:23 +0900 (JST)
Message-ID: <5483711f-504c-bcf3-0fbf-65d04530d188@socionext.com>
Date:   Fri, 18 Nov 2022 23:16:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Socionext F_OSPI controller
 bindings
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118005904.23557-1-hayashi.kunihiko@socionext.com>
 <20221118005904.23557-2-hayashi.kunihiko@socionext.com>
 <Y3du24GWN/enGORf@sirena.org.uk>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Y3du24GWN/enGORf@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for your comment.

On 2022/11/18 20:39, Mark Brown wrote:
> On Fri, Nov 18, 2022 at 09:59:03AM +0900, Kunihiko Hayashi wrote:
> 
>> +  socionext,cs-start-cycle:
>> +  socionext,cs-end-cycle:
>> +  socionext,cs-deassert-clk-cycle:
> 
> These are all generic SPI properties so we should add them
> generically, on the device rather than the controller since this
> is something that might vary per client device.  There was also a
> core function spi_set_cs_timing() which was in earlier versions
> and is about to get reintroduced.

So I understand you mean that these properties should be defined like
spi-peripheral-props.yaml for the devices.

If yes, I'll drop these properties once and define our vendor-specific
"peripheral-props" in the next series.

>> +  socionext,alternative-byte:
>> +    description:
>> +      Specify the extra bytes to transfer after address transfer.
> 
> This just doesn't seem like something the controller should be
> worrying about, the device should just send whatever the device
> needs sending.

This seems to be a feature added for the special devices,
so this should be device matter.

>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      - description: the number of bytes to transfer
>> +        maximum: 4
>> +      - description: value to transfer
>> +        default: 0
>> +      - description: bit-width to transfer
>> +        enum: [0, 1, 2, 4, 8]
> 
> This is also something SPI device should set up, as far as I can
> tell this should be set vis spi_mem_op.dummy.nbytes.

Yes, but the controller also supports dummy cycles, and can send
extra bytes before the dummy cycles.

>> +  socionext,data-swap-2byte:
>> +    description:
>> +      Indicates swap byte order per 2-bytes.
>> +    type: boolean
> 
>> +  socionext,data-swap-4byte:
>> +    description:
>> +      Indicates swap byte order per 4-bytes.
>> +    type: boolean
> 
> Again these should be set by the device.  I think these should be
> set based on a combination of bits per word and if the host is in
> big endian or little endian mode.

I see. This feature is complicated to use, so I'll not add it here.

Thank you,

---
Best Regards
Kunihiko Hayashi
