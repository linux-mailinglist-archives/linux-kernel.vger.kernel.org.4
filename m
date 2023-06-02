Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D771F821
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjFBBpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjFBBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66961107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685670233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qm3YBUUay/A3pBxQ63hdSOGk63jXLzGv+Yj/C0QgPBo=;
        b=Mr9dwRRJfQNGv2j06MCPIvgoSDkLm2WcJwzFSjZqhEHrS2cdudCY+vDsIJh38VBCUinBd7
        B8OveAdlEn7OlvHLYQLEa18Cz/NDiPjm4FCMKUyYVORq4b+6AuuauSZ2IFTT29ABXBGMDQ
        7Ud9myKKkPfLGtCakZsCdwteB+sDxuM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-F5O-SuqZM-uIDL0bbt2qBQ-1; Thu, 01 Jun 2023 21:43:50 -0400
X-MC-Unique: F5O-SuqZM-uIDL0bbt2qBQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6af87ea95c6so1637246a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685670230; x=1688262230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm3YBUUay/A3pBxQ63hdSOGk63jXLzGv+Yj/C0QgPBo=;
        b=MuGpAtiiamdVrLKyZAmd/1XxZoy+tiYtL5Dijlliu5PbhUwQClh7ak0yc1DrBrZc0U
         wb+2+kicw3uvK4pJ/DNZUBYxEOiczB3Yl7/9w8KAjevwB8hA8ivpCC/x38RUkkSIcSzM
         QwO4H6k2xnG4O2ca4rQBgGDSar4XLzXs+LSPsAugHzaFqoAsPX0cCcGL7ROEvzpiOfnC
         VmK9Ax45iZejGpKPqMx9yFjpfM8SsTvWPQDoyc9G1W6xEbwk86nINu/yZwgK4aZKB3Gl
         XsjH2kja78t3B4PGJb530W2IFFOw0D83OXaOAnf1LW7DMmnCnXiyU6MyDfN/L0Cer3fo
         j2rw==
X-Gm-Message-State: AC+VfDzzZ45OqJd/kQ1TmsDt5d83KoY+TaMMYv6rBw2eV7FDdtq9v75H
        THRcBO0MU9r1vqRJnuuZNZoOUiSyHYLFwEaayZROuXzRzm22PiUgEVU7jQg3PFhfOu+Kwi6UQ1t
        jMDXdnZtrC32IvXmTJqsdLzRq
X-Received: by 2002:a05:6830:1144:b0:6ab:1b58:f408 with SMTP id x4-20020a056830114400b006ab1b58f408mr1165852otq.19.1685670229963;
        Thu, 01 Jun 2023 18:43:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dXe+qWoYjYqWymPBlKMBkzayyp1ngY7RaWquL6mNcLpLBSiviFYZu9RyuAqcMvnhIoxOw2A==
X-Received: by 2002:a05:6830:1144:b0:6ab:1b58:f408 with SMTP id x4-20020a056830114400b006ab1b58f408mr1165844otq.19.1685670229730;
        Thu, 01 Jun 2023 18:43:49 -0700 (PDT)
Received: from [10.72.12.188] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u6-20020a634706000000b0053b8a4f9465sm103388pga.45.2023.06.01.18.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 18:43:49 -0700 (PDT)
Message-ID: <539de53d-729b-118e-1f2f-6dd2f6dccb71@redhat.com>
Date:   Fri, 2 Jun 2023 09:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 08/13] ceph: allow idmapped getattr inode op
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-9-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230524153316.476973-9-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Enable ceph_getattr() to handle idmapped mounts. This is just a matter
> of passing down the mount's idmapping.
>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   fs/ceph/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8e5f41d45283..2e988612ed6c 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2465,7 +2465,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
>   			return err;
>   	}
>   
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(idmap, inode, stat);
>   	stat->ino = ceph_present_inode(inode);
>   
>   	/*

As mentioned in my comment in "[PATCH v2 10/13] ceph: allow idmapped 
setattr inode op". The getattr requests may fail too in the MDS when 
doing the client auth checking.

So for all the requests we should always get the correct UID/GID instead 
of only for the creating requests, then we can make sure that the idmap 
is only a feature in client side and then in cephfs MDS side it will 
always get a consistent UID/GID no matter what idmappings the clients 
are using.

Right ?

Thanks

- Xiubo

