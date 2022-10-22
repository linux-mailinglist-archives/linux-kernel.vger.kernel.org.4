Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F59608C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiJVLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJVLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309682D940F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666434783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odmDeDwQVjher/qM3oM9cGdcAm/X6A1KhHi4v9Q2U1k=;
        b=bKzeLpU4I2gtRsgn+7QInweC+U+i6c+lE8qL+BvlWSNef58i9NC6UFfup7SXlarAmar0Wg
        OaWIVt9lFTXxAlL8LB4k/Oar2ji7RzhKJA2BfYB1/3jZbnj870wSE+uXpLX1+xPYvSzGxZ
        f5VYUcWJiRj/SDoD96+Uq5Vh03czPi4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-302-xedZt-LIMGWiqEZtWGENMQ-1; Sat, 22 Oct 2022 05:09:01 -0400
X-MC-Unique: xedZt-LIMGWiqEZtWGENMQ-1
Received: by mail-ed1-f72.google.com with SMTP id m20-20020a056402511400b0045da52f2d3cso4986163edd.20
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odmDeDwQVjher/qM3oM9cGdcAm/X6A1KhHi4v9Q2U1k=;
        b=S2wHx2C80419Xq4iyqsTTyQQbMuKEcuItTL1swlh/zGffsIQn46GyNxcoMeFurVSag
         GjqIIlYUvNLk/gETceSkidxX6asYgUN6ua6iUfAdtwU6Oq7W3AX1GXJb7XYQ8NWU3r6S
         gCLVikLbWm/SEKOlzgitWQnQa6g/rRjpfdnhxFU7QwTmkXJs/JPcs/AvNdHup76jS1ct
         kjBjTbtszt4gEtllbk9WTKxiocMml7uip3nQcwzXJ1Zq0xC+y287/VUPyl7d7kcfrQdB
         lBf7xNjXmrnzf8klRGKjJH4tGXcH+u0eiUBKQQQi0H/ng1dhspKV3yS4UGuixyt8rHNS
         l5/w==
X-Gm-Message-State: ACrzQf3ybouTGUr2gZJri9E7ePG+iuCpjsLqb38JXfX1tNGXjkjV25kv
        /dMzp1WKEPquKgNS8Rr4q8P4UyaeprEZWWfg9LNPF+EYYV8amYuSB1SsjDU6I2yCR22OPOKGIJw
        gvqJiOVsQc3v06YW5cOE3vLcC
X-Received: by 2002:a17:907:808:b0:730:54cc:b597 with SMTP id wv8-20020a170907080800b0073054ccb597mr19086045ejb.434.1666429740459;
        Sat, 22 Oct 2022 02:09:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5wEhhR2mnLJxetCB4SBQ0vEMlRcc1Nv8fTyENEUMtmBOswEAYXdwj/+tYLUYoPRamA0FH1xw==
X-Received: by 2002:a17:907:808:b0:730:54cc:b597 with SMTP id wv8-20020a170907080800b0073054ccb597mr19086033ejb.434.1666429740217;
        Sat, 22 Oct 2022 02:09:00 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id t5-20020a056402524500b0045726e8a22bsm15111235edd.46.2022.10.22.02.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 02:08:59 -0700 (PDT)
Message-ID: <f9327f38-72b3-bf65-a318-bf5982364c15@redhat.com>
Date:   Sat, 22 Oct 2022 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 2/2] KVM: debugfs: Return retval of simple_attr_open()
 if it fails
Content-Language: en-US
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <5ddb7c97d2f1edbd000020aa842b0619374e6951.1665975828.git.houwenlong.hwl@antgroup.com>
 <69d64d93accd1f33691b8a383ae555baee80f943.1665975828.git.houwenlong.hwl@antgroup.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <69d64d93accd1f33691b8a383ae555baee80f943.1665975828.git.houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 05:06, Hou Wenlong wrote:
> Although simple_attr_open() fails only with -ENOMEM with current code
> base, it would be nicer to return retval of simple_attr_open() directly
> in kvm_debugfs_open().
> 
> No functional change intended.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>   virt/kvm/kvm_main.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e30f1b4ecfa5..f7b06c1e8827 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5398,6 +5398,7 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
>   			   int (*get)(void *, u64 *), int (*set)(void *, u64),
>   			   const char *fmt)
>   {
> +	int ret;
>   	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
>   					  inode->i_private;
>   
> @@ -5409,15 +5410,13 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
>   	if (!kvm_get_kvm_safe(stat_data->kvm))
>   		return -ENOENT;
>   
> -	if (simple_attr_open(inode, file, get,
> -		    kvm_stats_debugfs_mode(stat_data->desc) & 0222
> -		    ? set : NULL,
> -		    fmt)) {
> +	ret = simple_attr_open(inode, file, get,
> +			       kvm_stats_debugfs_mode(stat_data->desc) & 0222
> +			       ? set : NULL, fmt);
> +	if (ret)
>   		kvm_put_kvm(stat_data->kvm);
> -		return -ENOMEM;
> -	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int kvm_debugfs_release(struct inode *inode, struct file *file)

Queued, thanks.

Paolo

