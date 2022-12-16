Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059B64EE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiLPQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLPQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:04:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B56F0C8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671206476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXlf0fi95Q9sDBDXZydRV0Mu2EmJPmkK+rvU5zY6sMw=;
        b=EaPLLB8FgdeJJO9HMWX6O54zU2Zk86pp3UDoP9KE1zl9KOrm3luvHgNKaAWvv8cKiNBHvL
        I1r87pDm7cV5zY98ngfu8K7CO+18XlmlpDS3crcCvWgB2ZkgVyhEPO4OB6Dq2GIsgwCIi5
        hueiN5UvvYDO6wshlAUAXxPViWTw9nY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-Kti8YBBMO92mwMvps3DwpQ-1; Fri, 16 Dec 2022 11:01:13 -0500
X-MC-Unique: Kti8YBBMO92mwMvps3DwpQ-1
Received: by mail-wm1-f71.google.com with SMTP id r129-20020a1c4487000000b003d153a83d27so1397529wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXlf0fi95Q9sDBDXZydRV0Mu2EmJPmkK+rvU5zY6sMw=;
        b=Sl/WzsE07QOKe8pHdqiWe/0OxScczijwRmhzzc85ThqAYowNum8CbA9Mvi3zhlWpzM
         PxsJA+80VnsfRjEPklW6blotXDSx1jOLsS92Tw8Bj1Rbh2VLlXgl4NJKJhcQ9z49XQ8B
         8uKvOa7tNZzpyicZAE3tLawjsxiaapyKh3C0F2llZXxPQiYSIPAQZgtNHsiukOnilNiB
         H7f74if4C0+G8qBFC0sUHCfeE+Q77HS9jvp4+CyXMYHWFDnJlPaUMxbBkoKiK6Q3G1UN
         8Qee+JF/4kigwv2e3NYbZ7+eRA+zVkYswlfFLPabVGY7wtkOWI3Rn5Qs/FSZ7F08xH1H
         K3aA==
X-Gm-Message-State: ANoB5pl3+mA4sqiKP6HUMBsjanmjJL2jetLA8aGAm2j1skGrkIBVVrMW
        5MSVDvUg2HNn0Q8Ek4+j/6kNIx2NXlhC3q5LUF/04MIHiBcQSqvo7FQcNm8hKG/7kfyJq8l2mUP
        OnsF0EdHwgN0im17Lt9TPyLtl
X-Received: by 2002:a05:600c:34cd:b0:3cf:c2a5:5abc with SMTP id d13-20020a05600c34cd00b003cfc2a55abcmr26467202wmq.17.1671206472022;
        Fri, 16 Dec 2022 08:01:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lP7tl2S6qgLTN3bZPyt+ZwVs1l98BARX/cmvswH+dKAX/0oE28TgKvm09gJrmULjrIem4HQ==
X-Received: by 2002:a05:600c:34cd:b0:3cf:c2a5:5abc with SMTP id d13-20020a05600c34cd00b003cfc2a55abcmr26467138wmq.17.1671206471395;
        Fri, 16 Dec 2022 08:01:11 -0800 (PST)
Received: from [192.168.3.108] (p4ff23686.dip0.t-ipconnect.de. [79.242.54.134])
        by smtp.gmail.com with ESMTPSA id s20-20020a7bc394000000b003d1da8c7854sm2877335wmj.45.2022.12.16.08.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 08:01:10 -0800 (PST)
Message-ID: <b3898fb8-3aed-8392-7063-1e58c06d6d5d@redhat.com>
Date:   Fri, 16 Dec 2022 17:01:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] mm: Fix a few rare cases of using swapin error pte
 marker
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>
References: <20221214200453.1772655-1-peterx@redhat.com>
 <20221214200453.1772655-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221214200453.1772655-3-peterx@redhat.com>
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

> diff --git a/mm/memory.c b/mm/memory.c
> index 032ef700c3e8..3e836fecd035 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -828,7 +828,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   			return -EBUSY;
>   		return -ENOENT;
>   	} else if (is_pte_marker_entry(entry)) {
> -		if (userfaultfd_wp(dst_vma))
> +		if (is_swapin_error_entry(entry) || userfaultfd_wp(dst_vma))
>   			set_pte_at(dst_mm, addr, dst_pte, pte);

As discussed, it would be great if we could in the future avoid such 
allow lists and instead have default allow and only handle problematic 
cases. Maybe we can do that in the future with selective clearing of 
markers.

-- 
Thanks,

David / dhildenb

