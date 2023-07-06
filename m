Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E574A387
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGFSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGFSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:01:34 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A15BA;
        Thu,  6 Jul 2023 11:01:34 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so772619a12.0;
        Thu, 06 Jul 2023 11:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666493; x=1691258493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXHDTuh6ZUNosNz3ayQBdLzUYKygC6td/C7Cck1x7W8=;
        b=W2MniBjf4UOQXjZGiynOtinRYLCQzNq5qUUTUmCMDbgohekzUjGWiNe2q26MnIZokK
         Of9+DOY5KgvfKLVvY2qhwoepYRCHJXuf5ZhwY88s29pSbCT3drW42xed67IgCxrDfv/P
         ZN1Akjw/mIpdAhVLOXkEM2k33nkcekFcMnUriin1rSEockFyXAF7rOWSpBscCfzkSV4m
         Jeqe9a/oOyK5oWlVL9X9/hfah7pYzVLsaoDbRcemuhnEGV0Zw6UXL7ZzZioqNOaPlji2
         z3SmmvHctKrWaMLzZiKUOxEhmSgiCh2x3sSmQJuJodWAk95xD/M4H0QswJsFgnVA9g9g
         mhog==
X-Gm-Message-State: ABy/qLai+36kvtABrtQO7pI09BLy1gpuSPSmyn+5uhdHIQOIHj02XeM1
        Jp/tGOAs+0B4UEqf4SR8QYw=
X-Google-Smtp-Source: APBJJlHsvmO/G5MNdY6l5DdVoExbjPGQmHlmAjqlg3+naNKX6zzzN+7OHu7b4B/mqN6W98XPS7IOWg==
X-Received: by 2002:a05:6a20:3d9:b0:12c:567b:2787 with SMTP id 25-20020a056a2003d900b0012c567b2787mr2675243pzu.19.1688666493508;
        Thu, 06 Jul 2023 11:01:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a75c:9545:5328:a233? ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id k19-20020aa792d3000000b0068277318e6asm1531808pfa.209.2023.07.06.11.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 11:01:33 -0700 (PDT)
Message-ID: <3c79f013-7bab-d798-b251-b9e3dd620022@acm.org>
Date:   Thu, 6 Jul 2023 11:01:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 3/7] blk-mq: support to track active queues from
 blk_mq_tags
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <20230618160738.54385-4-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230618160738.54385-4-yukuai1@huaweicloud.com>
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
> @@ -737,6 +738,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   struct tag_sharing_ctl {
>   	unsigned int active_queues;
>   	unsigned int share_queues;
> +	struct list_head head;
>   };

Please add a comment that explains that 'head' is the head of a list with
tag_sharing.node entries.

> +struct tag_sharing {
> +	struct list_head node;
> +};

Data structure names typically are a noun. Above I see a name that ends with a
verb. Would "shared_tag_info" or "tag_sharing_info" perhaps be a better name?

Thanks,

Bart.

