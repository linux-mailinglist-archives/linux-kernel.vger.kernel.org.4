Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D12623B75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiKJFqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKJFqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D551403E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 21:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668059144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8k4w4Vnv9fqY6JUFkeKEzkLEw9Y/HJrXWV3TRz87NqA=;
        b=i8S1sU6K9Zi/IJ/UAW9mYHjNqCg+JGzK94ErSQlv2xMbBcSYzBLN025MXdgQSo3xmOMhQT
        JfIvicdsCDuvbwaE00YcCUHso2ipGyxfzvGFmXLTICjn9lCGRm+szAS2EuGTUCvK36vu0y
        ZQfCzgsBI0Xo4wM0x6njTWOrRLBvvZU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-FhIe5S9mPN2ZUfuDLTYeLg-1; Thu, 10 Nov 2022 00:45:03 -0500
X-MC-Unique: FhIe5S9mPN2ZUfuDLTYeLg-1
Received: by mail-pj1-f72.google.com with SMTP id pj8-20020a17090b4f4800b002140219b2b3so3523693pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 21:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k4w4Vnv9fqY6JUFkeKEzkLEw9Y/HJrXWV3TRz87NqA=;
        b=AWwSajIA03v1Df8EysIxagXJsdjFowmbjlRW5tx1WChj4kECAPqvQMLm6sRbHnEUt2
         sceyjzRm+S1xKlKQHTkOWFELda8oQ5w9du4P66nKfgZNwSstxiDS36io5glEB66lQzck
         uMQOoY7YHfv7OQIpsU9CUBQvgeSxeRXBWXDFWXRDkEXepIewc/CSbAw/NrnhzZfs0n9s
         x+7bZ5K32T0DqtBxpY5fptuM4NhpwOh8UYt46dgqJtZ+vd6X6EtcOPIpJR2u4DiP7SkB
         qagt3Ppb/VmpftrnhIqLjApOo421iYB8jQbK/h3yAqHIo8QrPsgNxtlaHlP4HL6Y1KCm
         0fTA==
X-Gm-Message-State: ACrzQf2ixFuRlCci0y2G1/1NEzTLVdLQAk///xRbwcqwoHObMwgvcoz/
        3ZmomiJdkBPYmhBP4s/YXkY6m1ouMRVXHgL1kOCpFn1yX4XNDwXQqB7TtI290muvGMl9tu+cqQ9
        qIflbC/v2YoX9Oixpxwl3vLoWjvei3+Q6ns6Rn6h4Uc219ibFoDPIFKmKkahUESCJ4qCJlu/oeg
        ==
X-Received: by 2002:a17:902:d38d:b0:186:9fc5:6c13 with SMTP id e13-20020a170902d38d00b001869fc56c13mr63823532pld.73.1668059102778;
        Wed, 09 Nov 2022 21:45:02 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5Od5hw/v96iirS/f5xvd1IT5T0T2A96tmeZWR8dgNsa6AbLSl0yB/i2/FSqXPQnXI2ZtpnaQ==
X-Received: by 2002:a17:902:d38d:b0:186:9fc5:6c13 with SMTP id e13-20020a170902d38d00b001869fc56c13mr63823513pld.73.1668059102386;
        Wed, 09 Nov 2022 21:45:02 -0800 (PST)
Received: from [10.72.12.148] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b00176ba091cd3sm10211389plh.196.2022.11.09.21.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 21:45:01 -0800 (PST)
Subject: Re: [PATCH] ceph: Fix NULL vs IS_ERR checking in ceph_getattr
To:     Miaoqian Lin <linmq006@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110031311.1629288-1-linmq006@gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <67a1782c-9b7d-055a-5e62-456294cb4401@redhat.com>
Date:   Thu, 10 Nov 2022 13:44:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221110031311.1629288-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Thanks for your patch. This has already been fixed by Dan Carpenter 
weeks ago and already in the ceph-client's testing branch, please see [1]:

[1] 
https://github.com/ceph/ceph-client/commit/ffc4d66a34bb5bd76d0a3f83bebf500d96a8e37c

BRs

- Xiubo

On 10/11/2022 11:13, Miaoqian Lin wrote:
> The ceph_lookup_inode() function return error pointers on error
> instead of NULL.
> Use IS_ERR() to check the return value to fix this.
>
> Fixes: aa87052dd965 ("ceph: fix incorrectly showing the .snap size for stat")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   fs/ceph/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 4af5e55abc15..bad9eeb6a1a5 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2492,7 +2492,7 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
>   			struct inode *parent;
>   
>   			parent = ceph_lookup_inode(sb, ceph_ino(inode));
> -			if (!parent)
> +			if (IS_ERR(parent))
>   				return PTR_ERR(parent);
>   
>   			pci = ceph_inode(parent);

