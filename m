Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E106B0DE5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCHQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjCHP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C85A91A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678291079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAOaGkIwCA5ZS+Sgpcv1TA+3A1d64qpc9FdQuuvh2JU=;
        b=jOyoEStYBhWwlDfyLdGQh7cgWbDany/iGT4BF2F/PISyfOvPoIVltOvNeAJqTyQxP/jY6x
        evGN4lABx7AhaJkla/TN40U/tUo9hQC1oSuVQnJxMq9B2WMXKvvu0SBUY6f0oDlVAOatz6
        a5X2Nk+ixHq6o1c2qN3pc63Gcxmr8pk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-wfMQoFUoOY-I5rxAp2cIeQ-1; Wed, 08 Mar 2023 10:57:58 -0500
X-MC-Unique: wfMQoFUoOY-I5rxAp2cIeQ-1
Received: by mail-wm1-f72.google.com with SMTP id s18-20020a7bc392000000b003deaf780ab6so968492wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291077;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAOaGkIwCA5ZS+Sgpcv1TA+3A1d64qpc9FdQuuvh2JU=;
        b=udWV56+g6a+LwLtJZdx8Ul27NWfOEKvR9bH5FLaeepC/vNvLe1xdnqgvoJUfNRMIJY
         VjZAT5KU69g5dPMJnQN5vV728ROoZ6fTWEOdtzmyOy4ZrDSxAJqiAIXbp3hJDLUeZIKN
         kAk+mYedU4+Sa8LK3jYk9AvqkWRXUvwrm9kn40N4Rq5OXpMEsAePW1WXYSMqlnLHvbgl
         t5ziBlQO8Ryn8vqiqSGOIyVmV+btC+vPi75bj4goBPzINaj97zo/LCK0zDs9+mYteX4F
         s7dK0C04UyNZRKIX874Kljbkpf4E/UX5k10lERqQf4nCIbYKfnFgGJ+7eGdo4HvCcIFe
         eQrQ==
X-Gm-Message-State: AO0yUKVh1KebZGJTMm23XcH2NWOw2eW/+N49SplWdMPX8TWowyD4ve9U
        lsIdxBBde0DNfTsNYilxp/rg0kZOlE1OmfBuoIqw4zPoSWkdZQTHxjXNbwsA4Tbdr+egqBeK5Ha
        Mn4bAP0BSvmUBoW59tVMEjOEmYwpHtmtW
X-Received: by 2002:a05:600c:524c:b0:3e2:24a0:ba26 with SMTP id fc12-20020a05600c524c00b003e224a0ba26mr17175629wmb.16.1678291077571;
        Wed, 08 Mar 2023 07:57:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+0ZbDQv74474xESGT7KsCZ+Z0ADW8mAbBzIT3N2ds/q0PmHEKw5LdZFQNBVgWAbw2ieK8UIA==
X-Received: by 2002:a05:600c:524c:b0:3e2:24a0:ba26 with SMTP id fc12-20020a05600c524c00b003e224a0ba26mr17175606wmb.16.1678291077285;
        Wed, 08 Mar 2023 07:57:57 -0800 (PST)
Received: from [192.168.3.108] (p4ff23d27.dip0.t-ipconnect.de. [79.242.61.39])
        by smtp.gmail.com with ESMTPSA id q10-20020a7bce8a000000b003ea57808179sm20289317wmj.38.2023.03.08.07.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:57:56 -0800 (PST)
Message-ID: <83b3f3ad-19a2-3737-77dd-3c3f9db82194@redhat.com>
Date:   Wed, 8 Mar 2023 16:57:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230306213925.617814-1-peterx@redhat.com>
 <20230306213925.617814-2-peterx@redhat.com>
 <94be7b9f-c33e-c6dc-4132-6cb78f7c0624@redhat.com> <ZAiqPU0RX3JfDFRP@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
In-Reply-To: <ZAiqPU0RX3JfDFRP@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>> With WP_UNPOPUATED, application like QEMU can avoid pre-read faults all the
>>> memory before wr-protect during taking a live snapshot.  Quotting from
>>> Muhammad's test result here [3] based on a simple program [4]:
>>>
>>>     (1) With huge page disabled
>>>     echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
>>>     ./uffd_wp_perf
>>>     Test DEFAULT: 4
>>>     Test PRE-READ: 1111453 (pre-fault 1101011)
>>>     Test MADVISE: 278276 (pre-fault 266378)
>>>     Test WP-UNPOPULATE: 11712
>>>
>>>     (2) With Huge page enabled
>>>     echo always > /sys/kernel/mm/transparent_hugepage/enabled
>>>     ./uffd_wp_perf
>>>     Test DEFAULT: 4
>>>     Test PRE-READ: 22521 (pre-fault 22348)
>>>     Test MADVISE: 4909 (pre-fault 4743)
>>>     Test WP-UNPOPULATE: 14448
>>>
>>> There'll be a great perf boost for no-thp case, while for thp enabled with
>>> extreme case of all-thp-zero WP_UNPOPULATED can be slower than MADVISE, but
>>> that's low possibility in reality, also the overhead was not reduced but
>>> postponed until a follow up write on any huge zero thp, so potentitially it
>>
>> s/potentitially/potentially/
>>
>>> is faster by making the follow up writes slower.
>>
>> What I realized, interrestingly not only the writes, but also the reads. In
> 
> Curious why reading a zeropage would be a problem?

Oh, my thinking was that with markers you postpone placing the shared 
zeropage. So the next read access will require a pagefault to map the 
shared zeropage. Your v1 would have performed best in that case I guess.

-- 
Thanks,

David / dhildenb

