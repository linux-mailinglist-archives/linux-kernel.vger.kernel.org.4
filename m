Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5845D62D49A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiKQIE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKQIEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:04:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC02D2F2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668672231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lc6aO2jeVqUhMYtAzgGQ94NvGNINHdDrt/788aNpceE=;
        b=NwMMr7LtvV8Ar471pthin4uHN4z+FZHJn2hflIwkR9UngWSws34ZWhMpAYHccjWMM0dsBg
        +Bni5N8cVikq/PQPZ4z/abQShqGpxfMRHBX/yRiixJvOfvPT4NEYJ+HcnaimDL/hYT0tDS
        aOLZrz9YaokW3MC7pdla6cxJPAUO1V0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-XV58rmmCNEuC-WS-8TFzNw-1; Thu, 17 Nov 2022 03:03:42 -0500
X-MC-Unique: XV58rmmCNEuC-WS-8TFzNw-1
Received: by mail-pj1-f71.google.com with SMTP id mj8-20020a17090b368800b002137a506927so704092pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc6aO2jeVqUhMYtAzgGQ94NvGNINHdDrt/788aNpceE=;
        b=2BlZ52L+pJr2+sY+/PkYBw2XstYPfYzoK8ktwWk0+Ecr+vVp9JxONoN5bCPiwtoEmG
         erg1ZP8sNbSm7W5ta6kO0IamC+/sb2AwcNnrW7pYyJSMIv98duJFZGgAqwbGNU0AntkY
         O6IFV7FfjAmfVmr/zTgmreSoV7LJatE3aEXMefSo1WkzN77oeCgPSeT4hA2F1a+bBCNd
         uHt1f1ROgj1MJe44+ciVDsRZhyhylbzFG0qeXZpa9Hqekz/D4pj2JNjhN3HqXWYxux20
         ++AvEN48YWR3nx7g0on8ONKflT5my68MT0TCf7/1U0Zf2SyAadlmkmX/+cAqxJfLjVdy
         r4Zg==
X-Gm-Message-State: ANoB5pnHGAu4d7hD4ua/+iK8X/vqIa7ZnpX0zIZCjhwJgyiyXl4F4yP7
        LGmSIcTn2wXTwpcgaSaY5CPF7NEQyHzQ4K7QLDohMqm6aDUlSPStpruj3AVf/bwui+s9qvQfZ0B
        6IBQxyzzesYCfLQoje0gywqmaip/uZhBY+m+ez9bQshyxNo2mNx5dkyhthD/HJPX3g4TavoF8eA
        ==
X-Received: by 2002:aa7:9243:0:b0:56d:dd2a:f6b6 with SMTP id 3-20020aa79243000000b0056ddd2af6b6mr1848188pfp.30.1668672220757;
        Thu, 17 Nov 2022 00:03:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Ul0+6Ftaw44/dqSaV4XxhaLQGRUCY87AVvlj/XE3vDzVl3QE+GGR+9Tr/vnWSm8s2BI54bw==
X-Received: by 2002:aa7:9243:0:b0:56d:dd2a:f6b6 with SMTP id 3-20020aa79243000000b0056ddd2af6b6mr1848156pfp.30.1668672220340;
        Thu, 17 Nov 2022 00:03:40 -0800 (PST)
Received: from [10.72.12.148] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm547141pln.149.2022.11.17.00.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:03:40 -0800 (PST)
Subject: Re: [PATCH] ceph: make sure directories aren't complete after setting
 crypt context
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221116153703.27292-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <5de0ae69-5e3d-2ccb-64a3-971db66477f8@redhat.com>
Date:   Thu, 17 Nov 2022 16:03:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221116153703.27292-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/11/2022 23:37, Luís Henriques wrote:
> When setting a directory's crypt context, __ceph_dir_clear_complete() needs
> to be used otherwise, if it was complete before, any old dentry that's still
> around will be valid.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Hi!
>
> Here's a simple way to trigger the bug this patch is fixing:
>
> # cd /cephfs
> # ls mydir
> nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
> # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
> Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8  u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
> # fscrypt unlock mydir
> # touch /mnt/test/mydir/mysubdir/file
> touch: cannot touch '/mnt/test/mydir/mysubdir/file': No such file or directory
>
>   fs/ceph/crypto.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 35a2ccfe6899..dc1557967032 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -87,6 +87,10 @@ static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
>   		return -ERANGE;
>   
>   	memcpy(ctx, cfa->cfa_blob, ctxlen);
> +
> +	/* Directory isn't complete anymore */
> +	if (S_ISDIR(inode->i_mode) && __ceph_dir_is_complete(ci))
> +		__ceph_dir_clear_complete(ci);

Hi Luis,

Good catch!

BTW, why do this in the ceph_crypt_get_context() ? As my understanding 
is that we should mark 'mydir' as incomplete when unlocking it. While as 
I remembered the unlock operation will do:


Step1: get_encpolicy via 'mydir' as ctx
Step2: rm_enckey of ctx from the superblock


Since I am still running the test cases for the file lock patches, so I 
didn't catch logs to confirm the above steps yet.

If I am right IMO then we should mark the dir as incomplete in the Step2 
instead, because for non-unlock operations they may also do the Step1.

Thanks!

- Xiubo

>   	return ctxlen;
>   }
>   
>

