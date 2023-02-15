Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B2697CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjBONQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBONQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14648241E4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676466971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJNFIuqu9Gce6zrkPruAO8JV/AMize9aNRnmeacl/AI=;
        b=OIh2WN1Pmc4udyFHy9FJnuSxcpQedjAzd+GHvLAG/eXHJOLyX9WrKsdBtAG+S6eLzIRDVY
        1rCaKpselfF2EsuYjT63OtJgEg4rgTS3xvBBum9EW/4auDJ9/ucFDY8MzcI0m5Jx8ayfTz
        7bmriF4WEkPrijDZdGPrgllJG0ZuA3Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-att87qQWPNuKUv9VIvGTuw-1; Wed, 15 Feb 2023 08:16:08 -0500
X-MC-Unique: att87qQWPNuKUv9VIvGTuw-1
Received: by mail-wm1-f72.google.com with SMTP id j20-20020a05600c1c1400b003dc5dd44c0cso9223031wms.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJNFIuqu9Gce6zrkPruAO8JV/AMize9aNRnmeacl/AI=;
        b=3bZQinRbDGheTKSEw/fEo5wCfRNIVBmiHZh8jn3J6+yiLo5q/1PT5QbtWRr/Lv/F3j
         01rMSiwlNOPLnDM2XE3+fX5UdlPVdOFJ3gOPUoxWvoW+s0kvQX6oGpkHN/lGNsOGjdjj
         H0ks09HRqgvHGOFSXhM+qd5uyLChw/s4xNDboHJopBUSb8hFN68YHRqce9BLluB8cT1e
         dt2geXReSUcj2ZZN0tiQ+JaUcr1DK7i1e5h36lFf0Cb/bZw1+VLB5SpsE06Vw5uDHfY2
         wHO2ls0wVFfZALu28lubl1p77YJxSkpUvXbRnd1VwXSFb8XaYcurQKFRYgN0ux5qRNnW
         GkUg==
X-Gm-Message-State: AO0yUKWJgpqWeS6ByQuoex9qgZQszs8D1hWz0PVGIjM+CEcAViTBR+Z5
        k11mneASxXhdTArCI8EA5Crbt9uK3lD/Jovk+2/q9fepuISD5wzwfxR7ZJmGWL5m7zWrzz1RyLQ
        F1JPfNS/7KIALKRpYR2NAatZwewkhHw==
X-Received: by 2002:adf:f386:0:b0:2c5:51ed:adf7 with SMTP id m6-20020adff386000000b002c551edadf7mr1378246wro.34.1676466966864;
        Wed, 15 Feb 2023 05:16:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+3D62A5OUeKxaOzFj+NPme2A9Cjv1hK7rqDP5aQKgXZLam7GroA2X4/AIzYrC/FzsLSyvWDw==
X-Received: by 2002:adf:f386:0:b0:2c5:51ed:adf7 with SMTP id m6-20020adff386000000b002c551edadf7mr1378234wro.34.1676466966641;
        Wed, 15 Feb 2023 05:16:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:1400:b7d:4122:28d:f4c3? (p200300cbc70714000b7d4122028df4c3.dip0.t-ipconnect.de. [2003:cb:c707:1400:b7d:4122:28d:f4c3])
        by smtp.gmail.com with ESMTPSA id a17-20020a056000101100b002c57475c375sm178787wrx.110.2023.02.15.05.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 05:16:06 -0800 (PST)
Message-ID: <388b9a93-423f-33f8-0495-2a4a290fd1aa@redhat.com>
Date:   Wed, 15 Feb 2023 14:16:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/memory_hotplug: return zero from do_migrate_range()
 for only success
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230214223236.58430-1-sj@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230214223236.58430-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 23:32, SeongJae Park wrote:
> do_migrate_range() returns migrate_pages() return value, which zero
> means perfect success, in usual cases.  If all pages are failed to be
> isolated, however, it returns isolate_{lru,movalbe}_page() return
> values, or zero if all pfn were invalid, were hugetlb or hwpoisoned.  So
> do_migrate_range() returning zero means either perfect success, or
> special cases of isolation total failure.
> 
> Actually, the return value is not checked by any caller, so it might be
> better to simply make it a void function.  However, there is a TODO for
> checking the return value.

I'd prefer to not add more dead code ;) Let's not return an error instead.

It's still unclear which kind of fatal migration issues we actually care 
about and how to really detect them.

-- 
Thanks,

David / dhildenb

