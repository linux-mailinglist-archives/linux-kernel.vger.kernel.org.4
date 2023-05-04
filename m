Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516B06F71B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEDSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:05:02 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A241BCC;
        Thu,  4 May 2023 11:05:01 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64115e652eeso14431594b3a.0;
        Thu, 04 May 2023 11:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683223501; x=1685815501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ndDW36eTz2fNZR0ZWJLQqH5VttvJf9F4pFDzFwOuQQ=;
        b=QxUlpeKpAWrOcXqiMPRsxjRyuMkM/OZXmRIBqkfAtXkYOV8ovtCVCQ7spxtMKG3dIv
         TN6anzOv1CDJWqFV4aeMYbj+iySPyuR/AhyrfwPXrYX3NCvFaedzEcyaY6/mobiEhS6o
         TdVV5QgNCjS/g5VLsUW+vEOM44/vY0DVRb0M+Ss5sJsk7DoNTjCf8d/p4duQv3xljTz6
         UYfdAd/W4tnAEKW1qAkDbXSRttTrErzWPzssvh3mdNG/GiGgA4lTpt6c4aGTIwEIsvn7
         AU9Ufjv/vlDSQUfw/8Y0fS5CZlLI7jvWVevLeh4Swqe7GpBMtmoFmWpMYjZ3tby1QYdz
         ZuoQ==
X-Gm-Message-State: AC+VfDzRlMtdfHDAnHXNGqEXN6qTbeS3OYo5aaD3prJBNXPM6RALQXSb
        GIB4UV2wBOSnumBdyrqd6As=
X-Google-Smtp-Source: ACHHUZ58KH8p6W6BVL9E0BUnKgDpgwJ68lJQZBtDXziRHGwUExYMsoix/tRyd7IdpSv1Na2fQZF9gA==
X-Received: by 2002:a05:6a20:3d19:b0:f0:93d9:9c03 with SMTP id y25-20020a056a203d1900b000f093d99c03mr3746657pzi.15.1683223500955;
        Thu, 04 May 2023 11:05:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2c3b:81e:ce21:2437? ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b0062dd8809d6esm1463809pfo.150.2023.05.04.11.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 11:05:00 -0700 (PDT)
Message-ID: <0bb28ed3-8b4f-77f3-5648-adb42604f37e@acm.org>
Date:   Thu, 4 May 2023 11:04:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 5/5] ufs: core: Add error handling for MCQ mode
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        Powen.Kao@mediatek.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <5a52b255001e994d0a65be9b1d61fe69f2a12f6c.1681764704.git.quic_nguyenb@quicinc.com>
 <c3297d67-ac6f-e8b5-9167-648302319812@acm.org>
 <b35c2e61-6fb1-37d5-886e-0fb67ee0d0a2@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b35c2e61-6fb1-37d5-886e-0fb67ee0d0a2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 21:18, Bao D. Nguyen wrote:
> On 4/25/2023 5:21 PM, Bart Van Assche wrote:
>> On 4/17/23 14:05, Bao D. Nguyen wrote:
>>> +        /* MCQ mode */
>>> +        if (is_mcq_enabled(hba))
>>> +            return ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag);
>>
>> The above code will trigger an overflow if lrbp->task_tag >= 8 * sizeof(unsigned long). That's not acceptable.
> This ufshcd_clear_cmds() uses a bit map. There are multiple places in the UFS code have this limitation if the queue depth grows to be greater than 64. I am thinking:
> 1. Current ufs controllers in the market probably support queue depth 64 or less, so it may not be a problem today if host controller cap is set to 64 queue depth, but can be a problem in multiple places in the code later.
> 2. In mcq mode, we can pass a tag number into this api ufshcd_clear_cmds(); while in SDB mode, pass the tag's bit mask as before.
> 3. Use sbitmask() to support large queue depth? Thanks for any suggestions.

The UFS driver is the only block driver I know that tracks which commands
are pending in a bitmap. Please pass the lrbp pointer or the task_tag directly
to ufshcd_clear_cmds() instead of passing a bitmap to that function. Please
also introduce a loop in ufshcd_eh_device_reset_handler() around the
ufshcd_clear_cmds() call instead of passing a bitmap to ufshcd_clear_cmds().

>>>   static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>>   {
>>> +    struct ufshcd_lrb *lrbp;
>>> +    u32 hwq_num, utag;
>>> +    int tag;
>>> +
>>>       /* Resetting interrupt aggregation counters first and reading the
>>>        * DOOR_BELL afterward allows us to handle all the completed requests.
>>>        * In order to prevent other interrupts starvation the DB is read once
>>> @@ -5580,7 +5590,22 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>>        * Ignore the ufshcd_poll() return value and return IRQ_HANDLED since we
>>>        * do not want polling to trigger spurious interrupt complaints.
>>>        */
>>> -    ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>>> +    if (!is_mcq_enabled(hba)) {
>>> +        ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>>> +        goto out;
>>> +    }
>>> +
>>> +    /* MCQ mode */
>>> +    for (tag = 0; tag < hba->nutrs; tag++) {
>>> +        lrbp = &hba->lrb[tag];
>>> +        if (lrbp->cmd) {
>>> +            utag = blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->cmd));
>>> +            hwq_num = blk_mq_unique_tag_to_hwq(utag);
>>> +            ufshcd_poll(hba->host, hwq_num);
>>> +        }
>>> +    }
>>
>> Is my understanding correct that ufshcd_transfer_req_compl() is only called from single doorbell code paths and hence that the above change is not necessary?
> ufshcd_transfer_req_compl() can be invoked from MCQ mode such as the ufshcd_err_handler() as below:
> ufshcd_err_handler()-->ufshcd_complete_requests()-->ufshcd_transfer_req_compl()

Since there are multiple statements in ufshcd_transfer_req_compl() that assume
SDB mode (resetting SDB interrupt aggregation and calling ufshcd_poll()), please
move the is_mcq_enabled() test from ufshcd_transfer_req_compl() into the
callers of that function.

Thanks,

Bart.
