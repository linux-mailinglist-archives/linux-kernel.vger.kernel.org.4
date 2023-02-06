Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF868B428
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBFCdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:33:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257216AD9;
        Sun,  5 Feb 2023 18:33:05 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id e19so2773584plc.9;
        Sun, 05 Feb 2023 18:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLlYa+GY6p2HIEeWKAi8SvVyNlV/SUbfloewX/OmyJs=;
        b=VfC009St7OfQ4lCrhbWHmI6i+rIOCnKy10pmF4gobnjj1AtadqZngu5JG+sV+cfwdP
         96WHFVUrlpLJXjF/TDta/afzugu/zqRZB9/GKXXBmGDmZunh26wZfHwbzr0EJAcaXLa4
         wFtx4MMCxYmAP6ysECT0Sz77P7QT0/DfD7PNt+PpzQdfWwnOHk8eDE8a09pB/gBZyh+q
         6y13TjkCkMrhib5ENAAKopsko1lAnXrMbOpwktG+D5z3SyuKhxkvKwDFSe6VuRRlh/Wm
         oXYQ7RUJBCZiQAOj+TPql0cCqSTuS931SEaeIt5JxQGnPYrAL/IN7AsFtgLS308oRqGP
         VDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLlYa+GY6p2HIEeWKAi8SvVyNlV/SUbfloewX/OmyJs=;
        b=h1aPQpRAT6UEyySIkbeUH5S2U/Bpr0tklmyTIKoTXi724V/Fp8va8mBm6DyzSBHipt
         rTzC1B8rbgitSTLTjw+v0lOiKbVsRzZg9teEwArPXFb1JQE7l+DeFPFexVMtB493KXZx
         GeegnoOxTagxR0TpVOVZT6OWQJZ/ZucER9Epp5WVRFeO5oUsI7mZWdUPahp80xggahBY
         bbSldudUjIMPZpRqdlqfJsozaGsrB4Ff7jCRnRLjJFvZjtMyUgpWn1CUDVEGnp4sbFaN
         QHGpri011l8r0AaKcLrzizp0DA+L2qoU2IFJ/Tuiv3myRx2Ci3d2kjq50a1TsoYgQqrA
         ECvQ==
X-Gm-Message-State: AO0yUKXCphDUjtMRoRGdHSAL4a4LsE9LObeVPTU2eLiwvtXbtx45z5t2
        MoAtLo8yDSLtJdJrLyCHois=
X-Google-Smtp-Source: AK7set+yBu5B6sDhZBEAZQLaC0DtB/iDSiOlJv0SGfFt24nSnhoAG+9VkM8SVpTpkiDgXhUfaWtCyA==
X-Received: by 2002:a17:903:187:b0:189:f460:d24b with SMTP id z7-20020a170903018700b00189f460d24bmr20457867plg.5.1675650784478;
        Sun, 05 Feb 2023 18:33:04 -0800 (PST)
Received: from [192.168.50.247] ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001948af092d0sm5543686plx.152.2023.02.05.18.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 18:33:03 -0800 (PST)
Message-ID: <3558ad88-9846-b3f1-e5f8-3370cda6d185@gmail.com>
Date:   Mon, 6 Feb 2023 10:33:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ksmbd: fix possible memory leak in smb2_lock()
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, lsahlber@redhat.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230201081010.17446-1-hbh25y@gmail.com>
 <CAKYAXd-hZ=7uiaN0khsUKw6wCxVo_kfxyUdy9advVro6hahaFg@mail.gmail.com>
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <CAKYAXd-hZ=7uiaN0khsUKw6wCxVo_kfxyUdy9advVro6hahaFg@mail.gmail.com>
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

On 4/2/2023 18:10, Namjae Jeon wrote:
> 2023-02-01 17:10 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
>> argv needs to be free when setup_async_work fails or when the current
>> process is woken up.
>>
>> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   fs/ksmbd/smb2pdu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index d681f91947d9..5b7668c04f76 100644
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
>> @@ -7061,6 +7062,8 @@ int smb2_lock(struct ksmbd_work *work)
>>
>>   				ksmbd_vfs_posix_lock_wait(flock);
>>
>> +				work->cancel_fn = NULL;
>> +				kfree(argv);
> This change seems to causes a NULL pointer dereference issue in
> set_close_state_blocked_works(). It is right to free it and set NULL
> after removing entry from list.

I get it. I will send a v2.

Thanks,
Hangyu
>>   				if (work->state != KSMBD_WORK_ACTIVE) {
>>   					list_del(&smb_lock->llist);
>>   					spin_lock(&work->conn->llist_lock);
>> --
>> 2.34.1
>>
>>
