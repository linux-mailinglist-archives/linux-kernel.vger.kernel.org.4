Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D598262274D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiKIJlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiKIJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:41:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD3DCE8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667986812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FARa1HV2KzyDd5klYHusJbaZIKaWoNQyStFBhGdEdEk=;
        b=HVWiT/bvXTeyhNUAV1c/E8vDJP2cBNJJ5yvtiwPyQCfC8awtfKSN+gPsMhEG5J1ZZmNSV8
        Ss7ruQNNl96O6M+JxP4anCBi4y/yBIOf7Lov3f20e3FPI5u6FcEd8sJKMvfQXTJ7KCoIKm
        MX65h6T7X3giAwFHddoe0FvTodSvEak=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-8CH-hShZO0-FnYASkOqYzg-1; Wed, 09 Nov 2022 04:40:11 -0500
X-MC-Unique: 8CH-hShZO0-FnYASkOqYzg-1
Received: by mail-pl1-f198.google.com with SMTP id c7-20020a170903234700b0018729febd96so13092441plh.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FARa1HV2KzyDd5klYHusJbaZIKaWoNQyStFBhGdEdEk=;
        b=5nn8PfliiraqUgTCcCEcZv44UAL61i8rQVszqx7OgaS5J+cBeAmGZAvTSuqjXUlFWe
         io1TphijJo3ubMz87O12L+S4zaKJMg7gZKZ5q3nMefdjL9EV/ij94+IIBlICE16cNx0m
         TBYMrVxpDTfxNUfjYkljvAGvZs/K91WligOmInBO82E9FS7NmZzoBZp+dMe/JUk/EJQ6
         B0zUjjFsUgHQWyWw6XC+U3u4RTyTuOMJAqdQPrJattdLu82hDk0aG0i0Fb++eLN3IkqE
         uuY9u1biF6vhX+7jsxGeAF9Bd8kcNZw1Jow8wpUj7XFDm1qjPIObQUj8Jmtm80fbT3GE
         /JTw==
X-Gm-Message-State: ACrzQf13gzKpgh7dzezyk28hB+tjqKFtYrY+3VTc6s5qxo5GCbR378MJ
        fe8hcxDoGGl0NjYTAaaTxO2g1KHUmQLbZ7uP7zkKA0IM2V5ujUCYYbZMzERX6/NQ23/QLFStECN
        loau8RX7P73vGoyqW0VoasGfvxRgPpQxFcQ2wplb5z7XY4Dt+qjHwnCLQ2qTL1U+kvZt/pMdmBw
        ==
X-Received: by 2002:a05:6a00:179c:b0:56c:db33:9980 with SMTP id s28-20020a056a00179c00b0056cdb339980mr60589035pfg.76.1667986810462;
        Wed, 09 Nov 2022 01:40:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4CCcxTxJVun9YTMpzxXDu9w5IA2i4NpJ7dc8G/hUk3xEM7acScmuLMNK+6jX8ckWu0QZrpXQ==
X-Received: by 2002:a05:6a00:179c:b0:56c:db33:9980 with SMTP id s28-20020a056a00179c00b0056cdb339980mr60589010pfg.76.1667986810124;
        Wed, 09 Nov 2022 01:40:10 -0800 (PST)
Received: from [10.72.12.229] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i8-20020aa796e8000000b0056281da3bcbsm8076610pfq.149.2022.11.09.01.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:40:09 -0800 (PST)
Subject: Re: [PATCH v2] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221108143421.30993-1-lhenriques@suse.de>
 <215b729e-0af0-45d8-96af-3d3c319581c9@redhat.com> <Y2tz8zQPlTWtfOdw@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <444977b8-dbe3-1819-d4dd-b56a0a4aaf4f@redhat.com>
Date:   Wed, 9 Nov 2022 17:40:01 +0800
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

Thanks.

I will mentioned this fix in that commit comments.

- Xiubo


>
> Cheers,
> --
> Luís
>

