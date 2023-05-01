Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3196F31DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjEAOK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjEAOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:10:57 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72CB3;
        Mon,  1 May 2023 07:10:54 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f17b5552e9so6683725e9.1;
        Mon, 01 May 2023 07:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950253; x=1685542253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E152j3pnk/BrHS8sWJRy0UHCIwLsl7zy8OP47cXnS0Y=;
        b=TifFEeTJ4hkK/BKD0/h90tC+UdfdSexvrldKN9nisaIQqtf/RsSZw1Z4MAzSsQtEL6
         gLMJC2V+BkdENSew7SZH93ntHDu0casZ4cZorcoJI3/KX/QwOVy6G8s6/VECZ/lLzANN
         pKz2M8qWWHw76zIQaFrvQdjzeZi55lx5f5OMgZC+ZWajBkPyb0TwMVMNeLpcRWEzYfsq
         GmLUYUtUV/6n3pjMWOn2DOIFkX5YykYBH2rgQwM5ZPFOg/b633Mc/MRvE05R0kFqSBtJ
         74R+q+or8KStGHXn8Y7wGiLdvxvduEMHr2wQ0Il7LtPo208bfNLbwiTzRy2KN2W1lydK
         Af6Q==
X-Gm-Message-State: AC+VfDwHjAgE9tSbNCq4f5iBO7xUq6Yzt0QMIlhFUuytAxB0Mhp7OuCm
        crcYBN19WlZm20PHHMoKflo=
X-Google-Smtp-Source: ACHHUZ6+S4Mp/TYpM1og23avJsV4KoIc7H3R7YzUhy5ilDetCheIf/CqK4ZGbtFdINN5TWWGsJxKDg==
X-Received: by 2002:a05:600c:4f47:b0:3f1:7138:91ee with SMTP id m7-20020a05600c4f4700b003f1713891eemr10855839wmq.2.1682950252653;
        Mon, 01 May 2023 07:10:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003f17e79d74asm33029863wmc.7.2023.05.01.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 07:10:52 -0700 (PDT)
Message-ID: <eb9fec81-0ba6-ce3d-dadd-934250001126@grimberg.me>
Date:   Mon, 1 May 2023 17:10:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
 <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
 <1b060988-fc63-4a86-33b8-88ba61c9358f@grimberg.me>
 <gqeyqpv2idkkkf7jajdxbgj4fi5tnlbt7tmuudwxq3gul3w56y@ijwb4axr52dl>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <gqeyqpv2idkkkf7jajdxbgj4fi5tnlbt7tmuudwxq3gul3w56y@ijwb4axr52dl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/23 13:34, Shinichiro Kawasaki wrote:
> On Apr 19, 2023 / 13:45, Sagi Grimberg wrote:
>>
>>>>> Before we unload the module we should cleanup the fc resources first,
>>>>> basically reorder the shutdown sequence to be in reverse order of the
>>>>> setup path.
>>>>
>>>> If this triggers a bug, then I think it is a good idea to have a
>>>> dedicated test that reproduces it if we are changing the default
>>>> behavior.
>>>
>>> Right, though I would like to tackle one problem after the other, first get fc
>>> working with the 'correct' order.
>>>
>>>>> While at it also update the rdma stop_soft_rdma before the module
>>>>> unloading for the same reasoning.
>>>>
>>>> Why? it creates the wrong reverse ordering.
>>>>
>>>> 1. setup soft-rdma
>>>> 2. setup nvme-rdma
>>>>
>>>> 2. teardown nvme-rdma
>>>> 1. teardown soft-rdma
>>>>
>>>> I don't think we need this change. I mean it is a good test
>>>> to have that the rdma device goes away underneath nvme-rdma
>>>> but it is good for a dedicated test.
> 
> I agree that the new test case is good.
> 
>>>
>>> I was woried about this setup sequence here:
>>>
>>> 	modprobe -q nvme-"${nvme_trtype}"
>>> 	if [[ "${nvme_trtype}" == "rdma" ]]; then
>>> 		start_soft_rdma
>>>
>>> The module is loaded before start_soft_rdma is started, thus I thought we should
>>> do the reverse, first call stop_soft_rdma and the unload the module.
>>
>> They should be unrelated. the safe route is to first remove the uld and
>> then the device.
> 
> Sagi, this comment above was not clear for me. Is Daniel's patch ok for you?
> 
> IMO, it is reasonable to "do clean-up in reverse order as setup" as a general
> guide. It will reduce the chance to see module related failures when the test
> cases do not expect such failures. Instead, we can have dedicated test cases for
> the module load/unload order related failures. start_soft_rdma and
> stop_soft_rdma do module load and unload. So I think the guide is good for those
> helper functions also.

As I mentioned here, this change exercises a code path in the driver
that is a surprise unplug of the rdma device. It is equivalent to
triggering a surprise removal of the pci device normally during
nvme-pci test teardown. While this is worth testing, I'm not sure we
want the default behavior to do that, but rather add dedicated tests for
it.

Hence, my suggestion was to leave nvme-rdma as is.
