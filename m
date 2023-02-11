Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2569349F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 00:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBKXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 18:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 18:06:32 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D283D6;
        Sat, 11 Feb 2023 15:06:31 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id q13so10213956qtx.2;
        Sat, 11 Feb 2023 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XexWdl6TtTi4Fjueq7elzY32T2IN8DIhaj/CDtKmSgI=;
        b=hU9jBn9f0Z7VUVlMUN5qwUG4iDjrdNVQZDMXe2ZNsME+AnigDg0eeBMxe9KpNwgFmT
         4P1Wy3pqNZNuhhq3FVTERB9Xge/XNY2k7oNWuikHambKHtsH4dmN931+b5zL86XgCiHw
         urLg/hrmgHufdi9F0UY6SEi+r2PhRRwDW6QPbDVBe+xQSQrSfRAjj083H3PPVQUHWyTW
         dh9F73PiHAtQeH5LTLuxsDv94rmy4oX6zPQMVXw6ww89Aq1tRBNTDs2vfKkXKY9gicDj
         eUkpqlbw9qFaCXy913832NetRyyi19avRiWSgXXcII/RIwwkPQgAsl3XiRNUSeEZ1xpG
         ASgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XexWdl6TtTi4Fjueq7elzY32T2IN8DIhaj/CDtKmSgI=;
        b=rRImkuCAr3Tpx85hBbT0sZzGe+0/oxsx4fWQonhsfXz36zNTOF7TY13Ug8K+EHYNCt
         H5U+u+wWJ7vtxhd+N4YWlYCiNRu5IIdGQQImSd5DB46ZDHupXyxir/GCJ5rY6af/kIjF
         aS4TZ6A8Yww+DbJ9QjUmroq6Zzk/MbgU0hRbA0H2ZMqw1jcD3Z16Q+tJRgIMbasolY7C
         0qHCsUkp7SWWJ4KC/T50HkfPCImsW1Dw4O7hzKt7SdtorwUygIl7UTCqFPSRUaxyIiAB
         iPsEW2NUIoMGiTAfPFx0c/go0Gc23Bnp3eGS4jHCF4wkLDB4iqnVpz8n43W+ybBrkS/C
         Mt1w==
X-Gm-Message-State: AO0yUKVS7Rf9NtBB0YrhdnoNSMUIVk08qbRV1Y3GrUsN8C02/zkx4yXO
        t0k3jTGNiI1O/RlTXng8IQ==
X-Google-Smtp-Source: AK7set/4FWruaqIagAvn6SDdiTFI+kroF1mRDTT+90HAp8bQrUMKdaI/DiabjQ9uO8tUDtKDElebYw==
X-Received: by 2002:ac8:580f:0:b0:3ba:ef:fc0e with SMTP id g15-20020ac8580f000000b003ba00effc0emr37585314qtg.57.1676156790604;
        Sat, 11 Feb 2023 15:06:30 -0800 (PST)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o5-20020ac80245000000b003b64f1b1f40sm6126760qtg.40.2023.02.11.15.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 15:06:30 -0800 (PST)
Message-ID: <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
Date:   Sat, 11 Feb 2023 18:06:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Coly Li <colyli@suse.de>, kent.overstreet@linux.dev
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
References: <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
Content-Language: en-US
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 16:51, Linus Torvalds wrote:
> On Sat, Feb 11, 2023 at 1:41 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> @@ -2941,7 +2944,10 @@ void device_initialize(struct device *de
>>          kobject_init(&dev->kobj, &device_ktype);
>>          INIT_LIST_HEAD(&dev->dma_pools);
>>          mutex_init(&dev->mutex);
>> -       lockdep_set_novalidate_class(&dev->mutex);
>> +       if (!lockdep_static_obj(dev)) {
>> +               lockdep_register_key(&dev->mutex_key);
>> +               lockdep_set_class(&dev->mutex, &dev->mutex_key);
>> +       }
>>          spin_lock_init(&dev->devres_lock);
>>          INIT_LIST_HEAD(&dev->devres_head);
>>          device_pm_init(dev);
> 
> So I think this is the right thing to do, but I note that while that
> lockdep_set_novalidate_class() was "documented" to only be for
> 'dev->mutex' by scripts/checkpatch.pl, that horrific thing is also
> used by md/bcache/btree.c for the mca_bucket_alloc().
> 
> Can we *please* get rid of it there too (it was added by the initial
> code, and never had any explicit excuse for it), possibly by using the
> same model.
> 
> And then we could get rid of lockdep_set_novalidate_class() entirely.
> That would be a good thing.

Yeah, what bcache really needs (and presumably dev->mutex as well) is 
just to disable lockdep checking for self-deadlock of that lock type, 
since it's got its own deadlock avoidance and the subclass thing isn't 
good enough.

I've got a patch that should do what we want, replying from my other 
account with it.

