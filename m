Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF516D4FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjDCR5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjDCR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:57:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA92D4B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:56:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ja10so28844612plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680544617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvbXO2zEiAAtifGVfeUKcNOUgXd8fePbZNqY6UemQus=;
        b=NeE9Wk2utSK19PXZCOaD49MN9bJsYQQCqJkMm5dFlVhQ4vvtd39tS83Ayte5UqNH/E
         hQkOpBGdzyonrza8zrN6BS+EBfh4tDDmQtDTvheNR37l0XGyERQg2SZKou3blg+q+vcY
         tIadtzWN0DsbYZ8vj716opgE5Ajw9eL2oXL5tJJCei7uAhysaZE4CZl/Nsrw3ykGoQya
         9EsCld/FHm1EPhsBWCFAjQRGc0NuV3z7k97Jj1l/TipicMXFBzU72JXBXv5uGzIm7GB5
         Fkr5tmml+hyc8WL47nSRDq4+7FNjAiiTAqenK0YtEagBNuL2pcirKdcqTqU4XSxq417Y
         lOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zvbXO2zEiAAtifGVfeUKcNOUgXd8fePbZNqY6UemQus=;
        b=aA+JUBeNXo3WPgpJ/6ZbkrSRAeewUgCUge5A/o/54Ni/XAv2szOoOb8KyOSbcE32B0
         VsCRodPyPESwPDTCzP2pD6PlQg583F5DjTlZWj92/dPTLDJf5XuL34NCUCwv3f1acG1E
         qlm+lmecKfaVnA6ELXuRb/ct7+I10d9qL7UKSzaTNTZL1xtLNClforDSO9cgUfTZPR3l
         Ytuzej0e9tYxJkSOS2m/hr1qbSrgwwQKO5xVNZpUqw52dZUviDY7lrMCmodIPxxJio8x
         vqLqj4jfE6y5xGqd4ZhyYFba0TWNvtTkw517GXMvojiBqPDnj0V6bzss10iIN6r/Eb2q
         kMcQ==
X-Gm-Message-State: AAQBX9elSQuni8vRunJAohXo3kqQuKFLmXShr/BNSBKY3FOxtK+0thg7
        LoNX22hwBKqqzxxFkWNQ3Fhisg==
X-Google-Smtp-Source: AKy350Y/o4NlisuKM4QeBSHzVv110kGyt89sAVitu14JA8M02u9XVH+wqGBtQUeplDG2G3rdtxV/Fg==
X-Received: by 2002:a17:90b:4c10:b0:22c:816e:d67d with SMTP id na16-20020a17090b4c1000b0022c816ed67dmr42609674pjb.24.1680544616942;
        Mon, 03 Apr 2023 10:56:56 -0700 (PDT)
Received: from [10.4.252.188] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id bk4-20020a17090b080400b0023d0c2f39f2sm9999175pjb.19.2023.04.03.10.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 10:56:56 -0700 (PDT)
Message-ID: <cb69bf15-6288-e5d9-08c9-cf64187ddd03@bytedance.com>
Date:   Tue, 4 Apr 2023 01:56:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH v2] blk-throttle: Fix io statistics for
 cgroup v1
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
 <20230403153021.z4smxxnxbgdcgcey@blackpad>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230403153021.z4smxxnxbgdcgcey@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/3 下午11:30, Michal Koutný 写道:
> On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han <hanjinke.666@bytedance.com> wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
>> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
>> the only stable io stats interface of cgroup v1,
> 
> There is also blkio.bfq.{io_serviced,io_service_bytes} couple, so it's
> not the only. Or do you mean stable in terms of used IO scheduler?
> 

Oh, the stable here means that it always exists, and when the bfq 
scheduler is not used, the bfq interface may not exist.

>> and these statistics are done in the blk-throttle code. But the
>> current code only counts the bios that are actually throttled. When
>> the user does not add the throttle limit,
> 
> ... "or the limit doesn't kick in"
> 

Agree.

>> the io stats for cgroup v1 has nothing.
> 
> 
>> I fix it according to the statistical method of v2, and made it count
>> all ios accurately.
> 
> s/all ios/all bios and split ios/
> 
> (IIUC you fix two things)
> 
>> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> 
> Good catch.
> 
> Does it also undo the performance gain from that commit? (Or rather,
> have you observed effect of your patch on v2-only performance?)
> 

Under v1, this statistical overhead is unavoidable. Under v2, the static 
key is friendly to judging branches, so I think the performance 
difference before and after the patch is negligible.

>> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
>> ---
>>   block/blk-cgroup.c   | 6 ++++--
>>   block/blk-throttle.c | 6 ------
>>   block/blk-throttle.h | 9 +++++++++
>>   3 files changed, 13 insertions(+), 8 deletions(-)
> 
> The code looks correct.
> 
> Thanks,
> Michal

Thanks.

