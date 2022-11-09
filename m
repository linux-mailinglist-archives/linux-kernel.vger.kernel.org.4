Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335026227CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKIJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKIJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B523162
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667987872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDMpqou/pq7flrplrADwoL3gK1upqLAy4b6L3fxBqxM=;
        b=ehEHEDtatx7qIa9xWC67h99ZWbWlkr7Q1oLwCPkiz0AgAClpbprhVvF61OCAaVh3/zGPp6
        UQhP07tcoBFk/nnc1vmNQ3uMejVEnGQPH/MXH3qdJNsu0g7JupkSbF1vvCp1y23F41y1mz
        NDoAXUWj9j3pCoUnKHZEtjLYLH/h7uw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-NZq3wGdDM46Env-KSmzkOA-1; Wed, 09 Nov 2022 04:57:51 -0500
X-MC-Unique: NZq3wGdDM46Env-KSmzkOA-1
Received: by mail-pl1-f199.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so13128006plh.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDMpqou/pq7flrplrADwoL3gK1upqLAy4b6L3fxBqxM=;
        b=TBW9Dojl5EPLmEarjr0oDxGTQzcWBHPzBMjqHERSicU1xQkf3U56gtjv81dZV0xvr5
         XJnyUfmbth0sGtyKigBxb3Oo15F24LmS3gjZq4NJPogEiCBEz/BEG9yrbEHCBRvIE8GB
         s4leQFsE4mL23cf8xknxF2xxoZTQiLNKqEDqqa3fKrXvdUZScvRdE+Jr8nIFknOnZWom
         +zU6OO22DgrPU8U4WajkP2JQ4ufl3ouxKMEc3DXXFAu7iM8APaI9VGpOVe8D/bUq/6mg
         yN7You+wxfabJOo39GwW97/C3BwP1PuXrfXx8yjfJt11SvT7dg1qj8/tmhKxwFBdchyo
         lu+w==
X-Gm-Message-State: ACrzQf0ijR4kBrcJtyGgf0ASj4bOcKvemfwAGyDGBUci9VIGvRcPVuTC
        sS0nIVLgDoOoGv8ipQFSCIA5dYmWDUv/C4fW6JNdo0Pew/kS6VDtA7n2RzBV2S7mID57TOVuXz+
        m1dno+frRJrLRLPUX6cWBiUewT/Ge8jU5teht1DEFazMJyvaQkG35cKfgO3aWBTC2B+97m28vQg
        ==
X-Received: by 2002:a17:90a:bf11:b0:211:84c5:42d7 with SMTP id c17-20020a17090abf1100b0021184c542d7mr77174042pjs.122.1667987870111;
        Wed, 09 Nov 2022 01:57:50 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6F7rSxTnk1TNm4PMzbEEH6hs03HVKe/bAPHQIOZ8CM5D8D/l93IJ2riWbVWdU2U5LdEV5HFw==
X-Received: by 2002:a17:90a:bf11:b0:211:84c5:42d7 with SMTP id c17-20020a17090abf1100b0021184c542d7mr77174013pjs.122.1667987869816;
        Wed, 09 Nov 2022 01:57:49 -0800 (PST)
Received: from [10.72.12.229] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b001869581f7ecsm8701777plk.116.2022.11.09.01.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:57:49 -0800 (PST)
Subject: Re: [PATCH v2] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221108143421.30993-1-lhenriques@suse.de>
 <215b729e-0af0-45d8-96af-3d3c319581c9@redhat.com> <Y2tz8zQPlTWtfOdw@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <614e430a-a559-e640-b2f3-020db758c061@redhat.com>
Date:   Wed, 9 Nov 2022 17:57:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y2tz8zQPlTWtfOdw@suse.de>
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

Hi Luis,

Please check 
https://github.com/ceph/ceph-client/commit/205efda80b6759a741dde209a7158a5bbf044d23#diff-eb62c69f842ed95a7d047262a62946b07eda52f2ea49ae33c39ea13754dfc291.

Currently I only applied it into the 'testing' branch.

Thanks!

- Xiubo


On 09/11/2022 17:33, Luís Henriques wrote:
> On Wed, Nov 09, 2022 at 11:08:49AM +0800, Xiubo Li wrote:
>> On 08/11/2022 22:34, Luís Henriques wrote:
>>> Because ceph_init_fs_context() will never be invoced in case we get a
>>> mount error, destroy_mount_options() won't be releasing fscrypt resources
>>> with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
>>> an invocation to this function in the mount error path.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>> * Changes since v1:
>>>
>>> As suggested by Xiubo, moved fscrypt free from ceph_get_tree() to
>>> ceph_real_mount().
>>>
>>> (Also used 'git format-patch' with '--base' so that the bots know what to
>>> (not) do with this patch.)
>>>
>>>    fs/ceph/super.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>> index 2224d44d21c0..f10a076f47e5 100644
>>> --- a/fs/ceph/super.c
>>> +++ b/fs/ceph/super.c
>>> @@ -1196,6 +1196,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>>>    out:
>>>    	mutex_unlock(&fsc->client->mount_mutex);
>>> +	ceph_fscrypt_free_dummy_policy(fsc);
>>>    	return ERR_PTR(err);
>>>    }
>>>
>>> base-commit: 8b9ee21dfceadd4cc35a87bbe7f0ad547cffa1be
>>> prerequisite-patch-id: 34ba9e6b37b68668d261ddbda7858ee6f83c82fa
>>> prerequisite-patch-id: 87f1b323c29ab8d0a6d012d30fdc39bc49179624
>>> prerequisite-patch-id: c94f448ef026375b10748457a3aa46070aa7046e
>>>
>> LGTM.
>>
>> Thanks Luis.
>>
>> Could I fold this into the previous commit ?
> Yes, sure.  I'm fine with that.
>
> Cheers,
> --
> Luís
>

