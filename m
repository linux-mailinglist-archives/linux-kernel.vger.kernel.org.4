Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCC5F34D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJCRs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJCRst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:48:49 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12E25E82
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:48:35 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id de14so7214566qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0C6yn+Jn2hn9bHpTYIQGfMQvGSUJwmSgN1JbJ6wT+Qw=;
        b=UxquGlCPU0Lxr38j5xuVAab5bB4JR6CVnYGjR9TJU5chw7InxO/KyV1T0YpRhUJTtR
         Tyy3DPu5BGyAcxVWu15wE62nScZBCd01Lf1ycu+7fEc7wt6uJimMG3poD5hyOCoun8LO
         q1fvJgEDFwQG/5GNmnw1FmaM6to2K3RlolaOswgn72w2g+5GbVBeOnAW+2jmG/o/7rUQ
         1F9FYpK6iR7JNBjC9xiOHaVqlL4U7rxCOlz1iAzLZ0GLmnXtertHWZ/Q78d6Kb8yoFM/
         l0AQym463rcezixaDAHMg9nvDvYuhjPR+g+hqQnJbUejeNmSERcTx00mQZoCCjSE9yWF
         Aw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0C6yn+Jn2hn9bHpTYIQGfMQvGSUJwmSgN1JbJ6wT+Qw=;
        b=hwsQnZURlKLsdkRsjJ9So79rlcvQg9NSv/vcDlWG01EQDGpUgyV7BJ1h78Elr4pmwx
         QgLRqql+dk2tdUe/p9n68nv5UePEYHG9090cLJRYWcjRei1lKv5x7ZTvmp00iFA6VmgI
         fdIBpqOcq0ng7j20PGIGIQfzKe36+FSSp3B005nvDbfIh2WTzU47s/tf2pLIeWs/E92N
         6xbZ621oTM++fAP+i/q9uzdbE6qmuBJH2R2yerfgZGWet44E2/7HiOXHIromDbNHCczx
         Witwzzw224PqhqBEm5XBej2ghyxt6qPTabsG2ld2Dx7GUI7xCkmwSMJLgREUyr4JTr1g
         I/eQ==
X-Gm-Message-State: ACrzQf0uzKJ8iGvB5F89Q1kwMRfEsPhLfGn+oBWDHqwUd5CCQ3pueHaF
        Je2SkMiaW1sYK19i2Tmqp9Y=
X-Google-Smtp-Source: AMsMyM4CoyRnuDtKUgrn9x6v7MJeGrWrZeDtxB0bZfhjyJC5KBwnJKsttLVcbw67Oke1SPssDx7Omg==
X-Received: by 2002:ad4:5f48:0:b0:4af:b266:3bbd with SMTP id p8-20020ad45f48000000b004afb2663bbdmr16065477qvg.0.1664819314688;
        Mon, 03 Oct 2022 10:48:34 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b1-20020ac87541000000b0035bb6c3811asm9895482qtr.53.2022.10.03.10.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 10:48:34 -0700 (PDT)
Message-ID: <8aeea62b-c947-6414-bca1-3bd3f427cd56@gmail.com>
Date:   Mon, 3 Oct 2022 10:48:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To:     duoming@zju.edu.cn
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
 <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
 <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2022 7:56 PM, James Smart wrote:
> On 10/2/2022 6:50 PM, duoming@zju.edu.cn wrote:
>> Hello,
>>
>> On Sun, 2 Oct 2022 10:12:15 -0700 James Smart wrote:
>>
>>> On 10/1/2022 5:19 PM, Duoming Zhou wrote:
>>>> The function lpfc_poll_timeout() is a timer handler that runs in an
>>>> atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
>>>> As a result, the sleep-in-atomic-context bug will happen. The processes
>>>> is shown below:
>>>>
>>>> lpfc_poll_timeout()
>>>>    lpfc_sli_handle_fast_ring_event()
>>>>     lpfc_sli_process_unsol_iocb()
>>>>      lpfc_complete_unsol_iocb()
>>>>       lpfc_nvme_unsol_ls_handler()
>>>>        lpfc_nvme_handle_lsreq()
>>>>         nvme_fc_rcv_ls_req()
>>>>          kzalloc(sizeof(.., GFP_KERNEL) //may sleep
>>>>
>>>> This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
>>>> GFP_ATOMIC in order to mitigate the bug.
>>>>
>>>> Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
>>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>>> ---
>>>>    drivers/nvme/host/fc.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>>>> index 127abaf9ba5..36698dfc8b3 100644
>>>> --- a/drivers/nvme/host/fc.c
>>>> +++ b/drivers/nvme/host/fc.c
>>>> @@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port 
>>>> *portptr,
>>>>        lsop = kzalloc(sizeof(*lsop) +
>>>>                sizeof(union nvmefc_ls_requests) +
>>>>                sizeof(union nvmefc_ls_responses),
>>>> -            GFP_KERNEL);
>>>> +            GFP_ATOMIC);
>>>>        if (!lsop) {
>>>>            dev_info(lport->dev,
>>>>                "RCV %s LS failed: No memory\n",
>>>
>>> I would prefer this was fixed within lpfc rather than introducing atomic
>>> allocations (1st in either host or target transport).  It was introduced
>>> by lpfc change in irq handling style.
>>
>> Thank your for your reply and suggestions!
>>
>> Do you think change the lpfc_poll_timeout() to a delayed_work is better?
>>
>> Best regards,
>> Duoming Zhou
> 
> as a minimum: the lpfc_complete_unsol_iocb handler should be passing off 
> the iocb to a work queue routine - so that the context changes so that 
> either nvme host or nvmet ls callback routines can be called. If 
> possible, it should do the axchg alloc - to avoid a GFP_ATOMIC there as 
> well...
> 
> It's usually best for these nvme LS's and ELS's to be done in a slow 
> path thread/work queue element. That may mean segmenting a little 
> earlier in the path.
> 
> -- james
> 

looking further...   lpfc_poll_timeout() should only be used on an SLI-3 
adapter.  The existing SLI-3 adapters don't support NVMe. So I'm a 
little confused by this stack trace.

Can you describe what the system config/software setup is and 
specifically what lpfc adapter is being used (dmesg attachment logs are 
sufficient, or lspci output).

-- james

