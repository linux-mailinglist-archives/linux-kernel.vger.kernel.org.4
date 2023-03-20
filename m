Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9C6C0F99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCTKsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCTKrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72656265B0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679309041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Fv8w0AbL4i3rtVaOqAMiK4Y5Lk55ACIoeLlYUsMQaA=;
        b=YRGw22DckkMaK0Wd8f/UnQ6B5+NUsG7qtPyFqzOT7kTLjsIrYkx83hHjB1LKBbzLWlk7jo
        IBvyuB07cHHLHWOolPlsokAlsMQnKQCh9y91OCMRLiVvVQj3hYcWZKekMQ/DT2upoBXzav
        oUzBJBbXzhEDVuJLwE7glEDjH0PtmJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Y-rFtTEjOLmUr-xtin-gwQ-1; Mon, 20 Mar 2023 06:40:23 -0400
X-MC-Unique: Y-rFtTEjOLmUr-xtin-gwQ-1
Received: by mail-wm1-f69.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so8229331wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308822;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fv8w0AbL4i3rtVaOqAMiK4Y5Lk55ACIoeLlYUsMQaA=;
        b=bqvPTqmTZMsO+Yk+yqZby3TO6Wjfp8bxUkyqRrW9rsX71OUzHd1xy12Tu7eCpdwrds
         drNwulBoKYfkpG0AGcFnw77BqfuIm1btZt5v5PjZ75DUNauRnqZjV2COGss78RHcQcui
         +Wi4jbuXKMbfg8QHEvdF1mLuHOakj3y/tydbAoBwCnfxhUJZk+JvocPuUhEObzZDeIpQ
         iL+JrxhhI66zH0D4VPS2RaZro3XDUtqrAY4QDlmyyEgLIutrGYpAGpDdRurKJL3vM/Vd
         UQ+OCVdnTz0OJKWkoyYtNIrkScsFj0rE2+lQrT+LMuJS7aqzfzIyJkMQKPfHgTHZsvKd
         +Oeg==
X-Gm-Message-State: AO0yUKVKJ3yWXEsKpjErY/udnaeoSiNs3vNw45z1d5xlW5nsYDezFBTR
        NKMMG2K+jnny/aEZJ1mTEs8fcfLHK+SDwNtZ5XyDzEKRAWcp2NQSlOhwmFSs4UXlWyTRHPv1rxE
        Ezy9XR3jppgStd66gZsCUPGJ5
X-Received: by 2002:a1c:f706:0:b0:3eb:2e27:2d0c with SMTP id v6-20020a1cf706000000b003eb2e272d0cmr9616603wmh.1.1679308822327;
        Mon, 20 Mar 2023 03:40:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set/10g4Z7aB7TI1HoVcnUgopnpX2wy6FwefAdrIqgvU3clik3GvbZHOBAURtPSuVMmg+4a+jYg==
X-Received: by 2002:a1c:f706:0:b0:3eb:2e27:2d0c with SMTP id v6-20020a1cf706000000b003eb2e272d0cmr9616595wmh.1.1679308822052;
        Mon, 20 Mar 2023 03:40:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id l15-20020a7bc44f000000b003edef091b17sm3057940wmi.37.2023.03.20.03.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:40:21 -0700 (PDT)
Message-ID: <1cb57760-7ca6-a2e9-1f86-366ca8d3145e@redhat.com>
Date:   Mon, 20 Mar 2023 11:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 12/15] mm: move mem_init_print_info() to mm_init.c
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-13-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-13-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 23:00, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> mem_init_print_info() is only called from mm_core_init().
> 
> Move it close to the caller and make it static.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

