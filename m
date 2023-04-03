Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7136D3E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjDCHvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDCHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C3C525B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oL0VlAyPu/aM1OdlSXQQkhdK2GBY2lWcmoUVVdynghk=;
        b=MWWbNeT0SnGBzWTmP1mq5gjQj4hlkrlSPaaZAT3hMc8p5FiyIso26NT2/f89fib4Sy6ASc
        Tl4KGP5DJo6inNTAtXwE+la82bFHYCGnayBp4yU6vn58Cim/k10G2tEZ8gWXjLGAIMGQI0
        82ZUUjrqk0BcgwJzLxYvmSqwr5+NhfE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-OzfE9TpMMgePhGlgDit9vg-1; Mon, 03 Apr 2023 03:50:24 -0400
X-MC-Unique: OzfE9TpMMgePhGlgDit9vg-1
Received: by mail-wm1-f72.google.com with SMTP id bh19-20020a05600c3d1300b003ee93fac4a9so15405442wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508223;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oL0VlAyPu/aM1OdlSXQQkhdK2GBY2lWcmoUVVdynghk=;
        b=s/MIGFaqcOllKUVj5FhulCocttq+W2bwogbYQi0DOyoGLkTeFYJzGkOz/v8+OQtDaf
         q59DVWvEnSZ/x/pfMUSGNbpk7LyTNBN8gq4LFTBIt2UVZ7zDHhSjzmdoSWVngfwXq1U5
         iaOqjs2fY9ITmMlfyWG9KGfLdtTh02taJZdk42yRhFeQp6xfPzbqK4jyPcr9dahQRzxI
         ywVr1czkXYwc0NELb4fy7JHsNT2zQf86RVtdndwS6Ab+9rPvuEYUodwqfmf9fWoA/dHw
         Rk2Mse18hVtuU7kxN7nQPlo297YGeEt9kJFJ9jlqstWkQZhWCnundq7wDigTeAaFQ5KJ
         GxmQ==
X-Gm-Message-State: AAQBX9cxQLCHdgDcJfXPgCHaPYLMLggc95olatGwTJE+R1dat5ba0D7A
        6m6hTJ6FTo+p19qbdlVXwaUn7GOaHJodxQ10fUFu3dDFHMsK7kDhQFwbYRHZh5osmRMbTQXqW60
        rZ76kxmgK05EFKMe76iM2fSCC
X-Received: by 2002:adf:ea10:0:b0:2da:e8ac:6986 with SMTP id q16-20020adfea10000000b002dae8ac6986mr28431054wrm.10.1680508223287;
        Mon, 03 Apr 2023 00:50:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350YuhdhOVk7kyVsqBUK63173Ru/dTKvQHsl6sRXmwL21YsTD1kohstmV7L+YVBXKWeDoTj7JDQ==
X-Received: by 2002:adf:ea10:0:b0:2da:e8ac:6986 with SMTP id q16-20020adfea10000000b002dae8ac6986mr28431039wrm.10.1680508222971;
        Mon, 03 Apr 2023 00:50:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id g6-20020adfe406000000b002d743eeab39sm9025414wrm.58.2023.04.03.00.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:50:22 -0700 (PDT)
Message-ID: <cb0c2565-7e89-93a9-2ea1-da5773f7ce24@redhat.com>
Date:   Mon, 3 Apr 2023 09:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 04/29] selftests/mm: Merge util.h into vm_util.h
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160649.3106916-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160649.3106916-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:06, Peter Xu wrote:
> There're two util headers under mm/ kselftest.  Merge one with another.  It
> turns out util.h is the easy one to move.
> 
> When merging, drop PAGE_SIZE / PAGE_SHIFT because they're unnecessary
> wrappers to page_size() / page_shift(), meanwhile rename them to psize()
> and pshift() so as to not conflict with some existing definitions in some
> test files that includes vm_util.h.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

