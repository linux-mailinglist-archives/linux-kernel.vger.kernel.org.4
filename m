Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187A56A746B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCATqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCATqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:46:36 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3728448E02;
        Wed,  1 Mar 2023 11:46:35 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id i5so13500539pla.2;
        Wed, 01 Mar 2023 11:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hf+42KJO5LFizRDAuwRPl7+jvCnJqHf1aSZK2NWYkeY=;
        b=Qe7lqU3Y3bR53Vc4ZjF0KuwWrCbFNwYbAzUIUgmP6o3VUFMv4WHdxQT950+T8HRsDW
         VfhnLnYGeytp6x2P8Xs76PN7IYKT1RskpfJrzFti7AhZQEYfjBgdeJsN4rfpiC2hoqD+
         9zzP3ETybXtUvoPNsJcyhTHfgHy+q9ownXEW5XLV0bFa2Cv282vAT8DZAKQl42EB6Z/l
         MSD1FgeXB1xLS19HOWDwPwfKiB/uGGEZRJ+Vx0ekXr73cfXA4XNl9QVMI86tSVFzwETy
         fJ2QGBnIfdajCxOLH++vVWlRu62dpvkGpr3STL2mqXsCKowPCPY6QxSLrZpl88MaWgmp
         rgaA==
X-Gm-Message-State: AO0yUKUISYWRIsNfZ3S5eOwj2cxKYX1mi462DwnW/5ZUuztGL/Btbp/k
        ujAqm2KcMhJJSwXQphGDYVM=
X-Google-Smtp-Source: AK7set8mIs/ZmhfeWligGGZXNy5JUHbph/xXJ8FLpz9j/9cfilwKK3fU/hN9uZDEMlWdDNrAJJlIDA==
X-Received: by 2002:a05:6a20:7a97:b0:c7:249:cd8c with SMTP id u23-20020a056a207a9700b000c70249cd8cmr7196428pzh.5.1677699994483;
        Wed, 01 Mar 2023 11:46:34 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:e8e:76a3:8425:6d37? ([2620:15c:211:201:e8e:76a3:8425:6d37])
        by smtp.gmail.com with ESMTPSA id o11-20020a65614b000000b005039c35225bsm1492893pgv.94.2023.03.01.11.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 11:46:33 -0800 (PST)
Message-ID: <5cf19e69-b851-abe9-9496-bbba33109404@acm.org>
Date:   Wed, 1 Mar 2023 11:46:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH-next] scsi: fix use-after-free problem in
 scsi_remove_target
Content-Language: en-US
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com
References: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
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

On 2/12/23 19:43, Zhong Jinghua wrote:
> T0							T1
>   sdev_store_delete
>    scsi_remove_device
>     device_remove_file
>      __scsi_remove_device
>          					__iscsi_unbind_session
>          					 scsi_remove_target
> 						  spin_lock_irqsave
>          					  list_for_each_entry
>       scsi_target_reap // starget->reaf 1 -> 0

What is "reaf"? Did you perhaps want to write "reap_ref"?

> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index e7893835b99a..0ad357ff4c59 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1561,7 +1561,17 @@ void scsi_remove_target(struct device *dev)
>   		    starget->state == STARGET_CREATED_REMOVE)
>   			continue;
>   		if (starget->dev.parent == dev || &starget->dev == dev) {
> -			kref_get(&starget->reap_ref);
> +
> +			/*
> +			 * If starget->reap_ref is reduced to 0, it means
> +			 * that other processes are releasing it and
> +			 * there is no need to delete it again
> +			 */
> +			if (!kref_get_unless_zero(&starget->reap_ref)) {
> +				spin_unlock_irqrestore(shost->host_lock, flags);
> +				goto restart;
> +			}
> +
>   			if (starget->state == STARGET_CREATED)
>   				starget->state = STARGET_CREATED_REMOVE;
>   			else

The above comment should be made more clear, e.g. as follows: "If the 
reference count is already zero, skip this target. Calling 
kref_get_unless_zero() if the reference count is zero is safe because 
scsi_target_destroy() will wait until the host lock has been released 
before freeing starget."

Otherwise this patch looks fine to me.

Thanks,

Bart.

