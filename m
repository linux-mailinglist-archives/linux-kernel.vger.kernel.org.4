Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99BC6B167A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCHXZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHXZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:25:42 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4636423D;
        Wed,  8 Mar 2023 15:25:41 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id u5so155539plq.7;
        Wed, 08 Mar 2023 15:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugad4+Q+eKUn0g86TD3ttr1CmSivswhGxYdUjaKKTUQ=;
        b=PTPZM7MZiop2RXUwCPyUWwFMwM+qukzTD5ogRz5xWUkhlhsVjymhx+W04mNzlWjmDg
         0nmf0NodwI7xkqU7vTxNDrhL/GWOmTszsfOzuYazNazo63DGP+O/0seKDzAG+PxiVeYD
         3F1HbCojSdOEmXMcDRHt943bd6y9nGZsNyHORHFyKTQWZFf1vlosdlFZGOf3mtBi9J/x
         uSDHEwP2fvHtVRXkSA8/4P2ETHoMlCtGgW+YyomsLWUk5nesSZHUc6gsxDcg2zrQk2iK
         icnB3AFoUmAmpobUhDSZrbKbJoxFs81s8oRuoOlCW04jm3LoapX0gxT0tlhe7cFZlmE9
         tEHg==
X-Gm-Message-State: AO0yUKVQ0ZJvtKcW0xVbP4sqGXaZLib7j3LIUk/Rlrglgbm4JdCFlgZr
        C702yGBR3TcXvw/5RZMDAa4=
X-Google-Smtp-Source: AK7set+ZPREWQuqlRy2+K8H5xp0+oZPR6c0IVXcge9N+72YdBZvlPpxDCHTW3t4XdVvMyAJYduWedw==
X-Received: by 2002:a05:6a21:99a3:b0:b6:99a4:66bd with SMTP id ve35-20020a056a2199a300b000b699a466bdmr22863712pzb.38.1678317941340;
        Wed, 08 Mar 2023 15:25:41 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78dc6000000b005938f5b7231sm9815063pfr.201.2023.03.08.15.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 15:25:40 -0800 (PST)
Message-ID: <e354dece-5dc8-9cdc-b822-59a1e0f3a9c3@acm.org>
Date:   Wed, 8 Mar 2023 15:25:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v1 4/4] ufs: mcq: Added ufshcd_mcq_abort()
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <c7fcbb70f0e74d225c1a09f107ba1058270739be.1678247309.git.quic_nguyenb@quicinc.com>
 <85994527-d09d-f381-3dda-7cfb9ce98d4b@acm.org>
 <ec627f76-380b-bdfd-e736-1626d5bde0e4@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ec627f76-380b-bdfd-e736-1626d5bde0e4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 14:37, Bao D. Nguyen wrote:
> On 3/8/2023 11:02 AM, Bart Van Assche wrote:
>> On 3/7/23 20:01, Bao D. Nguyen wrote:
>>> +    if (ufshcd_mcq_cqe_search(hba, hwq, tag)) {
>>> +        dev_err(hba->dev, "%s: cmd found in cq. hwq=%d, tag=%d\n",
>>> +                __func__, hwq->id, tag);
>>> +        /*
>>> +         * The command should not be 'stuck' in the CQ for such a 
>>> long time.
>>> +         * Is interrupt missing? Process the CQEs here. If the 
>>> interrupt is
>>> +         * invoked at a later time, the CQ will be empty because the 
>>> CQEs
>>> +         * are already processed here.
>>> +         */
>>> +        ufshcd_mcq_poll_cqe_lock(hba, hwq);
>>> +        err = SUCCESS;
>>> +        goto out;
>>> +    }
>>
>> Please remove the above code and also the definition of the 
>> ufshcd_mcq_cqe_search() function. The SCSI error handler submits an 
>> abort to deal with command processing timeouts. 
>> ufshcd_mcq_cqe_search() can only return true in case of a software bug 
>> at the host side. Addressing such bugs is out of scope for the SCSI 
>> error handler.
> 
> This is an attempt to handle the error case similar to SDB mode where it 
> prints "%s: cmd was completed, but without a notifying intr, tag = %d" 
> in the ufshcd_abort() function.
> 
> In this case the command has been completed by the hardware, but some 
> reasons the software has not processed it. We have seen this print 
> happened during debug sessions, so the error case does happen in SBL mode.
> 
> Are you suggesting we should return error in this case without calling 
> ufshcd_mcq_poll_cqe_lock()?

What I am asking is to remove ufshcd_mcq_poll_cqe_lock() and all code 
that depends on that function returning true. Although such code might 
be useful for SoC debugging, helping with SoC debugging is out of scope 
for Linux kernel drivers.

Thanks,

Bart.

