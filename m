Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0D6FBE2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjEIEXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEIEW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:22:58 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A1244A0;
        Mon,  8 May 2023 21:22:58 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so4921844a12.0;
        Mon, 08 May 2023 21:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683606177; x=1686198177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hju9RP+TJIwPzHSbklx9tx6RuP11kFVSULgO0JpvMYo=;
        b=MHzG6A3YAVgfm/t7ioHZV0BS6k0e5qshXSzy7XuJTgXL7pu/SHRQkogNdbmtvQawUL
         oJaA46YxNdLEFXCvywMiV357tNAUniLGPZ0n7Pc0/rusqzAk/kZb1o/3CnNlqxX6IwzJ
         MV/X4wHPlS6mlMrrT1x26b0zU3dLvIYsTQ4/duDGN70aC84UxFCfkcTM8yqiKAj/Fofz
         4bcIwdD6VCEoCh4t3z2JhpbmWvy3Q/AToEaJ21S18oPy5d4pHjacMjAjYc6dmHzyRC1Q
         tNMknqyz/g9+VVYzLpu30p/qDAo1kS0K8q0H8wxu0GZ4Cpp+WylmJkCmn4bEBmx8rWAT
         FOUQ==
X-Gm-Message-State: AC+VfDyAYHm6wyX41X4VRYUdd4hdQhuazMxOSn70St74zEB5Y+2QL92A
        PfDHbm1Nvq0Xf0gvw3xzL2e6Fsb/2Hg=
X-Google-Smtp-Source: ACHHUZ4EIdouM0mgG3IfSt23/EyjMlvnlS3vOP6OeyX3/7Ov39m4Bil5YGWJ/0jRHZ3JcfFIEk97ng==
X-Received: by 2002:a17:902:cec2:b0:1a8:1f41:59ba with SMTP id d2-20020a170902cec200b001a81f4159bamr15207641plg.38.1683606177395;
        Mon, 08 May 2023 21:22:57 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902989700b001a96269e12csm350939plp.51.2023.05.08.21.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 21:22:57 -0700 (PDT)
Message-ID: <61f8f885-3f75-4e05-37dc-b54489adaeb7@acm.org>
Date:   Mon, 8 May 2023 21:22:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1] block: make the fair sharing of tag configurable
Content-Language: en-US
To:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com
References: <20230509012758.27094-1-ed.tsai@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230509012758.27094-1-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 18:27, Ed Tsai wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d6af9d431dc6..b8b36823f5f5 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -97,6 +97,7 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
>   			    struct sbitmap_queue *bt)
>   {
>   	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
> +			blk_queue_fair_tag_sharing(data->q) &&
>   			!hctx_may_queue(data->hctx, bt))
>   		return BLK_MQ_NO_TAG;

Has it been considered to move the blk_queue_fair_tag_sharing() call into
hctx_may_queue()? That should make this patch shorter.

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 17d7bb875fee..e96a50265285 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5149,6 +5149,9 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
>   	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
>   	if (hba->quirks & UFSHCD_QUIRK_4KB_DMA_ALIGNMENT)
>   		blk_queue_update_dma_alignment(q, 4096 - 1);
> +
> +	blk_queue_flag_clear(QUEUE_FLAG_FAIR_TAG_SHARING, q);
> +
>   	/*
>   	 * Block runtime-pm until all consumers are added.
>   	 * Refer ufshcd_setup_links().

Please split this patch into one patch for the block layer core and another
patch for the UFS driver.

Thanks,

Bart.

