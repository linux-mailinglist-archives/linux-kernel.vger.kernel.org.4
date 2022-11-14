Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C562759A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiKNFof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiKNFoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:44:34 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C5167D5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 21:44:33 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id y16so16085835wrt.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 21:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eahHoyYY2/MA8pX352vot2tyai1ojMXDBKok48YZJLI=;
        b=eKXSSjy+TIdqTD4B/Z69fqT9zIeDuUSJ+/fIhx+lcLmPhhg/S6AixTVZar3WmstrCF
         NQZFsK95xu2hidcKIzhcS0fUjOe9Pw2VqFbJD5fenLJ92Emevhff2eDHejAX9wN+5eBz
         GK8fOozzunxWbm7kCqdW7mN/O7gEWwiabn6W261Ir/SUjT4P5blrXhlXwbUmHUqi2Muv
         ik/a5zP1R/SgjGVMFkuslwIdxxqc3aGpaXFjNAAetIMDWHXyOOVefVkttQ8gB/TgUnm9
         +fDqe6ONB6CrXxvziY0IHhLajEMVs1B4tN8sJTB6efuGfyfzLf/A8WC8zD2Y08DUlG06
         wngg==
X-Gm-Message-State: ANoB5pkIbw1gIZejmrfc9vLgLZeORnUx7UKLjhatGP2IGOK2f3yyTxk+
        j5Aqy8AfX4JYPN4Cq0NGV5o=
X-Google-Smtp-Source: AA0mqf6Ye/k0Iru+IohDyksDVsPSSjtFPeeXH3+W+z6/WybcP+wQwrUU7HnUtAcYgT0rdSW/TLCe4w==
X-Received: by 2002:a5d:4704:0:b0:234:d11b:5f7a with SMTP id y4-20020a5d4704000000b00234d11b5f7amr6624244wrq.311.1668404671582;
        Sun, 13 Nov 2022 21:44:31 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003b49bd61b19sm18262140wmb.15.2022.11.13.21.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 21:44:31 -0800 (PST)
Message-ID: <70fe0136-87ab-ed6c-8d65-d57ecbdcdf2f@kernel.org>
Date:   Mon, 14 Nov 2022 06:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] tty: synclink_gt: release resources when synclink_gt
 driver open failed
Content-Language: en-US
To:     Zhengchao Shao <shaozhengchao@huawei.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, paulkf@microgate.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221114010734.314910-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 11. 22, 2:07, Zhengchao Shao wrote:
> When synclink_gt driver open failed, it doesn't release resources.

But hdlc_close() does. Now, you call it (apart from the TTY layer) too.

> Compile tested only.

Hmm, NACK.

> Fixes: d4c63b7c7450 ("synclink_gt fix module reference")
> Fixes: 705b6c7b34f2 ("[PATCH] new driver synclink_gt")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   drivers/tty/synclink_gt.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 25e9befdda3a..4dea52486410 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -1441,14 +1441,15 @@ static int hdlcdev_open(struct net_device *dev)
>   	/* generic HDLC layer open processing */
>   	rc = hdlc_open(dev);
>   	if (rc)
> -		return rc;
> +		goto err_open;
>   
>   	/* arbitrate between network and tty opens */
>   	spin_lock_irqsave(&info->netlock, flags);
>   	if (info->port.count != 0 || info->netcount != 0) {
>   		DBGINFO(("%s hdlc_open busy\n", dev->name));
>   		spin_unlock_irqrestore(&info->netlock, flags);
> -		return -EBUSY;
> +		rc = -EBUSY;
> +		goto err_open_busy;
>   	}
>   	info->netcount=1;
>   	spin_unlock_irqrestore(&info->netlock, flags);
> @@ -1458,7 +1459,7 @@ static int hdlcdev_open(struct net_device *dev)
>   		spin_lock_irqsave(&info->netlock, flags);
>   		info->netcount=0;
>   		spin_unlock_irqrestore(&info->netlock, flags);
> -		return rc;
> +		goto err_open_busy;
>   	}
>   
>   	/* assert RTS and DTR, apply hardware settings */
> @@ -1478,6 +1479,12 @@ static int hdlcdev_open(struct net_device *dev)
>   	else
>   		netif_carrier_off(dev);
>   	return 0;
> +
> +err_open_busy:
> +	hdlc_close(dev);
> +err_open:
> +	module_put(THIS_MODULE);
> +	return rc;
>   }
>   
>   /**

-- 
js
suse labs

