Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C706474FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLHR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLHR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:28:46 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A79857F;
        Thu,  8 Dec 2022 09:28:45 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id jl24so2150717plb.8;
        Thu, 08 Dec 2022 09:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6rMA8enB1ZNoyIDqdZjqqp7br7Eu1pXTVbOT7EIYGQ=;
        b=Sdj63OaJ8MojXe9c/gRNEt1z2QYY+OBx/ELVWYBsMkrZ6UT/Y6T75D2BmOkfLAIV1y
         bQdq10mrzQ0/9POEgGtjMgqBwyUNW6zH1MXNUFlwXBGrpa6Gcior7USADbD7mp98ryc5
         00Dw0EPO3DcfOh1J69UAdY/8SxxhhLD6cQFWAD0NF+Es6FFL33QyOeXGwDZvitYbVrIC
         WeuX2CH4VFjlmj6KSNSQNGNITui2cIWByViP6RENsuq/FgkXjuguUM3Ar+Tf6E3+MWK9
         3zJN9gVgMX536JElC872dgB1kQ8jcNWB0TfNmJLgB1NXq86J4mK4kxDgEBTHAumS2XIt
         nYhg==
X-Gm-Message-State: ANoB5pktdh7g3KaJqmxxJvzqgUfDBQQYc3WOMq3dCqLJ7dNrwkWtQwR2
        EsAouQeaEzMVMO87P82ADuU=
X-Google-Smtp-Source: AA0mqf7H3gJ6PPCGAlJNRm5jTIpngXqzz7iYtKR0YUQn52hrfAGFBvok2x2AXPTpmsaP/a3nnv7NpQ==
X-Received: by 2002:a17:90a:7881:b0:219:f1a2:b641 with SMTP id x1-20020a17090a788100b00219f1a2b641mr13551635pjk.97.1670520525012;
        Thu, 08 Dec 2022 09:28:45 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7b97:baa3:badc:5af? ([2620:15c:211:201:7b97:baa3:badc:5af])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902b41600b0016be834d54asm16726919plr.306.2022.12.08.09.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 09:28:44 -0800 (PST)
Message-ID: <b6dfaaee-405a-d576-d46d-0ec78f216f85@acm.org>
Date:   Thu, 8 Dec 2022 09:28:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/4] ufs: core: Remove redundant wb check
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1669550910-9672-2-git-send-email-Arthur.Simchaev@wdc.com>
 <b89f3337-0869-35a8-114d-85e1fd81eb2c@acm.org>
 <0a44763d-8c40-b9e7-6268-01567c401884@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0a44763d-8c40-b9e7-6268-01567c401884@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 04:22, Bean Huo wrote:
> 
> On 08.12.22 12:31 AM, Bart Van Assche wrote:
>> On 11/27/22 04:08, Arthur Simchaev wrote:
>>> We used to use the extended-feature field in the device descriptor,
>>> as an indication that the device supports ufs2.2 or later.
>>> Remove that as this check is specifically done few lines above.
>>>
>>> Reviewed-by: Bean Huo <beanhuo@micron.com>
>>> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
>>> ---
>>>   drivers/ufs/core/ufshcd.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>>> index 2dbe249..2e47c69 100644
>>> --- a/drivers/ufs/core/ufshcd.c
>>> +++ b/drivers/ufs/core/ufshcd.c
>>> @@ -7608,10 +7608,6 @@ static void ufshcd_wb_probe(struct ufs_hba 
>>> *hba, const u8 *desc_buf)
>>>            (hba->dev_quirks & 
>>> UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
>>>           goto wb_disabled;
>>>   -    if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
>>> -        DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
>>> -        goto wb_disabled;
>>> -
>>>       ext_ufs_feature = get_unaligned_be32(desc_buf +
>>>                       DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
>>
>> Does this code really have to be removed? I see a check of the
>> UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES flag above the removed
>> code but no check of the descriptor size?
>>
> it is not necessary to check this, but if you have concern, we could 
> change to like this:
> 
> 
>          if (desc_buf[DEVICE_DESC_PARAM_LEN] <
>              DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
>                  goto wb_disabled;
> 
> then   hba->desc_size could be removed.

Hi Bean,

My only concern is that this patch conflicts with the pending MCQ patch 
series. Since that conflict is unavoidable, let's keep this patch.

Bart.
