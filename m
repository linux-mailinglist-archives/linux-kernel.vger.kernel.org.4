Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79D62226D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKIDJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKIDJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F417E21
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667963339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rk+G6bXxmyU0fpyJouoERPNPm9IAIKngr86zd/Y8mwM=;
        b=UbWureG1R83cSXzai243vyNhbOi78rzI5hT0z+kc9Kixkhr25MR2RtPESZCEC5y367e7Dv
        7JUzf7QcK5Vl1ECabsP1IMyUt8AGDgFtzyaijq5h8J1XMCjddYVcHRFPEIKOcU2xyYUOJP
        N4rpZPAGHN+521zXKy7jL6cq++nkDtk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-oaNYFiEnOqSZYz9Q1Aielw-1; Tue, 08 Nov 2022 22:08:57 -0500
X-MC-Unique: oaNYFiEnOqSZYz9Q1Aielw-1
Received: by mail-pj1-f70.google.com with SMTP id b1-20020a17090a10c100b0020da29fa5e5so436010pje.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 19:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rk+G6bXxmyU0fpyJouoERPNPm9IAIKngr86zd/Y8mwM=;
        b=MSHhANv2O40hF7/qefNGmdR3dTcCb/LS6bx1zOOnuAALx9CN4wyqhv4CCTLCHNJpyZ
         s3Ki1kI2uQS9YDhPSbdM8sy+7hpTCgNJJcLUvuwUrf5qs9sY0is2WhHgJDnli8onnhSf
         7uspojcNLiU12WNhA/MCUP/vPZ5Y6ub7YbI0GMyJgXpsXYcfdRuM8y3zBXwMI6Cq37i1
         D+BJ1nDARDX6ve7JBoZDzXzRV6/uVak2RPf2Yu5J06Jj9KBs0oAVmN7/mM51PLmBxNgQ
         pz6HTjh/p64Nx24Z39KVi3jrt68ODVquMaPWRY5kticQzVdiFZMXrq90eMUtXoRdvFJX
         xzBQ==
X-Gm-Message-State: ACrzQf0jvuanei+kOv5J7J1LKVdq5T1clv/8AzcWI+FELCP/W2g5lQ/e
        gPFS2nHz7sJVBsnEEhwK3WKHafHb7KXwkG0Gj5EgJNpJPYCqOjo9Hiicpmk4nXlToh7u1D2eBjb
        cf3w2HxPfoVHQKSayCvfA2/7BuUs9LKAzJtZBRYQlXg9aTl7jy8lZG/uwJVbbG9uimAKHFj94rQ
        ==
X-Received: by 2002:a17:902:f707:b0:184:e44f:88cc with SMTP id h7-20020a170902f70700b00184e44f88ccmr58437341plo.42.1667963336732;
        Tue, 08 Nov 2022 19:08:56 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6EuTZRq9zT6tdrqFnjzqb0DCbN1EkoOmwWtqVnpO/xkA4AJWWB/eXF7aqeWwxUnT7itNf/Lg==
X-Received: by 2002:a17:902:f707:b0:184:e44f:88cc with SMTP id h7-20020a170902f70700b00184e44f88ccmr58437309plo.42.1667963336257;
        Tue, 08 Nov 2022 19:08:56 -0800 (PST)
Received: from [10.72.12.88] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b0018544ad1e8esm7751241plc.238.2022.11.08.19.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:08:55 -0800 (PST)
Subject: Re: [PATCH v2] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221108143421.30993-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <215b729e-0af0-45d8-96af-3d3c319581c9@redhat.com>
Date:   Wed, 9 Nov 2022 11:08:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221108143421.30993-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 08/11/2022 22:34, Luís Henriques wrote:
> Because ceph_init_fs_context() will never be invoced in case we get a
> mount error, destroy_mount_options() won't be releasing fscrypt resources
> with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
> an invocation to this function in the mount error path.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> * Changes since v1:
>
> As suggested by Xiubo, moved fscrypt free from ceph_get_tree() to
> ceph_real_mount().
>
> (Also used 'git format-patch' with '--base' so that the bots know what to
> (not) do with this patch.)
>
>   fs/ceph/super.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 2224d44d21c0..f10a076f47e5 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1196,6 +1196,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>   
>   out:
>   	mutex_unlock(&fsc->client->mount_mutex);
> +	ceph_fscrypt_free_dummy_policy(fsc);
>   	return ERR_PTR(err);
>   }
>   
>
> base-commit: 8b9ee21dfceadd4cc35a87bbe7f0ad547cffa1be
> prerequisite-patch-id: 34ba9e6b37b68668d261ddbda7858ee6f83c82fa
> prerequisite-patch-id: 87f1b323c29ab8d0a6d012d30fdc39bc49179624
> prerequisite-patch-id: c94f448ef026375b10748457a3aa46070aa7046e
>
LGTM.

Thanks Luis.

Could I fold this into the previous commit ?

BRs

- Xiubo


