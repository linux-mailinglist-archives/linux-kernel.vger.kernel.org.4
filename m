Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41261697581
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjBOEpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBOEpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:45:23 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D195A13DD0;
        Tue, 14 Feb 2023 20:45:22 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id be8so19147676plb.7;
        Tue, 14 Feb 2023 20:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676436322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLFQ+BMfL3mKR+HsukP0Rh0Qg58BDBN0n54srni9OUA=;
        b=ioqMaST+o1JY0hhbT0r25PvsHC/c2MD+hUPIaReHbwZlLx36O3c2IoZAIamMipx8tH
         LNnoUb2X0bRjqhvGKlCsCqxK42idtsC9AGtKtZbNv1gFMgf4SX5sK/3XxWAp1r9QkObI
         gvWeaFOQJ1labKYSWVM6Ax3ae9St6qOrUFStN1D0iEzChwTOqMcZiBcD5Mz9TcoNNprF
         oMIrUBgyFWEodG5oYdscqJgZ680BIckCpX/DnPFUNdEuN+rGKz9fJjULfkHRyxT/QLVY
         9sWCNqE2hB5OLEopJErqm2mnfo0BTJS+YYAV2zw4zbCLIhibMGVm99GZsY2BZyphg2LG
         n5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676436322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLFQ+BMfL3mKR+HsukP0Rh0Qg58BDBN0n54srni9OUA=;
        b=lDegrWHFSLiuijUTe+oIt5b0u/WcC2sWqw4Qg1vditu7oQuBHJgTiL2YLd4UMpfjFK
         MrmNkJ2tSwWVdvsz/AoOG8Rtt7bTDq0IqyFO+pdZJn8pt1GVNoIUv+qJxRRBOPrlYgtJ
         lWi1xJvDXGYudquCk1pI6z6BkGwRB1qmKidakQ/HnpV+lilrPjCfOPTo1IEU3P5DuhP+
         UIKEYdoiXTT7SPcnh7LYDqiOpNnFT2wM9SmnT7zkJvf/M47PKUKUMToxYyRua2lF4sdi
         5mnEb1oi3hwdvc6DEY2PbqHqIKpMiZrXx6iD53w6UvOz/x2cLFEEZVPaYtGy/FUL6+cD
         Z5bQ==
X-Gm-Message-State: AO0yUKXo414R1vKIxSQs52eOnomc7jqOKRUP2aDDL8ZKWiFrhCzdnP1y
        IXbxXw01iuIMAq6/YVIikSM=
X-Google-Smtp-Source: AK7set+za0MGZqB8ZOZ1zzeICVPrsUmWdFvCR9+H+JLVfHMArDOD6QqMC03U3t/tuiy/2fFVS8ouAw==
X-Received: by 2002:a17:903:22c4:b0:195:ea0e:3221 with SMTP id y4-20020a17090322c400b00195ea0e3221mr1397933plg.3.1676436322277;
        Tue, 14 Feb 2023 20:45:22 -0800 (PST)
Received: from [192.168.50.247] ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id iy1-20020a170903130100b0019a9436d2a0sm6096787plb.89.2023.02.14.20.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 20:45:21 -0800 (PST)
Message-ID: <a392c711-e61a-ad7a-bf90-7e3bbb076396@gmail.com>
Date:   Wed, 15 Feb 2023 12:45:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] ksmbd: fix possible memory leak in smb2_lock()
Content-Language: en-US
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, lsahlber@redhat.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230214063650.12832-1-hbh25y@gmail.com>
 <CAKYAXd9ua+wyXK5a7WQW7BfrkQ2wOu_MwBxLePFg-Jte=mdp4w@mail.gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <CAKYAXd9ua+wyXK5a7WQW7BfrkQ2wOu_MwBxLePFg-Jte=mdp4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/2/2023 09:04, Namjae Jeon wrote:
