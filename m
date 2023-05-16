Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326D87051BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjEPPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjEPPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:12:24 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6AF3A98;
        Tue, 16 May 2023 08:12:22 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ab267e3528so102406055ad.0;
        Tue, 16 May 2023 08:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684249942; x=1686841942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX1f8Bzw327HwH/5x2zhY/BAkrcZat0nUszLiZ8Dn9c=;
        b=YCv/cmlnDuLOxFk0qXdkAjZ69RG+XcSXx46fRJjEVQwfoU04J2y+VwUo/T1ldsxsgO
         4Du4usQzBoSuRVZ03XB4ySqmSNXJ/NKlLnPshLwyA9wmOvgKUO1bSS8Wy4GCXK4T5GUT
         ScERdoM44E9BWpeQ6PuIzH8DYgz509ndkrKsySDC+d6Jl3LD+3huWX3y3zCWucVQDkS7
         ALN5Tl/n7HOJv2IfBFM30MHjwgU+GyF5MJD7QmTFhKfBggoFSUz4FjrsHjoLqEGthMaw
         LNGTTv7YSUDXEHxifZ62+yh3BHgTnONOgmesqTQ6YTjbvmxxDGN/6uLMgfPL/GqqG+ou
         Xzkg==
X-Gm-Message-State: AC+VfDwCcJLreMBqQSYVcjNVYZBlf4/lRHFftqryizGIz/uUJrpTAAsz
        neHxXofPYr0WhocBbs6OXhA=
X-Google-Smtp-Source: ACHHUZ4q/GrA5JQKmbrPvawP8TTFNdoAM3+i1CgNAtug+vtc9Cf2K8M5RYMoX3E9HE7pHn1bXDt7pg==
X-Received: by 2002:a17:903:41d0:b0:1ad:55e6:16fe with SMTP id u16-20020a17090341d000b001ad55e616femr26890381ple.15.1684249941858;
        Tue, 16 May 2023 08:12:21 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902bb9100b001aaef9d0102sm15597698pls.197.2023.05.16.08.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:12:21 -0700 (PDT)
Message-ID: <86065501-ab2e-09b4-71cd-c0b18ede00ed@acm.org>
Date:   Tue, 16 May 2023 08:12:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <ZF0K7A6G2cYBjSgn@infradead.org>
 <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
 <ZF5G5ztMng8Xbd1W@infradead.org>
 <2740ee82-e35f-1cbf-f5d0-373f94eb14a5@acm.org>
 <de3f41a0-b13d-d4f6-765a-19b857bce53e@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <de3f41a0-b13d-d4f6-765a-19b857bce53e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 20:09, Yu Kuai wrote:
> 在 2023/05/13 2:12, Bart Van Assche 写道:
>> The fair tag sharing algorithm has a negative impact on all SCSI 
>> devices with multiple logical units. This is because logical units are 
>> considered active until (request timeout) seconds have elapsed after 
>> the logical unit stopped being used (see also the blk_mq_tag_idle() 
>> call in blk_mq_timeout_work()). UFS users are hit by this because UFS 
>> 3.0 devices have a limited queue depth (32) and because power 
>> management commands are submitted to a logical unit (WLUN). Hence, it 
>> happens often that the block layer "active queue" counter is equal to 
>> 2 while only one logical unit is being used actively (a logical unit 
>> backed by NAND flash). The performance difference between queue depths 
>> 16 and 32 for UFS devices is significant.
> 
> We meet similiar problem before, but I think remove tag fair sharing
> might cause some problems, because get tag is not fair currently, for
> example 2 devices share 32 tag, while device a issue large amount of
> io concurrently, and device b only issue one io, in this case, if fair
> tag sharing is removed, device b can get bad io latency.
> 
> By the way, I tried to propose a way to workaround this by following:
> 
> 1) disable fair tag sharing untill get tag found no tag is avaiable;
> 2) enable fair tag sharing again if the disk donesn't faild to get tag
> for a period of time;
> 
> Can this approch be considered?

I'm afraid that this approach won't help for the UFS driver since it is 
likely that all tags are in use by a single logical unit during an IOPS 
test. Hence, fair sharing would be enabled even when we don't want it to 
be enabled.

I propose that we switch to one of these two approaches:
* Either remove the fair tag sharing code entirely and rely on the 
fairness mechanism provided by the sbitmap code. I'm referring to how 
__sbitmap_queue_wake_up() uses the wake_index member variable.
* Or make the behavior of the fairness algorithm configurable from user 
space. One possible approach is to make the proportion of tags for a 
logical unit / NVMe namespace configurable via sysfs. This will allow to 
reduce the number of tags for the WLUN of UFS devices.

Thanks,

Bart.

