Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B3691111
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBITOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBITOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:14:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9580E8A58;
        Thu,  9 Feb 2023 11:14:33 -0800 (PST)
Received: from [192.168.1.90] (unknown [86.120.32.152])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9E0966020CE;
        Thu,  9 Feb 2023 19:14:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675970072;
        bh=UITjvKFtBFIU7eyLYMT0x/CRHRnXh/iOOdcpo4cUrSU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WDRmZuWu0I4VSCsTIMXaxccFxr6hRNpITjW4J28iumja2Z9s6UohwxVOCucXA42xP
         EaidOjgHWCHjY3bD1CNw8Aut5Gvm/cN31Jy6nFoexWxEJi9itpi6qtj6vcFcWT9j7D
         uvG7XTBYNvL4HXd2Hhm+zdLds4iURD5g/HXVfalvevn8psGwEhRxawpt6C84rvn73D
         i/kPofmRAbmxFnqbXz6EkHKqKRKz4Q6a24CtWNwZLQUZoSU/7LJHlkBiwrIRP1magq
         Lxy4bQ43lckeSF4I1jYMGc7PjjJDQ5OUaU4NYXMpEHwZXzqvm9dKSvgYfJko3OUOzl
         N2svv6j0BU5qA==
Message-ID: <10a16e9b-a796-9699-ca70-99eba7175e76@collabora.com>
Date:   Thu, 9 Feb 2023 21:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/1] dt-bindings: Fix multi pattern support in
 DT_SCHEMA_FILES
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230209002634.745163-1-cristian.ciocaltea@collabora.com>
 <20230209185620.GA624026-robh@kernel.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20230209185620.GA624026-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 20:56, Rob Herring wrote:
> On Thu, Feb 09, 2023 at 02:26:34AM +0200, Cristian Ciocaltea wrote:
>> DT_SCHEMA_FILES used to allow specifying a space separated list of file
>> paths, but the introduction of partial matches support broke this
>> feature:
> 
> That only happened to work by chance...
> 

Yeah, I remember you mentioned that a while ago when I provided a 
similar fix (96993a59f94d). I still find this useful, though..

>>
>> $ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml path/to/schema2.yaml"
> 
> Spaces are valid in filenames though we avoid them. Perhaps it would be
> better to use ':'.

Agree, will handle this in v2.

>> [...]
>>    LINT    Documentation/devicetree/bindings
>> usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [...]
>>                  [-v]
>>                  [FILE_OR_DIR ...]
>> yamllint: error: one of the arguments FILE_OR_DIR - is required
> 
> I think this also happens if nothing matches.
> 
>> [...]
>>
>> Restore the lost functionality by preparing a grep filter that is able
>> to handle multiple search patterns.
>>
>> Fixes: 309d955985ee ("dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES")
>>
> 
> Should be no blank line.

Thanks for noticing, that was unintentional.

>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
>> index bf2d8a8ced77..5475c25ae803 100644
>> --- a/Documentation/devicetree/bindings/Makefile
>> +++ b/Documentation/devicetree/bindings/Makefile
>> @@ -28,7 +28,7 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>>   find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
>>   		-name 'processed-schema*' \)
>>   
>> -find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
>> +find_cmd = $(find_all_cmd) | grep -F -e "$(subst $() ," -e ",$(strip $(DT_SCHEMA_FILES)))"
>>   CHK_DT_DOCS := $(shell $(find_cmd))
>>   
>>   quiet_cmd_yamllint = LINT    $(src)
>> -- 
>> 2.39.1
>>
