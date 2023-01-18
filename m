Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2DA672AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjARV7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjARV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:59:40 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143A65EFB4;
        Wed, 18 Jan 2023 13:59:40 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id y1so480091plb.2;
        Wed, 18 Jan 2023 13:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Lvd5Mvxqck3fJBa5/+a5U8omDaF2GvQNzIqnYVLL0=;
        b=g0I3M9JpaPXCdnK5sQU1LXAUREXYcKu63qOVs66rnMKDdtBc6G48p/gl5xYpO3UNwz
         aTWSed+kWYzYhvJLYVIKR7mLH+ea7M235yZIFPDACUVDbWansklQ22n+aoKjx8aNcEC7
         YVmbNenl/KeyOsCxh3m1OE88ryvMEmfXlB9JfKwusYvpgI/iJNc/UCBu/M49eacNH0nN
         slS4yO5+JveWNzELC3MGNat2/MVDyd6VglNPL/kw3FjRbdOALIDiuzqJpjQ7YuGjMffI
         8QF4T78caEK6RwYjt3cr6NSV/iQkr6EEmIUprDUt02GNQP9u3MVJC0v+y38hynfsbXno
         5JPQ==
X-Gm-Message-State: AFqh2kq9dMSw4jmP6nUCW+wZeyMBhZs2NFAYiQtoh/YyPHAvujNYF7i4
        yD4tLn/cNy3wOF/ix2Q6jsc=
X-Google-Smtp-Source: AMrXdXuAQfX7bnbd32O521ddbozFMQNiGD8+kGTXJCZGdTXWHS48iW72QMEKxv6bCZZI5ND3GbUz/g==
X-Received: by 2002:a17:902:bd83:b0:193:2bc9:eb25 with SMTP id q3-20020a170902bd8300b001932bc9eb25mr8807142pls.20.1674079179442;
        Wed, 18 Jan 2023 13:59:39 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:22ae:3ae3:fde6:2308? ([2620:15c:211:201:22ae:3ae3:fde6:2308])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b00192740bb02dsm22260907pln.45.2023.01.18.13.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:59:38 -0800 (PST)
Message-ID: <4bedb8bf-241f-03d8-9f84-1e070ab4c3d8@acm.org>
Date:   Wed, 18 Jan 2023 13:59:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/1] scsi: ufs: core: fix device management cmd timeout
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
References: <20221216032532.1280-1-mason.zhang@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221216032532.1280-1-mason.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 19:25, Mason Zhang wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index b1f59a5fe632..fa86ce80f350 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3008,6 +3008,22 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>   		} else {
>   			dev_err(hba->dev, "%s: failed to clear tag %d\n",
>   				__func__, lrbp->task_tag);
> +
> +			spin_lock_irqsave(&hba->outstanding_lock, flags);
> +			pending = test_bit(lrbp->task_tag,
> +					   &hba->outstanding_reqs);
> +			if (pending)
> +				hba->dev_cmd.complete = NULL;
> +			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
> +
> +			if (!pending) {
> +				/*
> +				 * The completion handler ran while we tried to
> +				 * clear the command.
> +				 */
> +				time_left = 1;
> +				goto retry;
> +			}
>   		}
>   	}

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
