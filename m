Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C141774A3A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGFSSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:18:45 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0519B7;
        Thu,  6 Jul 2023 11:18:44 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-666e3b15370so683589b3a.0;
        Thu, 06 Jul 2023 11:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667524; x=1691259524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T9dOQBRX06U6OSbcga+UMinIBWORQngwnP4FLmZoj8=;
        b=a71PqC0NZ5SQynw3v5WGkk0F6PkvzBbDbZIDp9AR2tq01uIqsh4yjVHrRQnr/G41P3
         AMBlBdzEhKvqjdjT8W48bArT1tt5peZVCtksRDT43q7TLFvVoNHtEH48ZWld1MFGcYDq
         OvIUYqfKWNOZ66AaM0K/FOYfjPZ4rlIqjG45i1Toz8ldw2faykDmOFUj88EIEbVUFZS/
         k+5qr7i1MFrAdc9pJoCHizgjn6eywH53a77T8fwQS5/ZjUDjJEl/D8PNrd/PSJoJYc7z
         n22svDJnAC4nDWbxi0SCqT6KJdXF1Vz4kihIqhYjgQp7jSo6zVAEp/kNtZd94Rs/TYsC
         IvaQ==
X-Gm-Message-State: ABy/qLZnAC75HebNYTRC34S4k8i6kyEtD9We+sDnpoWC0cds1cKY/O1z
        fWuceJJZ4lVdc6y2xt4LRcA=
X-Google-Smtp-Source: APBJJlGn8b7nvkRyaINPrTfaYC4httBXy6d69nr0xeznx1RV58f7ZdBuzzzbMTIJPXfH2MtVD6d/Xw==
X-Received: by 2002:a05:6a00:2d95:b0:67d:b924:54ca with SMTP id fb21-20020a056a002d9500b0067db92454camr2597355pfb.34.1688667524077;
        Thu, 06 Jul 2023 11:18:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a75c:9545:5328:a233? ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0066a4e561beesm1613255pfo.173.2023.07.06.11.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 11:18:43 -0700 (PDT)
Message-ID: <d533a9d7-8fbc-4adf-e4a2-5a5a47a00470@acm.org>
Date:   Thu, 6 Jul 2023 11:18:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 5/7] blk-mq: record the number of times fail to get
 driver tag while sharing tags
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <20230618160738.54385-6-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230618160738.54385-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 09:07, Yu Kuai wrote:
> +static void update_tag_sharing_busy(struct tag_sharing *tag_sharing)
> +{
> +	unsigned int count = atomic_inc_return(&tag_sharing->fail_count);
> +	unsigned long last_period = READ_ONCE(tag_sharing->period);
> +
> +	if (time_after(jiffies, last_period + HZ) &&
> +	    cmpxchg_relaxed(&tag_sharing->period, last_period, jiffies) ==
> +			    last_period)
> +		atomic_sub(count / 2, &tag_sharing->fail_count);
> +}

For new code, try_cmpxchg_relaxed() is preferred over cmpxchg_relaxed().

>   struct tag_sharing {
>   	struct list_head	node;
>   	unsigned int		available_tags;
> +	atomic_t		fail_count;
> +	unsigned long		period;
>   };

Please consider renaming "period" into "latest_reduction" or any other name
that make the purpose of this member clear.

Thanks,

Bart.

