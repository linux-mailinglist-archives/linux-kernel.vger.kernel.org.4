Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E20B612A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 13:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ3Mi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Mi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 08:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561ABBE29
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667133481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4B60fz/P8rMNitGf54Tbbilnbc37g2F5GF/ziw5C6k=;
        b=F1mL5OBMJx7mAsh4526rz80RfvXqkVZypHizc5CZgClOQKcnIR6dczQirn24YkgClndKC7
        91q6gxY7+cHXlXtTZRo+R5fqPC7dg+afC3FeC/7sE+SnjvxuxGA/03e++9VCVa+6dV52pu
        JeBfYHg46sz7+IR6oV9fkVV76kMq38E=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-m8qZF0qXPCSu5cpd2qf67w-1; Sun, 30 Oct 2022 08:37:59 -0400
X-MC-Unique: m8qZF0qXPCSu5cpd2qf67w-1
Received: by mail-pg1-f199.google.com with SMTP id 7-20020a630007000000b0045bb8a49ae6so4616109pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 05:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4B60fz/P8rMNitGf54Tbbilnbc37g2F5GF/ziw5C6k=;
        b=7kW026usU9QnnmB2y1oJyU0mHL/CqSTYzUR36YxJj89pNqYQDoPbFxmo3vSisFQYqP
         dilPugvGSfuUyyVBlXWJWhRrqWF6YUv2upl0jVSm7T2T7WBl/c+FDjgiAgP079tUSI2g
         sxVL8xZk2BCH/XEPouvAm6AAD5lJCk1/rAgu6tJoRh2vgF20fi7y4PC23roBdeBBu5Cn
         DRkrEvPRKhg0iorZCSDZpKMDm8fOjNZYSTe00HKu3+3WOX9nfePJyG/rWsb7d6Xq0Xp4
         1EdhrK8pPDgkVB1g5fIM85OJhFCYMCsiW9rGsU8i+grbzMERVzufRBr9pjL4hJnFHMkE
         z7mA==
X-Gm-Message-State: ACrzQf2Em62VV8zDnpOiPXKSum1bDEJpTRf/ne0kyV07/Isb/RdFKRWk
        rO0IBoPe0JwkdhpVGG1vcKpteGMXAiGtnN9v9Qaj9GoZSGsKOnwRJR/JxqEMSIrYEO/UcpjixeQ
        ENA4ItpUW+mqsX/RnRNaykFq2q0mR0hxm6LhOdVOb4hT7HvIXVDSzc1l6g4LhQ6FI+7OqEnjd4Q
        ==
X-Received: by 2002:a63:d015:0:b0:46f:b2a4:a34e with SMTP id z21-20020a63d015000000b0046fb2a4a34emr1589601pgf.594.1667133478499;
        Sun, 30 Oct 2022 05:37:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7wx6dkdTVFo+415zaVL0RwQ+2N45bWZGXiDPkCjdPgoRT47nm++TlMPHls4LYRxt/QVWGdvA==
X-Received: by 2002:a63:d015:0:b0:46f:b2a4:a34e with SMTP id z21-20020a63d015000000b0046fb2a4a34emr1589569pgf.594.1667133478077;
        Sun, 30 Oct 2022 05:37:58 -0700 (PDT)
Received: from [10.72.13.65] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902ca0300b00186a8085382sm2675327pld.43.2022.10.30.05.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 05:37:57 -0700 (PDT)
Subject: Re: [PATCH] ceph: fix mdsmap decode for v >= 17
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027152811.7603-1-lhenriques@suse.de>
 <8b666226-ef41-13ae-c90c-aaa5f499b0a0@redhat.com> <Y1ubPgzSm7YATBRv@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <2d9ab5c4-4921-ff19-c027-865ec0f415ca@redhat.com>
Date:   Sun, 30 Oct 2022 20:37:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y1ubPgzSm7YATBRv@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/10/2022 17:05, Luís Henriques wrote:
> On Fri, Oct 28, 2022 at 09:28:37AM +0800, Xiubo Li wrote:
>> On 27/10/2022 23:28, Luís Henriques wrote:
>>> Commit d93231a6bc8a ("ceph: prevent a client from exceeding the MDS
>>> maximum xattr size") was merged before the corresponding MDS-side changes
>>> have been merged.  With the introduction of 'bal_rank_mask' in the mdsmap,
>>> the decoding of maps with v>=17 is now incorrect.  Fix this by skipping
>>> the 'bal_rank_mask' string decoding.
>>>
>>> Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>> Hi!
>>>
>>> This inconsistency was introduced by ceph PR #43284; I think that, before
>>> picking this patch, we need to get PR #46357 merged to avoid new
>>> problems.
>>>
>>> Cheers,
>>> --
>>> Luís
>>>
>>>    fs/ceph/mdsmap.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
>>> index 3fbabc98e1f7..fe4f1a6c3465 100644
>>> --- a/fs/ceph/mdsmap.c
>>> +++ b/fs/ceph/mdsmap.c
>>> @@ -379,6 +379,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
>>>    		ceph_decode_skip_8(p, end, bad_ext);
>>>    		/* required_client_features */
>>>    		ceph_decode_skip_set(p, end, 64, bad_ext);
>>> +		/* bal_rank_mask */
>>> +		ceph_decode_skip_string(p, end, bad_ext);
>>>    		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
>>>    	} else {
>>>    		/* This forces the usage of the (sync) SETXATTR Op */
>>>
>> Luis,
>>
>> Because the ceph PR #43284 will break kclient here and your xattr size patch
>> got merged long time ago, we should fix it in ceph. More detail please see
>> my comments in:
>>
>> https://github.com/ceph/ceph/pull/46357#issuecomment-1294290492
> OK, agreed.  I'll update this PR to try to fix it on the MDS side
> instead.  And let's try to have it merged as soon as possible to prevent
> further issues.

Sounds good!

- Xiubo


> Cheers,
> --
> Luís
>

