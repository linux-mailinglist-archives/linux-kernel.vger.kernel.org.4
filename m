Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48D65F4E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjAEUBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjAEUBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2EE637A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672948830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AztRxqvsi6T4hudCdqABGgSTqQjaAiuEjAa9BRqIU4=;
        b=MrsuVrTCtPuZP55P4/R+DhAcPO1PtUsYUhj7aqGxyjMvRuq+9XFukXMjLdr1C9cTfMaYno
        NrB1mZiMJ6C3E1If6E898+OhMrMY+lvB+Bp3b3vvw3JpNifgd1BXj1+f+IkYXyAgSTp9+F
        S6+qRiWsbTaRloZsHiQX4QlUcMRxmUI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-p4XV1UuhPFmCmtwJTG40_A-1; Thu, 05 Jan 2023 15:00:26 -0500
X-MC-Unique: p4XV1UuhPFmCmtwJTG40_A-1
Received: by mail-qk1-f197.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso25726455qkp.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AztRxqvsi6T4hudCdqABGgSTqQjaAiuEjAa9BRqIU4=;
        b=NS9ZbD4UwwSV1g7PVU5Q62OPvEal8Gk6dZnVBhSd1T0wypR8suz/FFXAr2IlAOBSb2
         r+qzxoURFKx0pRjyQ/fUylL56GCeXcsmRJ3GH2cer4lgcXtpfbuDzj+LUKtm04cuyb5d
         WIGtlRu8U3dAkv+3ePvKFlXNMqEl2ZRBC3N3t0djTqJdQRC5jSy+lhNO8I1NiODZUeOt
         c9eXoXWHvZEBb/tZSvIQ1kYK971s1aXCAkpi/hzqDCutqvyGPO0AkZgAfrIo6JZ1V+Hp
         3TV6h5Aty50Aai5FqOjlvWUqyjxPshUKZYnT5HNJYnhwpQPjaP1xoBxgq8lNXdRXsG3a
         Rcdg==
X-Gm-Message-State: AFqh2krvodnLwMr9QDCFXD2K0soVCbaqyfIfvOonmWst+K+G4dp/43bv
        7JLeIrpOQGebbtfMFXs+bHRfxF2++BIw2awWIyPfluvAg4PwqtCM0XRHGq/HKsfq0k1kKoVm72H
        r0nCBJJQENNs/8nuoXF4s0Mpt
X-Received: by 2002:a05:622a:59cb:b0:3a9:80b6:4c9c with SMTP id gc11-20020a05622a59cb00b003a980b64c9cmr74557601qtb.47.1672948826296;
        Thu, 05 Jan 2023 12:00:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtgeFFHLUomTG9G/6VqLznisPrP0zOPi/grNJFxmDF8xFNkCPuz+CuJv2hfFsV3tDlrDlu3dg==
X-Received: by 2002:a05:622a:59cb:b0:3a9:80b6:4c9c with SMTP id gc11-20020a05622a59cb00b003a980b64c9cmr74557563qtb.47.1672948825962;
        Thu, 05 Jan 2023 12:00:25 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id gc11-20020a05622a59cb00b003a50d92f9b4sm22226580qtb.1.2023.01.05.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 12:00:25 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:00:23 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hugetlb: unshare some PMDs when splitting VMAs
Message-ID: <Y7csV7ozB+5euKhR@x1n>
References: <20230104231910.1464197-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104231910.1464197-1-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 11:19:10PM +0000, James Houghton wrote:
> PMD sharing can only be done in PUD_SIZE-aligned pieces of VMAs;
> however, it is possible that HugeTLB VMAs are split without unsharing
> the PMDs first.
> 
> Without this fix, it is possible to hit the uffd-wp-related WARN_ON_ONCE
> in hugetlb_change_protection [1]. The key there is that
> hugetlb_unshare_all_pmds will not attempt to unshare PMDs in
> non-PUD_SIZE-aligned sections of the VMA.
> 
> It might seem ideal to unshare in hugetlb_vm_op_open, but we need to
> unshare in both the new and old VMAs, so unsharing in
> hugetlb_vm_op_split seems natural.
> 
> [1]: https://lore.kernel.org/linux-mm/CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com/
> 
> Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

