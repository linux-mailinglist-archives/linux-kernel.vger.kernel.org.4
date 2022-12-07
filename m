Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807246455F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLGJA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLGI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:59:51 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBD5B64;
        Wed,  7 Dec 2022 00:59:49 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B73eoE9005999;
        Wed, 7 Dec 2022 09:59:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=nv6CSPzVcW61iwkrykBZRIYhH/dOHXw9fTiSF2/SiQM=;
 b=K5E2/ZFV72JXYOOO2qm+i5qqzlKR3RZqMka9beO8GWMopK6Ec60Rw26b05aEI+TmNL3+
 y89RUzlNV7+NxHi1aVgXIZj9ggtiZtTC7rbOhDjm/i1bhiCtSjN/VP5atSJL2TNyXBOb
 yeAxPa+bWYzV4kC5GpUj0WfR6AIRD337HG7A5CF/DrU4Yzd2c5yX58xO6nj0HlsrTAX4
 jFAWC4s7M7nLNHxIqBWl/lVbYKequzvRzGjjYRyian+ZzsFulCaOxvsIkJUJRJgdA4zl
 KpEvqV+cgnI9DrZB14/SUlsRkaxgW8ZKmFr4Xvwgbnn8NVZp6JFANPBTV6QIZB8FGP+/ 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m7x7py2bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 09:59:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 290B010002A;
        Wed,  7 Dec 2022 09:59:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F79D21BF66;
        Wed,  7 Dec 2022 09:59:33 +0100 (CET)
Received: from [10.201.20.73] (10.201.20.73) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 7 Dec
 2022 09:59:32 +0100
Message-ID: <9dbc355c-2f73-cfb9-4808-fce65d7860e3@foss.st.com>
Date:   Wed, 7 Dec 2022 09:59:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] rpmsg: char: Use preallocated SKBs.
Content-Language: en-US
To:     Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20221206085008.25388-1-piotr.wojtaszczyk@timesys.com>
 <0987cae3-0edc-918b-5b23-22f238f22aa2@foss.st.com>
 <CAG+cZ05b9W4e=AhoiAgehW7V7uWTPaBReAcQkTcVQmDsXwUYFw@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <CAG+cZ05b9W4e=AhoiAgehW7V7uWTPaBReAcQkTcVQmDsXwUYFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.73]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_04,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/22 15:40, Piotr Wojtaszczyk wrote:
> Hi Arnaud,
> 
> On Tue, Dec 6, 2022 at 1:54 PM Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com
> <mailto:arnaud.pouliquen@foss.st.com>> wrote:
>> On 12/6/22 09:50, Piotr Wojtaszczyk wrote:
>> > On a message reception copy the message to a SKB taken from preallocated
>> > pool instead of allocating a new SKB each time.
>> > During high rpmsg traffic this reduces consumed CPU time noticeably.
>>
>> Do you have any metrics to share?
> Tested on 1GHZ single core ARM Cortex-A55 (64bit), virtio backend.
> Ping-pong pair messages (receive + send) every 125us reduced cpu load from 7% to 6%.
> 
>> > +static inline
>> > +struct sk_buff *rpmsg_eptdev_get_skb(struct rpmsg_eptdev *eptdev)
>> > +{
>> > +     struct sk_buff *skb;
>> > +
>> > +     skb = skb_dequeue(&eptdev->skb_pool);
>> > +     if (!skb)
>> > +             skb = alloc_skb(MAX_RPMSG_BUF_SIZE, GFP_ATOMIC);
>>
>> The "get_mtu" endpoint ops should be used here.
>> But in any case this works for the virtio backend which defines get_mtu ops
>> (asit define the MAX_RPMSG_BUF_SIZE), but not for other backend such as glink.
>> Your proposal needs to be compatible with the legacy.
>>
>> Here is a proposal:
>>
>> static struct
>> sk_buff *rpmsg_eptdev_get_skb(struct rpmsg_eptdev *eptdev, int len)
>> {
>>         struct sk_buff *skb;
>>
>>         if (eptdev->ept->ops->get_mtu) {
>>                 skb = skb_dequeue(&eptdev->skb_pool);
>>                 if (!skb)
>>                         skb = alloc_skb(eptdev->ept->ops->get_mtu(eptdev->ept),
>>                                         GFP_ATOMIC);
>>         } else {
>>                 alloc_skb (len);
>>         }
>> }
> The received messages can have different lengths, if we try to reuse skb
> which was allocated for smaller a message previously, that is a problem, isn't it?
> I went for the worst case scenario in the virtio backend.

The get_mtu give you the max transmit unit which should be > len, but some
checks can be added

Regards,
Arnaud
> 
> 
>> > @@ -126,6 +161,18 @@ static int rpmsg_eptdev_open(struct inode *inode,
> struct file *filp)
>> >       struct rpmsg_endpoint *ept;
>> >       struct rpmsg_device *rpdev = eptdev->rpdev;
>> >       struct device *dev = &eptdev->dev;
>> > +     struct sk_buff *skb;
>> > +     int i;
>> > +
>> > +     /* Preallocate 8 SKBs */
>> > +     for (i = 0; i < 8; i++) {
>>
>> Do you need to preallocate them?
>> during runtime, it will try to reuse SKBs of the skb_pool and if no more
>> available it will create a new one.
>> This would also help to solve the issue of using MAX_RPMSG_BUF_SIZE
> Agree, we can allocate SKBs at run time if needed. I thought it would be better
> to start with some SKBs but I think now it's an overkill.
> 
> 
> -- 
> Piotr Wojtaszczyk
> Timesys
