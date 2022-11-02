Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25198616B31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiKBRt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKBRtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACE65F1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667411305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pe1MTRhzbzYJXNC8ZzbEb7/kFiwr8hS1jq1jIPOUpDg=;
        b=hjCsLQg1tpyHdNku0T0k46jLFCPRfqv/dCW0YpmVjpza0u4axdDBQP54zUoaBFw5VJ2U4Z
        ctc9P6uxurS3W2cw+TuhF7SjymGFHoV/Po7+spLRaV/GOUQhbYxr4766YnGXiURlKBda3o
        AxQyXegcJtOBJVgIjRdt+0wbe+hn08o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-S3QHjisAMeqd9YS53Xb9KA-1; Wed, 02 Nov 2022 13:48:24 -0400
X-MC-Unique: S3QHjisAMeqd9YS53Xb9KA-1
Received: by mail-ed1-f70.google.com with SMTP id t4-20020a056402524400b004620845ba7bso12485287edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pe1MTRhzbzYJXNC8ZzbEb7/kFiwr8hS1jq1jIPOUpDg=;
        b=l/cxulFMtcOB5BtDZRwNtwqhBmvWzg5+pMYixZtYj56CGNr38cm/jnQwRDl2xWI1Te
         HxmDcyAzDXtycrvV6vxD2ocC/po3shVyWhKf/KwjBruIjvH5ylSe2MDbVbvz+qOkXS68
         ZHh89F96lopeK5ex5JboVr73skGUroIHsKokv8BMaxXjhmsiaPw/V67cDJrn5kVLxr0T
         yAuRtedu/4h1YTsT+F+4ZLwnuX1pRejIjisxFx1LUZpsQHVI+4O7AlnjkZN6N9cxdLj6
         VFtevKJPeY4AbileYjgyZ4ew5Q7giC8aBgK5npskcIIQEFSGxdfsfE/hsZtnx93T2I/n
         2jYg==
X-Gm-Message-State: ACrzQf1mXdH5zbsNLk/LVPUqJ0IZoXMVa8k1RnGHMP1IEMNEaQtkwHTb
        3S0/hWeJkFAlAVi6q7pCq80jWWatDz+OO4+1bEt3q8qx9VY3z6RBFzrGeOF8i7Tgc266qLgvnxz
        U78Suf4+9P0VvKYg5gvfI419b
X-Received: by 2002:a17:907:25c5:b0:782:978d:c3da with SMTP id ae5-20020a17090725c500b00782978dc3damr23904934ejc.623.1667411303029;
        Wed, 02 Nov 2022 10:48:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM74RsEKYfiF1K+ilXBz5IRpRcQ6QbazxTl4W61C8I2sNbPLEdiwQWWgWPW6e/198iHCZuLjvw==
X-Received: by 2002:a17:907:25c5:b0:782:978d:c3da with SMTP id ae5-20020a17090725c500b00782978dc3damr23904917ejc.623.1667411302805;
        Wed, 02 Nov 2022 10:48:22 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id f17-20020a05640214d100b0044e937ddcabsm6106057edx.77.2022.11.02.10.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:48:22 -0700 (PDT)
Message-ID: <c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com>
Date:   Wed, 2 Nov 2022 18:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] KVM: replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101072506.7307-1-liubo03@inspur.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221101072506.7307-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 08:25, Bo Liu wrote:
> Fix the following coccicheck warning:
>    virt/kvm/kvm_main.c:3847:0-23: WARNING
>      vcpu_get_pid_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   virt/kvm/kvm_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f1df24c2bc84..3f383f27d3d7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3844,7 +3844,7 @@ static int vcpu_get_pid(void *data, u64 *val)
>   	return 0;
>   }
>   
> -DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
>   
>   static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
>   {

If you really wanted to do this, you would also have to replace 
debugfs_create_file with debugfs_create_file_unsafe.

However, this is not a good idea.  The rationale in the .cocci file is 
that "DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file() imposes some 
significant overhead", but this should not really be relevant for a 
debugfs file.

Such a patch would only make sense if there was a version of 
debugfs_create_file_unsafe() with a less-terrible name (e.g. 
debugfs_create_simple_attr?), which could _only_ be used with fops 
created by DEFINE_DEBUGFS_ATTRIBUTE.  Without such a type-safe trick, 
the .cocci file is only adding confusion to perfectly fine code.

Paolo

