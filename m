Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38177497C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGFI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjGFI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4441BC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688633740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtiptVHvMzNWj7OK86AmKFH74I1effK+jyGBu3N7VtM=;
        b=YRnzcskxSmlYiSwJe51YVkDwqC5MOkLyMEDICHyXe++I+Kydk5B+6DtFBhlyt4zIwiyvkm
        +Yejh0vH2w+lb8CCZ9dmJByjKVbFieH3ocmFB8xsHXSr+1s9+iOPbEBZvTBIslRgIw8xuD
        2mJ1T54/Uc0NwAbX9UqpL4KPUOBxsd8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-5qfQ8JuYNhqKEVvsdbkCAA-1; Thu, 06 Jul 2023 04:55:39 -0400
X-MC-Unique: 5qfQ8JuYNhqKEVvsdbkCAA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314394a798dso250757f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688633738; x=1691225738;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtiptVHvMzNWj7OK86AmKFH74I1effK+jyGBu3N7VtM=;
        b=Svm0zkEi1VTGg29NlZYlnmXiiM0WLP2obkfSUdqsfuf8h9tc1cdK/yDa1Hrov73Jl8
         EYR6OlrLau0CiHcrVOwfgSHkWsn6BO78HD5Oek0OdtwKYxs+LjmS0tTAGxJYxLboai8c
         k9py7rPWHeOWs5HmfQcfoyGxztTCnSYcbTq1vvad8K4Lf1vhGwFpKcK72hWtiNX01WK1
         q/V1BqBTfb4y/Rs6IFSA8uyM44wYr+4FXPoAP2sazAxzs70a4Hbqy5ZGAWHKcd+Oo3CR
         L34GRwFkfzo2LVrJVNS5N9qXOxatMihJddeaQtfB4zuNkPsBPEOI1BR31Je/mWS+5NQ3
         apXA==
X-Gm-Message-State: ABy/qLaSRqzt81G/9aHOmIOV/Uw/vTEHadXwC89VCmBxP2Mncyq0BHqS
        rVLdqSySENQpFE4VV2n/BLOkL8VIObNZd5Zbvnih78nYPlPJaRzWB+SjPp8HhcqMA55dqT1thXd
        /bbYuPVyxtz/5oYp5PtSLnWFn
X-Received: by 2002:adf:fd84:0:b0:314:a8d:2c9 with SMTP id d4-20020adffd84000000b003140a8d02c9mr1487461wrr.0.1688633738634;
        Thu, 06 Jul 2023 01:55:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfmHL4/hrNwfFY2QHgZie0XBPZya149E8ViI5Z5J/tcb8dm63kfZ9X06WtwuK0F+AYU+yPzg==
X-Received: by 2002:adf:fd84:0:b0:314:a8d:2c9 with SMTP id d4-20020adffd84000000b003140a8d02c9mr1487445wrr.0.1688633738310;
        Thu, 06 Jul 2023 01:55:38 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b00313f031876esm1301923wro.43.2023.07.06.01.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 01:55:37 -0700 (PDT)
Message-ID: <492be1c2-9078-1923-51f9-e01156455ea1@redhat.com>
Date:   Thu, 6 Jul 2023 10:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/ksm: prepare to remove the redundant ksm_merging_pages
 in procfs
Content-Language: en-US
To:     Nanyong Sun <sunnanyong@huawei.com>, akpm@linux-foundation.org
Cc:     xu.xin16@zte.com.cn, wangkefeng.wang@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230706094917.588213-1-sunnanyong@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230706094917.588213-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.23 11:49, Nanyong Sun wrote:
> Since the ksm_merging_pages information already included in
> /proc/<pid>/ksm_stat, we could remove /proc/<pid>/ksm_merging_pages
> to make the directory more clean, and can save a little bit resources.
> 
> To delete this interface more smoothly and avoid userspace break,
> retain this interface temporarily and modify its function to hint
> users to use ksm_stat instead.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>   fs/proc/base.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index eb2e498e3b8d..d080c58cbe6c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3189,14 +3189,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
>   static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
>   				struct pid *pid, struct task_struct *task)
>   {
> -	struct mm_struct *mm;
> -
> -	mm = get_task_mm(task);
> -	if (mm) {
> -		seq_printf(m, "%lu\n", mm->ksm_merging_pages);
> -		mmput(mm);
> -	}
> -
> +	seq_puts(m, "please use /proc/<pid>/ksm_stat instead\n");
>   	return 0;
>   }
>   static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,


Why do we care so much about removing 15 simple LOC? That change here 
will already mess with user space.

Sorry, but IMHO it's all not worth the churn.

-- 
Cheers,

David / dhildenb

