Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD9658DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiL2OMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiL2OMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:12:32 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D684912601;
        Thu, 29 Dec 2022 06:12:31 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d3so19013422plr.10;
        Thu, 29 Dec 2022 06:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcy9ftJKBrRHkC72YgwS3ie0/FVvPrzfi5Sffg9ACpo=;
        b=TORLYQ8yGzbZQIyLEnNk0Vx6CJzAsFKD/ZBFGME81EPqeE2TmkGC+G9QOMwA4iLCUU
         l8yoW7qs1w5cRDXkFQUgIGz1l/e8vub53fHKyywfWvuGGUX6S/Ecri/S+aLyQGFcxmdq
         BceT+7MQ+Hljj8LJoM7Ybn2CpSDA98Tc2zsyRNBR6AxcfyNsQNC5cRpLjkV9ebiGSYE1
         KlmW1ivriI70kmWfT+OCfCW7mOBSwqazO96oAGxh/jkdhJFMLBY1YtZ5ceeaXQcP806b
         gsPoZeJlz9LE/2XS38tVf43oa8ul6Z202dzjDc+9lF/bx6AGLkNZHMv1c4Mc/VPbLxwQ
         BXnw==
X-Gm-Message-State: AFqh2kpIlHE/ESK7szSblVGfB05ctVH/TKy8Ih5B88mR6qBqrltOz2f0
        tH+qvjqfa+PN8pr/ATxzwo4=
X-Google-Smtp-Source: AMrXdXsAqNFfvfsB+SuolGkuRhNtkrezEQ/gDYlfmkotyqEhDt8zMnxQINy6iDMslEl7w7ZNlaGeow==
X-Received: by 2002:a05:6300:8184:b0:b0:3e0f:508d with SMTP id bt4-20020a056300818400b000b03e0f508dmr34921955pzc.55.1672323151083;
        Thu, 29 Dec 2022 06:12:31 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id a23-20020a621a17000000b0057ef155103asm1081113pfa.155.2022.12.29.06.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 06:12:29 -0800 (PST)
Message-ID: <46b4a936-c59a-ba04-4395-ed53fb72a67d@acm.org>
Date:   Thu, 29 Dec 2022 06:12:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/1] ufs: update the timeout timer after resume
Content-Language: en-US
To:     Ed Tsai <ed.tsai@mediatek.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, matthias.bgg@gmail.com,
        linux-scsi@vger.kernel.org
Cc:     peter.wang@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        stanley.chu@mediatek.com, wsd_upstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221229030645.11558-1-ed.tsai@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221229030645.11558-1-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 19:06, Ed Tsai wrote:
> The tags allocation is limited by the number of active queues and a
> queue is marked as inactive by the queue timeout worker after up to 30Hz
> by default.
> 
> Therefore, tags for the general I/O may be limited to half of the max
> depth up to 30HZ after resume. To make sure the ufs request queue for pm
> usage can be inactive immediately, trigger the timeout worker to release
> the tag set.
> 
> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> ---
>   drivers/ufs/core/ufshcd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index e18c9f4463ec..c77570caa3a8 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8842,6 +8842,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
>   		hba->curr_dev_pwr_mode = pwr_mode;
>   	}
>   
> +	mod_timer(&sdp->request_queue->timeout, 0);
>   	scsi_device_put(sdp);
>   	hba->host->eh_noresume = 0;
>   	return ret;

Where is the code that restores the timeout to the original value?

Additionally, I think that only the block layer core should manipulate 
the request queue timer directly. Please add a helper function in the 
block layer and call that helper function from the UFS driver.

Thanks,

Bart.
