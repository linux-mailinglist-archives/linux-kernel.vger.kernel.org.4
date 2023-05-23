Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84C70DFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjEWOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbjEWOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3DC6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684853299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCqOpxr0nnnLiP9DyyZOzmcZxzwnoAGy3acWgoQxcdk=;
        b=DSslNN2kFm+Jhxooit59XVyvsqM1Bw2uEU+hrv2nk9LnB9i8dQm1K5lPSLu2geamYC7e80
        kTJg8+7PX2Cp+DKC24jh4RrxcoukwX2ZLQjk95qTfFUgywgQ4b4RCNjGgYfZfJbdS5JtfB
        JvnOnyDGBe+QEvsiBZ6cfxAazJwr1Gc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-feP7L153OP20vynlECKByw-1; Tue, 23 May 2023 10:48:15 -0400
X-MC-Unique: feP7L153OP20vynlECKByw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506beab6a73so1269763a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853294; x=1687445294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCqOpxr0nnnLiP9DyyZOzmcZxzwnoAGy3acWgoQxcdk=;
        b=kfSvZCs9UYY7inFxlLFc5Jd39kgpyG4dbhwHUkTCYivb5T/jtuwgBD6Qb8emdML9hL
         6LdWnirvDKguK1hme1GOsW/uFDqMXI9BvXcdFMPIu57e8j32a7q4osII5xEYkPLkUmL0
         91tWGOXEm9//Iw/W1dXVOXxbOZiA6u62QExWLU9tbazV4M/6d9bxA8C9WYzS0ZOcASHo
         Q/oak52W6H8nAk6xVe9o6nSqlp8/2BpNJR6Q0+lQodkiBDBcqw6bDVvb6NUQFwVW67k9
         McNJ3875I4seKO7yYr9/8WEXEyXW+ZAIMOpg3sTSY9FqyFcZaz1xFb5xGNaTREo4uDFx
         2Ovg==
X-Gm-Message-State: AC+VfDxojLIianrxUeg9vcL5ghK4kUpsRuoD0k2KFZzGKJPGqbip8m8M
        WHDqNQdyUjl8JiC8aYwfxJJyQZSR+YAxA8srdFkHK1VBYXrVmcwlPe/JbpnY81f5NT1c+aqFapa
        InOetyGomqd3IfUjPuGTCN/dB
X-Received: by 2002:a17:907:a07:b0:966:3c82:4a95 with SMTP id bb7-20020a1709070a0700b009663c824a95mr14081250ejc.19.1684853294593;
        Tue, 23 May 2023 07:48:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45XSE0ctzRa/PX4zWYTTxxjrjsmyp2hPlXUOWlmyB4bbx3XKWREeQagggqcbcqCuBWwwU+Xg==
X-Received: by 2002:a17:907:a07:b0:966:3c82:4a95 with SMTP id bb7-20020a1709070a0700b009663c824a95mr14081238ejc.19.1684853294286;
        Tue, 23 May 2023 07:48:14 -0700 (PDT)
Received: from [192.168.0.107] (ip4-83-240-118-160.cust.nbox.cz. [83.240.118.160])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906729300b00965ec1faf27sm4538776ejl.74.2023.05.23.07.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:48:13 -0700 (PDT)
Message-ID: <892bc614-9e2e-904b-29e0-62daeb855f79@redhat.com>
Date:   Tue, 23 May 2023 16:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers: mpt3sas: mpt3sas_debugfs: return value check of
 `mpt3sas_debugfs_root`
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Jing Xu <U202112064@hust.edu.cn>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230423122535.31019-1-U202112064@hust.edu.cn>
 <6e69b57c-80ae-8b6e-cb5f-9e05da46ecd6@redhat.com>
 <1484408f-f68e-4354-ab59-56af9cd1ef14@kili.mountain>
 <b7154e2c-0438-87d1-9edc-7eb1aad40cd1@hust.edu.cn>
 <81d236bb-3913-4eef-bf71-6d17535d6d79@kili.mountain>
Content-Language: en-US
From:   Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <81d236bb-3913-4eef-bf71-6d17535d6d79@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 16:38, Dan Carpenter wrote:
> On Mon, May 08, 2023 at 09:40:41PM +0800, Dongliang Mu wrote:
>>>>> diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>>>> index a6ab1db81167..c92e08c130b9 100644
>>>>> --- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>>>> +++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>>>> @@ -99,8 +99,6 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
>>>>>   void mpt3sas_init_debugfs(void)
>>>>>   {
>>>>>   	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
>>>>> -	if (!mpt3sas_debugfs_root)
>>>>> -		pr_info("mpt3sas: Cannot create debugfs root\n");
>>>> Hi Jing,
>>>> most drivers just ignore the return value but here the author wanted to
>>>> have the information logged.
>>>> Can you instead of removing the message modify the 'if' condition so it
>>>> suits the author's intention?
>>>
>>> This code was always just wrong.
>>>
>>> The history of this is slightly complicated and boring.  These days it's
>>> harmless dead code so I guess it's less bad than before.
>>
>> Hi Dan and Tomas,
>>
>> Any conclusion about this patch? The student Jing Xu is not sure about how
>> to revise this patch.
> 
> The correct fix is to delete the code.
> 
> Debugfs code has error checking built in and was never supposed to be
> checked for errors in normal driver code.
> 
> Originally, debugfs returned a mix of error pointers and NULL.  In the
> kernel, when you have a mix of error pointers and NULL, then the NULL
> means that the feature has been disabled deliberately.  It's not an
> error, we should not print a message.
> 
> So a different, correct-ish way to write write debugfs error handling
> was to say:
> 
> 	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
> 	if (IS_ERR(mpt3sas_debugfs_root))
> 		return PTR_ERR(mpt3sas_debugfs_root);
I'm fine with this as well, I could wish we get a fix for the exact same
case of debugfs_create_dir in mpt3sas_setup_debugfs and ideally all the
debugfs_create* in  mpt3sas_debugfs.c in a single patch. But this patch
is ok even if that wasn't possible.
tomash

> 
> However, in those days, a lot of people didn't understand error pointers
> and thought that "if (IS_ERR_OR_NULL(mpt3sas_debugfs_root)) {" was a
> super secure way to check for errors.  Or they just got it wrong and
> checked for NULL instead of error pointers.  Any of the checks are
> wrong, but if (IS_ERR()) check was at least correct-ish.
> 
> I dealt with this a lot because of my work with Smatch.  I used to be
> happy if I could persuade someone to write at least correct-ish code,
> but it was pretty painful to try explain this over and over and very few
> people deleted the checks.
> 
> Eventually Greg changed the code to never return NULL and mass deleted
> the IS_ERR() checks.  Not returning NULL makes it simpler to understand.
> And it makes it impossible to check in the correct-ish way so it kind of
> forces people to just delete the error handling.
> 
> regards,
> dan carpenter
> 

