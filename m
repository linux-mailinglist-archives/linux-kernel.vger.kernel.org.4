Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D04742135
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjF2Hln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF2HlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:41:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1330F6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:40:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7fef01fe4so2759725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688024408; x=1690616408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znG/5fKsp7zP0K967Ka3PZWUHHbz6JhxQhqkHda3fz4=;
        b=aPku/yElDU6Y56e/5mcC0d0xyzr1ju20OM0F1AvRqtw1qJ8Qquw9ETM2Do6w4Q93m2
         ZXyGdZJDEHzmAN0kcZFgdgjh5DtVxDoBpxaFzLnlFx7j6G5hwbWn9CYzNkFfihI4xwKF
         q6sSFBf/TOeV3CUiibr54sFGTaXC7F3roRC+W7CA12M+dajiAa5Fqx3x+UHEzYU2lnrm
         2U6KL8TNSTBBqeo5XBX2qRtvO36Rc5uJU3XMfSnPyJQlxdN755lb+cW9YRmiavEJRzft
         CszW8kRQsVI/crQ9GxOvWtiTSwHbWIC9d0BZKOSkQY3wr8dGdHjpvwkPEEE0/HDKjhoo
         iBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024408; x=1690616408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znG/5fKsp7zP0K967Ka3PZWUHHbz6JhxQhqkHda3fz4=;
        b=Tyi7qt6RNEIKKmJyz1vf0q6ml1Q0KlwdhTFAU2lT9SWDQN8txzfhv8zVjZ2DWjrsUa
         wRF9ZoXOmDTBh56eAHUMcYTzyxjFnGS23q7ERoR8w9uTMy/i/ul/nytFuNLFMpixUQiG
         tu2vydxCSCOyVq/OqoYRiCwTG0K0U+BkTUTEW+LH6cCtYq6GpQjDOggm4uKMClU608MR
         60u8WtKODOmppSAW0Yx0z6v//RlXeS8MNbQNNIvgTA9AkexfR0K7p7dyYF8RDeCz84z6
         XMYvPvkEA9FfDpjLQ3989E8v/IOrCNAYHr156EcIzIiM2B72dJNdRe8kIaNEMdL2oyj3
         we4g==
X-Gm-Message-State: ABy/qLZaZzZoelYpWCD5O7yEcGDGzOZZ2372tBJ80GUutW3dPO6z4hNy
        YkNnvtAyjwQ4nwSUb5OMqydqss2rQOW6vvi9lhk=
X-Google-Smtp-Source: APBJJlHTZJMVL8B7voVCbfWF57x/0SFaycRBr621haIGld+SPudSvo0LmrAZy1LpWvPLalFIGrrLAw==
X-Received: by 2002:a17:902:ea10:b0:1b8:5aba:509d with SMTP id s16-20020a170902ea1000b001b85aba509dmr306954plg.21.1688024408022;
        Thu, 29 Jun 2023 00:40:08 -0700 (PDT)
Received: from [10.254.62.122] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001b50b933febsm8583418plb.238.2023.06.29.00.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 00:40:07 -0700 (PDT)
Message-ID: <f91c32b3-1d3b-b28c-40cb-2edf02448f22@bytedance.com>
Date:   Thu, 29 Jun 2023 15:40:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] blk-mq: always use __blk_mq_alloc_requests() to
 alloc and init rq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
 <20230628124546.1056698-2-chengming.zhou@linux.dev>
 <20230629052828.GD16819@lst.de>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230629052828.GD16819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/29 13:28, Christoph Hellwig wrote:
> On Wed, Jun 28, 2023 at 08:45:44PM +0800, chengming.zhou@linux.dev wrote:
>> After these cleanup, __blk_mq_alloc_requests() is the only entry to
>> alloc and init rq.
> 
> I find the code a little hard to follow now, due to the optional
> setting of the ctx.  We also introduce really odd behavior here
> if the caller for a hctx-specific allocation doesn't have free
> tags, as we'll now run into the normal retry path.
> 
> Is this really needed for your timestamp changes?  If not I'd prefer
> to skip it.
> 

Thanks for your review!

Since hctx-specific allocation path always has BLK_MQ_REQ_NOWAIT flag,
it won't retry.

But I agree, this makes the general __blk_mq_alloc_requests() more complex.

The reason is blk_mq_rq_ctx_init() has some data->rq_flags initialization:

```
if (data->flags & BLK_MQ_REQ_PM)
	data->rq_flags |= RQF_PM;
if (blk_queue_io_stat(q))
	data->rq_flags |= RQF_IO_STAT;
rq->rq_flags = data->rq_flags;
```

Because we need this data->rq_flags to tell if we need start_time_ns,
we need to put these initialization in the callers of blk_mq_rq_ctx_init().

Now we basically have two callers, the 1st is general __blk_mq_alloc_requests(),
the 2nd is the special blk_mq_alloc_request_hctx(). So I change the 2nd caller
to reuse the 1st __blk_mq_alloc_requests().

Or we put these data->rq_flags initialization in blk_mq_alloc_request_hctx() too?

Thanks.

