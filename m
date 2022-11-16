Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B562C4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiKPQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiKPQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:41:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31D60E9C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668616532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6P/DkHlylDqeyIXovCIuF2YvI5jJp50fry7v8dWMgVo=;
        b=BGGo3jhSZKjv2DjuW8/6195sfNTZghL5VSYwNKwxweTJYe7dGJnQ6PqR5G7QagpvXVrdXv
        yVaH5XFget9CG7woH1qA9fyblkPe0NWAiM6kN6/+cfQTX4hkrDYVb4lODuqEvwkauCkxay
        PyMzXTcinIHw9w9cDm6iArkKnB1fK9Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-bqoVl_U1PQGxPp2Uw69GlQ-1; Wed, 16 Nov 2022 11:35:22 -0500
X-MC-Unique: bqoVl_U1PQGxPp2Uw69GlQ-1
Received: by mail-qk1-f197.google.com with SMTP id bq13-20020a05620a468d00b006fa5a75759aso17898431qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P/DkHlylDqeyIXovCIuF2YvI5jJp50fry7v8dWMgVo=;
        b=lbOrExmUCWNOwzXSsA3z/aX8ApaJyvsP4laVOzisNlBGPaJQV32I5dZtzZZvM9XEX3
         bKPgMixfNB/KqDdRWz5oVleSJZO9nYfaYqSc9fbVrnD8UfKEFyoHmLWZUP9ldgHMLTYo
         wo/2lMD+OWrDAVF5glP7Dcq/BpgimzpML4cAT/A2N8qU/SZNMUQ4+5NWSP7soW7ABWjf
         vI0eseLC4DtpEhBzFCYuO+cNNMWNPLkMLQOE/T4NuERXDiNq/WwiO9clStaHAIOH75H8
         Ss/Y0HOGxPOSm4Cp516MX59W0zBUoxyZ2Sxl5viTYVcRyGYbem5YLilaDcaHmxrOJAkJ
         lZyw==
X-Gm-Message-State: ANoB5pnLaYCczRog2wwJ3Ex+LmxGEvTpKgoSK0l+kFuGTnW9oOQdkbVi
        BXATu5bS4imTD8NRfmNlpjD/9U8Kqtcjt0wir0pVEoawpKCv3cs0RUgh+MpJ3RF9allPs3MtvaO
        MwEpcflw49iTmUWbOmvCI2vnq
X-Received: by 2002:ad4:51c2:0:b0:4bb:781e:6232 with SMTP id p2-20020ad451c2000000b004bb781e6232mr21168444qvq.15.1668616521903;
        Wed, 16 Nov 2022 08:35:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6brx9EkEPv6h957QCTT0k14m6ufIkEtyMRa3SdemkO46s593RTxi4C+EMxnGlsb9JQjbPPMA==
X-Received: by 2002:ad4:51c2:0:b0:4bb:781e:6232 with SMTP id p2-20020ad451c2000000b004bb781e6232mr21168417qvq.15.1668616521629;
        Wed, 16 Nov 2022 08:35:21 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id c8-20020ac853c8000000b00359961365f1sm8826363qtq.68.2022.11.16.08.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:35:21 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:35:19 -0500
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
Subject: Re: [RFC PATCH v2 02/47] hugetlb: remove mk_huge_pte; it is unused
Message-ID: <Y3URR/2S/M4rqRxL@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-3-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-3-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:18PM +0000, James Houghton wrote:
> mk_huge_pte is unused and not necessary. pte_mkhuge is the appropriate
> function to call to create a HugeTLB PTE (see
> Documentation/mm/arch_pgtable_helpers.rst).
> 
> It is being removed now to avoid complicating the implementation of
> HugeTLB high-granularity mapping.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

