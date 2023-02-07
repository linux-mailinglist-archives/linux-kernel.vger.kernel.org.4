Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCD68CD68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBGDWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBGDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:22:37 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E214DC;
        Mon,  6 Feb 2023 19:22:36 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id h197so292729pfe.12;
        Mon, 06 Feb 2023 19:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRQSsjf/n530aX3V/AMzNC7TQVwpP+pnG/W/Pt6Rvhg=;
        b=idDPfPaOwp6323xGogqrYIKwfcZCgPMstaZrOTNREulAueAxelgmIadLq38LpQk7WA
         rg2qaS2IhI8DW4eRYo4hE+IXPldh7OgS4AYp9siRQiNcKIlpTQFEUFc/0wJvvbgWXH0+
         Kszk3CVxtl0FDGWOh7980e3BQgiri88/CJGKqXSciXDNodgvz9Ozan+h/msXGteXU2hB
         TNk3pGFAnurSX5gOvWkOxXiAK1Wz4cM5vZe7mSFRxHNxZ4K95S55TFkW9t80NMRagSY4
         +cbXGXrQ28sDvDz6PgfXALryQdCDsZxUfrJyU4oF8z2usMMWWdE9vxN6LF2zq/owxf5H
         BBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRQSsjf/n530aX3V/AMzNC7TQVwpP+pnG/W/Pt6Rvhg=;
        b=pTCN00jjmADlBP+FNWqc6wm9B1JkyawGnp/pIUffxnPYVvU0U+aYWrSdb66KILFmTU
         98ciNvyZooFNhX6qiMNnQOfFI242QugOtE5DjeOJOiDQ2wHrky/Xgx80L7zzTqYaYwNm
         Qw7gAJz+H4gMJMSxkk/gq4wqI/2x6yHRztQB2hGufHxQ5wzbYMT3+St5AQmuZrrsbtSB
         LE5UepbLuinJmuL3aZPnAK0kNf6PSIiYcsyR0G6rdErSZwCl2MJrqMATFWOepNefnkT5
         5BXVxhFlIpwqSAu+3c8Ft18fw/asxufMAmDiBTKXWHj6Iv23AOHmy/Po2cJT8kTavVQC
         lZqw==
X-Gm-Message-State: AO0yUKVoUmWpseUHc27ZJq7FauszN3jW+m1R5PpBMBjD1SRqLD87Dplg
        AtU8u57LXUBlQiSkWLRE9/I=
X-Google-Smtp-Source: AK7set87u/1B6j308SCqfgAyV7K+oTPtl7YtlLq/lW5T/NT1YsPPMhFUJmJLS6qs+CkyKVXohTeE+A==
X-Received: by 2002:a62:824d:0:b0:594:3e27:f873 with SMTP id w74-20020a62824d000000b005943e27f873mr1555703pfd.1.1675740155862;
        Mon, 06 Feb 2023 19:22:35 -0800 (PST)
Received: from [192.168.50.247] ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id i3-20020aa78b43000000b0058e1e6a81e8sm1693205pfd.38.2023.02.06.19.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 19:22:35 -0800 (PST)
Message-ID: <882e6405-1d0a-ac6e-b6a1-941e60ecd222@gmail.com>
Date:   Tue, 7 Feb 2023 11:22:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ksmbd: fix possible memory leak in smb2_lock()
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        lsahlber@redhat.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206023630.9457-1-hbh25y@gmail.com>
 <CAKYAXd9c1Cm=3vbqTO6V=mwfu=YUEwEiGYZFc0mBfeSuH4phyQ@mail.gmail.com>
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <CAKYAXd9c1Cm=3vbqTO6V=mwfu=YUEwEiGYZFc0mBfeSuH4phyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/2023 07:44, Namjae Jeon wrote:
> 2023-02-06 11:36 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
>> argv needs to be free when setup_async_work fails or when the current
>> process is woken up.
>>
>> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>
>> v2: avoid NULL pointer dereference in set_close_state_blocked_works()
>>
>>   fs/ksmbd/smb2pdu.c   | 5 +++++
>>   fs/ksmbd/vfs_cache.c | 2 ++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index d681f91947d9..177a24704021 100644
>> --- a/fs/ksmbd/smb2pdu.c
>> +++ b/fs/ksmbd/smb2pdu.c
>> @@ -7050,6 +7050,7 @@ int smb2_lock(struct ksmbd_work *work)
>>   						      smb2_remove_blocked_lock,
>>   						      argv);
>>   				if (rc) {
>> +					kfree(argv);
>>   					err = -ENOMEM;
>>   					goto out;
>>   				}
>> @@ -7072,6 +7073,8 @@ int smb2_lock(struct ksmbd_work *work)
>>   						spin_lock(&fp->f_lock);
>>   						list_del(&work->fp_entry);
>>   						spin_unlock(&fp->f_lock);
>> +						kfree(argv);
>> +						work->cancel_fn = NULL;
>>   						rsp->hdr.Status =
>>   							STATUS_CANCELLED;
>>   						kfree(smb_lock);
>> @@ -7096,6 +7099,8 @@ int smb2_lock(struct ksmbd_work *work)
>>   				spin_lock(&fp->f_lock);
>>   				list_del(&work->fp_entry);
>>   				spin_unlock(&fp->f_lock);
>> +				kfree(argv);
>> +				work->cancel_fn = NULL;
> This doesn't seem so simple... You have to consider the racy issue
> between this change and smb2_cancel(). Also, how are you testing this
> patch?
> 

Do you means a race condition between smb2_lock() and smb2_cancel()? 
This look like another bug. This problem exists even if this patch does 
not exist. If state becomes KSMBD_WORK_CANCELLED we shouldn't go retry.

But you are right. This patch will cause UAF in race condition. I think 
setting cancel_fn to NULL before releasing argv can fix this UAF. After 
this memory leak is solved we should use another patch to fix the race 
condition. What do you think?

Thanks,
Hangyu

>>   				goto retry;
>>   			} else if (!rc) {
>>   				spin_lock(&work->conn->llist_lock);
>> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
>> index da9163b00350..eb95c16393b7 100644
>> --- a/fs/ksmbd/vfs_cache.c
>> +++ b/fs/ksmbd/vfs_cache.c
>> @@ -372,6 +372,8 @@ static void set_close_state_blocked_works(struct
>> ksmbd_file *fp)
>>   		list_del(&cancel_work->fp_entry);
>>   		cancel_work->state = KSMBD_WORK_CLOSED;
>>   		cancel_work->cancel_fn(cancel_work->cancel_argv);
>> +		kfree(cancel_work->cancel_argv);
>> +		cancel_work->cancel_fn = NULL;
>>   	}
>>   	spin_unlock(&fp->f_lock);
>>   }
>> --
>> 2.34.1
>>
>>
