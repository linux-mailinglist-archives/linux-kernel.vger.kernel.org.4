Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3428D670BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAQWnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAQWlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:41:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B585AA5B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673992483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SgeMP37+5GkMMY5cU2F9SAhbA9yv/IZm6bw7oKKCsAE=;
        b=XeyC26800ozv9myXbMau+/aj71H/Vbvu2uwac5xv1n2OCnplVqUu6t06DIXm7Ry8OT3WSZ
        nJZL70EtIsY5ruN7s0wXwjPfBu97LE9wsifw+ugwyhZALNvsuYU3XRChArAotw5WY6Llse
        qQMIfuncdHM1AIqy4NGe5bahcG72Fis=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-rMh5lSdbNp-_GQO5QR-wkQ-1; Tue, 17 Jan 2023 16:54:42 -0500
X-MC-Unique: rMh5lSdbNp-_GQO5QR-wkQ-1
Received: by mail-qt1-f198.google.com with SMTP id br26-20020a05622a1e1a00b003b62dc86831so2581497qtb.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgeMP37+5GkMMY5cU2F9SAhbA9yv/IZm6bw7oKKCsAE=;
        b=II6B/ARpSXbRQu1sjUHudOBpftIUaVl9OJWboIqsrjHIPAHusMQRTYSFup/CvlWniR
         AsB/mXhbNXUSF+jgZAXQVoVTDPynRcc6eiZpZ0qK02WfHjKPyMjFLSUrdq9VYYzgEXHi
         75V+5+P0wxG84m2FyGpPam2C8kR3ar9IwOEHqNdngfpCMKb08priygmfGMzMlMrnIZHM
         4xQa0KpkQfUSSuEh2WSPId90u/CgS2P1jMrzYI2rSFKmXL2meR5r2I86Qe/IpiwpV+V2
         SrNyUvsGgh642PDLXN/pnTQ1468aYU6G8zr2YJJhNSaoPxBqDS9o1M0p9Vr5WO0ZzYQF
         gEdA==
X-Gm-Message-State: AFqh2kq+2O4Zcof7ZTMmVyrCOcXHkhbzH2+St4VLjjkP+YXe1t4yfyXd
        /yAtlfs3rYWDcDOuvOhi0mtvi6QR4vtdTmoZfdo9iAddMlbZsGmV8HGu9XW5sP6FgAVtuM8nFgr
        bI36KNO5blC1iXDvUMS1S0/g5
X-Received: by 2002:a05:6214:2c0a:b0:532:35ef:203a with SMTP id lc10-20020a0562142c0a00b0053235ef203amr7280043qvb.31.1673992481889;
        Tue, 17 Jan 2023 13:54:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtlT8XS1fomDg2KJtqO7kFqcy20Zed4tyaDLwl2aePI17xv7CDEftZLFqepx1/fEDx1XInq5w==
X-Received: by 2002:a05:6214:2c0a:b0:532:35ef:203a with SMTP id lc10-20020a0562142c0a00b0053235ef203amr7280029qvb.31.1673992481692;
        Tue, 17 Jan 2023 13:54:41 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id bj3-20020a05620a190300b00705975d0054sm21166567qkb.19.2023.01.17.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:54:40 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:54:38 -0500
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
Subject: Re: [PATCH 35/46] hugetlb: add MADV_COLLAPSE for hugetlb
Message-ID: <Y8cZHv6dNHIg99tW@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-36-jthoughton@google.com>
 <Y8cN4G0ICoSSggS+@x1n>
 <CADrL8HVDyT6D-O=BoeHkA9oaRPLJR62Sxba8FdTjMaQYW-Ttfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HVDyT6D-O=BoeHkA9oaRPLJR62Sxba8FdTjMaQYW-Ttfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        On Tue, Jan 17, 2023 at 01:38:24PM -0800, James Houghton wrote:
> > > +             if (curr < end) {
> > > +                     /* Don't hold the VMA lock for too long. */
> > > +                     hugetlb_vma_unlock_write(vma);
> > > +                     cond_resched();
> > > +                     hugetlb_vma_lock_write(vma);
> >
> > The intention is good here but IIUC this will cause vma lock to be taken
> > after the i_mmap_rwsem, which can cause circular deadlocks.  If to do this
> > properly we'll need to also release the i_mmap_rwsem.
> 
> Sorry if you spent a long time debugging this! I sent a reply a week
> ago about this too.

Oops, yes, I somehow missed that one.  No worry - it's reported by
lockdep. :)

> 
> >
> > However it may make the resched() logic over complicated, meanwhile for 2M
> > huge pages I think this will be called for each 2M range which can be too
> > fine grained, so it looks like the "cur < end" check is a bit too aggresive.
> >
> > The other thing is I noticed that the long period of mmu notifier
> > invalidate between start -> end will (in reallife VM context) causing vcpu
> > threads spinning.
> >
> > I _think_ it's because is_page_fault_stale() (when during a vmexit
> > following a kvm page fault) always reports true during the long procedure
> > of MADV_COLLAPSE if to be called upon a large range, so even if we release
> > both locks here it may not tremedously on the VM migration use case because
> > of the long-standing mmu notifier invalidation procedure.
> 
> Oh... indeed. Thanks for pointing that out.
> 
> >
> > To summarize.. I think a simpler start version of hugetlb MADV_COLLAPSE can
> > drop this "if" block, and let the userapp decide the step size of COLLAPSE?
> 
> I'll drop this resched logic. Thanks Peter.

Sounds good, thanks.

-- 
Peter Xu

