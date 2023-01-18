Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E41C671FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjAROl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAROlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:41:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75AF2C642
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674052281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZJOxLnmkEvZGZ/FgYrJ/gq7makso9s4WdJRv05FlCs=;
        b=FaynD6Ww7PggX5rzV3xoomz11PSvon45nphbQu0hRH3xwPDVIB+H5FbDt9X4kCfkdp6bSJ
        73u/JWtC1TWjMwLuYi9WqqtypmYFpxMSqcouGKyeDbjiKMY4NuT1SoEMap5itR4AdLTF74
        CB6PU4vO/RReejxTewfk5hVyA3eU1Ck=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-TYBasntbNIiO1hVEDrlU4A-1; Wed, 18 Jan 2023 09:31:19 -0500
X-MC-Unique: TYBasntbNIiO1hVEDrlU4A-1
Received: by mail-wr1-f69.google.com with SMTP id v5-20020adf8b45000000b002bde0366b11so368749wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZJOxLnmkEvZGZ/FgYrJ/gq7makso9s4WdJRv05FlCs=;
        b=7ypsPAvuNia2LAanKssK4wuklqvAstJt+YmB0mcAtqkzzsf7iEVcWGnhAuoxryoh6t
         DUOVWtB/5ZLXRRpR3fbtdYconPJwuJc3YRsVCvyIOSnHPqeWBPiNTsODF3tePSVjrQqk
         cNwwn8QvWQZEC847uK244A27uH01fRcdEdMbIDezqBR6EA1GWykMsZGmCkQFxJHgiraw
         ApaG81ycpeG8KUt0FLcVe5i10f/vshXgAtpdApGIAOa8oCJnc3jGIpz78263RstpU+2n
         oDdrcNPWtH1Lqd8mJ2er2Z0trsg2q+5aHBldaTVHyksqsxiib2v7Ft4UzroBBjejYblr
         W8OQ==
X-Gm-Message-State: AFqh2krA2PmMlR2ZCFrUryOuvvFE8M9eZcnOgoJPEAibjJSVVxD1o9fu
        MbqQRT5/RPhZjjyy3sonzwOtwBcj2UNXj1tJN6H/ruX2EGLxWHvJyMiMFarckx+iMFq06SPTdQa
        OkwRsK52KeWkx/Uq/rQqcbmpr
X-Received: by 2002:a05:600c:1508:b0:3d3:5166:2da4 with SMTP id b8-20020a05600c150800b003d351662da4mr7009879wmg.8.1674052278233;
        Wed, 18 Jan 2023 06:31:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsth3/hCFmCk0CHrLL4sAw6wLN3YDRV43ECbmf5dcJXsZ/th3eShzA76PWIJL/IQZihhGpC9Q==
X-Received: by 2002:a05:600c:1508:b0:3d3:5166:2da4 with SMTP id b8-20020a05600c150800b003d351662da4mr7009855wmg.8.1674052277937;
        Wed, 18 Jan 2023 06:31:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:800:1a88:f98a:d223:c454? (p200300cbc70508001a88f98ad223c454.dip0.t-ipconnect.de. [2003:cb:c705:800:1a88:f98a:d223:c454])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm13524925wrr.20.2023.01.18.06.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:31:17 -0800 (PST)
Message-ID: <688bd1cb-0b4c-3b4f-6af9-7a07da3d16fa@redhat.com>
Date:   Wed, 18 Jan 2023 15:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 4/6] ksm: count zero pages for each process
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202212300916292181912@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202212300916292181912@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.22 02:16, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> As the number of ksm zero pages is not included in ksm_merging_pages per
> process when enabling use_zero_pages, it's unclear of how many actual
> pages are merged by KSM. To let users accurately estimate their memory
> demands when unsharing KSM zero-pages, it's necessary to show KSM zero-
> pages per process.
> 
> since unsharing zero pages placed by KSM accurately is achieved, then
> tracking empty pages merging and unmerging is not a difficult thing any
> longer.
> 
> Since we already have /proc/<pid>/ksm_stat, just add the information of
> zero_pages_sharing in it.
> 
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>   fs/proc/base.c           | 1 +
>   include/linux/mm_types.h | 7 ++++++-
>   mm/ksm.c                 | 2 ++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..ac9ebe972be0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3207,6 +3207,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   	mm = get_task_mm(task);
>   	if (mm) {
>   		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
> +		seq_printf(m, "zero_pages_sharing %lu\n", mm->ksm_zero_pages_sharing);
>   		mmput(mm);
>   	}
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4e1031626403..5c734ebc1890 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -776,7 +776,7 @@ struct mm_struct {
>   #ifdef CONFIG_KSM
>   		/*
>   		 * Represent how many pages of this process are involved in KSM
> -		 * merging.
> +		 * merging (not including ksm_zero_pages_sharing).
>   		 */
>   		unsigned long ksm_merging_pages;
>   		/*
> @@ -784,6 +784,11 @@ struct mm_struct {
>   		 * including merged and not merged.
>   		 */
>   		unsigned long ksm_rmap_items;
> +		/*
> +		 * Represent how many empty pages are merged with kernel zero
> +		 * pages when enabling KSM use_zero_pages.
> +		 */
> +		unsigned long ksm_zero_pages_sharing;

Same comment as for previous patch: this counts rmap itmaps, no? 
ksm_zero_rmap_items might be more appropriate.

-- 
Thanks,

David / dhildenb

