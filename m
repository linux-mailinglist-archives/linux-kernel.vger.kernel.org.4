Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6611161325F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJaJRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95946DEB6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667207767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7c4RHzQOuXVaRtNvZLfvHjb8W5S4vIcXv3YPEcl4G4=;
        b=PpFb/GKdOkounEOuBrbpG/GpCwyZVUHna/1bCztrgiDZb6WctW5vRVsOWm2Gb+udx9l5F1
        UVi0tYS34+mTdbtpPI2zSnGQ0xHoUtC7/A+NAJgYau+IJKlrmfTdUqUfFy7wCalqGCnATC
        khheM0RhhHD92IWRqXArgZTmYdxRUdY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-QrurjTs2MDWjiB1k5R2Exg-1; Mon, 31 Oct 2022 05:16:00 -0400
X-MC-Unique: QrurjTs2MDWjiB1k5R2Exg-1
Received: by mail-pj1-f70.google.com with SMTP id q1-20020a17090aa00100b002139a592adbso4982597pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7c4RHzQOuXVaRtNvZLfvHjb8W5S4vIcXv3YPEcl4G4=;
        b=C8gqD67tlZgbn1X3ty/aVpBJY3nEOovOFqs3dLEQiaoUfr6YCdbBVgx0xzlAVeFrZd
         ao1vhbWOCVMcfgWS3LTjUwUCN4WncwktK8Dox0GBIi8jqblvXi63thSz9LX+smXS4CED
         absz+hStgJgRDoGRHoiy8NR97amRKvDW7ay9IMQbCrnaO46IxvF0gpNbrtLpCi8uZYsv
         FykJIhVthl76/+rRxJgWNGbnoqUVDA/9aryrp4k272kRipklaOesxz0ueG+X2LYJ9nWm
         8HwvptFMobXGxp7ZyJhcCteFNT5D6xCv7ohWSJ3IHUKgH3kURz7lAuRXQfU6h8j7ta2o
         o3pw==
X-Gm-Message-State: ACrzQf0d9pQFkhYNOet7rDIn/wTc1PavlY8QAX5/vTapYzVw5Tnl1C2W
        BMKdn2ckJUgI95Z2RsgfvwRB98qULdKn7Z10KmKh8MiK+YfllO2Rf4l5M2EIdycy2aXTtcYr0CV
        VrBDa4OuJzcyoCm4Y+yUsurgkXiaeXhg7kFC5pcj/saUeXiRUjeO9WxLjE6nBP7BwoszjZ3RYBA
        ==
X-Received: by 2002:a17:902:e1ca:b0:186:878e:3b03 with SMTP id t10-20020a170902e1ca00b00186878e3b03mr13622083pla.95.1667207759537;
        Mon, 31 Oct 2022 02:15:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Y3yfYRZHlNXDqIukMvJPFVIaad4XFGehmfzvWkC9cS65AU5tBw0vLrcZXNslX8jAv14Z2NQ==
X-Received: by 2002:a17:902:e1ca:b0:186:878e:3b03 with SMTP id t10-20020a170902e1ca00b00186878e3b03mr13622056pla.95.1667207759172;
        Mon, 31 Oct 2022 02:15:59 -0700 (PDT)
Received: from [10.72.13.65] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090a294100b0020d67a726easm3741862pjf.10.2022.10.31.02.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 02:15:58 -0700 (PDT)
Subject: Re: [RFC PATCH] ceph: allow encrypting a directory while not having
 Ax caps
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027112653.12122-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a992d844-6d75-e134-60e1-acb8c8972ff3@redhat.com>
Date:   Mon, 31 Oct 2022 17:15:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221027112653.12122-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/2022 19:26, Luís Henriques wrote:
> If a client doesn't have Fx caps on a directory, it will get errors while
> trying encrypt it:
>
> ceph: handle_cap_grant: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len 0 new len 48)
> fscrypt (ceph, inode 1099511627812): Error -105 getting encryption context
>
> A simple way to reproduce this is to use two clients:
>
>      client1 # mkdir /mnt/mydir
>
>      client2 # ls /mnt/mydir
>
>      client1 # fscrypt encrypt /mnt/mydir
>      client1 # echo hello > /mnt/mydir/world
>
> This happens because, in __ceph_setattr(), we only initialize
> ci->fscrypt_auth if we have Ax.  If we don't have, we'll need to do that
> later, in handle_cap_grant().
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Hi!
>
> To be honest, I'm not really sure about the conditions in the 'if': shall
> I bother checking it's really a dir and that it is empty?
>
> Cheers,
> --
> Luís
>
>   fs/ceph/caps.c | 26 +++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 443fce066d42..e33b5c276cf3 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3511,9 +3511,29 @@ static void handle_cap_grant(struct inode *inode,
>   		     from_kuid(&init_user_ns, inode->i_uid),
>   		     from_kgid(&init_user_ns, inode->i_gid));
>   #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> -		if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
> -		    memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
> -			   ci->fscrypt_auth_len))
> +		if ((ci->fscrypt_auth_len == 0) &&
> +		    (extra_info->fscrypt_auth_len > 0) &&
> +		    S_ISDIR(inode->i_mode) &&
> +		    (ci->i_rsubdirs + ci->i_rfiles == 1)) {
> +			/*
> +			 * We'll get here when setting up an encrypted directory
> +			 * but we don't have Fx in that directory, i.e. other
> +			 * clients have accessed this directory too.
> +			 */
> +			ci->fscrypt_auth = kmemdup(extra_info->fscrypt_auth,
> +						   extra_info->fscrypt_auth_len,
> +						   GFP_KERNEL);
> +			if (ci->fscrypt_auth) {
> +				inode->i_flags |= S_ENCRYPTED;
> +				ci->fscrypt_auth_len = extra_info->fscrypt_auth_len;
> +			} else {
> +				pr_err("Failed to alloc memory for %llx.%llx fscrypt_auth\n",
> +					ceph_vinop(inode));
> +			}
> +			dout("ino %llx.%llx is now encrypted\n", ceph_vinop(inode));
> +		} else if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
> +			   memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
> +				  ci->fscrypt_auth_len))
>   			pr_warn_ratelimited("%s: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
>   				__func__, ci->fscrypt_auth_len, extra_info->fscrypt_auth_len);
>   #endif

Hi Luis,

Thanks for your time on this bug.

IMO we should fix this in ceph_fill_inode():

  995 #ifdef CONFIG_FS_ENCRYPTION
  996         if (iinfo->fscrypt_auth_len && (inode->i_state & I_NEW)) {
  997                 kfree(ci->fscrypt_auth);
  998                 ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
  999                 ci->fscrypt_auth = iinfo->fscrypt_auth;
1000                 iinfo->fscrypt_auth = NULL;
1001                 iinfo->fscrypt_auth_len = 0;
1002                 inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
1003         }
1004 #endif

The setattr will get a reply from MDS including the fscrypt auth info, I 
think the kclient just drop it here.

If we fix it in handle_cap_grant() I am afraid this bug still exists. 
What if there is no any new caps will be issued or revoked recently and 
then access to the directory ?

Thanks

- Xiubo

>

