Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1685472E613
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbjFMOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbjFMOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5451732
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686667404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCAk+GrfYv2LlZeL9R4DyIt9sUEULTjaibnxzpvOXzU=;
        b=UrSyi06Ro7IWOqWp9UL7C/Y9Bm/8nLjtV/Q+j8sct40eVtfLWm+OKAWhtiVmd/TVe6+1al
        J/zYY9rAV2kusCEVIPNqLN2dBZI6Nmiyxzoo+P0D+29M0fhs+pLocEYX+9aoDNOrIJrreo
        FiJagTqxcTiUBqLj7wIq6mk2OhSYMzo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-_r6EtMvVNpSVmQp2_zvFnQ-1; Tue, 13 Jun 2023 10:43:22 -0400
X-MC-Unique: _r6EtMvVNpSVmQp2_zvFnQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-25bd6f23032so2056737a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686667401; x=1689259401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qCAk+GrfYv2LlZeL9R4DyIt9sUEULTjaibnxzpvOXzU=;
        b=FOwGVUDV/7klIcTXiBqcPv6Q+RkdVZlnhkyZ69FE9W+i+fHhC0vdxDMIZDrdoRHzfn
         SDMMaRDc1oAbz5knm1LNvotj1yaqzTDa8aOh1uL1w4lByDVHhnnSjbPpppj4N+zY7Cax
         uIpI8B/UIVEZzajdKU8SxluERECsVAjGcVu30aY3reIqHLraDBUtg02Lug+SZBQuZOMH
         W/ulKYtog9G3S+zezK4hR3O3huktOYe9GHSXsEaIZiwyQHqCGsryP9MCe6pjgSogolbG
         fnuAcDbCQaHL5cjO/UwCuJz67nuzVO5ZOX5y5bcNjpEJP0beayN6WGbm88bvgM/m5A/K
         Q6ZQ==
X-Gm-Message-State: AC+VfDxjBawPIbyt0Fe49rKQznJxzcL+ndKP5cXHJkt3jaB/Lb8hWIy7
        JIKy/a/N2qcMU0Zfp/SQ+e/3tlOf5Z8UK1QTI53ORY4tR2CXXsFY9lxqtU8CY2d51VNnI1gfLJS
        g88MT8M1tUJ9PLeKK1zGm+/f1
X-Received: by 2002:a17:90b:364c:b0:25b:e311:14b9 with SMTP id nh12-20020a17090b364c00b0025be31114b9mr5583551pjb.29.1686667401476;
        Tue, 13 Jun 2023 07:43:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pzDK/dX7LQKc/Z1gmMKhXdFjH/ZJbgm6TymQSc9JNchoVhSaDhMC+a+dsmHcntgyeQR8+DA==
X-Received: by 2002:a17:90b:364c:b0:25b:e311:14b9 with SMTP id nh12-20020a17090b364c00b0025be31114b9mr5583529pjb.29.1686667401155;
        Tue, 13 Jun 2023 07:43:21 -0700 (PDT)
Received: from [10.72.13.126] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s23-20020a17090a1c1700b0025be4c602d5sm4095009pjs.38.2023.06.13.07.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 07:43:20 -0700 (PDT)
Message-ID: <c96f2604-e1ef-c3ad-9d15-5e0efa5f222b@redhat.com>
Date:   Tue, 13 Jun 2023 22:43:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [dm-devel] [PATCH -next v2 3/6] md: add a mutex to synchronize
 idle and frozen in action_store()
To:     Yu Kuai <yukuai1@huaweicloud.com>, guoqing.jiang@linux.dev,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-4-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
In-Reply-To: <20230529132037.2124527-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/29 下午9:20, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently, for idle and frozen, action_store will hold 'reconfig_mutex'
> and call md_reap_sync_thread() to stop sync thread, however, this will
> cause deadlock (explained in the next patch). In order to fix the
> problem, following patch will release 'reconfig_mutex' and wait on
> 'resync_wait', like md_set_readonly() and do_md_stop() does.
>
> Consider that action_store() will set/clear 'MD_RECOVERY_FROZEN'
> unconditionally, which might cause unexpected problems, for example,
> frozen just set 'MD_RECOVERY_FROZEN' and is still in progress, while
> 'idle' clear 'MD_RECOVERY_FROZEN' and new sync thread is started, which
> might starve in progress frozen. A mutex is added to synchronize idle
> and frozen from action_store().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 5 +++++
>   drivers/md/md.h | 3 +++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 23e8e7eae062..63a993b52cd7 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -644,6 +644,7 @@ void mddev_init(struct mddev *mddev)
>   	mutex_init(&mddev->open_mutex);
>   	mutex_init(&mddev->reconfig_mutex);
>   	mutex_init(&mddev->delete_mutex);
> +	mutex_init(&mddev->sync_mutex);
>   	mutex_init(&mddev->bitmap_info.mutex);
>   	INIT_LIST_HEAD(&mddev->disks);
>   	INIT_LIST_HEAD(&mddev->all_mddevs);
> @@ -4785,14 +4786,18 @@ static void stop_sync_thread(struct mddev *mddev)
>   
>   static void idle_sync_thread(struct mddev *mddev)
>   {
> +	mutex_lock(&mddev->sync_mutex);
>   	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>   	stop_sync_thread(mddev);
> +	mutex_unlock(&mddev->sync_mutex);
>   }
>   
>   static void frozen_sync_thread(struct mddev *mddev)
>   {
> +	mutex_init(&mddev->delete_mutex);


typo error? It should be mutex_lock(&mddev->sync_mutex); ?

Regards

Xiao

>   	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>   	stop_sync_thread(mddev);
> +	mutex_unlock(&mddev->sync_mutex);
>   }
>   
>   static ssize_t
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index bfd2306bc750..2fa903de5bd0 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -537,6 +537,9 @@ struct mddev {
>   	/* Protect the deleting list */
>   	struct mutex			delete_mutex;
>   
> +	/* Used to synchronize idle and frozen for action_store() */
> +	struct mutex			sync_mutex;
> +
>   	bool	has_superblocks:1;
>   	bool	fail_last_dev:1;
>   	bool	serialize_policy:1;

