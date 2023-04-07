Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F816DA6E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbjDGBVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbjDGBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386DA5CD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4154D63E34
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58D1C433D2;
        Fri,  7 Apr 2023 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680830437;
        bh=Hc+mjLQ2bPKEmltX+LVQc3NphT2dO+gfyXP2aojuCvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=giyOu+tXQd58ibN/OItUiwGCjzK+IWyTiXq9LbbkeHnHYSqNVjJ/2YVOnyI3YdFj4
         QqkT096W3Tviz0t8jfjvEMSiVLenBS+a3w7evLCelDHKbMjCogMmxr/m6W99+03+Rv
         /xJIvUVzxPJWrPceyzViNRnPs4bHz4LZpuTygbNceaSSnRiv8EK0vuh3vun7Uijoq2
         xJeTYeGeqN5rE5HqhGOr0SrkgsZlLdXXoGSnx7M6aZDN4JmEt9WU4InYEtXwM15UTO
         MS9S13oApgcw4CkVZ8249FVWQwVuxlPOR8+IgJXriyTXCixnmsKEWjus3LthEaBOF+
         Hf91u6hlaEtEw==
Message-ID: <2f076e24-b550-437a-a271-6f62f1d236d8@kernel.org>
Date:   Fri, 7 Apr 2023 09:20:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] f2fs: convert to use sysfs_emit
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230331113305.77217-1-frank.li@vivo.com>
 <3918411a-77fc-48d7-5b80-c4b84203a39c@kernel.org>
 <ZC2aZJFIJZclTkkK@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZC2aZJFIJZclTkkK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/5 23:57, Jaegeuk Kim wrote:
> On 04/05, Chao Yu wrote:
>> On 2023/3/31 19:33, Yangtao Li wrote:
>>> Let's use sysfs_emit.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/sysfs.c | 10 ++--------
>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 9ddc6ee19433..2c0b2cb05a3a 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -312,19 +312,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>>>    	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
>>>    		struct ckpt_req_control *cprc = &sbi->cprc_info;
>>> -		int len = 0;
>>>    		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
>>>    		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
>>> -		if (class == IOPRIO_CLASS_RT)
>>> -			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
>>> -		else if (class == IOPRIO_CLASS_BE)
>>> -			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
>>> -		else
>>> +		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
>>>    			return -EINVAL;
>>> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
>>> -		return len;
>>> +		return sysfs_emit(buf, "%s,%d\n", class == IOPRIO_CLASS_RT ? "rt" : "be", data);
>>
>> Exceed 80 columns.
> 
> Fixed and applied.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
