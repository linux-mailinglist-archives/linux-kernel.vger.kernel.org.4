Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861672E548
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbjFMOJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbjFMOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:09:03 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A61709;
        Tue, 13 Jun 2023 07:08:37 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-25c119005bcso644424a91.0;
        Tue, 13 Jun 2023 07:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665250; x=1689257250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvAFLkMD1GiJryurX3BgCgJEcKGxveNHWp6M99GnmxU=;
        b=HPcNeMI8D6+8DvPkAgnsReTK9ZlMybgb3Ryl8FC66Ydwa+TnLy5+GAy8okT7hATKoW
         AcHLYbVsXaaHPTBbTrFvyjblMlu1yMVAOl2nYy3mfjMtWM2xegXYsnkRPqybMHoozDQx
         l6jz6w6lq5wlhWeqb+krOb8G8aOq122OFAkveDKEPZ8xnvVZZB6RyO+ceFcFYVtAuO9e
         dnyjygZiAtiui+3ZHLCV0OOllh/e5ICerDY5W0ujKxcMNHthI6AG2jMJO278cgOvqW9o
         5ZGjGZ7JBXqt8ZsVOJfK15XCv5Nwxmxz9lMKeYOgDCmhpd7vWBfLhka8W4PWmoIJP43W
         Uglg==
X-Gm-Message-State: AC+VfDx2tJdb45yknMr7a8YXpWntWvY2wOZ4Hed3XVa/4ccjgjQLucXw
        rFTEyLuFZ5NWhdHpQ2f/8oE=
X-Google-Smtp-Source: ACHHUZ46BDy0mDKcY0HLANL3dOq0tH4OBEkYAY5URE+QljLf4o5QTQFqfE4hLEQB26qVcW4lasD6VQ==
X-Received: by 2002:a17:90a:5891:b0:253:340d:77d8 with SMTP id j17-20020a17090a589100b00253340d77d8mr10649596pji.33.1686665249640;
        Tue, 13 Jun 2023 07:07:29 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a150700b0025621aa4c6bsm6051815pja.25.2023.06.13.07.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 07:07:28 -0700 (PDT)
Message-ID: <04a4d0db-2f2d-e2fc-5458-4ddf852ffc8a@acm.org>
Date:   Tue, 13 Jun 2023 07:07:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
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
 <86065501-ab2e-09b4-71cd-c0b18ede00ed@acm.org>
 <a26e28a6-91e0-e803-749e-2ce957711c64@huaweicloud.com>
 <097caed2-10b3-7cd1-7c06-90f983e5c720@acm.org>
 <f9ccab59-91a1-69d5-6d20-2c6ea0e24b5a@huaweicloud.com>
 <66906bd5-d73f-af96-bf38-c6aee576fa73@acm.org>
 <bef8340e-f051-db63-5c2f-a2bc94c678ac@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bef8340e-f051-db63-5c2f-a2bc94c678ac@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/18/23 00:55, Yu Kuai wrote:
> 在 2023/05/18 10:23, Bart Van Assche 写道:
>> On 5/17/23 18:49, Yu Kuai wrote:
>>> Currently, fair share from hctx_may_queue() requires two
>>> atomic_read(active_queues and active_requests), I think this smoothing
>>> method can be placed into get_tag fail path, for example, the more times
>>> a disk failed to get tag in a period of time, the more tag this disk can
>>> get, and all the information can be updated here(perhaps directly
>>> record how many tags a disk can get, then hctx_may_queue() still only
>>> require 2 atomic_read()).
>>
>> That sounds interesting to me. Do you perhaps plan to implement this 
>> approach and to post it as a patch?
> 
> Of course, I'll try to send a RFC patch.

Hi Kuai,

Has this RFC patch already been posted or did I perhaps miss it?

Thanks,

Bart.

