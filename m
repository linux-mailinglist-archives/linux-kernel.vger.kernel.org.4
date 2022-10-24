Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7660979F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 02:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJXAzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 20:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJXAzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292CB13F9B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666572925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAZtzQlZwmSJ6U5+u4NWPMoRax8Dx0cjGRC4G8jWBWs=;
        b=c2ORzUcxCKx8F1O7rEmnyISI0B/S7oHgcytzKzVgoLPstuUtIUt/N5DVrYGmLNg3Pi3/SX
        6DmuRYYwpcOwIvjrMR5Fgan+m/Uo8BxNnrE3xL/OLZMlSe72QUwmeoKSMXMc1Ns8oLelIE
        YhMHD6D7CAw0t/QwtucL4pVnNLRTNog=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-IDcK_dofOJeBSAppbGEyxQ-1; Sun, 23 Oct 2022 20:55:22 -0400
X-MC-Unique: IDcK_dofOJeBSAppbGEyxQ-1
Received: by mail-pl1-f200.google.com with SMTP id q3-20020a17090311c300b0017898180dddso5465494plh.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAZtzQlZwmSJ6U5+u4NWPMoRax8Dx0cjGRC4G8jWBWs=;
        b=hSOBYGhfVGMPXLzKFGP43RMVOms0ktqAUQjD8Fo9CIMXp6L/2uO2d0YNmcRuadXBUV
         pa62dgRF36S+L65/D2hJWUfUpiy6rymha7cNALP4/4A4GFLK+JyQU7RFVR5yd/42KqGI
         mI/3j4vNqQb7HifXTtwVZLhTCqLkqtQukqYBBiPMCH/HAx3q0If8q24KgFWTBgshKoXi
         GOImZ0L1YPQlB8fiODPuNQ79ryjnpYJ6EGExcpXPkKYOX+ThiEeFVJ+0Xo2AFTb9we5N
         QME80Uqtpa2RatLWpwEJjqF98NzB2YFiWoMdwb5O1sFJ3fb9KnGZnuaQzPS9AcWak2zR
         pQig==
X-Gm-Message-State: ACrzQf2U5CkprZfQr3c7tnXAASBPEICDRP5oC549dDtVBi93QhyUhnPs
        MDpHLi/x9VyKvf4TuK529X65s/8G51HuWfaG1eocrdqKl/z+2gSQY7dwq8LxB5mhadOer4VN8XB
        jaRqt7HT+dM/E9pnZuyTrDpeK
X-Received: by 2002:a17:90b:38d2:b0:20d:8f2a:c4ba with SMTP id nn18-20020a17090b38d200b0020d8f2ac4bamr35766393pjb.209.1666572921123;
        Sun, 23 Oct 2022 17:55:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5s/daeivZt0e97/HJZZaWbcJDrkZFOpUZ9mm33dDhh4LkMFadYuyo/k4YhsG0JQoHuk5CoGQ==
X-Received: by 2002:a17:90b:38d2:b0:20d:8f2a:c4ba with SMTP id nn18-20020a17090b38d200b0020d8f2ac4bamr35766367pjb.209.1666572920868;
        Sun, 23 Oct 2022 17:55:20 -0700 (PDT)
Received: from [10.72.12.79] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c123-20020a624e81000000b005624e2e0508sm18802604pfb.207.2022.10.23.17.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 17:55:20 -0700 (PDT)
Subject: Re: [PATCH -next 3/5] ceph: fix possible null-ptr-deref when parsing
 param
To:     Hawkins Jiawei <yin31149@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
References: <20221023163945.39920-1-yin31149@gmail.com>
 <20221023163945.39920-4-yin31149@gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <aa3f35c1-1550-a322-956f-1837cb2389a9@redhat.com>
Date:   Mon, 24 Oct 2022 08:55:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221023163945.39920-4-yin31149@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/10/2022 00:39, Hawkins Jiawei wrote:
> According to commit "vfs: parse: deal with zero length string value",
> kernel will set the param->string to null pointer in vfs_parse_fs_string()
> if fs string has zero length.
>
> Yet the problem is that, ceph_parse_mount_param() will dereferences the
> param->string, without checking whether it is a null pointer, which may
> trigger a null-ptr-deref bug.
>
> This patch solves it by adding sanity check on param->string
> in ceph_parse_mount_param().
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>   fs/ceph/super.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 3fc48b43cab0..341e23fe29eb 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -417,6 +417,9 @@ static int ceph_parse_mount_param(struct fs_context *fc,
>   		param->string = NULL;
>   		break;
>   	case Opt_mds_namespace:
> +		if (!param->string)
> +			return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
> +				       param->string, param->key);
>   		if (!namespace_equals(fsopt, param->string, strlen(param->string)))
>   			return invalfc(fc, "Mismatching mds_namespace");
>   		kfree(fsopt->mds_namespace);

BTW, did you hit any crash issue when testing this ?

$ ./bin/mount.ceph :/ /mnt/kcephfs -o mds_namespace=

<5>[  375.535442] ceph: module verification failed: signature and/or 
required key missing - tainting kernel
<6>[  375.698145] ceph: loaded (mds proto 32)
<3>[  375.801621] ceph: Bad value for 'mds_namespace'

 From my test, the 'fsparam_string()' has already make sure it won't 
trigger the null-ptr-deref bug.

But it will always make sense to fix it in ceph code with your patch.

- Xiubo



