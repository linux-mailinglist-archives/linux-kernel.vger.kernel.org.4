Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB16E7A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjDSNPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjDSNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:15:52 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B741D13C34;
        Wed, 19 Apr 2023 06:15:50 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-2f94fe993edso476860f8f.1;
        Wed, 19 Apr 2023 06:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681910149; x=1684502149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIgRlyZSNH/SNYRlepaN+njO6QBAl9chuqcWN0oyisY=;
        b=SkshjrmWssSuD2f1iITqPrqGqeOomeCw9+gjW0AxlIkPPRu4jJvkBMx3kdlpxe7QpE
         Th0ZaHMHVMIQ//fe56jEkOCwc8zBRAnQa075vEUx91qZUII1phQ8QY9xJ57hbf3mq7HV
         Gdbm8q2yedSrYtpUT5KCe783hnTJmPu5WFGFYAV8V791r4F2rgORI0OuaY8ax4dQgRSw
         Yjw+Qu+qJ2A3QyetTB9ePKMRe0GoafYeAB83CznLRqpq/wVQm0s4XavIgAgfMfny/wNy
         Z1ctPvdWUQZtDTnMYL/mMPwfl6qbS3nnpnKcY8H5cavNVt0jwKTc4zwc3VPs8OT6wGbi
         H8UQ==
X-Gm-Message-State: AAQBX9eoc1dROPyotTOLbzPAO3GRMdP+WaTpm8Get4ld9XW9DgCJAZvo
        hzxf+SJk5/GM9kgKqDyUUPVV5w0NM4E=
X-Google-Smtp-Source: AKy350aM3txglqO3IBUp/d4qIVyIrEs8rob4csV9yafFShyvmuXFrJJ0427NCQSlvWFhFQKDFVdKKg==
X-Received: by 2002:a5d:548e:0:b0:2c7:1c72:699f with SMTP id h14-20020a5d548e000000b002c71c72699fmr11405069wrv.4.1681910149047;
        Wed, 19 Apr 2023 06:15:49 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b002fda1b12a0bsm4211767wrr.2.2023.04.19.06.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:15:48 -0700 (PDT)
Message-ID: <6a5feb66-632f-b843-c04d-e0aaa2d51415@grimberg.me>
Date:   Wed, 19 Apr 2023 16:15:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
 <zlavgcdalmmtabiabu76m4s3oo5hyaehckmwcxvqrnu3j6q6xo@5ke6gv5h3j7i>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <zlavgcdalmmtabiabu76m4s3oo5hyaehckmwcxvqrnu3j6q6xo@5ke6gv5h3j7i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> While testing the fc transport I got a bit tired of wait for the I/O jobs to
>>>> finish. Thus here some runtime optimization.
>>>>
>>>> With a small/slow VM I got following values:
>>>>
>>>> with 'optimizations'
>>>>      loop:
>>>>        real    4m43.981s
>>>>        user    0m17.754s
>>>>        sys     2m6.249s
>>
>> How come loop is doubling the time with this patch?
>> ratio is not the same before and after.
> 
> first run was with loop, second one with rdma:
> 
> nvme/002 (create many subsystems and test discovery)         [not run]
>      runtime  82.089s  ...
>      nvme_trtype=rdma is not supported in this test
> 
> nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
>      runtime  39.948s  ...
>      nvme_trtype=rdma is not supported in this test
> nvme/017 (create/delete many file-ns and test discovery)     [not run]
>      runtime  40.237s  ...
> 
> nvme/047 (test different queue types for fabric transports)  [passed]
>      runtime    ...  13.580s
> nvme/048 (Test queue count changes on reconnect)             [passed]
>      runtime    ...  6.287s
> 
> 82 + 40 + 40 - 14 - 6 = 142. So loop runs additional tests. Hmm, though my
> optimization didn't work there...

How come loop is 4m+ while the others are 2m+ when before all
were the same timeframe more or less?

> 
>>> Those jobs are meant to be run for at least 1G to establish
>>> confidence on the data set and the system under test since SSDs
>>> are in TBs nowadays and we don't even get anywhere close to that,
>>> with your suggestion we are going even lower ...
>>
>> Where does the 1G boundary coming from?
> 
> No idea, it just the existing hard coded values. I guess it might be from
> efa06fcf3c83 ("loop: test partition scanning") which was the first real test
> case (according the logs).

Was asking Chaitanya why is 1G considered sufficient vs. other sizes?
Why not 10G? Why not 100M?
