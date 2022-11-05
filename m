Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3EA61DEB1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKEVhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKEVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:37:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798712AD6
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:36:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id rQqRoPhJJiBgArQqRokrFb; Sat, 05 Nov 2022 22:36:56 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 05 Nov 2022 22:36:56 +0100
X-ME-IP: 86.243.100.34
Message-ID: <e22ecdd4-5a46-b573-6a41-f0c980722f0b@wanadoo.fr>
Date:   Sat, 5 Nov 2022 22:36:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH -next v2] checkpatch: Add check for array allocator family
 argument order
To:     Joe Perches <joe@perches.com>, Liao Chang <liaochang1@huawei.com>,
        apw@canonical.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        pbonzini@redhat.com
References: <20221104070523.60296-1-liaochang1@huawei.com>
 <dc5a7c79-af45-0e64-80fa-9f1ca8907033@wanadoo.fr>
 <85bcafd00fbbf9c8199ce9d10cfa959791a1b96a.camel@perches.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <85bcafd00fbbf9c8199ce9d10cfa959791a1b96a.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 05/11/2022 à 18:24, Joe Perches a écrit :
> On Fri, 2022-11-04 at 18:08 +0100, Christophe JAILLET wrote:
>> Le 04/11/2022 à 08:05, Liao Chang a écrit :
>>> These array allocator family are sometimes misused with the first and
>>> second arguments switchted.
>>>
>>> Same issue with calloc, kvcalloc, kvmalloc_array etc.
>>>
>>> Bleat if sizeof is the first argument.
>>>
>>> Link: https://lore.kernel.org/lkml/5374345c-7973-6a3c-d559-73bf4ac15079@redhat.com/
>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>> Acked-by: Joe Perches <joe@perches.com>
>>> ---
>>> v2:
>>> 1. Acked-by Joe Perches.
>>> 2. Use lore links in Link tag.
>>>
>>> ---
>>>    scripts/checkpatch.pl | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> index 1e5e66ae5a52..a9a9dc277cff 100755
>>> --- a/scripts/checkpatch.pl
>>> +++ b/scripts/checkpatch.pl
>>> @@ -7128,7 +7128,7 @@ sub process {
>>>    		}
>>>    
>>>    # check for alloc argument mismatch
>>> -		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
>>> +		if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>>>    			WARN("ALLOC_ARRAY_ARGS",
>>>    			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>>>    		}
>> Hi,
>>
>> Should the devm_ and not devm_ cases be separated?
>>
>> In the devm_case, sizeof will never be just after the first '('.
> Right.
>
> Likely this works better:
> ---
>   scripts/checkpatch.pl | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7be93c3df2bcb..7f37976a9f8b5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7145,12 +7145,18 @@ sub process {
>   			     "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
>   		}
>   
> -# check for alloc argument mismatch
> -		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
> +# check for alloc argument mismatch in alloc functions
> +		if ($line =~ /\b(((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>   			WARN("ALLOC_ARRAY_ARGS",
>   			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>   		}
>   
> +# check for alloc argument mismatch in devm_ alloc functions
> +		if ($line =~ /\b(devm_((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*$FuncArg\s*,\s*sizeof\b/) {
> +			WARN("ALLOC_ARRAY_ARGS",
> +			     "$1 uses number as second arg, sizeof is generally wrong\n" . $herecurr);
> +		}
> +
>   # check for multiple semicolons
>   		if ($line =~ /;\s*;\s*$/) {
>   			if (WARN("ONE_SEMICOLON",
>
+1

