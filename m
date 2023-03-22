Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDAB6C43DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCVHM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVHMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:12:24 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB4E5A193
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:12:22 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso12388351wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbxHciLG2pypN9Bl2bjTVAU52GvCboKUaOJHGsOIGts=;
        b=zoasazBjZzgvLt4ap6poshxPKUrCIafgM2Dht1dSiM9vFqNhUHlXSHmX9Ewy02G+fy
         jxq8ZpIsKzgJoiqcRWVeZo9OqSm6orx8609a64XASIuAno1k8u+RGolASFD1aMMvGNPE
         lGAYRWr/oZs4PYS4yrIWLiV1Wn5bAJ5wUvfVBokQ74cw6ZztnPX1rkPAPSANU2u8mTkq
         M+8QLxcxbsDAaw4cJSltpeRPOCW6kH5tFz0Sx8/UnPdssJUqOCG8mdWeEgvE5NT8jcv+
         GzRRLFopGNQhxnOY3XHnYwZnb5A6dD2lOmGrldB37VO8BNfiaZ7ukkeJaGIeNUy9zuOD
         uiUA==
X-Gm-Message-State: AO0yUKXU1ptCdAWZN16x5RxrYaWqrg14vuzTAHvxKvm59CT5MAnhU9MZ
        oHbO8aT4brzmZokbwPYQ0Q0=
X-Google-Smtp-Source: AK7set/xVFyitMqda4JG/F7Z0xoit+LJ1ikInj55ZuaxNfbI68pTdU7MxR5BPW/3soMGBns5GFGg6A==
X-Received: by 2002:a05:600c:4515:b0:3ed:2eb5:c2e6 with SMTP id t21-20020a05600c451500b003ed2eb5c2e6mr5384776wmo.2.1679469141061;
        Wed, 22 Mar 2023 00:12:21 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003ede6540190sm9659662wmq.0.2023.03.22.00.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:12:20 -0700 (PDT)
Message-ID: <4ec55800-fe57-11f5-d282-a7e4c58f14ce@grimberg.me>
Date:   Wed, 22 Mar 2023 09:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0V4dGVybmFsXSBSZTogW1BBVENIXSBudm1lOiBm?=
 =?UTF-8?Q?ix_heap-use-after-free_and_oops_in_bio=5fendio_for_nvme_multipath?=
To:     Lei Lei2 Yin <yinlei2@lenovo.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
 <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me>
 <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 	No, I have not verified this issue with a system larger than 5.10.y(such as 5.15.y and 6.0 or furthor), because some function we need like cgroup in upper version kernel has changed too much, we can't use these upper version kernel.

Well, this would be the starting point.

> 	In addition , uptreams have change bi_disk's modify to bio_set_dev(bio, ns->disk->part0), and as you said there is no bi_disk in struct bio anymore. So that is too involving because of code dependencies,  i want to do is what you said, to send an alternative surgical fix.

The correct course of action would be to identify and narrow down the
fix for this upstream, and then backport it back to stable kernel 5.10.y

> 	(I will confirm upstream for this problem in the near future, if it have same problem, i will submit this fix.)

Great.

> 	I'm not sure what evidence is needed to prove this problem and patch. The following is child bio and parent bio struct when heap-use-after-free occur catched by crash(I turn on kasan and panic_on_warn).
> 
> 	Please help me confirm if this is enough, thanks.

It is clear that there is a bug in 5.10.y, what we are discussing is:
1. Is this problem relevant to upstream kernel?
2. If yes, we can debate the correct fix, as your initial patch is not
    If not, then the upstream fix for this needs to be identified and
    backported.

Having stable kernels drift away from the original code-base is a bad
idea.
