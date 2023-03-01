Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307746A6F38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjCAPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCAPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3406303DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677683976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+pi+Q3n6FAc/3Vit9mlFi0cKydtod+1ggFmBEFVzpQ=;
        b=VuIfleq5baNgRuteMBPFh5MFPLsRhDzMJ9DApomI05gFB4xiW20idUb6Xjqk7NEKa6DT6D
        XrV4CIDOKBxTUR78QSQ3kw9zHL48Q2Qw8I6+zW7Q1BnYNl1fa4xpcuJBbxVUNw+6JvdAqI
        gUNil/LQRB4XFIQeNeVN/FSVTtJtWio=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-AIVuIcngOsic9dAj2bhs6A-1; Wed, 01 Mar 2023 10:19:35 -0500
X-MC-Unique: AIVuIcngOsic9dAj2bhs6A-1
Received: by mail-qk1-f199.google.com with SMTP id c15-20020a37e10f000000b00741a3333881so8257868qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 07:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677683974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+pi+Q3n6FAc/3Vit9mlFi0cKydtod+1ggFmBEFVzpQ=;
        b=uTqHcFYIjKNml86iBLyI5WCgSwZ5bPA2bvQXgUQ9AUijvixyJ+5raSWb+ERY6EzbMv
         31igvC8ainOe/2qoP7MkcXy0PekXNNtgEEMN9SFRuyCxUiGUfCIbHfnDvC4K0wNfwNpn
         bN9uZ5Qb4NPa9AVB5SyrELAnyz+eIKEph1kldi4kcyANylM6cVda31LKncCtGcqa6Dxb
         Ez05eI865FCG9r7VbTdgmqwamkM/uwV7Qpb6MVi3loUdq7Urp1HP228dHp57Uo0xTz89
         9XHJKor1JNq9pV39ArPJx3N+CSCn0InL6w6bT9h9/G//HfIR2o8P5tkrORzmqrck4WLz
         eM6A==
X-Gm-Message-State: AO0yUKW5XSDqI8q28jYrc9H51NDD/p1WJd9LxuWxxdOpMPP8Sx1Ep8+v
        e5XWkhTN+TUTy6LCDcqZQw3YFaJhNP16qgjOeh2X5iZ3tFOURzfKPmLQxhnVGzFNKucIeSY9unV
        qEd4fHBM1Am93hmm6hMwo7nrH
X-Received: by 2002:a0c:9c0e:0:b0:56e:89b9:9a92 with SMTP id v14-20020a0c9c0e000000b0056e89b99a92mr12284248qve.0.1677683974091;
        Wed, 01 Mar 2023 07:19:34 -0800 (PST)
X-Google-Smtp-Source: AK7set9OWJnH61ne7rRBbSI97/TEcVm5h0Ds8qUHxmuqzkd3WaHEYcHLo+QzJXxkDpHeSBu4A2GKIA==
X-Received: by 2002:a0c:9c0e:0:b0:56e:89b9:9a92 with SMTP id v14-20020a0c9c0e000000b0056e89b99a92mr12284208qve.0.1677683973761;
        Wed, 01 Mar 2023 07:19:33 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a15ed00b006fed58fc1a3sm8940339qkm.119.2023.03.01.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 07:19:32 -0800 (PST)
Date:   Wed, 1 Mar 2023 10:19:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <Y/9tA2EVglOJ0Ap1@x1n>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n>
 <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n>
 <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
 <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:55:51PM +0500, Muhammad Usama Anjum wrote:
> Hi Peter,

Hi, Muhammad,

> While using WP_UNPOPULATED, we get stuck if newly allocated memory is read
> without initialization. This can be reproduced by either of the following
> statements:
>     printf("%c", buffer[0]);
>     buffer[0]++;
> 
> This bug has start to appear on this patch. How are you handling reading
> newly allocated memory when WP_UNPOPULATED is defined?

Yes it's a bug, thanks for the reproducer. You're right I missed a trivial
but important detail.  Could you try apply below on top?

---8<---
diff --git a/mm/memory.c b/mm/memory.c
index 46934133bd0b..2f4b3892948b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4062,7 +4062,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
                                                vma->vm_page_prot));
                vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
                                vmf->address, &vmf->ptl);
-               if (!pte_none(*vmf->pte)) {
+               if (vmf_pte_changed(vmf)) {
                        update_mmu_tlb(vma, vmf->address, vmf->pte);
                        goto unlock;
                }
---8<---

I can send a new version after you confirmed it at least works on your
side. I'll also add some more test to cover that in the next version.

The current smoke test within this patch is really light; I somehow rely on
you on this patch on the testing side, and thanks for that.

> Running my pagemap_ioctl selftest as benchmark in a VM:
> without zeropage / wp_unpopulated (decide from pte_none() if page is dirty
> or not, buggy and wrong implementation, just for reference)
> 26.608 seconds
> with zeropage
> 39.203 seconds
> with wp_unpopulated
> 62.907 seconds
> 
> 136% worse performance overall
> 60% worse performance of unpopulated than zeropage

Yes this is unfortunate, because we're protecting more things than before
when with WP_ZEROPAGE / WP_UNPOPULATED but that's what it is for (when we
want to make sure that accuracy on the holes).

I didn't look closer to your whole test suite yet, but my pure test on
protection above should mean that it's still much better for such a use
case than either (1) pre-read or (2) MADV_POPULATE_READ.

Again, I hope the performance result is not a concern to you.  If it is,
please let us know.

Thanks,

-- 
Peter Xu

