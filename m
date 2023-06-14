Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B672F62B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbjFNHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbjFNHX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87822D64
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686727257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Cv1JzRA0ITaFwqMsVLtSdeb5FcnnDYorlxptC0NsHg=;
        b=Icizhaj/57uxCaDYeCYl2eqTBvbcdQyy31ZwAUVerB7NwOJOmBtyNA2scwmViZa1+hW1DH
        gMFdEMBl4rES+wKFUOnVl9eiiFi5rgmlsrWu0Aaf4aC++uKTw5QBzwcfTtwjCMr7P2VPJR
        hEcFsb9sXtF/Af7g6ffqbZcqT/Ifl1o=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-dt5PutsXNZGNpoMVFUK-9w-1; Wed, 14 Jun 2023 03:20:53 -0400
X-MC-Unique: dt5PutsXNZGNpoMVFUK-9w-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-53425d37fefso3072303a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686727252; x=1689319252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Cv1JzRA0ITaFwqMsVLtSdeb5FcnnDYorlxptC0NsHg=;
        b=d4l+tM6JKoWhJ1r96TA/t3uqjof+1RgCnxyMYjWmx78YDL1CrDA9c6nbMDw5/NXo1M
         DNU2rLJK4+rGolfJ8q5CdxlPoBBkviMUd4+eBwKIqk+VeZBKm+dn2X8IPWFfzVufZjZ4
         WPGfH16H/+KyV15CweqYQDmhNaTYGXt7Sw+D4y6NmtFMDX72UuyhZz9mFWbEGyjKnjSh
         Q5llc+wqsGH2cZFniJzs6Rz93We73bJ1AdltDYLl1KFnvwG8nVsT+XTfFATr6GRLZo2m
         L89dR4x0eYKgcOIYoi3+UngBNk/Sx2p4H3w+ocdQkljhpEtjTWEk3tozkRMD5COW4SJl
         EPQg==
X-Gm-Message-State: AC+VfDxhTxiAd8ZK9rNBJba/M5vF2v/0MXIUOqt9Nmo7lZOiPUEyYmSc
        dKMq0bRrSmsqY5QobHbl4Z2lDX7U4SoM42/Fcsd9Z3UdbFfkPnELDLaAomumoLZNtVSt1obNV8k
        CsDKQEmguqvMc3jLSeCTw3yWr
X-Received: by 2002:a17:903:2347:b0:1b1:99c9:8ce1 with SMTP id c7-20020a170903234700b001b199c98ce1mr11789019plh.51.1686727252669;
        Wed, 14 Jun 2023 00:20:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GCfs2iEd+UlGYv0S1z3ZGoD/fIDkPq52+kCuyNgIKUbm8u8+z+d39yf6mgV5s26EGgf7Cfw==
X-Received: by 2002:a17:903:2347:b0:1b1:99c9:8ce1 with SMTP id c7-20020a170903234700b001b199c98ce1mr11789010plh.51.1686727252401;
        Wed, 14 Jun 2023 00:20:52 -0700 (PDT)
Received: from [10.72.13.126] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902a71000b001b061dcdb6bsm11447933plq.28.2023.06.14.00.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 00:20:52 -0700 (PDT)
Message-ID: <79c170e2-35d9-5671-7b3d-377750c140bb@redhat.com>
Date:   Wed, 14 Jun 2023 15:20:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH -next v2 5/6] md: wake up 'resync_wait' at last in
 md_reap_sync_thread()
To:     Yu Kuai <yukuai1@huaweicloud.com>, guoqing.jiang@linux.dev,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-6-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
In-Reply-To: <20230529132037.2124527-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/29 下午9:20, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> md_reap_sync_thread() is just replaced with wait_event(resync_wait, ...)
> from action_store(), just make sure action_store() will still wait for
> everything to be done in md_reap_sync_thread().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 7912de0e4d12..f90226e6ddf8 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9531,7 +9531,6 @@ void md_reap_sync_thread(struct mddev *mddev)
>   	if (mddev_is_clustered(mddev) && is_reshaped
>   				      && !test_bit(MD_CLOSING, &mddev->flags))
>   		md_cluster_ops->update_size(mddev, old_dev_sectors);
> -	wake_up(&resync_wait);
>   	/* flag recovery needed just to double check */
>   	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	sysfs_notify_dirent_safe(mddev->sysfs_completed);
> @@ -9539,6 +9538,7 @@ void md_reap_sync_thread(struct mddev *mddev)
>   	md_new_event();
>   	if (mddev->event_work.func)
>   		queue_work(md_misc_wq, &mddev->event_work);
> +	wake_up(&resync_wait);
>   }
>   EXPORT_SYMBOL(md_reap_sync_thread);
>   


Reviewd-by: Xiao Ni <xni@redhat.com>

