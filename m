Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9E6A8043
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCBKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCBKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF033771B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677754059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5S8M7VFiIrjWBjAA3FzviIVL8rgISq30wNe4WT8BzAg=;
        b=TL7wKq/9P7idYtkeYxVycYYw9J69238xmCZxUPCn36vAxian84qTzoCwwLDO2ccTjrxeya
        XnGspdXp6Xe4wFj5ZlXccGvurrgL+LO79d0ZeHMVecM3Ap4YFa+cxSRacMn+vTqeePISkO
        4WxfoETv5AMK3xlvLGvPozY0tKXZEVw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-7PkbwasgMVO2A5pxHfr-5Q-1; Thu, 02 Mar 2023 05:47:38 -0500
X-MC-Unique: 7PkbwasgMVO2A5pxHfr-5Q-1
Received: by mail-wr1-f71.google.com with SMTP id u5-20020a5d6da5000000b002cd82373455so2016971wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S8M7VFiIrjWBjAA3FzviIVL8rgISq30wNe4WT8BzAg=;
        b=YVbGaCBZ6ih5U7nJa3dpvLOmKHANDBacZMxq+o7a9+XLfgkL4MwRxS6h9Ej4sNXEmq
         MwfrhpKODD3c+F5WMfrwJMBtN83Nz9QqFjzhXlC2irM3qssflYr5MvBva/SYxNi/svrh
         BvSxt1asJIb/wB9MgUojMjI/sed5l4fDPQ6/XVU8CzWpUaVT903b9FzIOmfLuhY12Xv7
         2DcHP3elS1x3VL4jqBrG/OnyfHtI8aTiJXuOrP26Ab4tj/JVNNl1wZO3clEUPIeo6FDG
         BQTxZbJX2272p379pvie5IJQ1RlYObdrmQr9we9rY6t0nXXmlZ5HenD5UT+SUAuq3+F7
         VjdQ==
X-Gm-Message-State: AO0yUKVgUlPvcWgeraK4MbwIe8ErqgBraPvYuyIgYW+zEkY+rUgs81ka
        IjiIGZZWpigsFCXr53P6C5dfSxF0j6k5VmbhKSk92tD3CsTW6mNiMApPI8DI2YPzPvepUa/hCCC
        ubJHI+8K/m7xm2cT4hIoglFDB
X-Received: by 2002:a5d:63c6:0:b0:2ca:101e:1056 with SMTP id c6-20020a5d63c6000000b002ca101e1056mr6974944wrw.1.1677754056950;
        Thu, 02 Mar 2023 02:47:36 -0800 (PST)
X-Google-Smtp-Source: AK7set8AlFkoEPhUXgQ2qZuUUweAAfw6iklrEvSxh3Ozh0PDQfe1FKMeP5ddXBc216eHMfeobx/RnA==
X-Received: by 2002:a5d:63c6:0:b0:2ca:101e:1056 with SMTP id c6-20020a5d63c6000000b002ca101e1056mr6974932wrw.1.1677754056612;
        Thu, 02 Mar 2023 02:47:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id w3-20020adff9c3000000b002c7e1a39adcsm15095664wrr.23.2023.03.02.02.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:47:36 -0800 (PST)
Message-ID: <3331790c-95a1-6ab9-2667-86aae3d28d7d@redhat.com>
Date:   Thu, 2 Mar 2023 11:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 08/11] mm/vmstat: switch counter modification to
 cmpxchg
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230209150150.380060673@redhat.com>
 <20230209153204.846239718@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230209153204.846239718@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.23 16:01, Marcelo Tosatti wrote:
> In preparation to switch vmstat shepherd to flush
> per-CPU counters remotely, switch all functions that
> modify the counters to use cmpxchg.
> 
> To test the performance difference, a page allocator microbenchmark:
> https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench01.c
> with loops=1000000 was used, on Intel Core i7-11850H @ 2.50GHz.
> 
> For the single_page_alloc_free test, which does
> 
>          /** Loop to measure **/
>          for (i = 0; i < rec->loops; i++) {
>                  my_page = alloc_page(gfp_mask);
>                  if (unlikely(my_page == NULL))
>                          return 0;
>                  __free_page(my_page);
>          }
> 
> Unit is cycles.
> 
> Vanilla			Patched		Diff
> 159			165		3.7%
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-vmstat-remote/mm/vmstat.c
> ===================================================================
> --- linux-vmstat-remote.orig/mm/vmstat.c
> +++ linux-vmstat-remote/mm/vmstat.c
> @@ -334,6 +334,188 @@ void set_pgdat_percpu_threshold(pg_data_
>   	}
>   }

I wonder why we get a diff that is rather hard to review because it 
removes all existing codes and replaces it by almost-identical code. Are 
you maybe moving a bunch of code while modifying some tiny bits at the 
same time?

-- 
Thanks,

David / dhildenb

