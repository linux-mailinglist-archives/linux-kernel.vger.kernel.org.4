Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0702561EE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiKGJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiKGJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679081789B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667812634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/06Zdswwk5u6ptmrFeG9CH1ESyHDETkaDN7bYalcrtY=;
        b=GDrW8Kr5WdIoJBS3MMWacb2g4Sb9/MvAqYlhtT6k6JKjodgLr81bgQxbs4m59DKQfnw9RH
        Kown+MMqzBd93IOc9k5FvS6HgC8XlgCJlmwMIckJ8acMx92Th5nlfrS61X183P4B1HpelO
        UlKu0w4dFOnAB7itKhXD9eXXUlPJtWU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-O2iwV5zCMDuG3Bekc9jxNQ-1; Mon, 07 Nov 2022 04:17:13 -0500
X-MC-Unique: O2iwV5zCMDuG3Bekc9jxNQ-1
Received: by mail-pf1-f197.google.com with SMTP id bq6-20020a056a000e0600b0056bcbc6720fso5305409pfb.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/06Zdswwk5u6ptmrFeG9CH1ESyHDETkaDN7bYalcrtY=;
        b=ZunQOrOMxkaI+BPb4YlkmVcUkgCb1798XwSbwq2XEEMCKcMU1Nip95S/W3/8lEetnv
         HorHLDTLdPbWdcyZE5tGO/tfq0b02zs8jHZYvxgqWrk2FZjntWUA0MeRFpT1q9aa5yjK
         /L+7G8rCEqh/UCjb7FpjmCJzTKPEspKINQpPGWe5qdIcP3u+wH+6Nbw73bn2nBe8xh0/
         vIMRZQmQuynF47lLtOKaOt1Z9C96bRQ0IwfxPmQmrVd95OX0YL6ElTnFNY/rodI2py7r
         Pl4956iasOk68Rte7g6QYogqp/wmRxbYjyl4OGIazicvyhz1CykIN79MSU0+a6jHXHnI
         nwJQ==
X-Gm-Message-State: ANoB5pnOQi/RXqUYjOnx6nwKDmpE4TQfQwdr/+qAmes/kPy9YAs7PLd+
        C24L1vJeCKRiPz7xBQsiMHN1goaoqmTA2H1B9eUU9fSTeElMDs3Nsfm5BfVgyOkxsUtrO5elOAB
        A6NsXNKFg2P1+aNiO8Unm8UB2NO8WlLWXODROiY406XP9uYkSDSoDxgcTVlZFqlNovrbZWiAtkw
        ==
X-Received: by 2002:a63:f306:0:b0:470:514e:1f4a with SMTP id l6-20020a63f306000000b00470514e1f4amr9182530pgh.523.1667812632076;
        Mon, 07 Nov 2022 01:17:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5r/6cQLpU43OkWVOCzxFBhk/I+3HK7SXpcOST2y4DWW/yZyxsewljQ73zUAbyy8U82gT7GTg==
X-Received: by 2002:a63:f306:0:b0:470:514e:1f4a with SMTP id l6-20020a63f306000000b00470514e1f4amr9182497pgh.523.1667812631729;
        Mon, 07 Nov 2022 01:17:11 -0800 (PST)
Received: from [10.72.12.88] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i193-20020a6287ca000000b00561d79f1064sm3961945pfe.57.2022.11.07.01.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:17:11 -0800 (PST)
Subject: Re: [RFC PATCH v2] ceph: allow encrypting a directory while not
 having Ax caps
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103140640.30850-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <25c35887-fe77-348d-9f4b-5f92a2362cec@redhat.com>
Date:   Mon, 7 Nov 2022 17:17:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221103140640.30850-1-lhenriques@suse.de>
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


On 03/11/2022 22:06, Luís Henriques wrote:
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
> ci->fscrypt_auth if we have Ax and ceph_fill_inode() won't use the
> fscrypt_auth received if the inode state isn't I_NEW.  Fix it by allowing
> ceph_fill_inode() to also set ci->fscrypt_auth if the inode doesn't have
> it set already.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index fb507d57cb26..c7831f801911 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1016,7 +1016,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>   	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
>   
>   #ifdef CONFIG_FS_ENCRYPTION
> -	if (iinfo->fscrypt_auth_len && (inode->i_state & I_NEW)) {
> +	if (iinfo->fscrypt_auth_len &&
> +	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
>   		kfree(ci->fscrypt_auth);
>   		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
>   		ci->fscrypt_auth = iinfo->fscrypt_auth;
>
Hi Luis,

This looks good to me.

I will test it and merge it if everything goes well.

Thanks!

- Xiubo

