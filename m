Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186106CB09E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjC0VZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC0VZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:25:37 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22455173E;
        Mon, 27 Mar 2023 14:25:37 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id o11so9772738ple.1;
        Mon, 27 Mar 2023 14:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+hWlMy+WTq4KqDPKevShzQK5+YLsZ35eRs3qtTHtNE=;
        b=3eFuHpcjtKoJoPbREpyMnztgs7KUPHnYlqriqNNauMPIY1/fkvZvLpU6Q9KUlAnho9
         ZDh8xLJlfyN/vM82ocIOKMrQthticF/9TeRYhq/ZiOamQpLragxAosXF3sxikLkADnE9
         tb5HgJi51fB5jy+zi/R8eAbyJXsEg5PFV097ijzS7xklm2L0lttweKCdNAc0DJOtx9bz
         5zrUIhwBy/2TQIBuLERpXE7WKPBAanG/6yHib4jbyLF1pvAJXaTHOna9LlTBAAnfEHW0
         WaSfb9p/atPnewdsgBrdgu7fUJgze/V8Sfg4GcHy1yeeJybM8xb65fG7+mdxtbEXHVne
         tN/A==
X-Gm-Message-State: AAQBX9fOL8mjTqy5vewS/NSxiPWOJrs1lVTzwIVIXidGq6utBdVWa+PJ
        pW13A3XVmnSwk00F3fV2lDk=
X-Google-Smtp-Source: AKy350ZwOUWKgbKOOim0MTzjxlTJK3v74GbGhJyLYE+2fsi7KxHkpJq05fTGFOMZ0xS0FkofV016PA==
X-Received: by 2002:a17:90b:4f47:b0:23d:2f73:d3c8 with SMTP id pj7-20020a17090b4f4700b0023d2f73d3c8mr15130777pjb.42.1679952336480;
        Mon, 27 Mar 2023 14:25:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:798e:a3a0:ddc2:c946? ([2620:15c:211:201:798e:a3a0:ddc2:c946])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001a1bf30cef1sm16668218plb.46.2023.03.27.14.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 14:25:36 -0700 (PDT)
Message-ID: <50fa480e-4c0e-70f2-5185-1d83df9f9e13@acm.org>
Date:   Mon, 27 Mar 2023 14:25:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] scsi: limit to set the host state
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
References: <20230325011734.507453-1-yebin@huaweicloud.com>
 <20230325011734.507453-4-yebin@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230325011734.507453-4-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 18:17, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, we can set the host state with any value. Actually, it doesn't
> make sense. As previous patch introduce SHOST_BLOCKED state, set this
> state, it will blocking IO. So this patch limit to set the host with
> running/blocked state.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   drivers/scsi/scsi_sysfs.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index b14f95ac594e..42c5936c7711 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -203,6 +203,7 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
>   	int i;
>   	struct Scsi_Host *shost = class_to_shost(dev);
>   	enum scsi_host_state state = 0;
> +	enum scsi_host_state old_state;
>   	unsigned long flags;
>   
>   	for (i = 0; i < ARRAY_SIZE(shost_states); i++) {
> @@ -216,8 +217,13 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
>   	if (!state)
>   		return -EINVAL;
>   
> +	if (state != SHOST_RUNNING && state != SHOST_BLOCKED)
> +		return -EINVAL;
> +
>   	spin_lock_irqsave(shost->host_lock, flags);
> -	if (scsi_host_set_state(shost, state)) {
> +	old_state = shost->shost_state;
> +	if ((old_state != SHOST_RUNNING && old_state != SHOST_BLOCKED) ||
> +	    scsi_host_set_state(shost, state)) {
>   		spin_unlock_irqrestore(shost->host_lock, flags);
>   		return -EINVAL;
>   	}

Please make sure that the "state != SHOST_RUNNING && state != 
SHOST_BLOCKED" check occurs only once and also that there is one 
spin_lock_irqsave() call in this function and only one 
spin_unlock_irqrestore() call.

Thanks,

Bart.
