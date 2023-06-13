Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD08472E56B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjFMOPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbjFMOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD05122
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686665690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpkNnyJl/r+l38jd7G4jK6EOYDsTz3j87kgRPwWTAIk=;
        b=UEf2412qnQxslGydMVsXHlAGJheQD7H3W1ba4V4jw8AFiat/XGsKgW6+kwkmoc9C0sVUjj
        7O+KCAWM7CauJ5VD2/ekPbjroieWhekQv3uCuYtsVIvbDEec4WYe/gna9a/0dGu8rdW+/E
        ZrcOVsJ5wBhGoXDm/Fj8HQ4qaPEYq8A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-DmXNZWxKPO2uFRts67c1Og-1; Tue, 13 Jun 2023 10:14:43 -0400
X-MC-Unique: DmXNZWxKPO2uFRts67c1Og-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b3c8e41075so13425715ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665674; x=1689257674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DpkNnyJl/r+l38jd7G4jK6EOYDsTz3j87kgRPwWTAIk=;
        b=T9ZgrLF/i2/O8mytiaYdAHEEsdNEeF9b3P7aN4vW6rRbkJC4fUuUMpU7HeA+pCR6Nv
         RrpOEoFy/Z+NAGqfZwmv68uBq2K+YkoyyuiEa+QnoITdfjHDdzzxYci0wDywee1A9S6Q
         6HEK4kzMtuVFmIbIPHL8Rwm9XLoukm2FE4p0zeCG8CZPy+N9R0ck+kG+r6CJBJIXqs4y
         YEGxtyAjZ7V/tt32YRKOu/ZAnfVmgvr/VP0DbCG39abqxRwKhVrDhZvzjNPfMG8jPc29
         rRZjENbWuGO4u5Z5xa6q3MU4NJthC7ZnkUzdvwKRLTYIPKkNY6MM3lYwn9rYEcnWHZ46
         slVg==
X-Gm-Message-State: AC+VfDxZc+3yx9geouUD5p3Nou7SQeOtWWRul7993yfRcXYcldWlq280
        R/YoKSmJC+hif3OgRZyjdBRhhQXjW/GL6prR68H98/isaqvM79cYXieP/SJoD5TPXDzpt4y7vnl
        +BVk/vD9Bru6KSyZupUKO/ZWb
X-Received: by 2002:a17:902:db05:b0:1ac:750e:33ef with SMTP id m5-20020a170902db0500b001ac750e33efmr10683892plx.3.1686665673982;
        Tue, 13 Jun 2023 07:14:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7hphU5oNXY+vLyEtzb2/VXAwyFdv/W1ERGfScbT2ryMWNZzP9j95BDoUSr4GRG7HdpNpBDJA==
X-Received: by 2002:a17:902:db05:b0:1ac:750e:33ef with SMTP id m5-20020a170902db0500b001ac750e33efmr10683869plx.3.1686665673684;
        Tue, 13 Jun 2023 07:14:33 -0700 (PDT)
Received: from [10.72.13.126] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902b11700b001b008b3dee2sm4805118plr.287.2023.06.13.07.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 07:14:33 -0700 (PDT)
Message-ID: <3917c8cf-dff7-e922-1d64-7ca1d7f03030@redhat.com>
Date:   Tue, 13 Jun 2023 22:14:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [dm-devel] [PATCH -next v2 2/6] md: refactor action_store() for
 'idle' and 'frozen'
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-3-yukuai1@huaweicloud.com>
 <b780ccfd-66b1-fdd1-b33e-aa680fbd86f1@redhat.com>
 <1aaf9150-bbd3-87a8-8d54-8b5d63ab5ed3@huaweicloud.com>
 <CALTww2-ta1NUJxcT3Dq5KP7iunnVx24X7RKj1OKYTYwEPeDNrg@mail.gmail.com>
 <68b215a4-b4bb-7c94-6ad4-84ea859af742@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
In-Reply-To: <68b215a4-b4bb-7c94-6ad4-84ea859af742@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/13 下午8:44, Yu Kuai 写道:
> Hi,
>
> 在 2023/06/13 20:25, Xiao Ni 写道:
>> On Tue, Jun 13, 2023 at 8:00 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> Hi,
>>>
>>> 在 2023/06/13 16:02, Xiao Ni 写道:
>>>>
>>>> 在 2023/5/29 下午9:20, Yu Kuai 写道:
>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>
>>>>> Prepare to handle 'idle' and 'frozen' differently to fix a deadlock,
>>>>> there
>>>>> are no functional changes except that MD_RECOVERY_RUNNING is checked
>>>>> again after 'reconfig_mutex' is held.
>>>>
>>>>
>>>> Can you explain more about why it needs to check MD_RECOVERY_RUNNING
>>>> again here?
>>>
>>> As I explain in the following comment:
>>
>> Hi
>>
>> Who can clear the flag before the lock is held?
>
> Basically every where that can clear the flag...
>
> // This context     // Other context
>             mutex_lock
>             ...
> test_bit -> pass
>             clear_bit
>             mutex_unlock
> mutex_lock
> test_bit -> check again
>
> Thanks,
> Kuai

At first, I wanted to figure out a specific case. Now I have the answer. 
Maybe there are two people that want to stop

the sync action at the same time. So this is the case that can be 
checked by the codes.

Regards

Xiao

>>
>> Regards
>> Xiao
>>>>> +    /*
>>>>> +     * Check again in case MD_RECOVERY_RUNNING is cleared before 
>>>>> lock is
>>>>> +     * held.
>>>>> +     */
>>>>> +    if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>>>>> +        mddev_unlock(mddev);
>>>>> +        return;
>>>>> +    }
>>>
>>> Thanks,
>>> Kuai
>>>
>>
>> .
>>
>

