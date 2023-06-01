Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAED719F42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjFAOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjFAOKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:10:11 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23CE79;
        Thu,  1 Jun 2023 07:09:48 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso1111226b3a.0;
        Thu, 01 Jun 2023 07:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628530; x=1688220530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TI76AT4YHLTbGXU1L9WXoyjgIgrdWz0UcRsneNrJPSg=;
        b=PRMyn5c+YU3o6Cg3o9biMH+Ewu6gh79tvxovvyWWssIu28D7Xr4V8UG+t1MK2OW8dE
         1ZIo7yahJATaD5yRvsan47yrwR5bdXaHOYIxnZZBjpmRbhvBDVDHgJkcbaARjvrGAyFE
         s3rkTkWiSm3f1JjSrXNpmcKl2uQdfooe4bZwBhAoKZyasnTp83GyjYUMGTj4rZbX+ZTs
         OWXgpVaNjVs/dBJLljnAWvB1FOt3ES2cextkyy86b84odZ666EisIK1s13+YQgG76Ed5
         8LnWrofPSvF58nayrGwJU/iHq5PgazL1JweftK39TOfE7RO+eRwRjgs5CfSl76UcUARz
         k/bQ==
X-Gm-Message-State: AC+VfDxXcC3ME58ns3el+Sz2/QNHGbkeX/cFTT5iS52YFSFL0GXxU/Xg
        vsbR7abU0LJphC/0yXJ+RKJFMYW6nJU=
X-Google-Smtp-Source: ACHHUZ6JNsk5v6xRbmmrmKljlVN/Pk+7V/9hGIpYskO7fzA2+4UCdKARv1rKhZznu4RVdT7BqwNNWQ==
X-Received: by 2002:a05:6a00:24c9:b0:64c:ecf7:f4a4 with SMTP id d9-20020a056a0024c900b0064cecf7f4a4mr11829719pfv.24.1685628530329;
        Thu, 01 Jun 2023 07:08:50 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id r25-20020a6560d9000000b00528da88275bsm1237834pgv.47.2023.06.01.07.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:08:49 -0700 (PDT)
Message-ID: <61ff835b-bd00-8cf3-6e4a-30c82cf9e7b1@acm.org>
Date:   Thu, 1 Jun 2023 07:08:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] scsi: ufs: core: Fix ufshcd_inc_sq_tail function bug
Content-Language: en-US
To:     Zhang Hui <masonzhang.xiaomi@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhanghui <zhanghui31@xiaomi.com>, Bean Huo <beanhuo@micron.com>,
        peng.zhou@mediatek.com, yudongbin@xiaomi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601124613.1446-1-zhanghui31@xiaomi.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230601124613.1446-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 05:46, Zhang Hui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> When qdepth is not power of 2, not every bit of the mask is 1, so
> sq_tail_slot some bits will be cleared unexpected.
> 
> Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
> ---
>   drivers/ufs/core/ufshcd-priv.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index d53b93c21a0c..319fba31c1f5 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -366,10 +366,11 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8
>   static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
>   	__must_hold(&q->sq_lock)
>   {
> -	u32 mask = q->max_entries - 1;
>   	u32 val;
>   
> -	q->sq_tail_slot = (q->sq_tail_slot + 1) & mask;
> +	q->sq_tail_slot++;
> +	if (q->sq_tail_slot == q->max_entries)
> +		q->sq_tail_slot = 0;
>   	val = q->sq_tail_slot * sizeof(struct utp_transfer_req_desc);
>   	writel(val, q->mcq_sq_tail);
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
