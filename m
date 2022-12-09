Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943696488A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLISu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLISuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:50:54 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CCA2D1EB;
        Fri,  9 Dec 2022 10:50:51 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d82so4313996pfd.11;
        Fri, 09 Dec 2022 10:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q6n80AI/p5yu9Dywj66FNMpbfZPHnd7kd9qY/cbMFk=;
        b=SHCyiRYG141E4D3MkPJ9HprmgNFlS/1CigX1N3yKyDwo3TIbItECawH42AFWSQC2xS
         Z5ksNaz5DlQ+eQiOFZ6MCKRnjpmTfBNkDkwgg+5+HzO/8qdpo7lIix/onB2fei0Urzvm
         PEoPN6vxnaO9BvrMQ1+Ypa+2Vjiz5Z4yF4YrG7i5b66Lh1Uk7gOmCW4Sdve9xuCgsTiB
         hxaziLoLK/0nV2JiFdQClkM3RKOJ1Mg47S2urlcTLbn7hHdkU+IqZNLH3fc0DxmUs0wT
         iUoFIHvuKTRhZYryZLcpQzaoA5Rqm2DdSx6evUMNIFa4Y7lQ4Yp/kiIPbjefImKDa5CG
         hhOA==
X-Gm-Message-State: ANoB5plW+K18nWiMc98vTgQ42lPYjcTMb/iSrgCSPNaFqkAY1HTCmyu9
        gZKfDp8Cgb/NFqQcYBfUhsTel6t3y2c=
X-Google-Smtp-Source: AA0mqf7ioBFgGmxkLMOXkzgWz2cpnnogR2IwP0DGXq3yGgDbL4gF9Gp76dBdoZ3pXK2AacI3Cm3rbg==
X-Received: by 2002:aa7:8298:0:b0:56d:5de0:111b with SMTP id s24-20020aa78298000000b0056d5de0111bmr6875047pfm.33.1670611850939;
        Fri, 09 Dec 2022 10:50:50 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:5c4e:b71f:9cdc:e100? ([2620:15c:211:201:5c4e:b71f:9cdc:e100])
        by smtp.gmail.com with ESMTPSA id y29-20020aa79e1d000000b00573eb4a9a66sm1553974pfq.2.2022.12.09.10.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 10:50:50 -0800 (PST)
Message-ID: <d53f0b3e-a831-ed1e-9a8e-3c6902a81fdf@acm.org>
Date:   Fri, 9 Dec 2022 10:50:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/1] scsi: ufs: core: fix device management cmd timeout
 flow
Content-Language: en-US
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
References: <20221209101321.30671-1-mason.zhang@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221209101321.30671-1-mason.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 02:13, Mason Zhang wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index b1f59a5fe632..6fe51b8d41f9 100644
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
> +		 * in case of an error, after clearing the doorbell,
> +		 * we also need to clear the task tag bit from the
> +		 * outstanding_reqs variable.
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

This patch causes the 'task_tag' bit to be cleared from outstanding_reqs 
even if ufshcd_clear_cmds() failed. I think that's wrong.

Bart.
