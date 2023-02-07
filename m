Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6629468CE1C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBGEXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBGEXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:23:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D513DF5;
        Mon,  6 Feb 2023 20:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53EA0611B7;
        Tue,  7 Feb 2023 04:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A445AC4339C;
        Tue,  7 Feb 2023 04:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675743779;
        bh=xxQg38rROAfC5O23oa9Y3z8r4vHX+C1FOW0RIXGTNTk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=p23QkRHox9OXn4+YaT62Qu2l51dO/IFJVA9yNNi1GivIvVEvTUuW4F7lcM+ePHPfg
         G7wEUVbY4QmfRfYTN9/lFzSrVkKYXcGtoIA96vWZUUfrCi5WjF54AsrtRKCNx9ExRG
         OSq8cBHv0MIvLmc4t/3fRVSsWJICZ34NZWq8ah2hRxDFj/fqb7VJnVApA/j5/KkbX7
         YLwJanBmxQRlEpnr3Fxm+h+w5j3F4adFjT6dSTd8soe4ura3L6SQDWE2pA5aFteuzH
         mJG2sXDrmW2JKb1aIjnfsflNSY1xuEuxEne9I8IYni7lBuJd7I1G7N4s0lAbCcP7Aq
         DbMR5NI89R2Wg==
Received: by mail-oi1-f179.google.com with SMTP id r28so11641056oiw.3;
        Mon, 06 Feb 2023 20:22:59 -0800 (PST)
X-Gm-Message-State: AO0yUKUBLQfqbEKK04li5UK+Uc2HfhTGmUKD27jls/oKwyhcV+iyuCNk
        JxoYzW/hTpF44TMJcun3JOmG1RxadXoCh0gCslc=
X-Google-Smtp-Source: AK7set9f66Fie71+mQmgHGduzAtNZO1B0DVIPmRIjbYC6IS0ZkH98BFP5DK9i5vzG+Yli7VbKOMbmrUggsAGwcDRLBI=
X-Received: by 2002:aca:6547:0:b0:363:a539:4f with SMTP id j7-20020aca6547000000b00363a539004fmr1541006oiw.189.1675743778800;
 Mon, 06 Feb 2023 20:22:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Mon, 6 Feb 2023
 20:22:58 -0800 (PST)
In-Reply-To: <882e6405-1d0a-ac6e-b6a1-941e60ecd222@gmail.com>
References: <20230206023630.9457-1-hbh25y@gmail.com> <CAKYAXd9c1Cm=3vbqTO6V=mwfu=YUEwEiGYZFc0mBfeSuH4phyQ@mail.gmail.com>
 <882e6405-1d0a-ac6e-b6a1-941e60ecd222@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 7 Feb 2023 13:22:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_qvYB1a3=4fn6VzRZGdR_ie7RfqvvtB8cYH0+GWF94Sg@mail.gmail.com>
Message-ID: <CAKYAXd_qvYB1a3=4fn6VzRZGdR_ie7RfqvvtB8cYH0+GWF94Sg@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: fix possible memory leak in smb2_lock()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        lsahlber@redhat.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-02-07 12:22 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
> On 7/2/2023 07:44, Namjae Jeon wrote:
>> 2023-02-06 11:36 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
>>> argv needs to be free when setup_async_work fails or when the current
>>> process is woken up.
>>>
>>> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>> ---
>>>
>>> v2: avoid NULL pointer dereference in set_close_state_blocked_works()
>>>
>>>   fs/ksmbd/smb2pdu.c   | 5 +++++
>>>   fs/ksmbd/vfs_cache.c | 2 ++
>>>   2 files changed, 7 insertions(+)
>>>
>>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>>> index d681f91947d9..177a24704021 100644
>>> --- a/fs/ksmbd/smb2pdu.c
>>> +++ b/fs/ksmbd/smb2pdu.c
>>> @@ -7050,6 +7050,7 @@ int smb2_lock(struct ksmbd_work *work)
>>>   						      smb2_remove_blocked_lock,
>>>   						      argv);
>>>   				if (rc) {
>>> +					kfree(argv);
>>>   					err = -ENOMEM;
>>>   					goto out;
>>>   				}
>>> @@ -7072,6 +7073,8 @@ int smb2_lock(struct ksmbd_work *work)
>>>   						spin_lock(&fp->f_lock);
>>>   						list_del(&work->fp_entry);
>>>   						spin_unlock(&fp->f_lock);
>>> +						kfree(argv);
>>> +						work->cancel_fn = NULL;
>>>   						rsp->hdr.Status =
>>>   							STATUS_CANCELLED;
>>>   						kfree(smb_lock);
>>> @@ -7096,6 +7099,8 @@ int smb2_lock(struct ksmbd_work *work)
>>>   				spin_lock(&fp->f_lock);
>>>   				list_del(&work->fp_entry);
>>>   				spin_unlock(&fp->f_lock);
>>> +				kfree(argv);
>>> +				work->cancel_fn = NULL;
>> This doesn't seem so simple... You have to consider the racy issue
>> between this change and smb2_cancel(). Also, how are you testing this
>> patch?
>>
>
> Do you means a race condition between smb2_lock() and smb2_cancel()?
> This look like another bug. This problem exists even if this patch does
> not exist. If state becomes KSMBD_WORK_CANCELLED we shouldn't go retry.
>
> But you are right. This patch will cause UAF in race condition. I think
> setting cancel_fn to NULL before releasing argv can fix this UAF.
I don't know until I see your updated patch. It may be protected by lock.
> After
> this memory leak is solved we should use another patch to fix the race
> condition. What do you think?
It doesn't matter whether it's a single patch or a multi-patches, as
long as this patch doesn't cause racy issue...

Thanks.
>
> Thanks,
> Hangyu
>
>>>   				goto retry;
>>>   			} else if (!rc) {
>>>   				spin_lock(&work->conn->llist_lock);
>>> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
>>> index da9163b00350..eb95c16393b7 100644
>>> --- a/fs/ksmbd/vfs_cache.c
>>> +++ b/fs/ksmbd/vfs_cache.c
>>> @@ -372,6 +372,8 @@ static void set_close_state_blocked_works(struct
>>> ksmbd_file *fp)
>>>   		list_del(&cancel_work->fp_entry);
>>>   		cancel_work->state = KSMBD_WORK_CLOSED;
>>>   		cancel_work->cancel_fn(cancel_work->cancel_argv);
>>> +		kfree(cancel_work->cancel_argv);
>>> +		cancel_work->cancel_fn = NULL;
>>>   	}
>>>   	spin_unlock(&fp->f_lock);
>>>   }
>>> --
>>> 2.34.1
>>>
>>>
>
