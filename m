Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE56EB2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjDUUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDUUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:06:53 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D602702;
        Fri, 21 Apr 2023 13:06:46 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-63b62d2f729so2208218b3a.1;
        Fri, 21 Apr 2023 13:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682107606; x=1684699606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dfyv5FN7xF6QzY/YKdeFbK9UZIryP5DcTEQcPzQtdzY=;
        b=AmHLZFnFgmuuJWoEkw91S44UBgXCSjD+Qw7TmX4o1f+ciiKZHzk5XcUKedkC4NBiqS
         3Ha+qC+YWMaNvleXgeH+GdM8b4dQ3qhqZIGudHJXi3tHXbjbR237EJi1bve7PxaSPUi1
         1wo9Vf8tdui9AKOdb1WWkYicltqvqhytspQH9AoNI0aergwkfCU4wfGn7UcKTSpE/vSM
         QtTl5ETDT2G/gHNsfD3TyB6llAybAsctN/0G1oyaluvb9CRdr6NX6B4ydRlzflAofo+D
         fvXx8AjYHqLeSmad1rueDVkIu/1UsOiYklet2YkiRkBxUfZJfLega5L0+6UhDmo9SrFZ
         TXvQ==
X-Gm-Message-State: AAQBX9d6tv1Ng+0UATux4Oe4cLpFiOUri/iUml0NgJi0itCHoETmPbxJ
        GNI3WY0KBgHoRWCJcp5XIjE=
X-Google-Smtp-Source: AKy350ZXdc4qGBNAbdHsNqr7fR3Yeo/NPEkEskreo/KMkEW84H+StzQOr19IbrV3KCX8h/loRQwoLw==
X-Received: by 2002:a05:6a00:2e8f:b0:626:1523:b10d with SMTP id fd15-20020a056a002e8f00b006261523b10dmr7418054pfb.4.1682107606102;
        Fri, 21 Apr 2023 13:06:46 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id l6-20020a656806000000b0051b71e8f633sm2956011pgt.92.2023.04.21.13.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 13:06:45 -0700 (PDT)
Message-ID: <fd67589e-58a4-3f5a-cc49-528bb70fd4e7@acm.org>
Date:   Fri, 21 Apr 2023 13:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/5] scsi: ufs: core: Fix mcq nr_hw_queues
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
References: <20230307065448.15279-1-powen.kao@mediatek.com>
 <20230307065448.15279-4-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230307065448.15279-4-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 22:54, Po-Wen Kao wrote:
> Since MAXQ is 0 based value, add one to obtain number of hardware queue.
> 
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index a39746b2a8be..c7b807f58dca 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -150,7 +150,8 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
>   	u32 hba_maxq, rem, tot_queues;
>   	struct Scsi_Host *host = hba->host;
>   
> -	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
> +	/* maxq is 0 based value */
> +	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1;
>   
>   	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
>   			rw_queues;

Please resend this patch.

Thanks,

Bart.
