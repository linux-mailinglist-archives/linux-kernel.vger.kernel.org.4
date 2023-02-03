Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81512689ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjBCQFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBCQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:04:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFAA9E9ED
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675440247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0k+DwIRn/nQk/hlUvm8L+KfqqsLBfRXdDbuz7IqD8k=;
        b=JZfRAnB+e84gqER5W2DsfyzxuwhB6W4NGwHk6jG19uPi/X9TCwEfwTdnxuH3/wU4oMjlqO
        FqtTyw6vfg1j8iKLxSekCyp7+D3/BxHQr7JAiR3d+eiyRjMzdRAzLQ3mvT6ME8I7bGVa/7
        B9kY3tx05AQrB/936gWkp14WEysB7hQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-R38_7ecZOBaDCXloizrNDQ-1; Fri, 03 Feb 2023 11:04:05 -0500
X-MC-Unique: R38_7ecZOBaDCXloizrNDQ-1
Received: by mail-wm1-f71.google.com with SMTP id o5-20020a05600c4fc500b003db0b3230efso4833494wmq.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0k+DwIRn/nQk/hlUvm8L+KfqqsLBfRXdDbuz7IqD8k=;
        b=ayRpSN0d1gBnyyY6THfJb1w7yBNILEQJPwD+F0dmgH8ZgfZr3US7mkmujmZp15wzrJ
         sK3yxV7ECbkOsJMWbSM0YLNsv5jmhgQfM11ZUuJTS2xeyIYeM2VE3sKyjdcfHeTPbZZc
         h3h/V22o7fqqnGwy3YG5NRziGibPHxB5iS6x5tv1lCOPHry8Rf0+FOcQJBEB/m7t2JKp
         leSW3neODoZgeXDJNU0klVwk8WOOyHhfqwCgZnJyDZiuenFaPuBGwaFJ/yitRX4Z0h8s
         LiQaxopHAnMFbcpDtUK1G+f0zCYBZCojSH3w68h8lqibpi6peN526iVCeek9Ch7FgWrz
         enZw==
X-Gm-Message-State: AO0yUKVQpm7Y4P3dD31Fh1GY/q9eapuvC7+TiHbZhe1dpSRBRSGVKooi
        6pvAEcinQ0UP9OW6bzDPEibk1w17ByoT7yEvqAwBoEgzFulTaln6HG8xtC1N7c6PE+xnOWOabt1
        Xnv/Hae6OEoK1iq6mv0CnQSaz
X-Received: by 2002:a05:600c:3b0f:b0:3de:1d31:1048 with SMTP id m15-20020a05600c3b0f00b003de1d311048mr9487413wms.29.1675440244210;
        Fri, 03 Feb 2023 08:04:04 -0800 (PST)
X-Google-Smtp-Source: AK7set91uqMIdlSiPtj2q9+R9cLSAkjmdlpJcWO4fdDXR7fN296xrVvwiLeNaixurWbC3xr0qm8Eww==
X-Received: by 2002:a05:600c:3b0f:b0:3de:1d31:1048 with SMTP id m15-20020a05600c3b0f00b003de1d311048mr9487389wms.29.1675440243933;
        Fri, 03 Feb 2023 08:04:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:7900:b84d:7f2e:b638:3092? (p200300cbc7067900b84d7f2eb6383092.dip0.t-ipconnect.de. [2003:cb:c706:7900:b84d:7f2e:b638:3092])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b003dd8feea827sm7905363wmc.4.2023.02.03.08.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 08:04:03 -0800 (PST)
Message-ID: <59630801-42b4-22e8-0ef6-5a5b8636dfbd@redhat.com>
Date:   Fri, 3 Feb 2023 17:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC v3 2/4] mm: move PG_slab flag to page_type
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-3-42.hyeyoo@gmail.com>
 <15fda061-72d9-2ee9-0e9f-6f0f732a7382@suse.cz> <Y9dI88l2YJZfZ8ny@hyeyoo>
 <Y9dRlNhh6O99tg4E@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9dRlNhh6O99tg4E@casper.infradead.org>
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

On 30.01.23 06:11, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 01:34:59PM +0900, Hyeonggon Yoo wrote:
>>> Seems like quite some changes to page_type to accomodate SLAB, which is
>>> hopefully going away soon(TM). Could we perhaps avoid that?
>>
>> If it could be done with less changes, I'll try to avoid that.
> 
> Let me outline the idea I had for removing PG_slab:
> 
> Observe that PG_reserved and PG_slab are mutually exclusive.  Also,

I recall that there are SetPageReserved() calls on pages allocated via slab.

-- 
Thanks,

David / dhildenb

