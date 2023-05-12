Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61599700E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbjELSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjELSMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:12:43 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6202105;
        Fri, 12 May 2023 11:12:42 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-643aad3bc41so9427842b3a.0;
        Fri, 12 May 2023 11:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683915162; x=1686507162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQfYCthLnyaujnup9YmDJTbvBFRzuX2vx8uShEoIOJM=;
        b=i7HQew0MTTsc4aHI2jX5mC8nDSTikm8gvaj8bb9M1GnlhwE2AOJedl4Jjqx4x1LMxy
         /qZ0RhATMipqDMxi5tB1UpMSHA4rmC4CwP4cdbQaMSI9Ev0/O/7V5Ik6TfmIpBha4e5y
         DjWpIzy7g1vWakItho3/4AZ+/tCyNJlAMJgOXYReoJ/hDs16f4QinROb15DmwjvqsZxY
         kr2S8vvnlieIDjYjnmhRnlbodo2zCIrjF1DDPXs2fGwFYU9Nv38Zkth4qnYcQvgm3yaB
         WHz7kWGd5gSR6/AR6GivOd1StUYrfprkd87tsp7E6Xm7Es3W4btduLOkwwh27bpxyKx1
         qx2A==
X-Gm-Message-State: AC+VfDy9xJbmLvK7Ni4tRB5HDPlvFR6ZLKVMSA+Ae+g+FpJQH3VoomOx
        GADjkB3buOxxQK+MFOMQ58lNfZ9+xHTvLA==
X-Google-Smtp-Source: ACHHUZ6ZU0gVSt6zpLxhCV9TDGL5kLhwmuSyj16MwTybO75Mae0F0hxqlgR7UKzaERM141Y0Q6ViMA==
X-Received: by 2002:a05:6a00:2183:b0:634:7ba3:d140 with SMTP id h3-20020a056a00218300b006347ba3d140mr31644745pfi.15.1683915162110;
        Fri, 12 May 2023 11:12:42 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b0063a04905379sm7352532pfn.137.2023.05.12.11.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 11:12:41 -0700 (PDT)
Message-ID: <2740ee82-e35f-1cbf-f5d0-373f94eb14a5@acm.org>
Date:   Fri, 12 May 2023 11:12:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <ZF0K7A6G2cYBjSgn@infradead.org>
 <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
 <ZF5G5ztMng8Xbd1W@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZF5G5ztMng8Xbd1W@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 07:02, Christoph Hellwig wrote:
> On Thu, May 11, 2023 at 08:38:04AM -0700, Bart Van Assche wrote:
>> For which devices is the fair sharing algorithm useful? As far as I know the
>> legacy block layer did not have an equivalent of the fair sharing algorithm
>> and I'm not aware of any complaints about the legacy block layer regarding
>> to fairness. This is why I proposed in January to remove the fair sharing
>> code entirely. See also https://lore.kernel.org/linux-block/20230103195337.158625-1-bvanassche@acm.org/.
> 
> Because the old code did not do tag allocation itself?  Either way I
> don't think a "I'll opt out for a random driver" is the proper approach
> when you think it's not needed.  Especially not without any data
> explaining why just that driver is a special snowflake.

Hi Christoph,

I'm still wondering whether there are any drivers that benefit from the 
fair tag sharing algorithm. If the number of tags is large enough 
(NVMe), the number of tags exceeds the number of requests in flight and 
hence the fair tag sharing algorithm is not necessary.

The fair tag sharing algorithm has a negative impact on all SCSI devices 
with multiple logical units. This is because logical units are 
considered active until (request timeout) seconds have elapsed after the 
logical unit stopped being used (see also the blk_mq_tag_idle() call in 
blk_mq_timeout_work()). UFS users are hit by this because UFS 3.0 
devices have a limited queue depth (32) and because power management 
commands are submitted to a logical unit (WLUN). Hence, it happens often 
that the block layer "active queue" counter is equal to 2 while only one 
logical unit is being used actively (a logical unit backed by NAND 
flash). The performance difference between queue depths 16 and 32 for 
UFS devices is significant.

Is my understanding correct that in the legacy block layer 
implementation blk_queue_start_tag() had to be called to assign a tag to 
a request? I haven't found any code in the Linux kernel v4.20 
implementation of blk_queue_start_tag() that implements fairness in case 
a request tag map (struct blk_queue_tag) is shared across request queues 
(one request queue per logical unit in case of SCSI). Do you agree with 
my conclusion that from the point of view of the SCSI core in general 
and the UFS driver in particular the fair tag sharing algorithm in the 
blk-mq code introduced a performance regression?

Thanks,

Bart.
