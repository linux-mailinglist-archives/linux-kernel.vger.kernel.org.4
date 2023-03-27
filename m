Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E783B6CB0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjC0V0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjC0V0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:26:51 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E98199C;
        Mon, 27 Mar 2023 14:26:51 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso253813pjf.0;
        Mon, 27 Mar 2023 14:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+AbrE2EWJ7PQz7DWeOuqK02oPdPI27YJdpRpH9VzJQ=;
        b=Hm0a1YclLLuaOnGC00etl+JblPRbUhPnDz/ZnNrbBGvBsHC5Lv7b2x/gOci8B2r1a5
         FrjBTJKdTEVJ+E5qEijdrMl0pGcO3o6vdughC5LewoVCOXfT4AIqelZW5CxGlJMwoB8E
         1FD2ntMIlhrH0FtGtbTvmyWaBl7/sRePXP18fqGp2KRNVgNNPTfKRPiwoOz1qF7QDjCZ
         h+nqm+4U/Ov2VhrvU6D0jZF4tQbxzLoWX7xv5AadNenLzhaq2x65ssb6lPkSEdJrCs/k
         ZAYiBctN2khv1Bpvv93VmF6zhaiqZtUXJZe2eEK6hRvD6EgJjCjmhcm5xS6nk2IA1liu
         IQuQ==
X-Gm-Message-State: AAQBX9ehpJh/09BuKoJbRTE7rzxw3xSZGwwP5vEGqFJBi4WoBAJG4uJE
        OcA8JbbMUSRJWscCBEdlQCI=
X-Google-Smtp-Source: AKy350YaUKUgKoTa0gsnLHRLizwc++xhPwRLYOpVcQtZ3RTvNBbtiihlkmuQ12r8cnXKPJ5iYIJvyQ==
X-Received: by 2002:a17:90b:4b4e:b0:23f:7e2e:fe13 with SMTP id mi14-20020a17090b4b4e00b0023f7e2efe13mr14835810pjb.0.1679952410612;
        Mon, 27 Mar 2023 14:26:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:798e:a3a0:ddc2:c946? ([2620:15c:211:201:798e:a3a0:ddc2:c946])
        by smtp.gmail.com with ESMTPSA id mv21-20020a17090b199500b0023d16f05dd8sm8011910pjb.36.2023.03.27.14.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 14:26:50 -0700 (PDT)
Message-ID: <c72dced5-fb0c-4392-b8ea-ad1ef5e1cef3@acm.org>
Date:   Mon, 27 Mar 2023 14:26:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] scsi: fix switch host state race between by sysfs and
 others
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
References: <20230325011734.507453-1-yebin@huaweicloud.com>
 <20230325011734.507453-2-yebin@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230325011734.507453-2-yebin@huaweicloud.com>
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
> Now, switch host state by sysfs isn't hold 'shost->host_lock' lock.
> It may race with other process, lead to host mixed state.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   drivers/scsi/scsi_sysfs.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index ee28f73af4d4..cc0ae5e3def3 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -202,6 +202,7 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
>   	int i;
>   	struct Scsi_Host *shost = class_to_shost(dev);
>   	enum scsi_host_state state = 0;
> +	unsigned long flags;
>   
>   	for (i = 0; i < ARRAY_SIZE(shost_states); i++) {
>   		const int len = strlen(shost_states[i].name);
> @@ -214,8 +215,13 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
>   	if (!state)
>   		return -EINVAL;
>   
> -	if (scsi_host_set_state(shost, state))
> +	spin_lock_irqsave(shost->host_lock, flags);
> +	if (scsi_host_set_state(shost, state)) {
> +		spin_unlock_irqrestore(shost->host_lock, flags);
>   		return -EINVAL;
> +	}
> +	spin_unlock_irqrestore(shost->host_lock, flags);
> +
>   	return count;
>   }

Please make sure that there is only one spin_unlock_irqrestore() call in 
this function.

Thanks,

Bart.


