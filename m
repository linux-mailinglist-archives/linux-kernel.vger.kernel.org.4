Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52867C486
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 07:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjAZGjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 01:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZGjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 01:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACEA51421
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 22:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674715139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwnaW40wODo/RPJeJh2TlciTsJYMAL7AVIWQnJnbBqw=;
        b=HLKTvqZU90pz92lQqtaWwN3nQZXNaBtiMcdVAdjjWIilJUKCNtHq2XZdBUY/0teZDJmnnh
        tnLlD3G56qdGW07+GRoesmrmj+EqUw79NLEW0/mVXAEiM+EKSIFgnD0wB3jxxIJo490O9i
        RzSNyFQJXgLq1m0haN/lFpn1aGU9idQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-dxdZgSm6NuS85QV5QXA4wg-1; Thu, 26 Jan 2023 01:38:56 -0500
X-MC-Unique: dxdZgSm6NuS85QV5QXA4wg-1
Received: by mail-qk1-f200.google.com with SMTP id bi7-20020a05620a318700b007091d3fe2d3so527746qkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 22:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwnaW40wODo/RPJeJh2TlciTsJYMAL7AVIWQnJnbBqw=;
        b=A3M5Z/tU66uQo6zz4rAInGUEY49xGy1AOJVpzVMU4gk4SsWMfkmnXQrjhOnC6sDTAI
         aU7g7MHbfBe9Gjpc5Tj0dZ3mVQ/o90yXYqcZVWiuvYAKsrazNAYozpOOtdvJNF7wYzcX
         yzVn5nZbVubPkd0o+M2LJZHwzW0rX/i0DSnZMHrIXvlXu0bt5rzVBZuhzQNJ3cKCEFcW
         aNH0jjzuz/I8V7P6SUZaa36wi7GemobknqdwYDO2zCWX9WetoKdkWss0fJ2UyVP1efUn
         clmHJDYUwIvZVAy1lOq+Csmg8U+ZPgLJXUDGkHTLQTZJMESaIcwEjix9U6P63Jj+c6MH
         /RkA==
X-Gm-Message-State: AFqh2kqzd7kiu/yLNMfLQwcV17qDdo+S0UU0kxhEbe8NHV/cmZ1nxcfj
        j7WxDpNf9hy3IqyuCK2DG/1mnHDVWXyZX+jh32eMuIKI2kjjhv8S0eOtX9G4z2G4s++pT+hHFlj
        wH0JDneTW28Gg6FlFZK2loiOW
X-Received: by 2002:a05:622a:1aa5:b0:3b6:a1fd:19cd with SMTP id s37-20020a05622a1aa500b003b6a1fd19cdmr41574773qtc.46.1674715134726;
        Wed, 25 Jan 2023 22:38:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuf7UjZI2ffXZKoGViT9PivCgdjta/q3yUMmhqaU7OtGXYv4rT+XOka9LZmTzNCFQdUCAdNYA==
X-Received: by 2002:a05:622a:1aa5:b0:3b6:a1fd:19cd with SMTP id s37-20020a05622a1aa500b003b6a1fd19cdmr41574753qtc.46.1674715134495;
        Wed, 25 Jan 2023 22:38:54 -0800 (PST)
Received: from [192.168.8.105] (tmo-064-101.customers.d1-online.com. [80.187.64.101])
        by smtp.gmail.com with ESMTPSA id x8-20020ac84d48000000b003b63b8df24asm247352qtv.36.2023.01.25.22.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 22:38:53 -0800 (PST)
Message-ID: <957489fb-8080-8806-6ddf-8687da469a43@redhat.com>
Date:   Thu, 26 Jan 2023 07:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 07/14] KVM: s390: selftest: memop: Fix integer literal
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-8-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230125212608.1860251-8-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 22.26, Janis Schoetterl-Glausch wrote:
> The address is a 64 bit value, specifying a 32 bit value can crash the
> guest. In this case things worked out with -O2 but not -O0.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Fixes: 1bb873495a9e ("KVM: s390: selftests: Add more copy memop tests")
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 3ec501881c7c..55b856c4d656 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -514,7 +514,7 @@ static void guest_copy_key_fetch_prot_override(void)
>   	GUEST_SYNC(STAGE_INITED);
>   	set_storage_key_range(0, PAGE_SIZE, 0x18);
>   	set_storage_key_range((void *)last_page_addr, PAGE_SIZE, 0x0);
> -	asm volatile ("sske %[key],%[addr]\n" :: [addr] "r"(0), [key] "r"(0x18) : "cc");
> +	asm volatile ("sske %[key],%[addr]\n" :: [addr] "r"(0L), [key] "r"(0x18) : "cc");
>   	GUEST_SYNC(STAGE_SKEYS_SET);
>   
>   	for (;;) {

Reviewed-by: Thomas Huth <thuth@redhat.com>

