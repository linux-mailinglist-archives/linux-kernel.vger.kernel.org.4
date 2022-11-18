Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E799762ED2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiKRFZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiKRFZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53924080
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668749066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAIhV3a/FP0PhSf9vR1ynZP39PzL62iR7XzPvBt4ymc=;
        b=X9n2Gt2K7gWDQGpK7vPMx7GlI1H9nw6OFh5ca8EdDYquyh4XXbz2XB92x4k6CK1qpvCN/k
        SLb8r0o0ZgYE/7YJQXz1dq8ArMjHt2DZiLG+NO3VCq5gwBHI1dBmidbqV6rejkygR08RzB
        9Wn0oNvXZz7jXcZlihwiDC4HN39tJow=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-GIrZV2vINtWd5aB078jA_g-1; Fri, 18 Nov 2022 00:24:24 -0500
X-MC-Unique: GIrZV2vINtWd5aB078jA_g-1
Received: by mail-pl1-f200.google.com with SMTP id i8-20020a170902c94800b0018712ccd6bbso3023448pla.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAIhV3a/FP0PhSf9vR1ynZP39PzL62iR7XzPvBt4ymc=;
        b=uDGr2029sD9PlVROBcfq7ffpb2nno1FY78hN/L9WNzA49tKDjk2KKPFYGBFwx772Pj
         XtnsnuJJXo7cuKm/B+fdNJf7yNPRYYHrYmuksaSlczB8d/4i4Fw8FuE8vsGneg/cczjL
         ynY5ubPHu+2bWOedrHUliZIjvB3F9iEwg2rYnd5psWWywZkJ5UYaF1usThIESZtGqQDo
         a+x4fmgpU4rrKE+BRGIQHmSCqu1xKzJZtsfrdCr5Bocvig19krYFkCPWJAgcztdhhI/K
         5nfihCZGFx9sXfTW3xOYkpwoDzfa1Yh1MwiM+DqohMU04HueoB2Eb32idhI6XWZUps/o
         0grA==
X-Gm-Message-State: ANoB5pn2P84+DboN6R4nDtuUcerBGO9T7qAcoJ2rBMcpo8dlLGvFv7AR
        j97rwB04+wrGk51iIf9Ng8X3fWX7f/tNj2uiNsEr8M60xn6llJu0/QBVu5KokJ6w/uucpViphpn
        RcF2HnsAx6g7uNxYh0yVDW9jct5A5U/3XZ+C6uHRbUNzv7rwH0GHZPxxHWXYYJIQPpfCSYReIDg
        ==
X-Received: by 2002:a17:902:db01:b0:187:3921:2b2d with SMTP id m1-20020a170902db0100b0018739212b2dmr6241903plx.13.1668749063559;
        Thu, 17 Nov 2022 21:24:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4dGNqsHk8dTiRMA6TS0oVRYyAe8B7JvXNSMBhO5UW647Er7WWR7fJ3ZYkNvIAjg+IwAVgpKw==
X-Received: by 2002:a17:902:db01:b0:187:3921:2b2d with SMTP id m1-20020a170902db0100b0018739212b2dmr6241885plx.13.1668749063170;
        Thu, 17 Nov 2022 21:24:23 -0800 (PST)
Received: from [10.72.12.148] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b0056c058ab000sm2117105pfo.155.2022.11.17.21.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 21:24:22 -0800 (PST)
Subject: Re: [PATCH] ceph: make sure directories aren't complete after setting
 crypt context
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116153703.27292-1-lhenriques@suse.de>
 <5de0ae69-5e3d-2ccb-64a3-971db66477f8@redhat.com>
 <41710b3d-b37f-8c65-d55d-c4137a366efd@redhat.com> <87o7t5mpby.fsf@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <116d12db-5c24-9a57-79a9-b7a02a0bb4c2@redhat.com>
Date:   Fri, 18 Nov 2022 13:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87o7t5mpby.fsf@suse.de>
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


