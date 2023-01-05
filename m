Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC7865EBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjAENBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjAENBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:01:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA585A8AE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672923621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2h8jzYSBEALCpf1r2L2tr1ZCFUOVJkX5SKUlm/mWTeA=;
        b=J2MZHstjJnqOiAO7jKpMo4kJcJOrXIjidag8sXCUYmrPhDHCN4nQF/WbyojGBJaVWUfTit
        PpBN6lef8IpPVSnGmX6iGPAMi/sDyjgulA85MTf4ZcJBpY+1FGvk0GHv189s3bnFIckI8v
        lK5ugsWnJ/+uE5rBvO3gBJo8q1vyaLs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-UfE4K6aUNDeW5xgBG6v8UA-1; Thu, 05 Jan 2023 08:00:17 -0500
X-MC-Unique: UfE4K6aUNDeW5xgBG6v8UA-1
Received: by mail-wm1-f70.google.com with SMTP id fm17-20020a05600c0c1100b003d96f0a7f2eso955897wmb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2h8jzYSBEALCpf1r2L2tr1ZCFUOVJkX5SKUlm/mWTeA=;
        b=lGu24jdNHO7UNaBXMll/LJ6+aRJuTDN69EcwtSYwjZUhU6V/CeJcMJFY0L3naLOthb
         4zkXiToeT1pYQ1gfMVPplGcGDkByU2GJ6YQ8vzjK+WQVGBzU/PmhvggV2yJN0D9X5rMo
         pPqASYIEEU+72YSwm41DyJsn3BtAcjXBbXwH+2/OsXj87wZiYzjxA1ANWg20kfU49sty
         P1rdramJfgQdyfG6God63rfPI5gBsOD275dYmrxeF4lQzp9HtK6HaZU8FrOSL/KwcghH
         eIpTCT1Q18XXJc3vbc7PBHvZAp0dYD8zW/84WNjmgbGEvio1wIUbZ0H5yXf9Bb6mbuGf
         C+YQ==
X-Gm-Message-State: AFqh2kpWXZ8G7S0yjWlMHeiEp3g0IqbkxrhDyDUAH9ykFTVDPsALcSXR
        829QO7tlg0m4swVu2xJRn+sTNJ6JiCwLGqzU1TSL0amIDREzw4m/aFSVh0oRFgugHmYNUPbLVjG
        t7oY8g6kR3WLXrdGbK0palV6T
X-Received: by 2002:a05:600c:a10:b0:3d5:64bf:ccb8 with SMTP id z16-20020a05600c0a1000b003d564bfccb8mr36274231wmp.12.1672923616550;
        Thu, 05 Jan 2023 05:00:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsKwczFkky/rzWSy76zFEhJGNLPLUfj7+A9mbg7Tk9C1+gQKOHMXK/YqNsh13tTR3Hfawp2EQ==
X-Received: by 2002:a05:600c:a10:b0:3d5:64bf:ccb8 with SMTP id z16-20020a05600c0a1000b003d564bfccb8mr36274217wmp.12.1672923616327;
        Thu, 05 Jan 2023 05:00:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm2524305wmo.24.2023.01.05.05.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 05:00:15 -0800 (PST)
Message-ID: <3ecd4b45-47c8-79e2-5f75-7ab9e96f3291@redhat.com>
Date:   Thu, 5 Jan 2023 14:00:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/page_alloc: Repalce with deferred_pages_enabled()
 wherever applicable
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     rppt@kernel.org, mgorman@suse.de, linux-kernel@vger.kernel.org
References: <20230105082506.241529-1-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230105082506.241529-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Repalce/Replace/

n 05.01.23 09:25, Anshuman Khandual wrote:
> Instead of directly accessing static deferred_pages, replace such instances
> with the helper deferred_pages_enabled(). No functional change is intended.
> 
> Cc; Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

