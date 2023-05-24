Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482D70EEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbjEXGzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:55:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17364E71
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:54:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64f47448aeaso409201b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684911260; x=1687503260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAefNZG4LZt3cqRcnMIDIEa1kLQTnHp5yWi9GEafibo=;
        b=VwbzWvjELIc1qjtZStMTGBOTUduER8iG58DJEbYd/ddVTi2TfixOAtyoDTqt2ldy1G
         rZUgroqQKWoUlSpGOFCuPB0gGBVHAdU7VZaRr5R9xZ4B5pFdsk7GquXQywDcJi4Gb+YC
         Wj+/HMOO86aH7ngxWmsyFbdnO8XVec2hMx8RKzrCbPk1JOCKsxar3EbCpYGFWGRp6Pa5
         sz3ISMMJqpsw/PUsJgttzpXzHeVNDWp0i4fA9HJtJyI14tucKyu57jvOioltpBmizHGY
         ZgAnjHtserzDng6cH5dxyXVgY8I6/vviqHVllEoaC4o9ALiNhroPlnnga0MxW8ZaZqvt
         QqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911260; x=1687503260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAefNZG4LZt3cqRcnMIDIEa1kLQTnHp5yWi9GEafibo=;
        b=Jni7vAgo42OVMnnBxUAzP1rK2og+7OQMHOGzN1EFTKYnmXqbFoWIVPjwSv7kib9Rco
         +qAUbghAvfAq9BDEFT4Db5TaolrFN2h4fjKY8PZ3tHFGMFFYaRprlHZzHM+eoXYp+uF2
         r+LNrrhR0AKLNigExmCMlKoR2YcE8HO1t5okGsjY3TgNMbxdOXV0mtRq1PlJVoTQzXW9
         jqUXgC6MbDl/xQLqHMuXc41E53iHtPM3BjTejFPa+aH9lvrCqw/2MHJw2/qJfxshkcP3
         m7YuPqlaCIBPqOduRx+6suwMRni3cCs6a6mm09Wu+YX6/y4CLg1eAHPbPdVMwK+ON8kF
         UGRw==
X-Gm-Message-State: AC+VfDzbkWjXJSAZZ4spMew9TAZ3pLRjlmYcqFyILJ9XVylPw+qWEQ+q
        DYphRUvUyqSTcFYtDklywMxD4actUd5ReClIOcc=
X-Google-Smtp-Source: ACHHUZ46b/+/pmjB2wPYWnYKyYg7Mp1usod75cx5YIoqK1LZ6TviuKm/20MwM/FVmyRsqozYxXzSIA==
X-Received: by 2002:a05:6a00:b50:b0:640:defd:a6d5 with SMTP id p16-20020a056a000b5000b00640defda6d5mr2173814pfo.12.1684911260295;
        Tue, 23 May 2023 23:54:20 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b0064cb6206463sm5599002pfd.85.2023.05.23.23.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 23:54:19 -0700 (PDT)
Message-ID: <4d49f7e7-2488-9690-258e-34e617cfef6f@bytedance.com>
Date:   Wed, 24 May 2023 14:54:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH] cgroup: rstat: Simplified
 cgroup_base_stat_flush() update last_bstat logic
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518124142.57644-1-jiahao.os@bytedance.com>
 <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
 <5g73i4yvi4ub4dqrf4dnq5qghkyckoygmgd2st6be3gg7twww2@w6zim6nxpt3b>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <5g73i4yvi4ub4dqrf4dnq5qghkyckoygmgd2st6be3gg7twww2@w6zim6nxpt3b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/23 Michal Koutný wrote:
> Hello Jia.
> 
> On Fri, May 19, 2023 at 12:15:57PM +0800, Hao Jia <jiahao.os@bytedance.com> wrote:
>> Maybe something like this?
> 
> (Next time please send with a version bump in subject.)

Thanks for your review, I will do it in the next version.

> 
> 
>> In cgroup_base_stat_flush() function, {rstatc, cgrp}->last_bstat
>> needs to be updated to the current {rstatc, cgrp}->bstat after the
>> calculation.
>>
>> For the rstatc->last_bstat case, rstatc->bstat may be updated on other
>> cpus during our calculation, resulting in inconsistent rstatc->bstat
>> statistics for the two reads. So we use the temporary variable @cur to
>> record the read statc->bstat statistics, and use @cur to update
>> rstatc->last_bstat.
> 
> If a concurrent update happens after sample of bstat was taken for
> calculation, it won't be reflected in the flushed result.
> But subsequent flush will use the updated bstat and the difference from
> last_bstat would account for that concurrent change (and any other
> changes between the flushes).
> 
> IOW flushing cannot prevent concurrent updates but it will give
> eventually consistent (repeated without more updates) results.
> 

Yes, so we need @curr to record the bstat value after the sequence fetch 
is completed.


>> It is better for us to assign directly instead of using
>> cgroup_base_stat_add() to update {rstatc, cgrp}->last_bstat.
> 
> Or do you mean the copying is faster then arithmetics?
> 

Yes, but it may not be obvious.
Another reason is that when we complete an update, we snapshot 
last_bstat as the current bstat, which is better for readers to 
understand. Arithmetics is somewhat obscure.

Thanks,
Hao
