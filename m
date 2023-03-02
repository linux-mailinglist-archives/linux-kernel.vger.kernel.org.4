Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D36A7D44
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCBJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCBJEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307251817C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677747759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rzx2MwJyGFazUQ+bL7x8PG/wxOPeZdsHQ/JpovqZTbo=;
        b=b3+mnCpe8JGvfzKWouVTEkA1jSTW1gJaZQCLT150qQ5IxQPQwEm7OMAOqJBpttGZNSND8V
        9RFf7r7vOg5Rr/uPzNGMny3W9oQRNSXUwx4Itki9a0lgkOcy4o56V8eccJLPvtA58U/LmA
        PTFQe9Z1pT03TG8SD/zdGV3H/d2GBRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-vmwexXWBPumUPwcqn1yqBw-1; Thu, 02 Mar 2023 04:02:36 -0500
X-MC-Unique: vmwexXWBPumUPwcqn1yqBw-1
Received: by mail-wm1-f70.google.com with SMTP id e17-20020a05600c219100b003e21fa60ec1so790115wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzx2MwJyGFazUQ+bL7x8PG/wxOPeZdsHQ/JpovqZTbo=;
        b=L03aZxU4RJb9/u8Er6S0Rm7e4kVGyDvfevOW4nV4uk9rGQFVk4j7z5wQxLh0633k8+
         bGVYyjIsgbcTPDaXVG4YlTPL18wByOt8K2YGri0NAag+KBHeJZh9WO8z1J29sfVzBc7y
         LmdaeEQwATodkkfI/FIpPsH+e8XPyAk6gMEYYi86j4YQngWFLyeYg5ACl9UBVJCa7MD7
         MMj6f9VWBNGNweCmgItPIDLmNEBKuY08YRPMIVJW/bWdvO4qG2LMnbOD542xsIH+IPYJ
         9gEmZjOoiWlC9TXgwgWAZjgrgekwiAS4r3WrK8tOYtDdFfH4R0hbXJhPGNz1EoG/M+78
         m99A==
X-Gm-Message-State: AO0yUKU/1dckv5n5RCos+brf+iXOp48EDufwreycoYkSI1PRymIc9d3O
        uywkwdURWAMpjHcMnnfvZPgKxEqRGbdsmhSEk6drZ+IOX9dzMa8z+No4sfr9p4rt1ccofIonQIE
        K5uLXuEpeYk+W9ioMggobKl7Z
X-Received: by 2002:adf:f18d:0:b0:2c9:5a1f:5864 with SMTP id h13-20020adff18d000000b002c95a1f5864mr7629281wro.21.1677747755292;
        Thu, 02 Mar 2023 01:02:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/b4hGgvgRD+4LWvfowqtA9986Zt0gXO0AP3E31VaZ2FjsborxxglzdVgHluaBsx+EJCrSayg==
X-Received: by 2002:adf:f18d:0:b0:2c9:5a1f:5864 with SMTP id h13-20020adff18d000000b002c95a1f5864mr7629264wro.21.1677747754963;
        Thu, 02 Mar 2023 01:02:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id s2-20020adfeb02000000b002cda9aa1dc1sm4385622wrn.111.2023.03.02.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:02:34 -0800 (PST)
Message-ID: <39c91d34-9d77-8e63-388c-6893b40c31d9@redhat.com>
Date:   Thu, 2 Mar 2023 10:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/migrate: Drop pte_mkhuge() in remove_migration_pte()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230302025349.358341-1-anshuman.khandual@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302025349.358341-1-anshuman.khandual@arm.com>
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

On 02.03.23 03:53, Anshuman Khandual wrote:
> Since the following commit, arch_make_huge_pte() should be used directly in
> generic memory subsystem as a platform provided page table helper, instead
> of pte_mkhuge(). This just drops pte_mkhuge() from remove_migration_pte(),
> which has now become redundant.
> 
> 'commit 16785bd77431 ("mm: merge pte_mkhuge() call into arch_make_huge_pte()")'
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Link: https://lore.kernel.org/all/1ea45095-0926-a56a-a273-816709e9075e@csgroup.eu/
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on latest mainline.
> 
>   mm/migrate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 37865f85df6d..d3964c414010 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -249,7 +249,6 @@ static bool remove_migration_pte(struct folio *folio,
>   		if (folio_test_hugetlb(folio)) {
>   			unsigned int shift = huge_page_shift(hstate_vma(vma));
>   
> -			pte = pte_mkhuge(pte);
>   			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
>   			if (folio_test_anon(folio))
>   				hugepage_add_anon_rmap(new, vma, pvmw.address,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

