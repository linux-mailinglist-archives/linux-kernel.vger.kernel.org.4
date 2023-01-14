Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0202F66ACB8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjANQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjANQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:52:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01D8A5F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:52:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so3505179pjg.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r8fEsyXFGyDo9GLdk8iexVXpcrJ+6dsb6d79v4PdLw=;
        b=YAL4ZniVqjGmb3RaqEl+JyyyDPfnTLJFci1AS0MsY7ffcCfD/80BS4+fwG73kZaqCG
         hP8tGGJD/UccV7j4bI8+9f1CtlkFtP7+qt4YscIPfK/bFYalSUhRGNfevMODsxZuLIsQ
         OwdNZa8wGOl2D2WCQkrnCbrHx/FteCRuRHVKKudS9mefVcozZqd2QpjzuckHsEV9aiZQ
         UHCoTtVgJy/u1e6pfFHrVDGzKXC0Tk4xRcmPlHxn4lnhv2Ds0kBepWoc0Koi6+CjEgKX
         tAtxcCyeLpObF32hdZUIBVJm6LObC8jkqWeocz8dCvq479QO1XmBEFzs8Qy0/MGBMnU7
         yflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0r8fEsyXFGyDo9GLdk8iexVXpcrJ+6dsb6d79v4PdLw=;
        b=lGI/EA+fC26CeUy+adLTKjJSih5rB8ppvkpWHY5GGoCD/jA64OaCGxjmfjdTyUeWyC
         pv/erkImu80kutuUpZZ4H7Sw7HhssP69xSexWTnMId9/Lqufgt20OhNz4+/ILaRhYBVA
         AuU/4LKCJGnTCovKdGIkhaYDibOdo4nEMheVqOOZ2lT+rPF7kCCyag/GuiXAA4wL+NVy
         n6stC5iNg1SDuv89GeuhzyyWdp2a/Z+hudkW3l0demOS3Th7c3538xzrJlDFWFRs/Jmu
         gkQcz0uzh1WT3ZDqj0k+8U5Y6A1GrwEUyylseLUp/W47gQ1ot9aywY8mYPeWq0CmHmn2
         1fMQ==
X-Gm-Message-State: AFqh2krrpo9oRg5YZl/fJcSpUAK/nDPwvmfnOnabEQfejEOxAgFC0TbW
        x+K/EYa5o8W0OTuGU8M7QFbilcbZ9ewmU7lf
X-Google-Smtp-Source: AMrXdXtBB+Thqid8TektyKq3oMWFoyl6CRastJTFGzRlJmLlJ3+3r5SJmjIc9B0EBYrVBwG4nAs5ow==
X-Received: by 2002:a17:902:8688:b0:189:e7ea:9ff9 with SMTP id g8-20020a170902868800b00189e7ea9ff9mr74756522plo.42.1673715151890;
        Sat, 14 Jan 2023 08:52:31 -0800 (PST)
Received: from [10.5.37.157] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001897e2fd65dsm16219645plk.9.2023.01.14.08.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 08:52:31 -0800 (PST)
Message-ID: <d1f71b24-2e50-341f-93f8-e3ed9b2dd412@bytedance.com>
Date:   Sun, 15 Jan 2023 00:52:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH 0/3] mm: replace atomic_t with percpu_ref
 in mempolicy.
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
References: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
 <Y8GPCT2w0WKARLVF@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y8GPCT2w0WKARLVF@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon 05-12-22 00:14:29, Zhongkun He wrote:
> [...]
>> +/* Obtain a reference on the specified mpol */
>>   static inline void mpol_get(struct mempolicy *pol)
>>   {
>>   	if (pol)
> 
> Shouldn't this be mpol_needs_cond_ref?
> 
>> -		atomic_inc(&pol->refcnt);
>> +		percpu_ref_get(&pol->refcnt);
>> +}
>> +
>> +static inline bool mpol_tryget(struct mempolicy *pol)
>> +{
>> +	return pol && percpu_ref_tryget(&pol->refcnt);
>>   }
>>   
>> +/*
>> + * This function initiates destruction of mempolicy.
> 
> This is not a useful comment. It would be much more helpful to say when
> this should be called.
> 
>> + */
>> +static inline void mpol_kill(struct mempolicy *pol)
>> +{
>> +        if (pol)
>> +                percpu_ref_kill(&pol->refcnt);
>> +}
>> +
>> +
>>   extern bool __mpol_equal(struct mempolicy *a, struct mempolicy *b);
>>   static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
>>   {
>> @@ -197,11 +210,15 @@ static inline void mpol_put(struct mempolicy *p)
>>   {
>>   }
>>   
>> -static inline void mpol_cond_put(struct mempolicy *pol)
>> +static inline void mpol_get(struct mempolicy *pol)
>>   {
>>   }
>>   
>> -static inline void mpol_get(struct mempolicy *pol)
>> +static inline bool mpol_tryget(struct mempolicy *pol)
>> +{
>> +}
> 
> This should return false, right?
> 
> [...]
>> +/* Obtain a reference on the specified task mempolicy */
> 
> Again, this is pretty much clear from the name. It would be more useful
> to explain how the pointer can be used - e.g. needs to call mpol_put
> or mpol_kill depending on the calling context.
> 
>> +static mempolicy *get_task_mpol(struct task_struct *p)
>> +{
>> +	struct mempolicy *pol;
>> +
>> +	rcu_read_lock();
>> +	pol = rcu_dereference(p->mempolicy);
>> +
>> +	if (!pol || mpol_tryget(pol))
> 
> Shouldn't be !mpol_tryget?
> 
>> +		pol = NULL;
>> +	rcu_read_unlock();
>> +
>> +	return pol;
>> +}
>> +
> 
> I do not see any rcu_assign_pointer for the newly created policy so this
> seems incomplete. Ditto no mpol_kill calls. I am unlikely to get into
> follow up patches now. Please split up the work so that it is reviewable
> more easily and then I can have a further look.
> 
> Thanks!

Thanks for your review, some changes may be in other patch,i will
reorganize the patches according to the suggestions to make
things clear.

Thanks.

