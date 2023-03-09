Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337A26B3185
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCIWzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCIWzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:55:10 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6D65058;
        Thu,  9 Mar 2023 14:54:41 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so6912288pjb.0;
        Thu, 09 Mar 2023 14:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678402472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DHNxVrsY82uW8tniKyTIOA7RxD60GlDeGu+usTAULI=;
        b=QMDC2o4qnVpB4mskNuM7SkHyf1Prg8cLIuvl4Q6Ff0h7eus+MKjck08GdCDG8KdVvZ
         JGF9T6+uEvX5AmbqTQ2b6VLTIE3zcRQJUEeuQZ9D85coiJdLpphZyByGBthP96Gcvo9g
         cNL9UtrYxbnby1JHzZ9Zg6g+m7jzfDrdvTsr3jfmJLZkO9UzySMng+Ykk07CYg7NUl/9
         8A4+IsL4tF/g/HlE7vpJHoy0iEBw1gczhplHSERGQ2mlrbjGtzkZoCRlek4K+C+mABqn
         fejzZ37/L27mZw5P6QBXuvnyQg4RTOdXsF/He6MInegTqHnyibjHAZCzA+VSrmENLaQN
         +Meg==
X-Gm-Message-State: AO0yUKXXxRP9tn+UUobFEm3ZzE+fWiCk5SWgZSGza6AGuugOItegspPm
        YswmTuNK7Jil4jajhrhvVDY=
X-Google-Smtp-Source: AK7set+jkRQluRAU5RZj4XY0WCg95mDlja9mv+95zKVHerFsG1t+RXQCJPKskXKnb/j6TqXtmAFDFQ==
X-Received: by 2002:a17:903:514:b0:19e:68e4:859c with SMTP id jn20-20020a170903051400b0019e68e4859cmr18952806plb.36.1678402471908;
        Thu, 09 Mar 2023 14:54:31 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id jy13-20020a17090342cd00b0019ea9e5815bsm158581plb.45.2023.03.09.14.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 14:54:31 -0800 (PST)
Message-ID: <a7970fd0-ee6f-f1c1-e8c4-6ee42237a567@acm.org>
Date:   Thu, 9 Mar 2023 14:54:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 1/3] ufs: mcq: Add supporting functions for mcq
 abort
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678338926.git.quic_nguyenb@quicinc.com>
 <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
 <1ca7dbef-5747-29c2-a11c-086cf36d636f@acm.org>
 <821e6994-9fed-2c15-6c25-b1761a267ec9@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <821e6994-9fed-2c15-6c25-b1761a267ec9@quicinc.com>
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

On 3/9/23 14:47, Bao D. Nguyen wrote:
> On 3/9/2023 10:15 AM, Bart Van Assche wrote:
>> On 3/8/23 21:28, Bao D. Nguyen wrote:
>>> +static inline bool ufshcd_mcq_is_sq_empty(struct ufs_hw_queue *q)
>>> +{
>>> +    return q->sq_head_slot == q->sq_tail_slot;
>>> +}
>>
>> Please remove this function and inline this function into its callers.
> 
> Same comment. Should I also update the existing ufshcd_mcq_is_cq_empty() 
> in a separate patch together with ufshcd_mcq_update_cq_tail_slot(), 
> ufshcd_mcq_update_cq_head() mentioned above?

Hi Bao,

Modifying the existing code may improve uniformity of the UFS host 
controller driver. If any existing code is refactored, please do that 
via a separate patch.

Thanks,

Bart.

