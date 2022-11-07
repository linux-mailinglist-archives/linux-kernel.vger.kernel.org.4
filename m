Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B961F17D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKGLIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiKGLH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55A1A053
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667819208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfoxAkUieJiDshj6YFSSi7blwnZDbIaEzgA6N7hJ03A=;
        b=UgEUzMcBkgVMN2o+gHIjg+GnSM4392nPmNQI/sNo6TXyE5f/OOadP83Y646RAtDP/TeoC1
        2Q65JHPGaztKa1ldZIlS+HtOc2BIpnC7fxxd9nvltt+ut+/9u1CUSjGSwYYNKmsqdVpaBL
        GwtKBh6yOip/8P1Lxv2wKVyCMNIZluQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-YFq68kP1NLyzFxctDltZbA-1; Mon, 07 Nov 2022 06:06:47 -0500
X-MC-Unique: YFq68kP1NLyzFxctDltZbA-1
Received: by mail-pj1-f72.google.com with SMTP id ch8-20020a17090af40800b002140ba517b6so4432702pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 03:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfoxAkUieJiDshj6YFSSi7blwnZDbIaEzgA6N7hJ03A=;
        b=I3+r6fhsax1A1b5IsK04PhHw0M684eEWMdyaAs/KXrhQ0aYqvybaN5Ewv7Y6HqGqCT
         Ula/QyV79rDX92ddmA36Llnk3C/5km0WeESbizV9+dPlEhoClLUOJWyr+U0KAU4SGStN
         /yIN90PQP2WpTk5WBmCne9wrz/47Bmdx6cYyeKTDkS7g++tY+ZphFDGRUCSGHF3gR/Xk
         t61MHCCDPWdsHZxna1l4iBZkkzXvSvUw6zJ+yTPUlD2eWtvLXv50CZltrWZrk+zpvICp
         OMRxhYVzdK0vB10bHfMogNCS59TXFnAHxW8R73WgebMOppvl6bNsrIjAr8pWTWvcmtzM
         Py8g==
X-Gm-Message-State: ACrzQf10N/yJELVLWzsY8yeMmeBAHcarAlwE30GufTpiMXO1vRJ22xZq
        +KeAC5HIJg7R644R49HImA9dtD3AfpmxT3R0v7rAXG+LbcFoN4951ElkMPKRBDFwOiDsaAnqjZX
        Sec+7L0CGeYcneYNBAQ/1mLw1utEKeyAwA2cHBWrwvpEtZSL66LFus9wqNab0yXnf3EjNP8VpXw
        ==
X-Received: by 2002:a17:90b:278b:b0:213:c2f2:6ca1 with SMTP id pw11-20020a17090b278b00b00213c2f26ca1mr45598039pjb.103.1667819206717;
        Mon, 07 Nov 2022 03:06:46 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4tw4ybAx5dZhRkPIzgym51Z/WimN/enhmbKm9E7JoxBfhwzxWIsrzsgL3EPJOjvlKycjjzog==
X-Received: by 2002:a17:90b:278b:b0:213:c2f2:6ca1 with SMTP id pw11-20020a17090b278b00b00213c2f26ca1mr45598012pjb.103.1667819206357;
        Mon, 07 Nov 2022 03:06:46 -0800 (PST)
Received: from [10.72.12.88] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 97-20020a17090a09ea00b0020d45a155d9sm5848707pjo.35.2022.11.07.03.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 03:06:46 -0800 (PST)
Subject: Re: [PATCH] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221103153619.11068-1-lhenriques@suse.de>
 <700018a6-aff7-6e7a-98df-2fc8cca39acb@redhat.com> <Y2jcrbZxgmLO/psM@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <afd5902a-3e79-a6d9-fcd7-abee276c5504@redhat.com>
Date:   Mon, 7 Nov 2022 19:06:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y2jcrbZxgmLO/psM@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
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


On 07/11/2022 18:23, Luís Henriques wrote:
> On Mon, Nov 07, 2022 at 03:47:23PM +0800, Xiubo Li wrote:
>> On 03/11/2022 23:36, Luís Henriques wrote:
>>> Because ceph_init_fs_context() will never be invoced in case we get a
>>> mount error, destroy_mount_options() won't be releasing fscrypt resources
>>> with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
>>> an invocation to this function in the mount error path.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>    fs/ceph/super.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>> index 2224d44d21c0..6b9fd04b25cd 100644
>>> --- a/fs/ceph/super.c
>>> +++ b/fs/ceph/super.c
>>> @@ -1362,6 +1362,7 @@ static int ceph_get_tree(struct fs_context *fc)
>>>    	ceph_mdsc_close_sessions(fsc->mdsc);
>>>    	deactivate_locked_super(sb);
>>> +	fscrypt_free_dummy_policy(&fsc->fsc_dummy_enc_policy);
>> Hi Luis,
>>
>> BTW, any reason the following code won't be triggered ?
>>
>> deactivate_locked_super(sb);
>>
>>    --> fs->kill_sb(s);
>>
>>          --> ceph_kill_sb()
>>
>>                --> kill_anon_super()
>>
>>                      --> generic_shutdown_super()
>>
>>                            --> sop->put_super()
>>
>>                                  --> ceph_put_super()
>>
>>                                        --> ceph_fscrypt_free_dummy_policy()
>>
>>                                             --> fscrypt_free_dummy_policy(
>>
> Here's what I'm seeing here:
>
>    sys_mount->path_mount->do_new_mount->vfs_get_tree->ceph_get_tree
>
> ceph_get_tree() fails due to ceph_real_mount() returning an error.  My
> understanding is that that, since fc->root is never set, that code path
> will never be triggered.  Does that make sense?

Okay, you are right!

How about fixing it in ceph_real_mount() instead ?

>
> An easy way to reproduce is by running fstest ceph/005 with the
> 'test_dummy_encryption' option.  (I'll probably need to send a patch to
> disable this test when this option is present.)

Anyway this should be fixed in kceph.

Thanks!

- Xiubo


>
> Cheers,
> --
> Luís
>

