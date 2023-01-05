Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE365F6F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjAEWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjAEWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:43:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF981BE87
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672958562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgUHJzZE66px4h3+wgCbKciUz0W22+aUBNT6U4fGi2Y=;
        b=UEIeMpjPbkBKUYo/NAVMqR+7XKFGQQ7ZGiDNq1I+b6rLpDWeUiP8Vqvw2Ds98HoQDf3Bip
        ylU76MsN0XB8NFxHpXmf7eVMz57Il9qKDzQCrhsRt9LNT/TbBNFoG0vzXaMcA3SurVJSBJ
        sq951NJrNH98aIqF08zrKbb7MxZMW/c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-T0WM0OGiMk6sMBgat84DRA-1; Thu, 05 Jan 2023 17:42:38 -0500
X-MC-Unique: T0WM0OGiMk6sMBgat84DRA-1
Received: by mail-qk1-f197.google.com with SMTP id l16-20020a05620a28d000b00704af700820so25583848qkp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgUHJzZE66px4h3+wgCbKciUz0W22+aUBNT6U4fGi2Y=;
        b=2TnXA+MsPKD9cLj9nMB9XVPnbsR3ChK5r+aYdziDxtAqND+5H64HzA40XyoJzK3tve
         XvCiwgXCC6pcBCvVRfKn0QAYGO4SSJx737lUO3qJii2JGKi3EpzsdGDBgP5tkso0m1pU
         jEQ9g9WmUmSc6aSQM+NxSSK0VeoRQH0vmzkzotW9da6ZWWPnDLwNdeeP9Fb/aFVTAFHb
         zaS2DKom2GztaT6TF0sKy3U/gzNJHwAfc54go27Ng4IKVedIDV9IOjMmchEtsr7tR2Th
         Ffz/ccg/oVfttLoDcZkbNhMvWHAKtl8s7f2lsK0lF9rtd10wdibVaAThZepwJSnr4fr6
         9CGg==
X-Gm-Message-State: AFqh2kqNwQUVmT//3qfUw0H4WMyM4ESLurrAt2CuGrXfHUoRo+3aifHV
        21G234Fez+PRQ60uOw701LGkMrJUe+olbdjZ97NKqzoimhT+IP7nYh10MUeg8oF35mhzQHZxPAu
        Up8sqxaYLCv6OtCQCw5uecKbu
X-Received: by 2002:ac8:7766:0:b0:3a5:f9cb:886f with SMTP id h6-20020ac87766000000b003a5f9cb886fmr72417713qtu.29.1672958558366;
        Thu, 05 Jan 2023 14:42:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsb7QMoGw7hkQTzlQFXCKWwVIMRvtRiRSKc80lHWO9Msaear+owA5O3ECrqcaUd58w1BSTVGA==
X-Received: by 2002:ac8:7766:0:b0:3a5:f9cb:886f with SMTP id h6-20020ac87766000000b003a5f9cb886fmr72417698qtu.29.1672958558192;
        Thu, 05 Jan 2023 14:42:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id fa11-20020a05622a4ccb00b003a68fe872a5sm22317208qtb.96.2023.01.05.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:42:37 -0800 (PST)
Date:   Thu, 5 Jan 2023 17:42:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y7dSWj+sGyXIPs/U@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105101844.1893104-22-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:18:19AM +0000, James Houghton wrote:
> -static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
> +static void damon_hugetlb_mkold(struct hugetlb_pte *hpte, pte_t entry,
> +				struct mm_struct *mm,
>  				struct vm_area_struct *vma, unsigned long addr)
>  {
>  	bool referenced = false;
> -	pte_t entry = huge_ptep_get(pte);
> +	pte_t entry = huge_ptep_get(hpte->ptep);

My compiler throws me:

mm/damon/vaddr.c: In function ‘damon_hugetlb_mkold’:
mm/damon/vaddr.c:338:15: error: ‘entry’ redeclared as different kind of symbol
  338 |         pte_t entry = huge_ptep_get(hpte->ptep);
      |               ^~~~~   

I guess this line can just be dropped.

>  	struct folio *folio = pfn_folio(pte_pfn(entry));
>  
>  	folio_get(folio);

-- 
Peter Xu

