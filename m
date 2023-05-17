Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC97070BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEQSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEQSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:23:30 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D4AD26;
        Wed, 17 May 2023 11:23:16 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ae3fe67980so12194915ad.3;
        Wed, 17 May 2023 11:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347796; x=1686939796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBzWQWarXz9+zZ2Mc7G87KcpNXJGB6yUDNeKIXNCtSA=;
        b=UkskJbNeTvAcm426IjPFfI97COAA4aWhhnz5GPsmfnfuh/V7HtzmqytwwVvC4p/Tos
         w0pofK8JW2hn+YZh6oeoVEj/hHFeNrC1dT1JPnG0U7AG9IHcZyf5alG+G9h/PKKN95jb
         3cVwtm0bUFt2tqK/d89M/bz4nfc1KrCmji6NkbA+mghmXaZjqmIJjO1uUJ4vFCmk6YwJ
         c1MNQrcQEmj7+pk1R9LQnuh2HN2R+3FoTQtHUAZXbi04OXBRzQ1P3CjypNbzMYoieU47
         ybiaO95UMmH0gudjsDFmuxGAMFsGjzwIDOtbuMPbRDjpo2RtDCLfEqcSwp2J4injT1Am
         W6EQ==
X-Gm-Message-State: AC+VfDwG/R1fmlKcif8Lul9X6RNPzOMJvI2XLrE37cAm9SBb8CULFwEt
        Zs7Y3UNVWEQ/GWSdv7S8Rbg=
X-Google-Smtp-Source: ACHHUZ4YGGTWAES+ifNoAmfqzMuyp7rgF6Rhkiiru7ruMgSKKpN7kzpCCSfJrIQ7EJbOmjWIGpTfVQ==
X-Received: by 2002:a17:903:124f:b0:1ac:451d:34a with SMTP id u15-20020a170903124f00b001ac451d034amr54880269plh.33.1684347796297;
        Wed, 17 May 2023 11:23:16 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902650900b001a6dc4f4a8csm18010196plk.73.2023.05.17.11.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:23:15 -0700 (PDT)
Message-ID: <097caed2-10b3-7cd1-7c06-90f983e5c720@acm.org>
Date:   Wed, 17 May 2023 11:23:13 -0700
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
 <86065501-ab2e-09b4-71cd-c0b18ede00ed@acm.org>
 <a26e28a6-91e0-e803-749e-2ce957711c64@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a26e28a6-91e0-e803-749e-2ce957711c64@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 00:49, Yu Kuai wrote:
> 在 2023/05/16 23:12, Bart Van Assche 写道:
>> I propose that we switch to one of these two approaches:
> 
> How about a smoothing method that the device with more io will share
> more tag, and each device will get at least one tag?

Hi Yu,

hctx_may_queue() is called from the hot path (blk_mq_get_tag()). I'm 
pretty sure that adding any nontrivial code in that path will cause a 
performance (IOPS) regression. So I don't think that adding a smoothing 
method in hctx_may_queue() is a realistic option.

Thanks,

Bart.
