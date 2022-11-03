Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17366174D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKCDUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiKCDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36ED13FB8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667445536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbroNESV1PQ7IaQsCKEABPmwn7Oc2TG7Zrit7suqSrg=;
        b=Dv+d/ql2PirgnXLW17kEzOpiuVTZP5Rc9LgsMQ7DueQKuVdkXYaWhxb+qGNIx4RYNf3ewM
        Cd8SwiJL5kSYpT597l+DE8rWbgqPkaD9DQEFjArWCeYIU1yvnljC4zJQLGsgMPGV70Qx6w
        PBe70DMba6z72l+pQVlkvXcl5IdQ7hI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-dAbm1XmEMEuevM2fiEBGyA-1; Wed, 02 Nov 2022 23:18:55 -0400
X-MC-Unique: dAbm1XmEMEuevM2fiEBGyA-1
Received: by mail-pj1-f70.google.com with SMTP id p4-20020a17090a680400b00213e2b077cbso290415pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbroNESV1PQ7IaQsCKEABPmwn7Oc2TG7Zrit7suqSrg=;
        b=1FKM2t29nsMfeRlP2kIJbF+8qKy8njaRWDgGWG3yq8ha4I92sLLXeRbi9RrQGz92T7
         N1ke4VjQxD6I5kmpyMIp5QGW0EUwLYEkHN5OulgIsANB0cmqztW+cGLvECvmimlIUkzl
         ttY5PW7T2C1Nf5F948q5IVegoVHPGo09htZCkS41lQh1WBz4qpCvD+GmQKqhePP5bN3W
         WBIuHB016Fhlr9jIRfU5PU6bUo8lgXiLPzGvA08gHw/GDE+zN6B9Que9ierGGG2N/R0w
         ayO27wFuA4KOYJnl89YoBa7wLRC2EaRW6n9jnO6txNCN6h8vPNVNvbAKXLI+ZzXmaaRU
         keYw==
X-Gm-Message-State: ACrzQf2zbycsMfN6tTDcYkRFqN7I/6PHAUfic6W98U7ITCDTfUHMtA68
        adzSGwHB/8WfUM7JHvVEOD2R+FBbzFKozxU/1iZtt+8W76HoGkW0O4G9jMKI5zlpv08+OYQgxlT
        rvl23iP24CykTXxSeDrHjSaiUvG/gI0pHaOgrLZsCyBKt8GaNZEZJ1BSj5T5CqAcSfJzva2C/ug
        ==
X-Received: by 2002:a17:90a:578c:b0:213:b509:9474 with SMTP id g12-20020a17090a578c00b00213b5099474mr26301465pji.45.1667445534057;
        Wed, 02 Nov 2022 20:18:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6S03GbdpE+nfumLcVgqIjZIHkemKQ8mMluPstprGpGtqtpDUheObxILn4dKv/oNy4eDsEnLA==
X-Received: by 2002:a17:90a:578c:b0:213:b509:9474 with SMTP id g12-20020a17090a578c00b00213b5099474mr26301425pji.45.1667445533325;
        Wed, 02 Nov 2022 20:18:53 -0700 (PDT)
Received: from [10.72.12.172] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b00186b5c1a715sm9004081pla.182.2022.11.02.20.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 20:18:52 -0700 (PDT)
Subject: Re: [RFC PATCH] ceph: allow encrypting a directory while not having
 Ax caps
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027112653.12122-1-lhenriques@suse.de>
 <a992d844-6d75-e134-60e1-acb8c8972ff3@redhat.com> <Y2JZI1QOl3dXBVUb@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8e1eecb7-1b54-2459-efc9-2f410ad0a904@redhat.com>
