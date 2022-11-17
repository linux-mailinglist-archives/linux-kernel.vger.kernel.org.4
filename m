Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C826662D913
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiKQLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiKQLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E055A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668683290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hJFMcIT53QnK3wZUol6C7JAYb+pXC+Uh295TWzYK8g=;
        b=dDfksV8JfcJ4ylJjhuZ/zII6OKc5CoKM901fE8tv0rW8QqFtTVXn+lZpt3OIZooI9PXQ+9
        d1oDkLGKm12fcstrq6ehsWZRBByb2MpGcHCiybGHW3yoaQjwask9fD53dQlzrRq23Ee8+Q
        RIAM604l5Xau+OUZ3dc/JY0fr+r5PrA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-0H-vN4oYNdCYNTaTk85AYA-1; Thu, 17 Nov 2022 06:08:08 -0500
X-MC-Unique: 0H-vN4oYNdCYNTaTk85AYA-1
Received: by mail-pl1-f198.google.com with SMTP id q10-20020a170902f34a00b00186c5448b01so1207135ple.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hJFMcIT53QnK3wZUol6C7JAYb+pXC+Uh295TWzYK8g=;
        b=c/8OEAyUBZ3ukj6t9N+qjZ0sjwq1V69kv67Jp3ZGPTuzbPR7Ac+xRtqSrFlSojhA+Q
         YWeHeKNLQAG4AJT4PutxbzdaNCVjwoY1CzHAgk9n32F+MuoORqjoZGegjTXzV+f3femf
         WzNCf26yUCvDLFcR3vRr/XTrrUnCYS7vv18uwTqgLtuJtwyR+m3JSP04qbzNohvYIvyO
         TAwdXnfghu4pa/6YdhvFvtE6YVMOEZwrnRm1xMFegDEi4SVn1dSbxQzzAd8FLvQt4T/e
         0O6jbFV1nJlJqNntmkYb+V/sUufmSiSXrxTe281TMphkeHBshRCm1DRYuLxpq7pz2bNd
         iijQ==
X-Gm-Message-State: ANoB5plhqOeze2H94cEGZR9hEK5xUab5zzClB5MrHk9mVoGkwnZB/6SD
        fUWhHs13o0w5vX25mSagdxC9ALVYarJJCLlupbDcBxnn/PCUz1E7XwqeX8T1l5kybhaqHPsRKFT
        saU2YO5cEgEA16d6voPjTTouiGS12ujew+D606+9d7b0QZ9Gc0UuDhuZtN3Jhh06hLudBKD+v6g
        ==
X-Received: by 2002:a17:903:2ce:b0:17f:8a20:d9b5 with SMTP id s14-20020a17090302ce00b0017f8a20d9b5mr2278815plk.76.1668683287637;
        Thu, 17 Nov 2022 03:08:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Aqgbfk1NNZoVWMG2j8mJu0XUHx0gOZFjXhj6xB3w7YNJtRnuIV8CRlIjpnEZ3Kh2u+d8EQA==
X-Received: by 2002:a17:903:2ce:b0:17f:8a20:d9b5 with SMTP id s14-20020a17090302ce00b0017f8a20d9b5mr2278784plk.76.1668683287253;
        Thu, 17 Nov 2022 03:08:07 -0800 (PST)
Received: from [10.72.12.148] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n25-20020a63a519000000b0046ec057243asm762689pgf.12.2022.11.17.03.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:08:06 -0800 (PST)
Subject: Re: [PATCH] ceph: make sure directories aren't complete after setting
 crypt context
From:   Xiubo Li <xiubli@redhat.com>
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221116153703.27292-1-lhenriques@suse.de>
 <5de0ae69-5e3d-2ccb-64a3-971db66477f8@redhat.com>
Message-ID: <41710b3d-b37f-8c65-d55d-c4137a366efd@redhat.com>
Date:   Thu, 17 Nov 2022 19:08:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5de0ae69-5e3d-2ccb-64a3-971db66477f8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/11/2022 16:03, Xiubo Li wrote:
>
> On 16/11/2022 23:37, Luís Henriques wrote:
>> When setting a directory's crypt context, __ceph_dir_clear_complete() 
>> needs
>> to be used otherwise, if it was complete before, any old dentry 
>> that's still
>> around will be valid.
>>
>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>> ---
>> Hi!
>>
>> Here's a simple way to trigger the bug this patch is fixing:
>>
>> # cd /cephfs
>> # ls mydir
>> nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>> # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>> Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8 
>> u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
>> # fscrypt unlock mydir
>> # touch /mnt/test/mydir/mysubdir/file
>> touch: cannot touch '/mnt/test/mydir/mysubdir/file': No such file or 
>> directory
>>
>>   fs/ceph/crypto.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index 35a2ccfe6899..dc1557967032 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -87,6 +87,10 @@ static int ceph_crypt_get_context(struct inode 
>> *inode, void *ctx, size_t len)
>>           return -ERANGE;
>>         memcpy(ctx, cfa->cfa_blob, ctxlen);
>> +
>> +    /* Directory isn't complete anymore */
>> +    if (S_ISDIR(inode->i_mode) && __ceph_dir_is_complete(ci))
>> +        __ceph_dir_clear_complete(ci);
>
> Hi Luis,
>
> Good catch!
>
> BTW, why do this in the ceph_crypt_get_context() ? As my understanding 
> is that we should mark 'mydir' as incomplete when unlocking it. While 
> as I remembered the unlock operation will do:
>
>
> Step1: get_encpolicy via 'mydir' as ctx
> Step2: rm_enckey of ctx from the superblock
>
Sorry, it should be add_enckey.
>
> Since I am still running the test cases for the file lock patches, so 
> I didn't catch logs to confirm the above steps yet.
>
> If I am right IMO then we should mark the dir as incomplete in the 
> Step2 instead, because for non-unlock operations they may also do the 
> Step1.
>
Your patch will work. But probably we should do this just around 
__fscrypt_prepare_readdir() or fscrypt_prepare_readdir() instead ? We 
need to detect that once the 'inode->i_crypt_info' changed then mark the 
dir as incomplete.

For now for the lock operation it will evict the inode, which will help 
do this for us already. But for unlock case, we need to handle it by 
ourself.

Thanks!

- Xiubo


> Thanks!
>
> - Xiubo
>
>>       return ctxlen;
>>   }
>>

