Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4EA61EC69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKGHsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKGHse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:48:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B912618
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667807257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52WLTkQahESKRvbE8wwCRR9ybE1ehJc40vrQX6Z9vt4=;
        b=Vwdg5FGzEZGTLF3EecFikoWx7+CRbcvdtozxNRWRmOpJozP8omuAHL4jTb07wf/QV0QMMl
        XljQjZ5wayFo74kgi1V9Yw0u4WbBOuSyFBlPx+MwdAUuOiS8SC1K/OQjXkQI1zDABNuPGD
        xs88ahjo4DzOXk0Sonzxbpn1IlxdpRg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-Exnr4IrYOGSBXwxKvs_F4w-1; Mon, 07 Nov 2022 02:47:31 -0500
X-MC-Unique: Exnr4IrYOGSBXwxKvs_F4w-1
Received: by mail-pl1-f197.google.com with SMTP id e13-20020a17090301cd00b001871e6f8714so8618004plh.14
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52WLTkQahESKRvbE8wwCRR9ybE1ehJc40vrQX6Z9vt4=;
        b=Beu+R8ZiuuFey12FiWU7OhtsV3+sMS8w/97JZQfjIILTcuNz6T4dyvQeStmF+IHacL
         RBMmZ+hWt3rHw1up1e6VDH5ibhltYmbb9XDjGX4vn8uVmaUARlDv6dipblzLQNQTbMwR
         VwtEkC54OjUjS5a+TlSoF7di1Y2vPgeviejUxQTIsHQL/O2Z4hKzUk6AaQPMLcbA9i+4
         3ejwiIHwFm3UEIoeqhv4sGFLThnS08NmG9vl4ibtSGg/Rld7eB1sglH5yoZ20VhKJhDN
         YxzU/dJ8+Nbpk3wJAh65EUsGxWwynOfdkgf7PHyfhQ8sETAK/oqIftYIfsnthGwGK6YJ
         IUYQ==
X-Gm-Message-State: ACrzQf0VJOjS1W0Ss1tMu3huh6/TyWwPyt20UV7BHKrWJMlbNs+ah0h0
        B/7AAuwfschgYgVva/BapBwxLZyiZAQqPRlcREzjxgRAMG6Bj7uVZygdBYSTe+mMinc/MsCl5dM
        41MQJVYp+sRj0TjC1Ng/AUQT6FiqrkscS+w1sEQCMsW0UyhBK4c9iFazhM6z3dhn6U18eWvDGaA
        ==
X-Received: by 2002:aa7:8750:0:b0:56c:318a:f811 with SMTP id g16-20020aa78750000000b0056c318af811mr48662454pfo.14.1667807249802;
        Sun, 06 Nov 2022 23:47:29 -0800 (PST)
X-Google-Smtp-Source: AMsMyM58IgxAa4t6zhJ5Ig9aVRVRRguY43dC1mCgSfPeAWW24MmCEWrDnBo8UXHD4us991OwHxOLIg==
X-Received: by 2002:aa7:8750:0:b0:56c:318a:f811 with SMTP id g16-20020aa78750000000b0056c318af811mr48662426pfo.14.1667807249400;
        Sun, 06 Nov 2022 23:47:29 -0800 (PST)
Received: from [10.72.12.88] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b0016d72804664sm4294618plh.205.2022.11.06.23.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 23:47:29 -0800 (PST)
Subject: Re: [PATCH] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103153619.11068-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <700018a6-aff7-6e7a-98df-2fc8cca39acb@redhat.com>
Date:   Mon, 7 Nov 2022 15:47:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221103153619.11068-1-lhenriques@suse.de>
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


On 03/11/2022 23:36, Luís Henriques wrote:
> Because ceph_init_fs_context() will never be invoced in case we get a
> mount error, destroy_mount_options() won't be releasing fscrypt resources
> with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
> an invocation to this function in the mount error path.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/super.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 2224d44d21c0..6b9fd04b25cd 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1362,6 +1362,7 @@ static int ceph_get_tree(struct fs_context *fc)
>   
>   	ceph_mdsc_close_sessions(fsc->mdsc);
>   	deactivate_locked_super(sb);
> +	fscrypt_free_dummy_policy(&fsc->fsc_dummy_enc_policy);

Hi Luis,

BTW, any reason the following code won't be triggered ?

deactivate_locked_super(sb);

   --> fs->kill_sb(s);

         --> ceph_kill_sb()

               --> kill_anon_super()

                     --> generic_shutdown_super()

                           --> sop->put_super()

                                 --> ceph_put_super()

                                       --> ceph_fscrypt_free_dummy_policy()

                                            --> fscrypt_free_dummy_policy(

Thanks!

- Xiubo


>   	goto out_final;
>   
>   out:
>

