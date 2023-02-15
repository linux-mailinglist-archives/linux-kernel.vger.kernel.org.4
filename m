Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD6698233
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBOReQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjBOReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:34:14 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68BB5FCD;
        Wed, 15 Feb 2023 09:34:11 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so4005069pjd.1;
        Wed, 15 Feb 2023 09:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7RJUFWr8yFaYxrhdiEcn2oKMmIGGDkUJslynTZp+P4=;
        b=vMEDsLHo7W+ztjS91pENbMoEdm0Jt85PNDMvmZjJMYkaapEvKL9dME1Fj3YBlcr9xq
         cvQBhjIZKcNydQP7uojf2CM089fvkGYLyhBRq0MG8pMv5FN8XonNY3pPObw9iQTPMjKA
         4DOSs0tkPeD69oWceFxk8ve3HN0AyWpEa7jh/GyCaGvnPTo5vytkd5P6bf++Lluqikfr
         pfhPX1qmFdZJ7MouvIFuh6RnHzjh2Shz/15uCUHvVeTF97JyGvr6y6USxnRP5A75Yv1K
         HeC/n7gALfubpwBoHxRMuMfeovjQdHbcIt0GbCGxdKDprBUnz6ZGPH3KMko2Yn6NxpwV
         pCzQ==
X-Gm-Message-State: AO0yUKVpXfZFWaYkpTLM/B8461g2sU+4p1fKnNSOiSqoCPP6lURL3t1q
        6v/Wz0XMLFirYDlUOH4YasI=
X-Google-Smtp-Source: AK7set8KLjD29nGYSoiZcDjoRn7yIAWLQdb0khrbWiYyRjTHemXuKmGovegMmhMZOXZujT+FAiP9yg==
X-Received: by 2002:a17:903:24f:b0:19a:b2ee:cf41 with SMTP id j15-20020a170903024f00b0019ab2eecf41mr3717131plh.59.1676482451156;
        Wed, 15 Feb 2023 09:34:11 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f2b7:9a62:c95d:fb83? ([2620:15c:211:201:f2b7:9a62:c95d:fb83])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b0019a6fe0f975sm5076016plk.267.2023.02.15.09.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 09:34:10 -0800 (PST)
Message-ID: <fef343fb-42e3-501a-709e-f1c0b74a84c8@acm.org>
Date:   Wed, 15 Feb 2023 09:34:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] scsi: ufs: core: Fix mcq tag calcualtion
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        mason.zhang@mediatek.com, quic_asutoshd@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230215123750.15785-1-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230215123750.15785-1-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 04:37, Po-Wen Kao wrote:
> Transfer command descriptor is allocated in ufshcd_memory_alloc()
> and referenced by transfer request descriptor with stride size
> sizeof_utp_transfer_cmd_desc()
> instead of
> sizeof(struct utp_transfer_cmd_desc).
> 
> Consequently, computing tag by address offset should also refer to the
> same stride.
> 
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 31df052fbc41..3a27fa4b0024 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
>   	addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
>   		hba->ucdl_dma_addr;
>   
> -	return div_u64(addr, sizeof(struct utp_transfer_cmd_desc));
> +	return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));
>   }
>   
>   static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
