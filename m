Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5806553AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiLWSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLWSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:38:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6CE101F0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671820686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DT/pRLoUUOx0KMR2s9yyiI/zbo/mAqi0ZYgS7h1VIJA=;
        b=e5os1jnO3cMtf0G8+T8XTZcTei9unecx4rd5hcpIuW0eUmdDMx1ZGUD2U65katGtBfveZg
        CF811ym7Qdf42ak5CMvZ7DmS+Eb3yelIQPy3R0mcZWPXjsm9ow2cEtAx+eScLCV0QNEJqx
        4SNypy6NPvUqKj0IdqhGq6V3swcomxE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-cYZdKcTUM92HgPXnjIQFWQ-1; Fri, 23 Dec 2022 13:38:04 -0500
X-MC-Unique: cYZdKcTUM92HgPXnjIQFWQ-1
Received: by mail-qk1-f199.google.com with SMTP id bi3-20020a05620a318300b00702545f73d5so3575729qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT/pRLoUUOx0KMR2s9yyiI/zbo/mAqi0ZYgS7h1VIJA=;
        b=RxNMe6KUcOanE7Dc7h0SQvsjkNGjpf8EXGV5PB2cHV92eVNMKTK8wTbbzANEKFO3J7
         8tFFYJr05CJQOOD3+9q4gPUeBAnPv6Qfa6t6Ufns+6clTetFtEycC/tr7RmHtTILMHSc
         0kugHPIYnpgV5cfnzRKbE8AK+5Wh47vRgC8BgAObfMNz3A1z+SQRm2+NugijhN3Fh/eI
         oIvOrCk1UZLeRJwinFL+X88jSX+DYnHAU/uHH3I/FZJ4fpBUVj0xu6d517VhyC57nphe
         2AuVDDQ/pqRaiJFABL+iBH+zv49Oo7CoMpVBuYh1xOsGVFw0Tcw3NbEPcABvo00Lecl+
         smRA==
X-Gm-Message-State: AFqh2kpPnbMQbIOm2wTzqvA4Rzm0VmrNDgF9QFvlywWBOkwZnltwPNMt
        afQzc8hUiBeOSr/Ai9HehCTk1oFsZ6CnJc59O4PpJ/FENoFwxaH5tFVi8f8yatkE9lGanAJWP2a
        ny3je5DNOnhiSfO8TcULQ3Uzg
X-Received: by 2002:a05:6214:590c:b0:52c:2e58:c1b2 with SMTP id lp12-20020a056214590c00b0052c2e58c1b2mr11035225qvb.43.1671820684535;
        Fri, 23 Dec 2022 10:38:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXspTCzUooGGhpqaW91lUCglSy3YUutb7cqTuUcey/CskEzzrEWCfexqxzhLAMtU54LFK1GW7w==
X-Received: by 2002:a05:6214:590c:b0:52c:2e58:c1b2 with SMTP id lp12-20020a056214590c00b0052c2e58c1b2mr11035212qvb.43.1671820684347;
        Fri, 23 Dec 2022 10:38:04 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a0e0f00b006fc2b672950sm2659807qkm.37.2022.12.23.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:38:03 -0800 (PST)
Date:   Fri, 23 Dec 2022 13:38:02 -0500
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
Subject: Re: [RFC PATCH v2 34/47] hugetlb: userfaultfd: add support for
 high-granularity UFFDIO_CONTINUE
Message-ID: <Y6X1isYeuZMxvDEC@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-35-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-35-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Fri, Oct 21, 2022 at 04:36:50PM +0000, James Houghton wrote:
> +	bool use_hgm = uffd_ctx_has_hgm(&dst_vma->vm_userfaultfd_ctx) &&
> +		mode == MCOPY_ATOMIC_CONTINUE;

Do you think in your new version use_hgm can work even for MISSING by
default?

I had a feeling that the major components are ready for that anyway.  Then
no matter how HGM is enabled (assuming it'll switch to MADV, or even one
can just register with MISSING+MINOR and enable the uffd HGM feature), an
existing MISSING only app can easily switch to HGM support if it's on huge
pages.

Thanks,

-- 
Peter Xu

