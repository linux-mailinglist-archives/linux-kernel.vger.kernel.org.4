Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B85E9B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiIZIHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiIZIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7A1A83D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664179510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEaIpM2M16xMJopiwVq/id6X3ZOhbK3867/FHXeVBbY=;
        b=g8Ql32CBaEFqzxDSgFkf/ygDHegyN981+ENzyAYqLSggUTXTHQ3Sfalt7SJK6GRkOVKu19
        cZ3FUzYBUNgXiRmDBR4xQXOvs6/8j0BTR8d1olbwYLU3te0assPPSTZqrjNfc+GGwTVnzO
        QksyOGDgbLZgwKS2rQXmqxSyhvidSl4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-428-BuQ2S2eTPN-JMv4jq4WNVA-1; Mon, 26 Sep 2022 04:05:08 -0400
X-MC-Unique: BuQ2S2eTPN-JMv4jq4WNVA-1
Received: by mail-wm1-f71.google.com with SMTP id c3-20020a7bc843000000b003b486fc6a40so1558300wml.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=HEaIpM2M16xMJopiwVq/id6X3ZOhbK3867/FHXeVBbY=;
        b=cwEQmHz31Dpm4q3M9j5L2lLtZMM/VH8JyLGymGb7plHBOUOE4eNgmWz9iZF6WH5ZV3
         A7r4DJthkkB2bv/jWqSfomxKvN+NvJpSy0AqgfctN8rihbp5LpAg156CszTnrnCO03zu
         tOGhjKA0bQbCZ02QRmaBpuc6RXz7hYS1OfF/2CydAPyj2jzQqlJv8vHKolRLKMt0bpbu
         bi1I6wt2bLMtXS3+ybmDJ0zpORR7wEvs8stUOVYSVWxEsXRbqDjd60hTyJMIAJfS4neV
         LMFln7gjMUlRyU3i2HRj61/l6dqT2at0CUsin2LK22XVafhzCi9TqHdUxyse+zVuyD9d
         hBXQ==
X-Gm-Message-State: ACrzQf24fm6yE7VzOzhA7Au1ofFA7YA0t1TZ2oBjpP9daol/GxS2TLsB
        aJ53M+fNVAxl0iEhC47EKaoP5+B2gvv8aj53OmKbfu3oMN8tMLriwqLoRJ8wsPvY1ZYSu3G/fFV
        NYq0mMaKXPOwIdwHDduCYm2Y6
X-Received: by 2002:a5d:628e:0:b0:228:6961:aa6f with SMTP id k14-20020a5d628e000000b002286961aa6fmr13182648wru.36.1664179507813;
        Mon, 26 Sep 2022 01:05:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4J7x73T6JSoN1RTPwEm4yUUW3MfoxwZ/vG03LyK4X5HKwl6uK5ImJt70EFv1g7qMgngcw8gg==
X-Received: by 2002:a5d:628e:0:b0:228:6961:aa6f with SMTP id k14-20020a5d628e000000b002286961aa6fmr13182625wru.36.1664179507566;
        Mon, 26 Sep 2022 01:05:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d4891000000b0022a2bacabbasm13989707wrq.31.2022.09.26.01.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:05:07 -0700 (PDT)
Message-ID: <a99f0684-b075-7fc5-082a-2c0cc706574b@redhat.com>
Date:   Mon, 26 Sep 2022 10:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter counter
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-5-naoya.horiguchi@linux.dev>
 <20220923082613.GB1357512@ik1-406-35019.vs.sakura.ne.jp>
 <20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   /*
> @@ -2414,6 +2417,10 @@ int unpoison_memory(unsigned long pfn)
>   unlock_mutex:
>   	mutex_unlock(&mf_mutex);
>   	if (!ret || freeit) {
> +		/*
> +		 * TODO: per-memory_block counter might break when the page
> +		 * size to be unpoisoned is larger than a memory_block.
> +		 */

Hmm, but that happens easily e.g., with 1 GiB hugetlb page and 128 MiB 
memory section/block size. What would be the right thing to do here? The 
TODO should rather spell that out instead of just stating the problem.

-- 
Thanks,

David / dhildenb

