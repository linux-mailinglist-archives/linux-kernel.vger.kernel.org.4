Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BCD612C9C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ3UTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3UTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:19:14 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F009A18F;
        Sun, 30 Oct 2022 13:19:14 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id io19so9104715plb.8;
        Sun, 30 Oct 2022 13:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpcsaYxX2/iZPVTp5DAYjYaAQ7Q9mqzIBJhkkWXT9KI=;
        b=vu0TPKGcdmlcF9FBWopcH8ixG6IMGpdlC7S5v8eebz5THEQq1TR9rHP0a0O/y/jLZg
         kDjqwcGe7/Z/esXQdnJg7LuaUCk+UytSg+y+O15aNRKU8Hg1GzQstEGli4urFkffdg2S
         uk5pb0JfFnuYGie4gkgVzQAIkJHgNtDLfFp4OiX99VKfmeO9Q7whHSPNNqH6IYzxFlvC
         I8UneGzOtJ+Xs8ctPffo8Ft6sk9OMHuItFiBW8rbR2d6IyGAxFMnYWKChFLNlHq53mtQ
         FSZeEEdgKXta+2TMxX+qJ0xv6Fv7j1dKM6y8SrM5vgoS3f10aLkWMK13LBwUyEf/fSfV
         S3LQ==
X-Gm-Message-State: ACrzQf3FseWQxoditB/avn05kTjupd0TjS1I0CX98xTdo7Oa4J4S7cLS
        Es3O6rh97yjR9UqGxZl+jJ/+LC+XXAI=
X-Google-Smtp-Source: AMsMyM6m6X1LDQAhui8BGKPfZ1MNzm6uykXWqEcVPHk/HTI+9TH+KyBI8USgMbD8mUXjQcrwLSY+ZQ==
X-Received: by 2002:a17:902:f786:b0:180:6f9e:23b with SMTP id q6-20020a170902f78600b001806f9e023bmr10961455pln.37.1667161153435;
        Sun, 30 Oct 2022 13:19:13 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w2-20020a623002000000b00561beff1e09sm3010408pfw.164.2022.10.30.13.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 13:19:12 -0700 (PDT)
Message-ID: <036eb44a-fd6a-4460-49d0-5f596452d1e1@acm.org>
Date:   Sun, 30 Oct 2022 13:19:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
Content-Language: en-US
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
 <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
 <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
 <9a758d91-42c5-d6b3-ddde-9c2b89d741a6@acm.org>
 <fb1acbc.15062f.18429642056.Coremail.nickyc975@zju.edu.cn>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fb1acbc.15062f.18429642056.Coremail.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 07:55, Jinlong Chen wrote:
>>> So I think there is a redundant call to blk_freeze_queue_start(), we
>>> just need to call blk_mq_freeze_queue_wait() after calling
>>> blk_queue_start_drain().
>>
>> I think it is on purpose that blk_queue_start_drain() freezes the
>> request queue and never unfreezes it. So if you want to change this
>> behavior it's up to you to motivate why you want to change this behavior
>> and also why it is safe to make that change. See also commit
>> d3cfb2a0ac0b ("block: block new I/O just after queue is set as dying").
> 
> I think there might be some misunderstanding. I didn't touch
> blk_queue_start_drain(), so its behavior is not changed. What I have done
> is just replacing blk_freeze_queue() with blk_mq_freeze_queue_wait() in
> blk_mq_destroy_queue().

Hi Jinlong,

Does this mean that you want me to provide more information about what I 
wrote? Without this patch, blk_mq_destroy_queue() uses two mechanisms to 
block future I/O requests:
1. Set the flag QUEUE_FLAG_DYING.
2. Freeze the request queue and leave it frozen.

Your patch modifies blk_mq_destroy_queue() such that it unfreezes the 
request queue after I/O has been quiesced instead of leaving it frozen. 
I would appreciate it if Ming Lei (Cc-ed) could comment on this change 
since I think that Ming introduced (2) in blk_mq_destroy_queue() 
(formerly called blk_cleanup_queue()).

Thanks,

Bart.