> 2023-02-14 15:36 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
>> argv needs to be free when setup_async_work fails or when the current
>> process is woken up.
>>
>> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>
>> v2: avoid NULL pointer dereference in set_close_state_blocked_works()
>> v3: avoid race condition between smb2_lock() and smb2_cancel()
>> v4: use another way to avoid race condition
>>
>>   fs/ksmbd/smb2pdu.c   | 20 +++++++++++++-------
>>   fs/ksmbd/vfs_cache.c |  2 ++
>>   2 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index d681f91947d9..1b517d3ca2ef 100644
>> --- a/fs/ksmbd/smb2pdu.c
>> +++ b/fs/ksmbd/smb2pdu.c
>> @@ -6666,7 +6666,8 @@ int smb2_cancel(struct ksmbd_work *work)
>>   				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
>>   				    le64_to_cpu(hdr->Id.AsyncId),
>>   				    le16_to_cpu(chdr->Command));
>> -			cancel_work = iter;
>> +			if (iter->cancel_fn)
>> +				cancel_work = iter;
> You have freed ->cancel_argv in smb2_lock().  Wouldn't this cause UAF
> issue the below?
> 
>          if (cancel_work) {
>                  cancel_work->state = KSMBD_WORK_CANCELLED;
>                  if (cancel_work->cancel_fn)
>                          cancel_work->cancel_fn(cancel_work->cancel_argv);
>          }
I think this can't cause UAF beacause cancel_fn will be set to NULL 
before releasing argv in smb2_lock(). There is no way to use a argv.

>>   			break;
>>   		}
>>   		spin_unlock(&conn->request_lock);
>> @@ -7050,6 +7051,7 @@ int smb2_lock(struct ksmbd_work *work)
>>   						      smb2_remove_blocked_lock,
>>   						      argv);
>>   				if (rc) {
>> +					kfree(argv);
>>   					err = -ENOMEM;
>>   					goto out;
>>   				}
>> @@ -7061,6 +7063,16 @@ int smb2_lock(struct ksmbd_work *work)
>>
>>   				ksmbd_vfs_posix_lock_wait(flock);
>>
>> +				spin_lock(&work->conn->request_lock);
>> +				spin_lock(&fp->f_lock);
>> +				if (work->state != KSMBD_WORK_CLOSED) {
> I think that this check is not needed if we don't delete entry in
> set_close_state_blocked_works().
>> +					list_del(&work->fp_entry);
>> +					work->cancel_fn = NULL;
>> +					kfree(argv);
>> +				}
>> +				spin_unlock(&fp->f_lock);
>> +				spin_unlock(&work->conn->request_lock);
>> +
>>   				if (work->state != KSMBD_WORK_ACTIVE) {
>>   					list_del(&smb_lock->llist);
>>   					spin_lock(&work->conn->llist_lock);
>> @@ -7069,9 +7081,6 @@ int smb2_lock(struct ksmbd_work *work)
>>   					locks_free_lock(flock);
>>
>>   					if (work->state == KSMBD_WORK_CANCELLED) {
>> -						spin_lock(&fp->f_lock);
>> -						list_del(&work->fp_entry);
>> -						spin_unlock(&fp->f_lock);
>>   						rsp->hdr.Status =
>>   							STATUS_CANCELLED;
>>   						kfree(smb_lock);
>> @@ -7093,9 +7102,6 @@ int smb2_lock(struct ksmbd_work *work)
>>   				list_del(&smb_lock->clist);
>>   				spin_unlock(&work->conn->llist_lock);
>>
>> -				spin_lock(&fp->f_lock);
>> -				list_del(&work->fp_entry);
>> -				spin_unlock(&fp->f_lock);
>>   				goto retry;
>>   			} else if (!rc) {
>>   				spin_lock(&work->conn->llist_lock);
>> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
>> index da9163b00350..761a8aa540ce 100644
>> --- a/fs/ksmbd/vfs_cache.c
>> +++ b/fs/ksmbd/vfs_cache.c
>> @@ -372,6 +372,8 @@ static void set_close_state_blocked_works(struct
>> ksmbd_file *fp)
>>   		list_del(&cancel_work->fp_entry);
>>   		cancel_work->state = KSMBD_WORK_CLOSED;
>>   		cancel_work->cancel_fn(cancel_work->cancel_argv);
>> +		cancel_work->cancel_fn = NULL;
>> +		kfree(cancel_work->cancel_argv);
> If we remove list_del, we don't need to do them here ? and we can
> change _safe version to list_for_each().

Agreed. I will move this list_del() to smb2_lock() in v5.

Thanks,
Hangyu

>>   	}
>>   	spin_unlock(&fp->f_lock);
>>   }
>> --
>> 2.34.1
>>
>>
