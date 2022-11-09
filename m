Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17277622D16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKIOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKIOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:02:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E3E75
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668002489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Vl9+3D8jIkkIQI/8eeviV4h7Hg0ItDX7Hqx/i0QKXk=;
        b=cWYx/XOe0xcIcbAR8e7uusEoWZC6AVhBmZ2OjlyRGLpIvpAU7ySdwi24TFfpyT/s8N8zEs
        hJtK7F7rg+qAu8KB7ox0Ruq1+mhatC46LLPLDYg2eCqZLeVsl6IZe7Jptphy6tNTH9vpN2
        WG/akvxVvMdt0rdeKMG7IA1pSfC4G2g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-DE7d-ydXMB-YqOEcx-928g-1; Wed, 09 Nov 2022 09:01:28 -0500
X-MC-Unique: DE7d-ydXMB-YqOEcx-928g-1
Received: by mail-pl1-f198.google.com with SMTP id s15-20020a170902ea0f00b00187050232fcso13402485plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Vl9+3D8jIkkIQI/8eeviV4h7Hg0ItDX7Hqx/i0QKXk=;
        b=uomnyNugWMUB5wItw3pGDLWs8bZ8N13y/6AL3o+s1H+xOYGvGyEqAuEP6iBrPR5F8e
         bWpMmrpJKz7JqVztlHuZyZbUCLEU0P4wmpSF4yPcKBCQnc+RW7v5ExOEZ2vDs2ADqosS
         iDCWbMzeB32xngwk3dxZ2akUxtM7oqQXxeNKWXBcCaFijyRNF9sT+01yOzXQ0omY/Np6
         95AM8Am3zthD/vrjmxRNmiWbKYsNWLMw5l1Fu2GptCv8kZVgk28KfsbRh1v2npTB1Jrs
         L+WHxU2+fpfvMWNQLGtbG9aoxi23v7oQU94GnL4KN6BjiBulVLc9UPTBix4rx0Pyv6rE
         EQLg==
X-Gm-Message-State: ACrzQf3p+pc7nCSMxPMnIP8eHLWDMYC/k3O2t8fqjiCQ9B8M4KcALIiM
        DyO5lqR2FQCCjXmWTbd0frkQ2g9llJ6Wz4nJ15/QtAHYSBfyX+Z5GEvBjwSSfwiAWZ0IzGWbZJc
        y52CUO0vM8//R4U+nRP/yJzrO/0O4SNYQyfs83Pt2Eq4gPeVfBTTc4f5g9slEVMNSYB/r1btDDQ
        ==
X-Received: by 2002:a17:902:e811:b0:186:8a61:ea76 with SMTP id u17-20020a170902e81100b001868a61ea76mr61905107plg.10.1668002485472;
        Wed, 09 Nov 2022 06:01:25 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4BZ8m3HdU4oR37bcIdyvX5RRjTSYp2lO2296eOedPK4Gaj017xxhb14Kd85YESsbfypbF+dg==
X-Received: by 2002:a17:902:e811:b0:186:8a61:ea76 with SMTP id u17-20020a170902e81100b001868a61ea76mr61905053plg.10.1668002484869;
        Wed, 09 Nov 2022 06:01:24 -0800 (PST)
Received: from [10.72.12.148] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902768700b00186b549cdc2sm9111540pll.157.2022.11.09.06.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:01:24 -0800 (PST)
Subject: Re: [PATCH v2] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221108143421.30993-1-lhenriques@suse.de>
 <215b729e-0af0-45d8-96af-3d3c319581c9@redhat.com> <Y2tz8zQPlTWtfOdw@suse.de>
 <614e430a-a559-e640-b2f3-020db758c061@redhat.com> <Y2uDCwDf+ZgKcRqu@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <dddccd91-9866-adb4-3497-ecfeb936e211@redhat.com>
Date:   Wed, 9 Nov 2022 22:01:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y2uDCwDf+ZgKcRqu@suse.de>
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


On 09/11/2022 18:38, Luís Henriques wrote:
> On Wed, Nov 09, 2022 at 05:57:41PM +0800, Xiubo Li wrote:
>> Hi Luis,
>>
>> Please check https://github.com/ceph/ceph-client/commit/205efda80b6759a741dde209a7158a5bbf044d23#diff-eb62c69f842ed95a7d047262a62946b07eda52f2ea49ae33c39ea13754dfc291.
> Ugh! That's quite confusing :-)
>
> I did a 'git fetch' and looked into commit 205efda80b67 ("ceph: implement
> -o test_dummy_encryption mount option") instead, and compared it with it's
> version in the wip-fscrypt branch.  It looks good to me: the only
> difference I see is my fix (adding the 'ceph_fscrypt_free_dummy_policy'
> call to 'ceph_real_mount').  Thanks!

I will update the wip-fscrypt branch later.

Thanks!


> Cheers,
> --
> Luís
>
>> Currently I only applied it into the 'testing' branch.
>>
>> Thanks!
>>
>> - Xiubo
>>
>>
>> On 09/11/2022 17:33, Luís Henriques wrote:
>>> On Wed, Nov 09, 2022 at 11:08:49AM +0800, Xiubo Li wrote:
>>>> On 08/11/2022 22:34, Luís Henriques wrote:
>>>>> Because ceph_init_fs_context() will never be invoced in case we get a
>>>>> mount error, destroy_mount_options() won't be releasing fscrypt resources
>>>>> with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
>>>>> an invocation to this function in the mount error path.
>>>>>
>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>> ---
>>>>> * Changes since v1:
>>>>>
>>>>> As suggested by Xiubo, moved fscrypt free from ceph_get_tree() to
>>>>> ceph_real_mount().
>>>>>
>>>>> (Also used 'git format-patch' with '--base' so that the bots know what to
>>>>> (not) do with this patch.)
>>>>>
>>>>>     fs/ceph/super.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>>>> index 2224d44d21c0..f10a076f47e5 100644
>>>>> --- a/fs/ceph/super.c
>>>>> +++ b/fs/ceph/super.c
>>>>> @@ -1196,6 +1196,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>>>>>     out:
>>>>>     	mutex_unlock(&fsc->client->mount_mutex);
>>>>> +	ceph_fscrypt_free_dummy_policy(fsc);
>>>>>     	return ERR_PTR(err);
>>>>>     }
>>>>>
>>>>> base-commit: 8b9ee21dfceadd4cc35a87bbe7f0ad547cffa1be
>>>>> prerequisite-patch-id: 34ba9e6b37b68668d261ddbda7858ee6f83c82fa
>>>>> prerequisite-patch-id: 87f1b323c29ab8d0a6d012d30fdc39bc49179624
>>>>> prerequisite-patch-id: c94f448ef026375b10748457a3aa46070aa7046e
>>>>>
>>>> LGTM.
>>>>
>>>> Thanks Luis.
>>>>
>>>> Could I fold this into the previous commit ?
>>> Yes, sure.  I'm fine with that.
>>>
>>> Cheers,
>>> --
>>> Luís
>>>

