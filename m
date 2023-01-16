Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC1D66B92B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjAPIk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjAPIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:40:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438F1125BA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:40:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so30374342pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEb72C/frQfArwPtQinDRwWrx1ltU8v74zNyyIO4oyM=;
        b=70wIzIqS5PHYs/wx55I/kYhXzJvgzLv/QbuMQDjFXqIP7qFP9pafYEhRV35zjE41nm
         bHLVtho2Y5WKecfl9VToPr0gdKEbNh8Vl/XnxMdSU6/sIB9ZrMRbYYXZScDgsIUjGRM6
         QZk5810wU5Ja7OmuKH4Rdr3C7pwCj1tycTeDTAXQ3hIIoDcbu8aKUWAbSO0FY8MeKStR
         D+bXb6OxnFDoFgnC4jK5I/Z4JTdxGzHEx+d060RT6akaIhp3UPY0+IWMfe5IVuCs2LIC
         Vn/k4S9cwlQ0FVLGTglxqBtKqwYuf3plk6am0kp4Gojn4KryrKQi1pQ6VPFeV34oR1oo
         o16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bEb72C/frQfArwPtQinDRwWrx1ltU8v74zNyyIO4oyM=;
        b=MiUGjhZdqRyLfsUVt38XOqWaxPs9nYFxE8xFPIZWBjQfCFEDYWNACt8wAqiS6uPSU7
         VnmwPt7GSN9DneBhdOUy6SLEcIxux9r4WSdDMQ7GtqDwawH3lzYrERskRNKU8h79D+Cc
         Xo/bAtXTqyWjtVG1yMqnADC/0xhQN6mAO5Ecl6OkneUOVmb6mJOIXkJmVeoHQnv+iU0B
         LrnSqB4WdXSvaclBM4v9dSBJrA8y49JrnuaawzIRKbtBC2olLFudlaYCHKDWmNa/S8k8
         JRXJTXmjjvCjN6chT4cI6s7cDRNiv5A2hGUWtWkZ2wds/MyHTZjVPpvMDICfxBQI9dC+
         f5xA==
X-Gm-Message-State: AFqh2koXuieX2Hsf7tbrq57yaDv5ybCw9YX7PbRorEgXMD9P4+KNLtdC
        3CbziDbFEPolThQm9+OGGTRhzXQDenYxdV1b
X-Google-Smtp-Source: AMrXdXtodyd3wASxNOG8btTnZoEfcCXYqPhDmV8llKqkMaVOBYQDi3nt9CLvWvtiVf6ERc65m79FPA==
X-Received: by 2002:a17:902:b48f:b0:192:8502:77f9 with SMTP id y15-20020a170902b48f00b00192850277f9mr20251942plr.27.1673858451651;
        Mon, 16 Jan 2023 00:40:51 -0800 (PST)
Received: from [10.90.35.114] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001947222676csm5849391pla.249.2023.01.16.00.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:40:51 -0800 (PST)
Message-ID: <49b867c1-2b68-c034-9f60-b26a77ff326a@bytedance.com>
Date:   Mon, 16 Jan 2023 16:40:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] memblock: Make finding index faster when modify
 regions.
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
 <20230113082659.65276-3-zhangpeng.00@bytedance.com>
 <Y8QHehG1L+kuyqoR@kernel.org>
 <acbfecf4-e3ee-4df2-6685-6cefca38bde6@bytedance.com>
 <Y8T+qWlUT1KTeFNI@kernel.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <Y8T+qWlUT1KTeFNI@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/16 15:37, Mike Rapoport 写道:
> On Mon, Jan 16, 2023 at 11:17:40AM +0800, Peng Zhang wrote:
>>
>>
>> 在 2023/1/15 22:02, Mike Rapoport 写道:
>>> Hi,
>>>
>>> On Fri, Jan 13, 2023 at 04:26:58PM +0800, Peng Zhang wrote:
>>>> We can use binary search to find the index to modify regions in
>>>> memblock_add_range() and memblock_isolate_range(). Because the
>>>> arrangement of regions is ordered. It may be faster when there are
>>>> many regions. So implemented a binary search and a new macro to walk
>>>> regions.
>>>
>>> Did you see a measurable speedup with this optimization?
>>> I'm not in favor of micro-optimizations that complicate code.
>>>
>> Thank you for your reply. I haven't measured this patch yet, theoretically
>> this small optimization might be difficult to observe.
>> If you think this patch complicates the code, you can ignore this patch.
>>
>> These three patches are independent and they can be applied independently.
>> The logic of the third patch is very simple. It will not complicate the
>> code. It is tested by the default configuration of qemu. The total number of
>> iterations of memblock_merge_regions() in the third patch is reduced from
>> more than one thousand to more than one hundred, this is only in the case of
>> a small number of regions. Can you consider the third patch?
> 
> Can you please send the numbers and show how did you obtained them?
> 
>> Sincerely yours,
>> Peng.
> 
I obtained the numbers like this:

void memblock_merge_regions(struct memblock_type *type) {
	static int iteration_count = 0;
	static int max_nr_regions = 0;

	max_nr_regions = max(max_nr_regions, (int)type->cnt);
	...
	while () {
		iteration_count++;
		...
	}
	pr_info("iteration_count: %d max_nr_regions %d", iteration_count, 
max_nr_regions);
}

Boot the kernel by qemu.
The folowing numbers is the last output.

master branch:
iteration_count: 1762 max_nr_regions 41

patched:
iteration_count: 182 max_nr_regions 41

If max_nr_regions is larger, the difference will be more.

Thanks.

Sincerely yours,
Peng
