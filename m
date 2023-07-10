Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48A74D1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjGJJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjGJJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00F10D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688981564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=feKfT2GvXCROVww4eZNbKTv+YtvilbWXxCvzkbciRhY=;
        b=JXvCHX2f0TDSRy6IGfkshwCuIrVIPsiKmixbBPNqb6ieysekCOsTZFPY9TAe4RUOUpZZa5
        xPw6Iep33g8SnHKzOzeIr/GDFTimn3kUAK9UMugUW22caI4tdTZKHHhAXirIHPzV5/9/Uh
        SQVxb1Ri9k56SWC9LuQx1M20wF5h7Ck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-ZDXUfRXmOpqOLwUg1cDw1w-1; Mon, 10 Jul 2023 05:32:43 -0400
X-MC-Unique: ZDXUfRXmOpqOLwUg1cDw1w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbefe1b402so25637075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981562; x=1691573562;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feKfT2GvXCROVww4eZNbKTv+YtvilbWXxCvzkbciRhY=;
        b=bGbaAv99hXOYTGlECg1Q5f6VafoaiF6xcshQTZspN7yClOOKfeR9a2m1jB8tXAIPsK
         NRyGzRMeosHr4F5UyH6T0odsVsXCI8pLXSaw6wSgnaOthY//eKJaLtX4055/eEYzxN8F
         KnKD2WPvaEdJjd+tLFfl29QMWtWondWDXFTm+xN9PgcGx19p/t2h5Jl/nAM0NXy9wbzE
         3sCkoYWfBo21OW6wTGP3MKJpo0fZumgkEqVdqJQQXbz42gn5FW3JzbjkeP4IiifUmbFp
         ukbJQ0D/BhaJ0n6quvaseKd9hQ9DIjI7bMQL9ceCuar+9k+QqToVigN6N4Uc9e/RR9/D
         xefg==
X-Gm-Message-State: ABy/qLbLwL/Mko9Ro9pvvYJ6tLRaQk7qvLJeuJzJ3UZ8ujddVOBpfvvh
        I3CFS+2HbzT7bDxGDxsaZ8lHql4SkVtfJYujiDl1Qe4MxbMzyIa/xbjQTKxn8jrvld5Gpmy2HyN
        0GEDNa5CjeiSqHtqx9s0xlh6R
X-Received: by 2002:a05:600c:2313:b0:3fc:521:8492 with SMTP id 19-20020a05600c231300b003fc05218492mr5821038wmo.5.1688981561916;
        Mon, 10 Jul 2023 02:32:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE6ZgJ0/UlKVhwASeD/7xDB/tkvVIEoM79WQl5KkGDgu46daoSzxg16iohGJdU7Jw0HNIgfnQ==
X-Received: by 2002:a05:600c:2313:b0:3fc:521:8492 with SMTP id 19-20020a05600c231300b003fc05218492mr5821009wmo.5.1688981561552;
        Mon, 10 Jul 2023 02:32:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:7500:b60f:a446:46f6:5acf? (p200300cbc7387500b60fa44646f65acf.dip0.t-ipconnect.de. [2003:cb:c738:7500:b60f:a446:46f6:5acf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c230b00b003fbaade0735sm9732540wmo.19.2023.07.10.02.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:32:41 -0700 (PDT)
Message-ID: <04efd5eb-06c2-d449-8427-d7c30df962d1@redhat.com>
Date:   Mon, 10 Jul 2023 11:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
 <676ce1b3-6c72-011e-3a4f-723945db3d31@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
In-Reply-To: <676ce1b3-6c72-011e-3a4f-723945db3d31@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.23 15:25, Yin, Fengwei wrote:
> 
> 
> On 7/8/2023 12:02 PM, Matthew Wilcox wrote:
>> I would be tempted to allocate memory & copy to the new mlocked VMA.
>> The old folio will go on the deferred_list and be split later, or its
>> valid parts will be written to swap and then it can be freed.
> If the large folio splitting failure is because of GUP pages, can we
> do copy here?
> 
> Let's say, if the GUP page is target of DMA operation and DMA operation
> is ongoing. We allocated a new page and copy GUP page content to the
> new page, the data in the new page can be corrupted.

No, we may only replace anon pages that are flagged as maybe shared 
(!PageAnonExclusive). We must not replace pages that are exclusive 
(PageAnonExclusive) unless we first try marking them maybe shared. 
Clearing will fail if the page maybe pinned.

page_try_share_anon_rmap() implements the clearing logic, taking care of 
synchronizing against concurrent GUP-fast.

There are some additional nasty details regarding O_DIRECT. But once it 
completely switched from using FOLL_GET to properly using FOLL_PIN (a 
lot of that conversion already happened IIRC), we're fine in that regard.

-- 
Cheers,

David / dhildenb

