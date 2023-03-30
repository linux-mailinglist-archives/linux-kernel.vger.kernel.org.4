Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59576D0B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjC3Qjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjC3Qj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:39:28 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B26CC1F;
        Thu, 30 Mar 2023 09:39:27 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id l7so17760500pjg.5;
        Thu, 30 Mar 2023 09:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyc4baqiAVc4MZuTEjpXFtc6aR17Qbxd5seZOLPAYQg=;
        b=bNhJRDsTkKXApN5BlJz6eqfVEowxtnZ9dzPDRxXZY8szQZ5lfQ1HlxFnYtxvWuTfV6
         5Y13fahLXFmhedXnB60k2Eiu6NxQ6BwMP/6Xl00ugbVq+8uXg/hkOWVqjkwuevkt3v2V
         6n0XExepRvqrkDG7UuPb8cGTr+MB8fSiojVFPf7mtweSJGUoDPThzRM1iUQhTwB3TXRQ
         uCI4oLjYcserR7CjBS3A+q5bRAwSxPFu1ZtAWC1ZBaVbK3cD+ahvc1Pt+AkcxWnq/BNz
         B95CbJZ0pJRY9lyaTFAC2EeKKICJ2rWIaw492Y92jixl5Mo8WIDyNX+yjVhk2zGCfw9P
         XjPA==
X-Gm-Message-State: AO0yUKXjkvppktoCl2Ersto5v3qw24fN6vfBwHiUBA41bmlpDGWDhVy3
        Q833uJNiMygcOfo2nFXBNU4=
X-Google-Smtp-Source: AK7set/B/GkmcGzx2/pRlYFXWKwnFKfiSj5e1N/Bxt1UYgm06zQZy2Fa80tu4U1FKYuvUR7oenwJGA==
X-Received: by 2002:a05:6a20:4725:b0:da:2d16:db89 with SMTP id ek37-20020a056a20472500b000da2d16db89mr19345973pzb.28.1680194366720;
        Thu, 30 Mar 2023 09:39:26 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6b0e:992b:d535:b656? ([2620:15c:211:201:6b0e:992b:d535:b656])
        by smtp.gmail.com with ESMTPSA id n23-20020aa78a57000000b005809d382016sm96974pfa.74.2023.03.30.09.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:39:25 -0700 (PDT)
Message-ID: <8cb5216b-7dee-a924-1362-88b53ecbe6ea@acm.org>
Date:   Thu, 30 Mar 2023 09:39:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330131109.5722-1-avri.altman@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230330131109.5722-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 06:11, Avri Altman wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 35a3bd95c5e4..d529c42a682a 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8468,6 +8468,10 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>   	if (ret)
>   		goto err;
>   
> +	if (WARN_ONCE(hba->nutrs * hba->nr_hw_queues > (1 << 16) - 1,
> +		     "there can be at most 1<<16 inflight requests\n"))
> +		goto err;
> +
>   	/*
>   	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
>   	 * Number of supported tags in MCQ mode may be larger than SDB mode.

Hi Avri,

WARN*() should only be used to report kernel bugs. hba->nutrs * 
hba->nr_hw_queues being too large is not a kernel bug but a 
configuration issue.

Instead of failing MCQ allocation, shouldn't 
ufshcd_mcq_decide_queue_depth() be modified such that it restricts 
hba->nutrs to a value that can be supported?

Thanks,

Bart.
