Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4674A3E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGFSnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjGFSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:43:06 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633491BF6;
        Thu,  6 Jul 2023 11:43:04 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b852785a65so7451775ad.0;
        Thu, 06 Jul 2023 11:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688668984; x=1691260984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJSqTuA4rxUcVPYnik9uob4hLh1/TwEOZHwAsiup89o=;
        b=CA/YQYucup3tOBIH5JozXwebx+BrsTBy3fBdruWBqJ1/NcbkQSlH8kGVMDewWXMD+V
         4kXeuIYO8z2npwWnITOS5pwlVVEU/6plNqiuMOAmvG8APa2BC/DXe1QHH7a2yQD3DOWc
         4jRxq0bQ0NIwixoA/35mzk+4S1GP+r3VI3hsxbQhhLE5x79tl1EraWjYeoz8R857Mxfx
         NbscO0OHYVv2G0FGokERxPrfvtQNl6ezjOOI5oYEg2Ka0lMck6uweKK0FgWGRCPxR7id
         2pquPdP8ma//MP4H1N5jCk6CTU98AaUJnV2uUyY2UFARIvcWtu/0G7Je4i+h2qib11OY
         +89Q==
X-Gm-Message-State: ABy/qLbuvXiqgTsktuHtFvpYU0gsy7O2+CJmoojngOU6fgonyimNYTym
        UFE2KDWwYgDoEZ9IMU/cuS0=
X-Google-Smtp-Source: APBJJlHBYDfZfzJ5gmKtKg8N+6jJW7hn+N7mquB8h5rdgKOnD90vAzJCoOt8LhOYk0jlFL4f1L/Big==
X-Received: by 2002:a17:903:32d1:b0:1b8:a67f:1c15 with SMTP id i17-20020a17090332d100b001b8a67f1c15mr9340335plr.25.1688668983758;
        Thu, 06 Jul 2023 11:43:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a75c:9545:5328:a233? ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001b8a2edab6asm1737887plg.244.2023.07.06.11.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 11:43:03 -0700 (PDT)
Message-ID: <dce8850c-92ee-8519-aa74-dc2d7ecc41e0@acm.org>
Date:   Thu, 6 Jul 2023 11:43:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 0/7] blk-mq: improve tag fair sharing
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <4c9fea33-9c30-4ab9-c210-95e09d323837@acm.org>
 <82d44ba1-4389-079c-935a-cbb49203ca27@huaweicloud.com>
 <c4de836a-a2a1-847f-1525-1accb814e45e@acm.org>
 <84f9bfb4-293b-ad55-97e4-e8c611c5e9ca@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <84f9bfb4-293b-ad55-97e4-e8c611c5e9ca@huaweicloud.com>
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

On 7/4/23 20:17, Yu Kuai wrote:
> - currently borrowed tags will never be returned untill queue is idle,
> I should figure out a way to return borrowed tags if this queue is not
> busy, so that other queues can borrow tag from this queue.

At least for UFS this is a significant disadvantage. If e.g. one SCSI
command is sent to the UFS WLUN every 20 seconds and the request queue
timeout is 30 seconds then borrowed tags will never be returned.

The complexity of this patch series is a concern to me. The complexity
of this patch series may be a barrier towards merging this patch series
in the upstream kernel.

Thanks,

Bart.

