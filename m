Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417936328D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiKUP6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKUP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519854B26
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669046262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSrlQMIuLLb408AYq73wGHaQitblZLzVnKNYWxZfL9g=;
        b=VowR4wfR8UHqKXIe1WJHXg6weJBt+Vo/zCLu79AvuQFUoRTlFXd1OUoJV71lhbQ+A2sH0H
        jXEqXyIMJu8GGum2ilJGJlFcIVI6POlIVhZcgF6lzT3qpHLupMnPrVsBKTKyDqKWh2o+np
        omwjq37W+Gb7rrGAI+SS1cf66pBFVlM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-OnAlqkleNDaT4EXkB4Sm5Q-1; Mon, 21 Nov 2022 10:57:41 -0500
X-MC-Unique: OnAlqkleNDaT4EXkB4Sm5Q-1
Received: by mail-ej1-f71.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso6787860ejb.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSrlQMIuLLb408AYq73wGHaQitblZLzVnKNYWxZfL9g=;
        b=XXNEnskTauaeWJwgsye96rJU/uH7e63iIkDOu+buMru63kKsQEq76At1uEm73teOfx
         Fuu1YxA3d7sh9Qs77IZkIZT+vRiwApD1Nk42EJjlKQyG5rWQ1rkk3Z05oIwluXzXeZ1T
         f5DhXU4hGnaXxTvMHAslgjLBMj+krYygZXtOcmn/oCmnAb4ZjqEvF50DfVn/SDBV6sc9
         uaoCSZ0qqkj/zeVpuBKRDbWmWHZ+kqJlFaKPTZjNks8k8DxRbVMjQho6nF6B6l+K5fM7
         szaJstArfmdlnBeXVHF1pzFsznpL58v99/sp1Fggo9YLCxbrqDTC6fA09fRsXTscATSM
         ZNPw==
X-Gm-Message-State: ANoB5plckYtpHNl5MFv3qS4Plmbzm+MtVQlTSi/23XymHa3hY2KAejPH
        pTeER0a8KWZ3whuMoHptS9TCiIGVwdMXNJZG4M7A2H5iLZ7Z0zahjQ0EgfBQc9Fy7bUlVdY8YJe
        UFjHkDeW9201Q59gjS6wCAi8X
X-Received: by 2002:a17:906:3155:b0:7ad:90db:c241 with SMTP id e21-20020a170906315500b007ad90dbc241mr16094428eje.284.1669046259204;
        Mon, 21 Nov 2022 07:57:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4/y8bb1kzSiZCC9luT4L+ZHOKAD7cRl9fZuGVQyKNvIyOfHUXVykJkl23EkrRlztWFizx4Sg==
X-Received: by 2002:a17:906:3155:b0:7ad:90db:c241 with SMTP id e21-20020a170906315500b007ad90dbc241mr16094411eje.284.1669046259014;
        Mon, 21 Nov 2022 07:57:39 -0800 (PST)
Received: from [10.43.17.4] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7cb08000000b00461b169c02csm5283198edt.91.2022.11.21.07.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 07:57:38 -0800 (PST)
Message-ID: <aa2c354f-b7d1-6b97-ddff-762f7fec8431@redhat.com>
Date:   Mon, 21 Nov 2022 16:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] arm64/mm: fix incorrect file_map_count for non-leaf
 pmd/pud
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116083811.464678-1-liushixin2@huawei.com>
 <20221116083811.464678-2-liushixin2@huawei.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
In-Reply-To: <20221116083811.464678-2-liushixin2@huawei.com>
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

On 11/16/22 09:38, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when collapse hugepage:
> 
>   ------------[ cut here ]------------
>   kernel BUG at mm/page_table_check.c:82!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in:
>   CPU: 6 PID: 68 Comm: khugepaged Not tainted 6.1.0-rc3+ #750
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : page_table_check_clear.isra.0+0x258/0x3f0
>   lr : page_table_check_clear.isra.0+0x240/0x3f0
> [...]
>   Call trace:
>    page_table_check_clear.isra.0+0x258/0x3f0
>    __page_table_check_pmd_clear+0xbc/0x108
>    pmdp_collapse_flush+0xb0/0x160
>    collapse_huge_page+0xa08/0x1080
>    hpage_collapse_scan_pmd+0xf30/0x1590
>    khugepaged_scan_mm_slot.constprop.0+0x52c/0xac8
>    khugepaged+0x338/0x518
>    kthread+0x278/0x2f8
>    ret_from_fork+0x10/0x20
> [...]
> 
> Since pmd_user_accessible_page() doesn't check if a pmd is leaf, it
> decrease file_map_count for a non-leaf pmd comes from collapse_huge_page().
> and so trigger BUG_ON() unexpectedly.
> 
> Fix this problem by using pmd_leaf() insteal of pmd_present() in
> pmd_user_accessible_page(). Moreover, use pud_leaf() for
> pud_user_accessible_page() too.
> 
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>


Tested on 6.0.6 kernel, no oopses anymore.

