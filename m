Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A973E5B85E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiINKDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiINKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989346CD00
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663149791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1ETyT+v8pgJCm2Ac1OrFwTV0+ZElI/JolxfD221azM=;
        b=aELWjt2FXGhnhNwRe7HZvm2nxnlTzMShZmv5tFn+dQ5V4peGdSkFvAVCJrWczkYMxDMQ4v
        ZJnhL2iQNGN5LQEZhmsg7hPmvErg0qx4b1q6lyZvtweXjCHXVedGQbPRM6a85Y/2BEGAFD
        apxy5Yi3Icss8GOBtt7ll09o7zr18qg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-135-9swZEoYEMvuxcwjuSkx-ww-1; Wed, 14 Sep 2022 06:03:10 -0400
X-MC-Unique: 9swZEoYEMvuxcwjuSkx-ww-1
Received: by mail-wm1-f70.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso10719358wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=c1ETyT+v8pgJCm2Ac1OrFwTV0+ZElI/JolxfD221azM=;
        b=s1UMFWR8tglR2I3o1RTPneZjt+joBUyiV5wWlxloaxuypJWlm5shr4DpE8sjqiRl/u
         FnrcOZ6oCte1ZZnxrJsh7YI4mdoe22lgqlBI/zunztsRqvVCH6UQfgGi+vYpHGMirwX+
         +RIdDxG0BGj92IV+hgPXTt4TM3KhL/G7uPSXsJlG5E4uIDlOPn++YSe0YsXCeouChtj2
         HtInTAZsABmodiXW8/YSzfoIVyH4di27fgvqNj9F+HsK5FSSDx7K+OuLYvCX6G3TC2ZU
         ymJmpvMznZQ3zi/8oFaWRhaR4/EXigOW4djSozDSnIBf9GaDzNwafXQZRnJXgtRXK31p
         3ptQ==
X-Gm-Message-State: ACgBeo3q7hH+tQCM7E5tbGUxdZ313/pEFCdwS1We0izm2/g/BWMTAHgO
        XJmFtO2hqLawANf2zir1r5l+lZqffNq8aJZY4m8Y+hdrt3spdBRxWdcoyWY0NWTEypqcoYMIKdP
        E9mbD7xaUmtrTtRiI2lptzSwe
X-Received: by 2002:adf:fac9:0:b0:228:652b:a33e with SMTP id a9-20020adffac9000000b00228652ba33emr20734046wrs.61.1663149789415;
        Wed, 14 Sep 2022 03:03:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6t54ZB4vYC+AeZy1aRNmx2WUEQiFF9CWkoqYZB6+Tnw9U8ZHRQ21b2Sk/PoUkMxNISv/pVzA==
X-Received: by 2002:adf:fac9:0:b0:228:652b:a33e with SMTP id a9-20020adffac9000000b00228652ba33emr20734024wrs.61.1663149789110;
        Wed, 14 Sep 2022 03:03:09 -0700 (PDT)
Received: from [10.119.22.46] ([89.101.193.71])
        by smtp.gmail.com with ESMTPSA id t3-20020a1c4603000000b003a5c244fc13sm16971787wma.2.2022.09.14.03.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:03:07 -0700 (PDT)
Message-ID: <7d14feb6-24a7-c114-c9c0-9ff3d8f4f448@redhat.com>
Date:   Wed, 14 Sep 2022 12:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] mm: hugetlb: simplify per-node sysfs creation and
 removal
To:     Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Andi Kleen <andi@firstfloor.org>
References: <20220914072603.60293-1-songmuchun@bytedance.com>
 <20220914072603.60293-2-songmuchun@bytedance.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220914072603.60293-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.22 09:26, Muchun Song wrote:
> The following commit offload per-node sysfs creation and removal to a
> kworker and did not say why it is needed.  And it also said "I don't know
> that this is absolutely required".  It seems like the author was not sure
> as well.  Since it only complicates the code, this patch will revert the
> changes to simplify the code.
> 
>    39da08cb074c ("hugetlb: offload per node attribute registrations")
> 
> We could use memory hotplug notifier to do per-node sysfs creation and
> removal instead of inserting those operations to node registration and
> unregistration.  Then, it can reduce the code coupling between node.c and
> hugetlb.c.  Also, it can simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