On 18/11/2022 02:02, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 17/11/2022 16:03, Xiubo Li wrote:
>>> On 16/11/2022 23:37, Luís Henriques wrote:
>>>> When setting a directory's crypt context, __ceph_dir_clear_complete() needs
>>>> to be used otherwise, if it was complete before, any old dentry that's still
>>>> around will be valid.
>>>>
>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>> ---
>>>> Hi!
>>>>
>>>> Here's a simple way to trigger the bug this patch is fixing:
>>>>
>>>> # cd /cephfs
>>>> # ls mydir
>>>> nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>>>> # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>>>> Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8
>>>> u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
>>>> # fscrypt unlock mydir
>>>> # touch /mnt/test/mydir/mysubdir/file
>>>> touch: cannot touch '/mnt/test/mydir/mysubdir/file': No such file or
>>>> directory
>>>>
>>>>    fs/ceph/crypto.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>>>> index 35a2ccfe6899..dc1557967032 100644
>>>> --- a/fs/ceph/crypto.c
>>>> +++ b/fs/ceph/crypto.c
>>>> @@ -87,6 +87,10 @@ static int ceph_crypt_get_context(struct inode *inode,
>>>> void *ctx, size_t len)
>>>>            return -ERANGE;
>>>>          memcpy(ctx, cfa->cfa_blob, ctxlen);
>>>> +
>>>> +    /* Directory isn't complete anymore */
>>>> +    if (S_ISDIR(inode->i_mode) && __ceph_dir_is_complete(ci))
>>>> +        __ceph_dir_clear_complete(ci);
>>> Hi Luis,
>>>
>>> Good catch!
>>>
>>> BTW, why do this in the ceph_crypt_get_context() ? As my understanding is that
>>> we should mark 'mydir' as incomplete when unlocking it. While as I remembered
>>> the unlock operation will do:
>>>
>>>
>>> Step1: get_encpolicy via 'mydir' as ctx
>>> Step2: rm_enckey of ctx from the superblock
>>>
>> Sorry, it should be add_enckey.
>>> Since I am still running the test cases for the file lock patches, so I didn't
>>> catch logs to confirm the above steps yet.
>>>
>>> If I am right IMO then we should mark the dir as incomplete in the Step2
>>> instead, because for non-unlock operations they may also do the Step1.
>>>
>> Your patch will work. But probably we should do this just around
>> __fscrypt_prepare_readdir() or fscrypt_prepare_readdir() instead ? We need to
>> detect that once the 'inode->i_crypt_info' changed then mark the dir as
>> incomplete.
>>
>> For now for the lock operation it will evict the inode, which will help do this
>> for us already. But for unlock case, we need to handle it by ourself.
> OK, that makes sense and to be honest I thought that there should be
> another place for doing this. Unfortunately, I didn't found it: in the
> test case I have the fscrypt_prepare_readdir() isn't called:
>
>     # cd /cephfs
>     # ls mydir
>     nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>     # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>     Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8 u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
>
> At this point readdir was executed, of course.  And
> __ceph_dir_set_complete() is also used to indicate that we have the full
> contents.  However, executing the following commands won't result in any
> new readdir():
>
>     # fscrypt unlock mydir
>     # touch /mnt/test/mydir/mysubdir/file
>
> and since the encryption key is set at the sb level, I couldn't find a way
> to detect changes in inode->i_crypt_info.  ceph_d_revalidate() is invoked
> but at that point I don't thing we have a way to know what is changing.
>
> Any ideas?

# ls mydir/
zy94Zt01M90xwYq+nxJsEvea+HYq49mqVgrUBkYrJAU
# ls mydir/zy94Zt01M90xwYq+nxJsEvea+HYq49mqVgrUBkYrJAU/
24iNa8ICYc6nZZIkL,4n1sOtp9KiaTGtpq8PCZDQ6LU 
ivG4rQYzg6YENagbTZaV2kh2sVouEdlkmBZPfgVDl48

I have added the debug logs in all the places just like:

@@ -784,7 +786,9 @@ static struct dentry *ceph_lookup(struct inode *dir, 
struct dentry *dentry,
                 return ERR_PTR(-ENAMETOOLONG);

         if (IS_ENCRYPTED(dir)) {
+       printk("%s fscrypt_has_encryption_key(dir): %d ======\n", 
__func__, fscrypt_has_encryption_key(dir));
                 err = __fscrypt_prepare_readdir(dir);
+       printk("%s fscrypt_has_encryption_key(dir): %d ======\n", 
__func__, fscrypt_has_encryption_key(dir));
                 if (err)
                         return ERR_PTR(err);
                 if (!fscrypt_has_encryption_key(dir)) {


# fscrypt unlock mydir
Enter custom passphrase for protector "l":
"mydir" is now unlocked and ready for use.

And after "mydir/" was unlocked and then when doing:

# touch mydir/dir/file2

And when lookup the "dir/" dentry I can see the "mydir/" encryption key 
changed:

709 <7>[79125.023676] ceph:  __ceph_caps_issued_mask ino 0x10000000004 
cap 000000004dc11892 issued pAsLsXsFs (mask As)
710 <7>[79125.023687] ceph:  __touch_cap 000000007071b095 cap 
000000004dc11892 mds0
711 <7>[79125.023823] ceph:  lookup 000000007071b095 dentry 
00000000f97501b2 'dir'
712 <4>[79125.023838] ceph_lookup fscrypt_has_encryption_key(dir): 0 ======
713 <4>[79125.024186] ceph_lookup fscrypt_has_encryption_key(dir): 1 ======
714 <7>[79125.024194] ceph:   dir 000000007071b095 flags are 0x0
715 <7>[79125.024269] ceph:  do_request on 00000000a93fafef

I am thinking could we just make __fscrypt_prepare_readdir(), which will 
return 0 when the key is already set or successfully set, to return 1 
instead of 0 to mark that the key changed ?

Thanks!

- Xiubo

>
> Cheers,

