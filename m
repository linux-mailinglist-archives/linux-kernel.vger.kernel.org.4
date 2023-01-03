Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5565C29A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjACO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjACO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:59:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8F10B7F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:59:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m4so32836232pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTBfmrYG9jhoVs3A20y3gwKZc2IDTaZ51aMbYCgXcPs=;
        b=4ooxSF9ZPagmYIapZW43b+tnZ7PJBkgPp6nDfz+lh3sMvvTNa366vXthSy7tFHQuIA
         U79YcfWWjZOKaCMb5nwv4iE5EFekotKyWtaMg/K7/LOArZwpyzJ3/Wotx6HtomY9ejd6
         FUplyrTY+ZEaAJsncQRqfWm9WYSdLYSPF+Md02MZn865AEUtmPtZzylnfL5elRF5FbNS
         z/T3TejXLMv8UZJuGrzVOC1SbRxo/zjZaBornrFQ9is0ivpUqO50PuIRf7Gq1ZwmIGrF
         fzqt1MJQ7lKSbggMFFtUfAyBOfVLiFc6MvTMyXWH2FAUGeH+jvKUzzWCQYOpcVLF2WgK
         3pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTBfmrYG9jhoVs3A20y3gwKZc2IDTaZ51aMbYCgXcPs=;
        b=uAOLhAp+b+rd4gH96hqOkAmNMrDXbiEmyF5wQu3A/d7Z6mT7eAjwpq/6IEwTLU6Sqw
         lNul3VVc37K4YMJ12ouwLiwf4qhYCvAOe3XhrceFBx+C0ZTWF6do/8DbBCpkt3UWghWL
         XwfbCPvblKj1EJM0PX53jAHBBDE7j0ktdBvziLe35fzaJNVvaxy4MXgZnZ06ydgquxV6
         F/ERKHqTFmYG1NIenA1s6qEHEoBuM8mV3p4XxqLcWYoWDb94GLfr4DS8mczMBqinOxx6
         9dxCKMKU2h4aOpaF8gtGx1hEcBJF3+xDZzt50u4K3vI4yuuzn0RKLM00ynj+qCt69se2
         pX9A==
X-Gm-Message-State: AFqh2kpNmZLGyxrUn23W1FyZXz4kaC8DEVuFFXJckAUuI/ZhpBOPtu7/
        NMPGixHIhUzzCr+ie4sEmjw/Lg==
X-Google-Smtp-Source: AMrXdXvDqvwtG3OlA+SjqWzjo8NrL7Vi3cA/SaZBzH05dRNJQuqQqgPmZmuSaRkpy/3tceygbb4XiA==
X-Received: by 2002:a17:902:b611:b0:189:f277:3834 with SMTP id b17-20020a170902b61100b00189f2773834mr10105958pls.6.1672757949188;
        Tue, 03 Jan 2023 06:59:09 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902d48e00b00192d9258512sm2153217plg.154.2023.01.03.06.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:59:08 -0800 (PST)
Message-ID: <1ecb9b0c-1103-650a-e32a-93110466b2ae@kernel.dk>
Date:   Tue, 3 Jan 2023 07:59:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug-report] possible performance problem in ret_to_user_from_irq
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Hui Tang <tanghui20@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <7ecb8f3c-2aeb-a905-0d4a-aa768b9649b5@huawei.com>
 <Y7P+MjPNA6Tg8JBr@shell.armlinux.org.uk>
 <50a5ebdb-4107-26cc-a2f6-da551d99ff38@kernel.dk>
 <Y7Q88aBpxfWRqzTe@shell.armlinux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y7Q88aBpxfWRqzTe@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 7:34?AM, Russell King (Oracle) wrote:
> On Tue, Jan 03, 2023 at 07:25:26AM -0700, Jens Axboe wrote:
>> On 1/3/23 3:06?AM, Russell King (Oracle) wrote:
>>> On Mon, Dec 26, 2022 at 04:45:20PM +0800, Hui Tang wrote:
>>>> hi folks.
>>>>
>>>> I found a performance problem which is introduced by commit
>>>> 32d59773da38 ("arm: add support for TIF_NOTIFY_SIGNAL").
>>>> After the commit,  any bit in the range of 0..15 will cause
>>>> do_work_pending() to be invoked. More frequent do_work_pending()
>>>> invoked possible result in worse performance.
>>>>
>>>> Some of the tests I've done? as follows:
>>>> lmbench test			base		with patch
>>>> ./lat_ctx -P 1 -s 0  2		7.3167		11.04
>>>> ./lat_ctx -P 1 -s 16 2          8.0467		14.5367
>>>> ./lat_ctx -P 1 -s 64 2		7.8667		11.43
>>>> ./lat_ctx -P 1 -s 16 16		16.47		18.3667
>>>> ./lat_pipe -P 1			28.1671		44.7904
>>>>
>>>> libMicro-0.4.1 test		base		with patch
>>>> ./cascade_cond -E -C 200\
>>>>  -L -S -W -N "c_cond_1" -I 100	286.3333	358
>>>>
>>>> When I adjust test bit, the performance problem gone.
>>>> -	movs	r1, r1, lsl #16
>>>> +	ldr	r2, =#_TIF_WORK_MASK
>>>> +	tst	r1, r2
>>>>
>>>> Does anyone have a good suggestion for this problem?
>>>> should just test _TIF_WORK_MASK, as before?
>>>
>>> I think it should be fine - but I would suggest re-organising the
>>> TIF definitions so that those TIF bits that shouldn't trigger
>>> do_work_pending are not in the first 16 bits.
>>>
>>> Note that all four bits in _TIF_SYSCALL_WORK need to stay within
>>> an 8-bit even-bit-aligned range, so the value is suitable for an
>>> immediate assembly constant.
>>>
>>> I'd suggest moving the TIF definitions for 20 to 19, and 4..7 to
>>> 20..23, and then 8 to 4.
>>
>> Like this?
>>
>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>> index aecc403b2880..7f092cb55a41 100644
>> --- a/arch/arm/include/asm/thread_info.h
>> +++ b/arch/arm/include/asm/thread_info.h
>> @@ -128,15 +128,16 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>  #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
>>  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
>>  #define TIF_UPROBE		3	/* breakpointed or singlestepping */
>> -#define TIF_SYSCALL_TRACE	4	/* syscall trace active */
>> -#define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
>> -#define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
>> -#define TIF_SECCOMP		7	/* seccomp syscall filtering active */
>> -#define TIF_NOTIFY_SIGNAL	8	/* signal notifications exist */
>> +#define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
>>  
>>  #define TIF_USING_IWMMXT	17
>>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>> -#define TIF_RESTORE_SIGMASK	20
>> +#define TIF_RESTORE_SIGMASK	19
>> +#define TIF_SYSCALL_TRACE	20	/* syscall trace active */
>> +#define TIF_SYSCALL_AUDIT	21	/* syscall auditing active */
>> +#define TIF_SYSCALL_TRACEPOINT	22	/* syscall tracepoint instrumentation */
>> +#define TIF_SECCOMP		23	/* seccomp syscall filtering active */
>> +
>>  
>>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> 
> Yep, LGTM, thanks.

Hui Tang, can you give it a whirl? Just checked and it applies to
5.10-stable as well, just with a slight offset.

-- 
Jens Axboe

