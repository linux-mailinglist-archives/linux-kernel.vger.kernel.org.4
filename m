Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE745EF01E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiI2IP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiI2IPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928B1114EA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664439317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGXHV6nws60kbN7IUHu6/7cTkMhU5QGMA+F9vF0u7F0=;
        b=i6tDbAJxlAEXbNa0UjAzAswaGEpNC1Cixec9hHaH/YPMtx9YFjcUQwsyvO8Sv5AgwUIBi/
        cVizmU9bFyBhqwgPYqvyVDV/X8szd8iGNIQaRyPLGWaKQbDjUeW42AqHhRZI+p7VrqnAc7
        +ZKTRXlpKqHrCBMDxI6W27HwOjhd0Fk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-FOa-iXBsOzyTRg0mGutyBg-1; Thu, 29 Sep 2022 04:15:16 -0400
X-MC-Unique: FOa-iXBsOzyTRg0mGutyBg-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso2624826wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=HGXHV6nws60kbN7IUHu6/7cTkMhU5QGMA+F9vF0u7F0=;
        b=UsKdZBxCJU+1nEh7pS6amhym8gfRtQ5A1bkzK5w5o8yhqvI4cu4weK8rBnwSZY/r6b
         ZHbs25RnsbP2siHlBrf7uYg8WiOLLcqWArRWaZOyb+vfdPtmEWo9Rp53YmKW1QvfGMxT
         Bbr+P9CHAAbnF48i7XT0pHw3lkrF0go4CwwzOQK+eJZSJy0diFrkEsvDSc6nNOroakJO
         WVh5CA/O7lagIYQbx2EDbPQaZNJRpbZTfi/BxAqO5nIXG98V/TvnXnHah1NHL1U/YCYo
         BAWrOPLCjWE35LPv7/OcXhVMyjVCxn+O5bg5nkrXvFoaS5YCnY6cNLx5uQAV0UooWvZP
         fznQ==
X-Gm-Message-State: ACrzQf1pZVsDcoDVCZXfC9CP0Jmvch6cm8LdYdn9olp4vGkLlB5pQBih
        4t6jHtCT3srTy4HYJFokrENHqnJJrxocUGKrP72yGForFA+/cXi+rQkJjTNDAA/Eze+kTq2Ka4d
        n8pZOetm4ZwQTeHvRj1kacgxX
X-Received: by 2002:a5d:504c:0:b0:228:db0e:a4c9 with SMTP id h12-20020a5d504c000000b00228db0ea4c9mr1299909wrt.272.1664439315055;
        Thu, 29 Sep 2022 01:15:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54jxnN0sDuqOjYfVkz+0Uai3rapONQWcUbZG/jUyignAWN5N/Gq9SKp+8AzTCFUD66/vwakg==
X-Received: by 2002:a5d:504c:0:b0:228:db0e:a4c9 with SMTP id h12-20020a5d504c000000b00228db0ea4c9mr1299889wrt.272.1664439314779;
        Thu, 29 Sep 2022 01:15:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id d16-20020adfe890000000b0021e4829d359sm6033406wrm.39.2022.09.29.01.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:15:14 -0700 (PDT)
Message-ID: <8e61d0f4-0c40-6c2d-da60-fa97e2ee7530@redhat.com>
Date:   Thu, 29 Sep 2022 10:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/9] mm/vmstat: show start_pfn when zone spans pages
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220928223301.375229-1-opendmb@gmail.com>
 <20220928223301.375229-3-opendmb@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220928223301.375229-3-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 00:32, Doug Berger wrote:
> A zone that overlaps with another zone may span a range of pages
> that are not present. In this case, displaying the start_pfn of
> the zone allows the zone page range to be identified.
> 

I don't understand the intention here.

"/* If unpopulated, no other information is useful */"

Why would the start pfn be of any use here?

What is the user visible impact without that change?

> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>   mm/vmstat.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 90af9a8572f5..e2f19f2b7615 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1717,6 +1717,11 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>   
>   	/* If unpopulated, no other information is useful */
>   	if (!populated_zone(zone)) {
> +		/* Show start_pfn for empty overlapped zones */
> +		if (zone->spanned_pages)
> +			seq_printf(m,
> +				   "\n  start_pfn:           %lu",
> +				   zone->zone_start_pfn);
>   		seq_putc(m, '\n');
>   		return;
>   	}
-- 
Thanks,

David / dhildenb

