Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D466874A383
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGFSAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGFSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:00:19 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36623BA;
        Thu,  6 Jul 2023 11:00:19 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-666edfc50deso714096b3a.0;
        Thu, 06 Jul 2023 11:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666418; x=1691258418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+ohPa783boQSqewlPh3vxCWnQt7IOYSt994tq4NfmU=;
        b=gg0VWv6BtuY/5X5o+b3ZlwpUORD15eYjzDY3E6IanZeSMX23qHkU3Qt8Czj0Okw1VF
         z8E0YoqpU7/JZSSqo+kI9a8VBF+OLbZS/KNtgLAcYrOjau0T8h7NKap/GujaBB1VqYSB
         DhEEp4sIb+soApZziM43FXESzk5CJAb15e6tsvxrKikSOX250ruY7Rb1Ml55qP7nWQDU
         DOzDMIEUldtCosKuLACsAGhQJ1QbwGONtRpNorD1vpf5pSyedK9RCvyP1Ewb/f7Rk95C
         oARC6lkTKo8y9Waufm46JDTVjnb/sTSH3cV+/8y6jbfLk730XTrIPdqWi4+ct6QjYl83
         o88w==
X-Gm-Message-State: ABy/qLYAsI0LglTNZLQvWjgWufe3zaBXV8horq2M+z19QIxEos0yBw2J
        HTEskrIHX6qBjTepRYuvIcfwoqaweNI=
X-Google-Smtp-Source: APBJJlFx6Av3MgVoC4qeFsvYUkKmxqQpeVXPQvVhThBInLjc3yz8Gn+igaNvBtuMR9fjc9vRKNpY7Q==
X-Received: by 2002:a05:6a00:1a15:b0:682:8505:1e4 with SMTP id g21-20020a056a001a1500b00682850501e4mr4262461pfv.17.1688666418510;
        Thu, 06 Jul 2023 11:00:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a75c:9545:5328:a233? ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00682c8637109sm1561314pfi.34.2023.07.06.11.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 11:00:17 -0700 (PDT)
Message-ID: <43743388-98dc-a446-d7bd-52b45589deeb@acm.org>
Date:   Thu, 6 Jul 2023 11:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 2/7] blk-mq: delay tag fair sharing until fail to get
 driver tag
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <20230618160738.54385-3-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230618160738.54385-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 09:07, Yu Kuai wrote:
> Start tag fair sharing when a device start to issue io will waste
> resources, same number of tags will be assigned to each disk/hctx,
> and such tags can't be used for other disk/hctx, which means a disk/hctx
> can't use more than assinged tags even if there are still lots of tags
                       ^^^^^^^^
                       assigned
> that is assinged to other disks are unused.
           ^^^^^^^^
           assigned
> Add a new api blk_mq_driver_tag_busy(), it will be called when get
> driver tag failed, and move tag sharing from blk_mq_tag_busy() to
> blk_mq_driver_tag_busy().


> +	spin_lock_irq(&tags->lock);
> +	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
> +	blk_mq_update_wake_batch(tags, tags->ctl.share_queues);
> +	spin_unlock_irq(&tags->lock);
> +}

Are all tags->ctl.share_queues changes protected by tags->lock? If so, please
use a regular assignment to update that member variable instead of using
WRITE_ONCE().

> @@ -735,6 +736,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   
>   struct tag_sharing_ctl {
>   	unsigned int active_queues;
> +	unsigned int share_queues;
>   };

Please rename "share_queues" into "shared_queues" such that the names of
both struct members start with an adjective.

Thanks,

Bart.
