Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD126C086D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCTBTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 21:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjCTBSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 21:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274921BEC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679274420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0vOaM1tKTQAz8L7rlTZdRfoEPC1QD7yBns1c74Hjyg=;
        b=D5Prx6DKtRFUaOiltjNrZ/oMNmS2wjEPLCZSWobnu0X0iTZZYYrtaLr9jiSV9oHSvwizsp
        n8ekNBWMKAqLslpYOsTCyg53BKye+FFVJv49NUOgspr5X77l93viIshTqNgf6AX2a9eFH3
        A+dYjJMqh/Ctl6t4C5zIja0juBvo/Jk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-6WwsyUmWONOJ6yi3RHNPIQ-1; Sun, 19 Mar 2023 21:06:58 -0400
X-MC-Unique: 6WwsyUmWONOJ6yi3RHNPIQ-1
Received: by mail-pj1-f72.google.com with SMTP id o89-20020a17090a0a6200b0023b3d3acdd6so6069102pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679274418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0vOaM1tKTQAz8L7rlTZdRfoEPC1QD7yBns1c74Hjyg=;
        b=D0GDr9FHGXPPpsHXUWvaGyIeh3QF3RzDkyrXGyjJWR3pdk7DYabaRh8fCprkkHwPk8
         Z9JY0onwFqlr7RPbzkEIbQ8y3XRUXn6/L39v9eZbbIQD1I2hOtxshKW4HtK24CUGO3n3
         lguuq61Lnx4bB1FsNc5yNdbl8AZW+zSgvYzThf/TbbLXfOgsJ4RQnOZYenQdJ4fv07u4
         MIs4O6EXE0+OqRz3AWkmyxZpslpflQI/Xsfys5pBUWtVdqMGtsbpY+vDXD9JqNjrVsE4
         da6wEJzKRYeJ2UseoXq8BtN9zHTH6YEhGIBYdmlG1tjUgLGEdro7Jv8mOZSle8qkQDpV
         6egA==
X-Gm-Message-State: AO0yUKWyGF3KzDqIIJJmQifgj/BM2blKF/evTB3fl6W3Pu5QtHzUSVW8
        wJ/00J8TCoY/RFxINMAuVssCX0FWp3m+vkhSSoIKdphkRZZSZzkoZKWhkkLtalPVKiEB/uT3FDY
        XwnPhphFYfxTCORSsx92pqvVO
X-Received: by 2002:a05:6a20:c513:b0:d4:e980:9f90 with SMTP id gm19-20020a056a20c51300b000d4e9809f90mr14219882pzb.44.1679274417964;
        Sun, 19 Mar 2023 18:06:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set8+UgjIHU7VdHYD+/GnLGy8VEirYNsOOmjjpSWecSRrHgGQVBpyeiNqw6vSuMgPvspLp2mXRg==
X-Received: by 2002:a05:6a20:c513:b0:d4:e980:9f90 with SMTP id gm19-20020a056a20c51300b000d4e9809f90mr14219866pzb.44.1679274417637;
        Sun, 19 Mar 2023 18:06:57 -0700 (PDT)
Received: from [10.72.12.59] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h11-20020a62b40b000000b005da23d8cbffsm5080473pfn.158.2023.03.19.18.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 18:06:57 -0700 (PDT)
Message-ID: <568da52f-18a6-5f96-cd51-5b07dedefb2d@redhat.com>
Date:   Mon, 20 Mar 2023 09:06:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/3] ceph: fscrypt: fix atomic open bug for encrypted
 directories
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316181413.26916-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230316181413.26916-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/03/2023 02:14, Luís Henriques wrote:
> Hi!
>
> I started seeing fstest generic/123 failing in ceph fscrypt, when running it
> with 'test_dummy_encryption'.  This test is quite simple:
>
> 1. Creates a directory with write permissions for root only
> 2. Writes into a file in that directory
> 3. Uses 'su' to try to modify that file as a different user, and
>     gets -EPERM
>
> All the test steps succeed, but the test fails to cleanup: 'rm -rf <dir>'
> will fail with -ENOTEMPTY.  'strace' shows that calling unlinkat() to remove
> the file got a -ENOENT and then -ENOTEMPTY for the directory.
>
> This is because 'su' does a drop_caches ('su (874): drop_caches: 2' in
> dmesg), and ceph's atomic open will do:
>
> 	if (IS_ENCRYPTED(dir)) {
> 		set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
> 		if (!fscrypt_has_encryption_key(dir)) {
> 			spin_lock(&dentry->d_lock);
> 			dentry->d_flags |= DCACHE_NOKEY_NAME;
> 			spin_unlock(&dentry->d_lock);
> 		}
> 	}
>
> Although 'dir' has the encryption key available, fscrypt_has_encryption_key()
> will return 'false' because fscrypt info isn't yet set after the cache
> cleanup.
>
> The first patch will add a new helper for the atomic_open that will force
> the fscrypt info to be loaded into an inode that has been evicted recently
> but for which the key is still available.
>
> The second patch switches ceph atomic_open to use the new fscrypt helper.
>
> Cheers,
> --
> Luís
>
> Changes since v2:
> - Make helper more generic and to be used both in lookup and atomic open
>    operations
> - Modify ceph_lookup (patch 0002) and ceph_atomic_open (patch 0003) to use
>    the new helper
>
> Changes since v1:
> - Dropped IS_ENCRYPTED() from helper function because kerneldoc says
>    already that it applies to encrypted directories and, most importantly,
>    because it would introduce a different behaviour for
>    CONFIG_FS_ENCRYPTION and !CONFIG_FS_ENCRYPTION.
> - Rephrased helper kerneldoc
>
> Changes since initial RFC (after Eric's review):
> - Added kerneldoc comments to the new fscrypt helper
> - Dropped '__' from helper name (now fscrypt_prepare_atomic_open())
> - Added IS_ENCRYPTED() check in helper
> - DCACHE_NOKEY_NAME is not set if fscrypt_get_encryption_info() returns an
>    error
> - Fixed helper for !CONFIG_FS_ENCRYPTION (now defined 'static inline')

This series looks good to me.

And I have run the test locally and worked well.


> Luís Henriques (3):
>    fscrypt: new helper function - fscrypt_prepare_lookup_partial()

Eric,

If possible I we can pick this together to ceph repo and need your ack 
about this. Or you can pick it to the crypto repo then please feel free 
to add:

Tested-by: Xiubo Li <xiubli@redhat.com> and Reviewed-by: Xiubo Li 
<xiubli@redhat.com>

Thanks

- Xiubo

>    ceph: switch ceph_open() to use new fscrypt helper
>    ceph: switch ceph_open_atomic() to use the new fscrypt helper
>
>   fs/ceph/dir.c           | 13 +++++++------
>   fs/ceph/file.c          |  8 +++-----
>   fs/crypto/hooks.c       | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/fscrypt.h |  7 +++++++
>   4 files changed, 54 insertions(+), 11 deletions(-)
>
-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

