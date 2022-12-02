Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487CB640DD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiLBStl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiLBStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:49:39 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABE1100D;
        Fri,  2 Dec 2022 10:49:38 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id c7so1194448pls.4;
        Fri, 02 Dec 2022 10:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CBzkXVDDPZe5/9NuELokoGUjygO1b1caPP14700/3U=;
        b=Q95KKbCRIOwR3+CfA+R8pnzQJGkRe+R4HgruE1yPLi/jEHusI2QiswygcMcOnbuHph
         gQYARDCGbkrG4iu2iCTXGVKARArfA1kJRzQvX2hm2QTU2j3zZym5skSmJawp/te57Hal
         7nZPewUYufKYvPnkGFTDEGMNyEOqwLjC8zmQD0qibZt1qRJawKDICt+R8685vHpfATXJ
         ChiWdqktpXisRuA+nJzLa2p0mNXg2niMEvh/t/ztYkE3HyEvE96v+t5O2g2YXw/qq1ww
         gBdGZgek4ht/1WtkrU7esH7c+ftacwHZBQfvGgbveXVBpcZ/NM/EgXPpD5paxy1qOB48
         WmNw==
X-Gm-Message-State: ANoB5plvASDeblqYDzwejWvAjzPBFcvFQhHM73pjLyOXTZvDoIcBv7KX
        Tjj7RYQjEczVuqFT5A39vnijgcjrl18=
X-Google-Smtp-Source: AA0mqf64THpA2kCG1WLZRDX+01ZLsXiFpDMjYdTU6TIbwRubKhNZhNqXP1ElRr6a16dZHTwq3NcLKg==
X-Received: by 2002:a17:902:e807:b0:189:117c:fcfe with SMTP id u7-20020a170902e80700b00189117cfcfemr53977622plg.124.1670006977763;
        Fri, 02 Dec 2022 10:49:37 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:a058:2d91:1701:a909? ([2620:15c:211:201:a058:2d91:1701:a909])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902f21100b00189393ab02csm5840690plc.99.2022.12.02.10.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 10:49:36 -0800 (PST)
Message-ID: <4e2a09d5-9fbf-069f-c5bf-fb577cb63232@acm.org>
Date:   Fri, 2 Dec 2022 10:49:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v1 1/1] scsi: ufs: core: fix device management cmd timeout
 flow
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Peter Wang <peter.wang@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>, wsd_upstream@mediatek.com
References: <20221202105817.19801-1-mason.zhang@mediatek.com>
Content-Language: en-US
In-Reply-To: <20221202105817.19801-1-mason.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 02:58, Mason Zhang wrote:
> From: Mason Zhang <Mason.Zhang@mediatek.com>
> 
> In ufs error handler flow, host will send device management cmd(NOP OUT)
> to device for recovery link. If cmd response timeout, and clear doorbell
> fail, ufshcd_wait_for_dev_cmd will do nothing and return,
> hba->dev_cmd.complete struct not set to null.
> 
> In this time, if cmd has been responsed by device, then it will
> call complete() in __ufshcd_transfer_req_compl, because of complete
> struct is alloced in stack, then the KE will occur.
> 
> Fix the following crash:
>    ipanic_die+0x24/0x38 [mrdump]
>    die+0x344/0x748
>    arm64_notify_die+0x44/0x104
>    do_debug_exception+0x104/0x1e0
>    el1_dbg+0x38/0x54
>    el1_sync_handler+0x40/0x88
>    el1_sync+0x8c/0x140
>    queued_spin_lock_slowpath+0x2e4/0x3c0
>    __ufshcd_transfer_req_compl+0x3b0/0x1164
>    ufshcd_trc_handler+0x15c/0x308
>    ufshcd_host_reset_and_restore+0x54/0x260
>    ufshcd_reset_and_restore+0x28c/0x57c
>    ufshcd_err_handler+0xeb8/0x1b6c
>    process_one_work+0x288/0x964
>    worker_thread+0x4bc/0xc7c
>    kthread+0x15c/0x264
>    ret_from_fork+0x10/0x30
> 
> Change-Id: Id17da259894294b61bef41cf7dfb94506e7e0310

Please verify patches with checkpatch before posting these upstream. Checkpatch
will tell you that Change-Id tags must be removed before posting a patch upstream.

> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>   drivers/ufs/core/ufshcd.c | 46 ++++++++++++++++++---------------------
>   1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index b1f59a5fe632..2b4934a562a6 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2979,35 +2979,31 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>   		err = -ETIMEDOUT;
>   		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
>   			__func__, lrbp->task_tag);
> -		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
> +		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0)
>   			/* successfully cleared the command, retry if needed */
>   			err = -EAGAIN;
> +		/*
> +		 * Since clearing the command succeeded we also need to
> +		 * clear the task tag bit from the outstanding_reqs
> +		 * variable.
> +		 */
> +		spin_lock_irqsave(&hba->outstanding_lock, flags);
> +		pending = test_bit(lrbp->task_tag,
> +				   &hba->outstanding_reqs);
> +		if (pending) {
> +			hba->dev_cmd.complete = NULL;
> +			__clear_bit(lrbp->task_tag,
> +				    &hba->outstanding_reqs);
> +		}
> +		spin_unlock_irqrestore(&hba->outstanding_lock, flags);

I don't think it is safe to clear the corresponding bit from outstanding_reqs
if ufshcd_clear_cmds() returns a value != 0.

Instead of making all these changes, would the following patch be sufficient?

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bb4cbfe7fd57..d5deec621d2a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3008,6 +3008,9 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
  		} else {
  			dev_err(hba->dev, "%s: failed to clear tag %d\n",
  				__func__, lrbp->task_tag);
+			spin_lock_irqsave(&hba->outstanding_lock, flags);
+			hba->dev_cmd.complete = NULL;
+			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
  		}
  	}


Thanks,

Bart.
