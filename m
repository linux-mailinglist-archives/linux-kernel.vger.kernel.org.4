Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D76A72A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCASHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCASHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:07:45 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F0B464;
        Wed,  1 Mar 2023 10:07:44 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so72674pjb.3;
        Wed, 01 Mar 2023 10:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz6WOZ/z5lwtTAg8FqEkEPXRRvxotq7sY4hiW57q0Vo=;
        b=z5p+0eGYgWq0Uq61esGr6ir+1SX+VjyviJ5xjkQe5gV6BAASHRcRBuZKRZnYRiBGi6
         i695Xkm5HW/Ru/77Kd5qWTgMhVpLbdG9xAh+IIStGIG9AT1PIHB1DO0XzOYguPdBxpNs
         56sk+swjNUVme4LWo+YbLXLisuizB2JT6kfLSxi/Uv3si/vnhd+WrrqTt8ifrNle3mTE
         yQsJAM4DHAC52KIkmx/SWp2bLjroxNIUTXWQe34z/6Jv7K0lVGdEUqKf96QzcfvA+tmA
         EcnSnA8pWvYX15TIxbkcuT4lP1TaBnwEFs9uJacrCy403NBFNOXqsB/v9NvxHFzNbths
         JItA==
X-Gm-Message-State: AO0yUKVZG/uXPXc8ADYZklpEqWlItoowC6BKhWQrOjOiHQfqUX5lNoVJ
        w5St6BwisHARyvJcNWWn9PCf0sxxzIQ=
X-Google-Smtp-Source: AK7set9JhYtmNMV7lCXdQ9mo54Y2U1aBntVSGSDCFpGeGYqdnoGmlTk21DhG8GfJwnoV5I2xt7Rfug==
X-Received: by 2002:a05:6a20:65b0:b0:cc:dd86:ca27 with SMTP id p48-20020a056a2065b000b000ccdd86ca27mr6552688pzh.17.1677694063831;
        Wed, 01 Mar 2023 10:07:43 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:e8e:76a3:8425:6d37? ([2620:15c:211:201:e8e:76a3:8425:6d37])
        by smtp.gmail.com with ESMTPSA id a6-20020a631a46000000b004fc1d91e695sm7682911pgm.79.2023.03.01.10.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:07:43 -0800 (PST)
Message-ID: <a3c08b5f-b8cb-fdd9-eb60-b1adc2879fff@acm.org>
Date:   Wed, 1 Mar 2023 10:07:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ufs: host: ufs-qcom: Return directly if MCQ resource is
 provided in DT
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_asutoshd@quicinc.com
References: <20230301073110.9083-1-manivannan.sadhasivam@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230301073110.9083-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 23:31, Manivannan Sadhasivam wrote:
> Instead of using a goto label to return, let's return directly in the
> "if" condition after setting mcq_base.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 34fc453f3eb1..d90f963eed02 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1460,8 +1460,10 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>   	/* MCQ resource provided in DT */
>   	res = &hba->res[RES_MCQ];
>   	/* Bail if MCQ resource is provided */
> -	if (res->base)
> -		goto out;
> +	if (res->base) {
> +		hba->mcq_base = res->base;
> +		return 0;
> +	}
>   
>   	/* Explicitly allocate MCQ resource from ufs_mem */
>   	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
> @@ -1489,9 +1491,6 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>   		goto ioremap_err;
>   	}
>   
> -out:
> -	hba->mcq_base = res->base;
> -	return 0;
>   ioremap_err:
>   	res->base = NULL;
>   	remove_resource(res_mcq);

This patch changes the behavior for the success case without mentioning 
this in the patch description. So I assume that the behavior change is 
unintentional and hence that this patch should be dropped?

Bart.
