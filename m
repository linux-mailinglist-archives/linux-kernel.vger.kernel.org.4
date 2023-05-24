Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2224E710040
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjEXV5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjEXV5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:57:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F70119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:57:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-25566708233so709920a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684965420; x=1687557420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAhC/flunH4mhtUx9WkifybqdgbT+jLIDs5rKRqBH18=;
        b=VcANevIbUge33+JiwrVldMPsDVseKzleSpEoGVXvCtvf59KvdrxkNaG3LuTkHdW4Jk
         bifOJhE2t54HMCgFf22CN2SG1cVz5SG5Lko5jtDAvmJP1YtUNTibOJe5TrnwIpvIOFYR
         dOrd/xuRTa+VnYbxbX7Rn0MbebnB6yrfeiMEBHHLsoKYVoaHG7M7CsH56LaK0Gh7rdBq
         C2unCUg13w37PapsE/+jP/rfI9e9ejFvHv85XK6ohMG1yFOAxI5zmjatNWwb/cCXOFso
         h/YeuYHyIZlpMyxTKJUzb+DpHWDl8D7Slzl1NiYD68IRDEkqt8JInDTOFbEVdcrm4ai5
         6/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965420; x=1687557420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAhC/flunH4mhtUx9WkifybqdgbT+jLIDs5rKRqBH18=;
        b=RcVcBpGfVsiGiscUP9SW8qHIo9CcIpKEp10MQ3Eh7S7TnfjV5CQIy5OJIZGoxkm3cV
         YRp+Ggr9Ont/79R12cUzCgY5477yndh4p1i9YXe1Q4FF0/EBoyybqyPdA0fWBjNE89i8
         QTVemrTL5UEgtZ21VLsl6HKMBnq0fNxPyisetF7cKz6DE0MynMx7kxgY+dXvnzR5aOm0
         rMWT4rgg3a2VG6na3PnBliJBfSCt3b9bf6hf7umqZPkFRbIVyOkUawdzyYI8COvBuxzm
         IfuL3gv1bMHtilvF8Vs/Cf1bOno7FXwmPWJWq40SVxG9MVnMihg7e0KF7+oLlONgQJqZ
         JZEA==
X-Gm-Message-State: AC+VfDwEpUxq34AKoLfeqfmv73EzsNht1UjyDV/T8HIQq1zMxxbE4PNe
        +6nXmHC3leSmZ9Bns5r0BYyV0Q==
X-Google-Smtp-Source: ACHHUZ5QRESsHt/p5Vp49+LOpaxi0xAHAvojh3fT62UGmVDu+zceNYswQcWGKavnizqXEm1VGKl/5w==
X-Received: by 2002:a17:90b:46d1:b0:247:529f:92d7 with SMTP id jx17-20020a17090b46d100b00247529f92d7mr19482622pjb.8.1684965420233;
        Wed, 24 May 2023 14:57:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b0024e41f23a2dsm1954764pjc.3.2023.05.24.14.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 14:56:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q1wTY-003UIE-1M;
        Thu, 25 May 2023 07:56:56 +1000
Date:   Thu, 25 May 2023 07:56:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Mitigate a vmap lock contention
Message-ID: <ZG6IKE7yNEkJhge+@dread.disaster.area>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
 <ZGzX3vRMlGHIcYCe@pc636>
 <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
 <ZG3d1FUXiCk3QL3D@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG3d1FUXiCk3QL3D@pc636>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:50:12AM +0200, Uladzislau Rezki wrote:
> On Wed, May 24, 2023 at 03:04:28AM +0900, Hyeonggon Yoo wrote:
> > On Tue, May 23, 2023 at 05:12:30PM +0200, Uladzislau Rezki wrote:
> > And I would like to ask some side questions:
> > 
> > 1. Is vm_[un]map_ram() API still worth with this patchset?
> > 
> It is up to community to decide. As i see XFS needs it also. Maybe in
> the future it can be removed(who knows). If the vmalloc code itself can
> deliver such performance as vm_map* APIs.

vm_map* APIs cannot be replaced with vmalloc, they cover a very
different use case.  i.e.  vmalloc allocates mapped memory,
vm_map_ram() maps allocated memory....

> vm_map_ram() and friends interface was added because of vmalloc drawbacks.

No. vm_map*() were scalability improvements added in 2009 to replace
on vmap() and vunmap() to avoid global lock contention in the vmap
allocator that XFS had been working around for years with it's own
internal vmap cache....

commit 95f8e302c04c0b0c6de35ab399a5551605eeb006
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Tue Jan 6 14:43:09 2009 +1100

    [XFS] use scalable vmap API
    
    Implement XFS's large buffer support with the new vmap APIs. See the vmap
    rewrite (db64fe02) for some numbers. The biggest improvement that comes from
    using the new APIs is avoiding the global KVA allocation lock on every call.
    
    Signed-off-by: Nick Piggin <npiggin@suse.de>
    Reviewed-by: Christoph Hellwig <hch@infradead.org>
    Signed-off-by: Lachlan McIlroy <lachlan@sgi.com>

vmap/vunmap() themselves were introduce in 2.5.32 (2002) and before
that XFS was using remap_page_array() and vfree() in exactly the
same way it uses vm_map_ram() and vm_unmap_ram() today....

XFS has a long, long history of causing virtual memory allocator
scalability and contention problems. As you can see, this isn't our
first rodeo...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
