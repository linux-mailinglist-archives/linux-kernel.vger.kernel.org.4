Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7855BC532
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiISJUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiISJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43491CE1A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663579217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrBD4wlaONcMGYg1HxtJ7UDDQW/eU0hoafM/vqbQdC8=;
        b=RxQbX1a/JaAF7bIqsfKS/2n7UTdpvjQwdnujB+wDm+CM7uYRnbfwCCLnjtvlPNuO3P5ref
        71dY6OBA+L2OV7K+ZghrLyUzzzhbuO2B/NQ2RKDvbha/NUgN5aDAownIFKTxFePOYak2YN
        5me31JnP30IbTcQsrtiPr1MeZK/TwYQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-aoez07eUPRWWpCnuJJWcTA-1; Mon, 19 Sep 2022 05:20:16 -0400
X-MC-Unique: aoez07eUPRWWpCnuJJWcTA-1
Received: by mail-wr1-f69.google.com with SMTP id c21-20020adfa315000000b0022adc2a2edaso1392382wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VrBD4wlaONcMGYg1HxtJ7UDDQW/eU0hoafM/vqbQdC8=;
        b=UsnAey0kEeSMROlMxTPMvldbSDnKRpoemDo8jDSV3UO93g//pSA/TRzjlaBId3yNYi
         VY7GYPjCrK39CXWI5PQQiPDbJdi6rMa0+OvDzo/f8BLuyzrXg3fLQqWVLHkSJ6z2pOUx
         COo4zJe4ZyfmYHYsutC//DN50Fy7CQFWnCGpdJAREv1U4q+pQ9Fl52700DyeuOCVg23s
         3BFeB9nJganpYMilGqEZ8DSVH/5VU+Jqy2VR4o0Y1gdT/AAV2HuzV17YtoKjcTFhXZ9w
         jMlNGTkeKtYpSL0UzfSQGb1LG3lIS5t/KAVQ7vNcM42VmyL/HqLDaI9CDc6yyH77CzTv
         iXJQ==
X-Gm-Message-State: ACrzQf2Tsqc89U6OrdYik8HfrZ2/iUKe8YpOb4k+ckkvAEkztiVyxF1T
        +DLU3rlFodhVLb2fGvrEp/gmL/0lqh+7FHzihY9pBWBlfBU6bduN286ToZabGiptQwOzu6fgKgj
        okFrZuqV6EnA3Es9/p7d9ID+O
X-Received: by 2002:adf:e781:0:b0:228:b44c:d0f7 with SMTP id n1-20020adfe781000000b00228b44cd0f7mr9394668wrm.243.1663579215128;
        Mon, 19 Sep 2022 02:20:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM40gi8fb1JNpCfan1XUhRZ465bQABplaEbcoKHL65i6udarmw0EbHumnsl5dbBGjFrfeA7ndA==
X-Received: by 2002:adf:e781:0:b0:228:b44c:d0f7 with SMTP id n1-20020adfe781000000b00228b44cd0f7mr9394649wrm.243.1663579214829;
        Mon, 19 Sep 2022 02:20:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id e4-20020adfdbc4000000b00228c792aaaasm13288512wrj.100.2022.09.19.02.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 02:20:14 -0700 (PDT)
Message-ID: <93c044ca-7d2f-e23f-8eb4-72c133737a15@redhat.com>
Date:   Mon, 19 Sep 2022 11:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -v2] lib/notifier-error-inject: fix error when writing
 errno to debugfs file
Content-Language: en-US
To:     Akinobu Mita <akinobu.mita@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220917071427.28499-1-akinobu.mita@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220917071427.28499-1-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.22 09:14, Akinobu Mita wrote:
> The simple attribute files do not accept a negative value since the
> commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), so we can no longer use DEFINE_SIMPLE_ATTRIBUTE() to
> define a file operations for errno value.
> 
> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

But shouldn't we fix simple_attr_write() instead?

I mean, simple_attr_read() might use attr->fmt to print a signed value, 
but simple_attr_write() fails on signed values now?

I might be wrong, but there is a disconnect. I feel like 
simple_attr_write() should similarly make decisions based on attr->fmt.

> ---
> v2: Fix Reported-by line
> 
>   lib/notifier-error-inject.c | 38 ++++++++++++++++++++++++++++++-------
>   1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
> index 21016b32d313..30ec41f58d53 100644
> --- a/lib/notifier-error-inject.c
> +++ b/lib/notifier-error-inject.c
> @@ -3,20 +3,44 @@
>   
>   #include "notifier-error-inject.h"
>   
> -static int debugfs_errno_set(void *data, u64 val)
> +static int notifier_err_errno_show(struct seq_file *m, void *data)
>   {
> -	*(int *)data = clamp_t(int, val, -MAX_ERRNO, 0);
> +	int *value = m->private;
> +
> +	seq_printf(m, "%d\n", *value);
> +
>   	return 0;
>   }
>   
> -static int debugfs_errno_get(void *data, u64 *val)
> +static int notifier_err_errno_open(struct inode *inode, struct file *file)
>   {
> -	*val = *(int *)data;
> -	return 0;
> +	return single_open(file, notifier_err_errno_show, inode->i_private);
> +}
> +
> +static ssize_t notifier_err_errno_write(struct file *file, const char __user *ubuf, size_t len,
> +					loff_t *offp)
> +{
> +	struct seq_file *m = file->private_data;
> +	int *value = m->private;
> +	int ret;
> +
> +	ret = kstrtoint_from_user(ubuf, len, 0, value);
> +	if (ret)
> +		return ret;
> +
> +	*value = clamp(*value, -MAX_ERRNO, 0);
> +
> +	return len;
>   }
>   
> -DEFINE_SIMPLE_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
> -			"%lld\n");
> +static const struct file_operations fops_errno = {
> +	.owner = THIS_MODULE,
> +	.open = notifier_err_errno_open,
> +	.read = seq_read,
> +	.write = notifier_err_errno_write,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
>   
>   static struct dentry *debugfs_create_errno(const char *name, umode_t mode,
>   				struct dentry *parent, int *value)

-- 
Thanks,

David / dhildenb

