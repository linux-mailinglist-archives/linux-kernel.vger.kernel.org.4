Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187545EEA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiI1Xkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiI1XkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:40:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA411DFE5;
        Wed, 28 Sep 2022 16:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GtZBVoojZglRKf15s4Lbuh/hiw3mYqJL//9snIz2hts=; b=qdJXfw9HLJYQm7iBXKg1buwUGM
        6U60rkI6EecBHtwAihCIasRxlVYvmfrnxjNivPY8DM9uiDvgb7cOj9HdbKAraknS15wN6Zc3wYS7Z
        Lwp520IWLcQc1wBL2bfl65cuG3M3GgjSiqM1qb3clItiuAqwmXpAXUhS7G16REb0GYGCVuZM6YVZW
        mUJgV1wb7y4WdbMz1eQPEBBeqhmHkOkXbuwvIXxGckwjlysE369nBXL53t+64zsK1CvSuaEHOkFvQ
        RXj36Fcnw26ulGFrlZ9zM+XVmkLj8Md1F8m713xWj55sQF7R3O3KuxQBJfIwy2DS+t9R48a/Xhzaf
        1Dfrzo6g==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odgeA-000fNc-1j; Wed, 28 Sep 2022 23:39:22 +0000
Message-ID: <574f63b0-5d34-617b-2b9d-b3b282fafd9e@infradead.org>
Date:   Wed, 28 Sep 2022 16:39:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [External] Re: [RFC] proc: Add a new isolated /proc/pid/mempolicy
 type.
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
References: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
 <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
 <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
 <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_SBL_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 9/26/22 07:08, Michal Hocko wrote:
> On Mon 26-09-22 20:53:19, Zhongkun He wrote:
>>> [Cc linux-api - please do so for any patches making/updating
>>> kernel<->user interfaces]
>>>
>>>
>>> On Mon 26-09-22 17:10:33, hezhongkun wrote:
>>>> From: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>>>
>>>> /proc/pid/mempolicy can be used to check and adjust the userspace task's
>>>> mempolicy dynamically.In many case, the application and the control plane
>>>> are two separate systems. When the application is created, it doesn't know
>>>> how to use memory, and it doesn't care. The control plane will decide the
>>>> memory usage policy based on different reasons.In that case, we can
>>>> dynamically adjust the mempolicy using /proc/pid/mempolicy interface.
>>>
>>> Is there any reason to make it procfs interface rather than pidfd one?
>>
>> Hi michal,  thanks for your reply.
>>
>> I just think that it is easy to display and adjust the mempolicy using
>> procfs. But it may not be suitable, I will send a pidfd_set_mempolicy patch
>> later.
> 
> proc interface has many usability issues. That is why pidfd has been
> introduced. So I would rather go with the pidfd interface than repeating
> old proc API mistakes.

Sorry, I'm not familiar with the pidfd interface and I can't find any
documentation on it. Is there some?

Can I 'cat' or 'grep' in the pidfd interface?

>> Btw.in order to add per-thread-group mempolicy, is it possible to add
>> mempolicy in mm_struct?
> 
> I dunno. This would make the mempolicy interface even more confusing.
> Per mm behavior makes a lot of sense but we already do have per-thread
> semantic so I would stick to it rather than introducing a new semantic.
> 
> Why is this really important?

Thanks.

-- 
~Randy
