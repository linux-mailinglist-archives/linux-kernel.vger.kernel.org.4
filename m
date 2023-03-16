Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321656BD457
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCPPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCPPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F72FCDD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678981791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdjkv+Dro60o5zto0WjmQhFWFoXz77DgBHrj6x+iB4E=;
        b=S8fORY6DYvhxJgpSRyHMyxt6qfG4NL40ewWgm8P0Bh4E1ZBCkeevdOZGoyCTf9pihdBxqn
        8o8Mk29AnnpgD5n0CQrMqeD6ajwpUER+x/DHEHaSVkSIeILuRqiTwtQ3PL8lXqOTdkPMRS
        kUEpvIeXvCvirpekj+2zP0lAWlFAObk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-SMXbWNA5NlmSFIB9AJTsFg-1; Thu, 16 Mar 2023 11:28:23 -0400
X-MC-Unique: SMXbWNA5NlmSFIB9AJTsFg-1
Received: by mail-wr1-f69.google.com with SMTP id u5-20020a5d6da5000000b002cd82373455so369771wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980502;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdjkv+Dro60o5zto0WjmQhFWFoXz77DgBHrj6x+iB4E=;
        b=IJ5mHt2XesTlJ4/kn5+Z0gRLFskhrNXUwa0LbWEipvPHgahioV+k800UuouHs7dm++
         OizZq0KjFAg+oGuZ/4iyFwI1JUGKC0mvg/PL5ViZCUJWGxxH74TWQ1OtytS4JsckLcmG
         ReBDFqYqubN6aibmiA7sd21SafJk4vGk9HXFcbwxNJaEGPvuhAElGwY3EHWPWlF+mdbR
         nggWZnIgZZF9WZY52K0WGm4HFpYbGq0Gv4glN4iKeekgvKjE8VapUAS3aQMR+jTwKmQ0
         6XslRf6fxiMZqGgJjNU809VXpEuCkXFGuejgON5MZtIQnnvbyIS7Sf1ocs+G2Vi5c3cz
         bhew==
X-Gm-Message-State: AO0yUKV8b9Vry/cZxvM6yX5hbCbOpAik6jevv+3mitn6VZLzfI2rsPml
        Yo/iT7RA29cZB6Rl7TLuf/sLPdpRELdVlVGjhtWrhXqGeDklx2BY82wxmKPNZ4FjK4dp02AB1BF
        U8PgES5Xq1UYs6k+NVQvBNkI4
X-Received: by 2002:a05:600c:a0a:b0:3eb:2e1e:beae with SMTP id z10-20020a05600c0a0a00b003eb2e1ebeaemr22827104wmp.25.1678980502802;
        Thu, 16 Mar 2023 08:28:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set953OhR0PSJo4Wlye88S0M6Ni6iKYVzJO5E81/ycX2kl1XkCG+PEy2QJ3Xm6J5j+tXXXFeKfA==
X-Received: by 2002:a05:600c:a0a:b0:3eb:2e1e:beae with SMTP id z10-20020a05600c0a0a00b003eb2e1ebeaemr22827088wmp.25.1678980502430;
        Thu, 16 Mar 2023 08:28:22 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c5449000000b003dc1d668866sm5273902wmi.10.2023.03.16.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 08:28:21 -0700 (PDT)
Message-ID: <e6b72d88-3011-c284-f53a-71431065b991@redhat.com>
Date:   Thu, 16 Mar 2023 16:28:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Using MAP_SHARE_VALIDATE in mmap without fd
Content-Language: en-US
To:     Nils Hartmann <nils1hartmann@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230310171617.wqnqs42l2viwjsz5@archlinux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230310171617.wqnqs42l2viwjsz5@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.23 18:16, Nils Hartmann wrote:
> Hey,
> I have a rather simple question about the MAP_SHARED_VALIDATE flag in mmap.
> When used without a file pointer, EINVAL is returned. Is there a reason for this?

You mean, using it with shared anonymous memory? (MAP_SHARED|MAP_ANON)

I assume you mean "file descriptor" not "file pointer".

> I researched a bit but could not find anything. I attached a simple patch that adds MAP_SHARE_VALIDATE to the flags switch and checks for invalid flags.
> 

The only reason MAP_SHARED_VALIDATE was introduced was due to MAP_SYNC, 
only required for DAX. DAX does not apply to shared anonymous memory.

I guess nobody cared/cares.

Question is if we want to update the implementation (there has to be a 
good reason IMHO) or simply update the man page, stating that 
MAP_SHARED_VALIDATE is not supported for MAP_ANON.

> Signed-off-by: Nils Hartmann <nils1hartmann@gmail.com>
> ---
>   mm/mmap.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 740b54be3..fd7db51af 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1196,6 +1196,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>   {
>   	struct mm_struct *mm = current->mm;
>   	vm_flags_t vm_flags;
> +	unsigned long flags_mask;
>   	int pkey = 0;
>   
>   	validate_mm(mm);
> @@ -1266,14 +1267,14 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>   	if (mlock_future_check(mm, vm_flags, len))
>   		return -EAGAIN;
>   
> +	flags_mask = LEGACY_MAP_MASK;
>   	if (file) {
>   		struct inode *inode = file_inode(file);
> -		unsigned long flags_mask;
>   
>   		if (!file_mmap_ok(file, inode, pgoff, len))
>   			return -EOVERFLOW;
>   
> -		flags_mask = LEGACY_MAP_MASK | file->f_op->mmap_supported_flags;
> +		flags_mask |= file->f_op->mmap_supported_flags;
>   
>   		switch (flags & MAP_TYPE) {
>   		case MAP_SHARED:
> @@ -1327,6 +1328,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>   		}
>   	} else {
>   		switch (flags & MAP_TYPE) {
> +		case MAP_SHARED_VALIDATE:
> +			if (flags & ~flags_mask)
> +				return -EOPNOTSUPP;
> +			fallthrough;
>   		case MAP_SHARED:
>   			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
>   				return -EINVAL;

-- 
Thanks,

David / dhildenb