Date:   Thu, 3 Nov 2022 11:18:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y2JZI1QOl3dXBVUb@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/11/2022 19:48, Luís Henriques wrote:
> On Mon, Oct 31, 2022 at 05:15:51PM +0800, Xiubo Li wrote:
>> On 27/10/2022 19:26, Luís Henriques wrote:
>>> If a client doesn't have Fx caps on a directory, it will get errors while
>>> trying encrypt it:
>>>
>>> ceph: handle_cap_grant: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len 0 new len 48)
>>> fscrypt (ceph, inode 1099511627812): Error -105 getting encryption context
>>>
>>> A simple way to reproduce this is to use two clients:
>>>
>>>       client1 # mkdir /mnt/mydir
>>>
>>>       client2 # ls /mnt/mydir
>>>
>>>       client1 # fscrypt encrypt /mnt/mydir
>>>       client1 # echo hello > /mnt/mydir/world
>>>
>>> This happens because, in __ceph_setattr(), we only initialize
>>> ci->fscrypt_auth if we have Ax.  If we don't have, we'll need to do that
>>> later, in handle_cap_grant().
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>> Hi!
>>>
>>> To be honest, I'm not really sure about the conditions in the 'if': shall
>>> I bother checking it's really a dir and that it is empty?
>>>
>>> Cheers,
>>> --
>>> Luís
>>>
>>>    fs/ceph/caps.c | 26 +++++++++++++++++++++++---
>>>    1 file changed, 23 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>> index 443fce066d42..e33b5c276cf3 100644
>>> --- a/fs/ceph/caps.c
>>> +++ b/fs/ceph/caps.c
>>> @@ -3511,9 +3511,29 @@ static void handle_cap_grant(struct inode *inode,
>>>    		     from_kuid(&init_user_ns, inode->i_uid),
>>>    		     from_kgid(&init_user_ns, inode->i_gid));
>>>    #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
>>> -		if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
>>> -		    memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
>>> -			   ci->fscrypt_auth_len))
>>> +		if ((ci->fscrypt_auth_len == 0) &&
>>> +		    (extra_info->fscrypt_auth_len > 0) &&
>>> +		    S_ISDIR(inode->i_mode) &&
>>> +		    (ci->i_rsubdirs + ci->i_rfiles == 1)) {
>>> +			/*
>>> +			 * We'll get here when setting up an encrypted directory
>>> +			 * but we don't have Fx in that directory, i.e. other
>>> +			 * clients have accessed this directory too.
>>> +			 */
>>> +			ci->fscrypt_auth = kmemdup(extra_info->fscrypt_auth,
>>> +						   extra_info->fscrypt_auth_len,
>>> +						   GFP_KERNEL);
>>> +			if (ci->fscrypt_auth) {
>>> +				inode->i_flags |= S_ENCRYPTED;
>>> +				ci->fscrypt_auth_len = extra_info->fscrypt_auth_len;
>>> +			} else {
>>> +				pr_err("Failed to alloc memory for %llx.%llx fscrypt_auth\n",
>>> +					ceph_vinop(inode));
>>> +			}
>>> +			dout("ino %llx.%llx is now encrypted\n", ceph_vinop(inode));
>>> +		} else if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
>>> +			   memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
>>> +				  ci->fscrypt_auth_len))
>>>    			pr_warn_ratelimited("%s: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
>>>    				__func__, ci->fscrypt_auth_len, extra_info->fscrypt_auth_len);
>>>    #endif
>> Hi Luis,
>>
>> Thanks for your time on this bug.
>>
>> IMO we should fix this in ceph_fill_inode():
>>
>>   995 #ifdef CONFIG_FS_ENCRYPTION
>>   996         if (iinfo->fscrypt_auth_len && (inode->i_state & I_NEW)) {
>>   997                 kfree(ci->fscrypt_auth);
>>   998                 ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
>>   999                 ci->fscrypt_auth = iinfo->fscrypt_auth;
>> 1000                 iinfo->fscrypt_auth = NULL;
>> 1001                 iinfo->fscrypt_auth_len = 0;
>> 1002                 inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
>> 1003         }
>> 1004 #endif
>>
>> The setattr will get a reply from MDS including the fscrypt auth info, I
>> think the kclient just drop it here.
> I've done some testing and I don't really see this code kfree'ing a valid
> fscrypt_auth here.  However, I guess it is possible to fix this issue here
> too, but in a different way, by changing that 'if' condition to:
>
> 	if (iinfo->fscrypt_auth_len &&
> 	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
> 	...
> 	}
>
> I'm not really sure if this is sane though.  When we loose the 'Ax' caps
> (another client as accessed the directory we're encrypting), we also seem
> to loose the I_NEW state.  Using the above code seems to work for the
> testcase in my patch, but I'm not sure it won't break something else.

It should be okay IMO.

The I_NEW is for new created directories, such as for mkdir request,etc. 
But currently the code didn't consider the setattr case.

Please send you patch let's check and discuss there.

Thanks!

- Xiubo

> Cheers,
> --
> Luís
>
>> If we fix it in handle_cap_grant() I am afraid this bug still exists. What
>> if there is no any new caps will be issued or revoked recently and then
>> access to the directory ?
>>
>> Thanks
>>
>> - Xiubo
>>

