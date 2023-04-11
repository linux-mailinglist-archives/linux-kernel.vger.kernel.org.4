Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06176DDFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDKPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDKPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:46:33 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3857173A;
        Tue, 11 Apr 2023 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=s2GNIxiOdMRo32rxHLzkvUgx/1HWR5yuURrFTvxp/Ms=; b=nGulDQNO8k4wxugoP4ox8lB10X
        Quz/YHnoB03rzn2RP8SQaoFIaQRvAKAUw4oTnKl64D8X8EZEMCtMz+khxhsZ2BPIFzAChcy22h3K0
        wPh7yq0MvzkJQ1n3wl7MMwjyG2IrzYGp0wky51ldKNx0LLufMI65/lLJGKUb0QGcjz0UmjyBJZjy2
        2zSutM0P8g6n7EgvOraTASNqg9pDtPZUiPIKnbczqvn6TcinizL9IibVUlHt7bKltZEKAe1SghpG0
        QGOPLHA9ebvMxxsoVOnF042WLXXky6SuWIqYouCAOMrtc9wAF+AiBuDPyynbk578QVht55whk+5aH
        PA7jzy4A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pmGCH-006AQu-Fd; Tue, 11 Apr 2023 09:46:18 -0600
Message-ID: <f67e8d9b-dae8-fced-ce7b-b0f8fff2d127@deltatee.com>
Date:   Tue, 11 Apr 2023 09:46:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
 <20230410113559.1610455-2-yukuai1@huaweicloud.com>
 <CAPhsuW7rUQ9KFxCQw-iAAA64=x==b-Qu0nnp32TXn-85Okb00w@mail.gmail.com>
 <daa344fe-9d8d-16f9-aded-513f250928b9@huaweicloud.com>
 <CAPhsuW7bBaVsneBHYqwN3yd5k3sg6ZUFqEJad3yOD0=N-e411g@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPhsuW7bBaVsneBHYqwN3yd5k3sg6ZUFqEJad3yOD0=N-e411g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: song@kernel.org, yukuai1@huaweicloud.com, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH -next v5 1/6] md: pass a md_thread pointer to
 md_register_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-10 23:26, Song Liu wrote:
> On Mon, Apr 10, 2023 at 6:34 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/04/11 9:15, Song Liu 写道:
>>> On Mon, Apr 10, 2023 at 4:37 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Prepare to protect md_thread with rcu, there are no functional changes.
>>>
>>> Why do we need this change? To add __rcu later?
>>
>> Add __rcu is one reason, more importantly is to assign md_thread inside
>> md_register_thread in patch 6:
>>
>> rcu_assign_pointer(*threadp, thread);
> 
> Got it.
> 
>>>
>>> Can we do something like:
>>>
>>> struct md_thread __rcu *md_register_thread(void (*run) (struct md_thread *),
>>>                 struct mddev *mddev, const char *name)
>>
>> I think this is not necessary, if we don't want to change api, we must
>> use rcu_assign_pointer for each caller to set md_thread.
> 
> I think it is better to use rcu_assign_pointer at the caller side.

I agree.

Logan
